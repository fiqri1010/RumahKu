import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/core/sync/sync_engine.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';

class _MockSyncAdapter extends Mock implements SyncAdapter {}

MediaStorageService _memoryMedia() {
  final store = <String, Uint8List>{};
  return MediaStorageService(
    saver: ({
      required String fileName,
      required Uint8List bytes,
      required String mimeType,
    }) async {
      final path = 'mem://$fileName';
      store[path] = bytes;
      return path;
    },
    reader: (path) async => store[path],
  );
}

void main() {
  late AppDatabase db;
  late InventoryRepository invRepo;
  late MovingRepository movingRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    invRepo = InventoryRepository(db: db, mediaService: _memoryMedia());
    movingRepo = MovingRepository(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('project & box creation links unified Location, QR URI, and auto-increments code',
      () async {
    final household = await db.ensureDefaultHousehold();
    final project = await movingRepo.createProject(
      householdId: household.id,
      draft: const MovingProjectDraft(
        name: 'Pindah Rumah Bekasi 2026',
        originAddress: 'Jakarta Selatan',
        destinationAddress: 'Bekasi Timur',
        status: MovingProjectStatus.packing,
      ),
    );

    final box1 = await movingRepo.createBox(
      householdId: household.id,
      projectId: project.id,
      draft: const MovingBoxDraft(
        destinationRoom: 'Dapur',
        isFragile: true,
        priority: BoxPriority.high,
        weightKg: 9.5,
      ),
    );
    final box2 = await movingRepo.createBox(
      householdId: household.id,
      projectId: project.id,
      draft: const MovingBoxDraft(destinationRoom: 'Kamar Utama'),
    );

    expect(box1.boxCode, 'BOX-01');
    expect(box2.boxCode, 'BOX-02');
    expect(box1.labelQr, 'rumahku://box/${box1.id}');

    // Verify parseRumahKuQrUri parses box, item, and loc URIs cleanly
    final parsedBox = parseRumahKuQrUri(box1.labelQr);
    expect(parsedBox?.entityType, 'box');
    expect(parsedBox?.id, box1.id);
    expect(parseRumahKuQrUri('rumahku://item/abc-123')?.entityType, 'item');
    expect(parseRumahKuQrUri('https://example.com'), isNull);

    // Verify linked moving_box Location exists in unified locations table
    final allLocs = await db.getLocations(household.id);
    final linkedLoc = allLocs.singleWhere((l) => l.id == box1.locationId);
    expect(linkedLoc.kind, LocationKind.movingBox.dbValue);
    expect(linkedLoc.name, 'BOX-01 (Dapur)');
    expect(linkedLoc.qrCode, box1.labelQr);

    // Verify case-insensitive lookup by box code
    final found = await db.findMovingBoxByCode(household.id, 'box-01');
    expect(found?.id, box1.id);
  });

  test('bulkMoveLocationToBox packs nested room + shelf items & unpackBoxToLocation restores them',
      () async {
    final household = await db.ensureDefaultHousehold();
    final locs = await db.getLocations(household.id);
    final kamarUtama = locs.firstWhere((l) => l.name == 'Kamar Utama');
    final ruangKeluarga = locs.firstWhere((l) => l.name == 'Ruang Keluarga');

    final rakBuku = await invRepo.createLocation(
      householdId: household.id,
      parentId: kamarUtama.id,
      name: 'Rak Buku Kamar',
      kind: LocationKind.bookshelf,
    );

    final kasur = await invRepo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Lampu Tidur',
        locationId: kamarUtama.id,
        purchasePrice: 350000,
      ),
    );
    final buku = await invRepo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Clean Architecture',
        locationId: rakBuku.id,
        assetType: AssetType.book,
        purchasePrice: 450000,
      ),
    );
    final tv = await invRepo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Smart TV 55"',
        locationId: ruangKeluarga.id,
        purchasePrice: 8000000,
      ),
    );

    final project = await movingRepo.createProject(
      householdId: household.id,
      draft: const MovingProjectDraft(name: 'Pindahan Uji'),
    );
    final box = await movingRepo.createBox(
      householdId: household.id,
      projectId: project.id,
      draft: const MovingBoxDraft(
        destinationRoom: 'Kamar Utama',
        isFragile: true,
        weightKg: 12.0,
      ),
    );

    // Pack entire Kamar Utama subtree (should pack Lampu Tidur + Clean Architecture, NOT Smart TV)
    final movedCount = await movingRepo.bulkMoveLocationToBox(
      boxId: box.id,
      sourceLocationId: kamarUtama.id,
      includeSubLocations: true,
    );
    expect(movedCount, 2);

    final summaries = MovingRepository.buildBoxSummaries(
      await db.getMovingBoxesForProject(project.id),
      await db.getItems(household.id),
    );
    expect(summaries.single.itemCount, 2);
    expect(summaries.single.totalValue, 800000);
    expect(
      summaries.single.items.map((i) => i.id),
      containsAll([kasur.id, buku.id]),
    );
    expect(summaries.single.items.any((i) => i.id == tv.id), isFalse);

    // Advance status through all 5 stages: packing -> ready -> inTransit -> arrived -> unpacked
    var cur = await movingRepo.advanceBoxStatus(box.id);
    expect(cur?.status, MovingBoxStatus.ready.dbValue);
    cur = await movingRepo.advanceBoxStatus(box.id);
    expect(cur?.status, MovingBoxStatus.inTransit.dbValue);
    cur = await movingRepo.advanceBoxStatus(box.id);
    expect(cur?.status, MovingBoxStatus.arrived.dbValue);

    final statsBeforeUnpack = MovingRepository.computeProjectStats(
      MovingRepository.buildBoxSummaries(
        await db.getMovingBoxesForProject(project.id),
        await db.getItems(household.id),
      ),
    );
    expect(statsBeforeUnpack.deliveryProgress, 1.0);
    expect(statsBeforeUnpack.unpackProgress, 0.0);
    expect(statsBeforeUnpack.fragileBoxCount, 1);
    expect(statsBeforeUnpack.totalWeightKg, 12.0);

    // Unpack box into Ruang Keluarga
    final unpacked = await movingRepo.unpackBoxToLocation(
      boxId: box.id,
      destinationLocationId: ruangKeluarga.id,
    );
    expect(unpacked, 2);

    final boxAfter = await db.getMovingBoxById(box.id);
    expect(boxAfter?.status, MovingBoxStatus.unpacked.dbValue);

    final unpackedKasur = await db.watchItemById(kasur.id).first;
    final unpackedBuku = await db.watchItemById(buku.id).first;
    expect(unpackedKasur?.locationId, ruangKeluarga.id);
    expect(unpackedBuku?.locationId, ruangKeluarga.id);
  });

  test('deleteBox and deleteProject safely preserve packed items without deleting them',
      () async {
    final household = await db.ensureDefaultHousehold();
    final item = await invRepo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Blender Philips'),
    );

    final project = await movingRepo.createProject(
      householdId: household.id,
      draft: const MovingProjectDraft(name: 'Pindahan Sementara'),
    );
    final box = await movingRepo.createBox(
      householdId: household.id,
      projectId: project.id,
      draft: const MovingBoxDraft(destinationRoom: 'Dapur'),
    );

    await movingRepo.bulkMoveItemsToBox(boxId: box.id, itemIds: [item.id]);
    expect((await db.watchItemById(item.id).first)?.locationId, box.locationId);

    await movingRepo.deleteProject(project.id);

    expect(await db.getMovingProjects(household.id), isEmpty);
    expect(await db.getMovingBoxesForProject(project.id), isEmpty);

    // Item must survive safely with locationId detached to null
    final surviving = await db.watchItemById(item.id).first;
    expect(surviving, isNotNull);
    expect(surviving!.locationId, isNull);
  });

  test('SyncEngine pushes and pulls moving_projects & moving_boxes with LWW',
      () async {
    final household = await db.ensureDefaultHousehold();
    final adapter = _MockSyncAdapter();
    when(() => adapter.isConfigured).thenReturn(true);
    when(() => adapter.isAuthenticated).thenReturn(true);
    when(
      () => adapter.upsertRecord(
        table: any(named: 'table'),
        payload: any(named: 'payload'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => adapter.pullDelta(
        table: any(named: 'table'),
        householdId: any(named: 'householdId'),
        sinceUtc: any(named: 'sinceUtc'),
      ),
    ).thenAnswer((_) async => const []);

    final project = await movingRepo.createProject(
      householdId: household.id,
      draft: const MovingProjectDraft(name: 'Sync Move'),
    );
    final box = await movingRepo.createBox(
      householdId: household.id,
      projectId: project.id,
      draft: const MovingBoxDraft(destinationRoom: 'Garasi'),
    );

    final newerTs = DateTime.now().toUtc().add(const Duration(minutes: 5));
    when(
      () => adapter.pullDelta(
        table: 'moving_boxes',
        householdId: household.id,
        sinceUtc: any(named: 'sinceUtc'),
      ),
    ).thenAnswer(
      (_) async => [
        {
          'id': box.id,
          'household_id': household.id,
          'project_id': project.id,
          'location_id': box.locationId,
          'box_code': box.boxCode,
          'label_qr': box.labelQr,
          'destination_room': 'Garasi Baru',
          'status': 'in_transit',
          'is_fragile': true,
          'priority': 'high',
          'weight_kg': 14.5,
          'created_at': box.createdAt.toUtc().toIso8601String(),
          'updated_at': newerTs.toIso8601String(),
          'deleted_at': null,
        },
      ],
    );

    final engine = SyncEngine(db: db, adapter: adapter);
    final res = await engine.synchronize(householdId: household.id);
    expect(res.hasError, isFalse);
    expect(res.pushedCount, 3); // project + linked location + box
    expect(res.pulledCount, 1);

    final syncedBox = await db.getMovingBoxById(box.id);
    expect(syncedBox?.destinationRoom, 'Garasi Baru');
    expect(syncedBox?.status, 'in_transit');
    expect(syncedBox?.isFragile, isTrue);
    expect(syncedBox?.weightKg, 14.5);
  });
}
