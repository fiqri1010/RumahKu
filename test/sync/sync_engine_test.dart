import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mocktail/mocktail.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/core/sync/sync_engine.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';

class MockSyncAdapter extends Mock implements SyncAdapter {}

void main() {
  late AppDatabase db;
  late MockSyncAdapter adapter;
  late Map<String, Uint8List> mediaStore;
  late MediaStorageService mediaService;
  late InventoryRepository repo;
  late SyncEngine engine;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    adapter = MockSyncAdapter();
    mediaStore = <String, Uint8List>{};
    mediaService = MediaStorageService(
      saver: ({
        required String fileName,
        required Uint8List bytes,
        required String mimeType,
      }) async {
        final path = 'mem://$fileName';
        mediaStore[path] = bytes;
        return path;
      },
      reader: (path) async => mediaStore[path],
    );
    repo = InventoryRepository(db: db, mediaService: mediaService);
    engine = SyncEngine(
      db: db,
      adapter: adapter,
      mediaBytesLoader: mediaService.readBytes,
    );

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
    when(
      () => adapter.uploadMedia(
        bucket: any(named: 'bucket'),
        remotePath: any(named: 'remotePath'),
        bytes: any(named: 'bytes'),
        mimeType: any(named: 'mimeType'),
      ),
    ).thenAnswer((inv) async => inv.namedArguments[#remotePath] as String);
  });

  tearDown(() async {
    await db.close();
  });

  test('NoopSyncAdapter or offline mode returns noop and preserves local outbox',
      () async {
    final household = await db.ensureDefaultHousehold();
    await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Meja Kerja'),
    );

    final noopEngine = SyncEngine(db: db, adapter: const NoopSyncAdapter());
    final noopResult = await noopEngine.synchronize(householdId: household.id);
    expect(noopResult.pushedCount, 0);
    expect(noopResult.hasError, isFalse);

    final offlineResult = await engine.synchronize(
      householdId: household.id,
      isOnline: false,
    );
    expect(offlineResult.pushedCount, 0);

    final pending = await db.getPendingOutbox();
    expect(pending.length, 1);
  });

  test('pushes offline outbox mutations in strict FIFO order and clears queue',
      () async {
    final household = await db.ensureDefaultHousehold();
    final pushedOrder = <String>[];

    when(
      () => adapter.upsertRecord(
        table: any(named: 'table'),
        payload: any(named: 'payload'),
      ),
    ).thenAnswer((inv) async {
      final table = inv.namedArguments[#table] as String;
      final payload = inv.namedArguments[#payload] as Map<String, dynamic>;
      pushedOrder.add('$table:${payload['id']}:${payload['name']}');
    });

    final loc = await repo.createLocation(
      householdId: household.id,
      name: 'Gudang Belakang',
      kind: LocationKind.room,
    );
    final item = await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(name: 'Tangga Lipat', locationId: loc.id),
    );
    await repo.updateItem(
      id: item.id,
      draft: ItemDraft(name: 'Tangga Lipat Aluminium', locationId: loc.id),
    );

    final result = await engine.synchronize(householdId: household.id);
    expect(result.hasError, isFalse);
    expect(result.pushedCount, 3);
    expect(pushedOrder, [
      'locations:${loc.id}:Gudang Belakang',
      'items:${item.id}:Tangga Lipat',
      'items:${item.id}:Tangga Lipat Aluminium',
    ]);
    expect(await db.getPendingOutbox(), isEmpty);
  });

  test('push error increments retryCount, stores lastError, and keeps outbox entry',
      () async {
    final household = await db.ensureDefaultHousehold();
    await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Kipas Angin'),
    );

    when(
      () => adapter.upsertRecord(
        table: any(named: 'table'),
        payload: any(named: 'payload'),
      ),
    ).thenThrow(Exception('network timeout'));

    final result = await engine.synchronize(householdId: household.id);
    expect(result.hasError, isTrue);
    expect(result.errorMessage, contains('network timeout'));

    final pending = await db.getPendingOutbox();
    expect(pending.length, 1);
    expect(pending.first.retryCount, 1);
    expect(pending.first.lastError, contains('network timeout'));
  });

  test('delta pull applies remote records with LWW conflict resolution and tombstones',
      () async {
    final household = await db.ensureDefaultHousehold();
    final localItem = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'TV Ruang Tamu (Versi Lokal Terbaru)',
        purchasePrice: 7000000,
      ),
    );
    final itemToDeleteRemotely = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Lampu Lama'),
    );

    // Drain outbox first so we isolate pull behavior
    for (final e in await db.getPendingOutbox()) {
      await db.deleteOutboxEntry(e.id);
    }

    final staleRemoteTime =
        localItem.updatedAt.toUtc().subtract(const Duration(minutes: 10));
    final newerRemoteTime =
        DateTime.now().toUtc().add(const Duration(minutes: 5));

    when(
      () => adapter.pullDelta(
        table: 'locations',
        householdId: household.id,
        sinceUtc: any(named: 'sinceUtc'),
      ),
    ).thenAnswer(
      (_) async => [
        {
          'id': 'loc-remote-1',
          'household_id': household.id,
          'parent_id': null,
          'name': 'Balkon Atas',
          'kind': 'room',
          'created_at': newerRemoteTime.toIso8601String(),
          'updated_at': newerRemoteTime.toIso8601String(),
          'deleted_at': null,
        },
      ],
    );

    when(
      () => adapter.pullDelta(
        table: 'items',
        householdId: household.id,
        sinceUtc: any(named: 'sinceUtc'),
      ),
    ).thenAnswer(
      (_) async => [
        // 1. Stale remote update -> must be skipped by LWW
        {
          'id': localItem.id,
          'household_id': household.id,
          'name': 'TV Versi Usang',
          'category': 'Umum',
          'asset_type': 'general',
          'quantity': 1,
          'created_at': staleRemoteTime.toIso8601String(),
          'updated_at': staleRemoteTime.toIso8601String(),
          'deleted_at': null,
        },
        // 2. Brand new remote item referencing the newly pulled location
        {
          'id': 'item-remote-1',
          'household_id': household.id,
          'location_id': 'loc-remote-1',
          'name': 'Kursi Santai Balkon',
          'category': 'Furnitur',
          'asset_type': 'general',
          'quantity': 2,
          'purchase_price': 450000,
          'created_at': newerRemoteTime.toIso8601String(),
          'updated_at': newerRemoteTime.toIso8601String(),
          'deleted_at': null,
        },
        // 3. Newer remote soft-delete tombstone
        {
          'id': itemToDeleteRemotely.id,
          'household_id': household.id,
          'name': itemToDeleteRemotely.name,
          'category': 'Umum',
          'asset_type': 'general',
          'quantity': 1,
          'created_at': itemToDeleteRemotely.createdAt.toUtc().toIso8601String(),
          'updated_at': newerRemoteTime.toIso8601String(),
          'deleted_at': newerRemoteTime.toIso8601String(),
        },
      ],
    );

    final result = await engine.synchronize(householdId: household.id);
    expect(result.hasError, isFalse);
    expect(result.pulledCount, 3); // 1 location + 1 new item + 1 tombstone
    expect(result.skippedLocalNewerCount, 1); // stale TV update skipped

    // Verify local newer item was NOT overwritten
    final tv = await db.watchItemById(localItem.id).first;
    expect(tv?.name, 'TV Ruang Tamu (Versi Lokal Terbaru)');

    // Verify new remote item was persisted
    final remoteChair = await db.watchItemById('item-remote-1').first;
    expect(remoteChair?.name, 'Kursi Santai Balkon');
    expect(remoteChair?.locationId, 'loc-remote-1');

    // Verify tombstone soft-deleted the local item
    final deletedLamp = await db.watchItemById(itemToDeleteRemotely.id).first;
    expect(deletedLamp, isNull);

    // Verify checkpoints were updated
    expect(await db.getCheckpoint('locations'), newerRemoteTime);
    expect(await db.getCheckpoint('items'), newerRemoteTime);
  });

  test('uploads pending media into item-media vs sensitive-docs buckets',
      () async {
    final household = await db.ensureDefaultHousehold();
    final item = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Sertifikat & Foto'),
    );

    final tinyImg = img.Image(width: 64, height: 64);
    img.fill(tinyImg, color: img.ColorRgb8(200, 120, 40));
    final rawPng = Uint8List.fromList(img.encodePng(tinyImg));

    final regularPhoto = await repo.addPhotoAttachment(
      householdId: household.id,
      itemId: item.id,
      rawImageBytes: rawPng,
      kind: AttachmentKind.photo,
    );
    final sensitiveScan = await repo.addPhotoAttachment(
      householdId: household.id,
      itemId: item.id,
      rawImageBytes: rawPng,
      kind: AttachmentKind.docScanPdf,
    );

    final uploadedBuckets = <String, String>{};
    when(
      () => adapter.uploadMedia(
        bucket: any(named: 'bucket'),
        remotePath: any(named: 'remotePath'),
        bytes: any(named: 'bytes'),
        mimeType: any(named: 'mimeType'),
      ),
    ).thenAnswer((inv) async {
      final bucket = inv.namedArguments[#bucket] as String;
      final remotePath = inv.namedArguments[#remotePath] as String;
      uploadedBuckets[remotePath] = bucket;
      return remotePath;
    });

    final result = await engine.synchronize(householdId: household.id);
    expect(result.hasError, isFalse);
    expect(result.uploadedMediaCount, 2);

    final expectedRegularPath = '${household.id}/${item.id}/${regularPhoto.id}.jpg';
    final expectedSensitivePath =
        '${household.id}/${item.id}/${sensitiveScan.id}.jpg';
    expect(uploadedBuckets[expectedRegularPath], 'item-media');
    expect(uploadedBuckets[expectedSensitivePath], 'sensitive-docs');

    final refreshed = await db.watchAttachmentsForItem(item.id).first;
    expect(refreshed.every((a) => a.uploadStatus == 'synced'), isTrue);
    expect(refreshed.every((a) => a.remotePath != null), isTrue);
  });
}
