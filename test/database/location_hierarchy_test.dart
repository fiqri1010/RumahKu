import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';

MediaStorageService _inMemoryMedia() {
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
  late InventoryRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = InventoryRepository(db: db, mediaService: _inMemoryMedia());
  });

  tearDown(() async {
    await db.close();
  });

  test('ensureDefaultHousehold seeds Rumah Utama + starter rooms idempotently',
      () async {
    final h1 = await db.ensureDefaultHousehold();
    final h2 = await db.ensureDefaultHousehold();

    expect(h1.id, h2.id);
    expect(h1.name, 'Rumah Utama');
    expect(h1.currencyCode, 'IDR');
    expect(h1.inviteCode, isNotEmpty);

    final locations = await db.getLocations(h1.id);
    expect(locations.length, 4);

    final root = locations.singleWhere((l) => l.parentId == null);
    expect(root.name, 'Rumah Utama');
    expect(root.kind, LocationKind.property.dbValue);
    expect(root.qrCode, startsWith('rumahku://loc/'));

    final rooms = locations.where((l) => l.parentId == root.id).toList();
    expect(
      rooms.map((r) => r.name),
      containsAll(['Ruang Keluarga', 'Kamar Utama', 'Garasi']),
    );
  });

  test(
      'recursive location tree builds breadcrumbs, subtree IDs, and rolls up counts & values',
      () async {
    final household = await db.ensureDefaultHousehold();
    final seeded = await db.getLocations(household.id);
    final kamarUtama = seeded.firstWhere((l) => l.name == 'Kamar Utama');

    final lemari = await repo.createLocation(
      householdId: household.id,
      parentId: kamarUtama.id,
      name: 'Lemari Pakaian',
      kind: LocationKind.furniture,
    );
    final kardus = await repo.createLocation(
      householdId: household.id,
      parentId: lemari.id,
      name: 'Kardus Jaket',
      kind: LocationKind.movingBox,
    );

    await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Kasur King',
        locationId: kamarUtama.id,
        purchasePrice: 5000000,
      ),
    );
    await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Jaket Gunung',
        locationId: kardus.id,
        quantity: 2,
        purchasePrice: 750000,
      ),
    );

    final allLocs = await db.getLocations(household.id);
    final allItems = await db.getItems(household.id);

    final breadcrumbs = InventoryRepository.buildBreadcrumbMap(allLocs);
    expect(
      breadcrumbs[kardus.id],
      'Rumah Utama › Kamar Utama › Lemari Pakaian › Kardus Jaket',
    );

    final subtree =
        InventoryRepository.collectLocationSubtreeIds(kamarUtama.id, allLocs);
    expect(subtree, {kamarUtama.id, lemari.id, kardus.id});

    final tree = InventoryRepository.buildLocationTree(allLocs, allItems);
    expect(tree.length, 1);
    final rootNode = tree.first;
    expect(rootNode.totalItemCount, 2);
    expect(rootNode.totalValue, 6500000);

    final kamarNode =
        rootNode.children.firstWhere((c) => c.location.id == kamarUtama.id);
    expect(kamarNode.directItemCount, 1);
    expect(kamarNode.totalItemCount, 2);
    expect(kamarNode.totalValue, 6500000);

    final lemariNode = kamarNode.children.single;
    expect(lemariNode.directItemCount, 0);
    expect(lemariNode.totalItemCount, 1);
    expect(lemariNode.totalValue, 1500000);
  });

  test('updateLocation prevents self-parenting and descendant cycles',
      () async {
    final household = await db.ensureDefaultHousehold();
    final root =
        (await db.getLocations(household.id)).firstWhere((l) => l.parentId == null);

    final room = await repo.createLocation(
      householdId: household.id,
      parentId: root.id,
      name: 'Ruang Kerja',
      kind: LocationKind.room,
    );
    final shelf = await repo.createLocation(
      householdId: household.id,
      parentId: room.id,
      name: 'Rak Buku',
      kind: LocationKind.bookshelf,
    );
    final box = await repo.createLocation(
      householdId: household.id,
      parentId: shelf.id,
      name: 'Kotak Kabel',
      kind: LocationKind.container,
    );

    // Self-parenting must throw LocationCycleException
    await expectLater(
      repo.updateLocation(
        id: room.id,
        name: room.name,
        kind: LocationKind.room,
        parentId: room.id,
      ),
      throwsA(isA<LocationCycleException>()),
    );

    // Descendant-parenting (room -> box) must throw LocationCycleException
    await expectLater(
      repo.updateLocation(
        id: room.id,
        name: room.name,
        kind: LocationKind.room,
        parentId: box.id,
      ),
      throwsA(isA<LocationCycleException>()),
    );

    // Valid reparenting (box -> room) succeeds
    final moved = await repo.updateLocation(
      id: box.id,
      name: 'Kotak Kabel Dipindah',
      kind: LocationKind.container,
      parentId: room.id,
    );
    expect(moved.parentId, room.id);
    expect(moved.name, 'Kotak Kabel Dipindah');
  });

  test('deleteLocation promotes child locations & items up and queues outbox',
      () async {
    final household = await db.ensureDefaultHousehold();
    final kamarUtama = (await db.getLocations(household.id))
        .firstWhere((l) => l.name == 'Kamar Utama');

    final lemari = await repo.createLocation(
      householdId: household.id,
      parentId: kamarUtama.id,
      name: 'Lemari Lama',
      kind: LocationKind.furniture,
    );
    final laci = await repo.createLocation(
      householdId: household.id,
      parentId: lemari.id,
      name: 'Laci Atas',
      kind: LocationKind.container,
    );
    final jamTangan = await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Jam Tangan Seiko',
        locationId: lemari.id,
        purchasePrice: 3200000,
      ),
    );

    // Clear initial creation outbox entries to isolate deleteLocation effects
    for (final entry in await db.getPendingOutbox()) {
      await db.deleteOutboxEntry(entry.id);
    }

    await repo.deleteLocation(lemari.id);

    final activeLocs = await db.getLocations(household.id);
    expect(activeLocs.any((l) => l.id == lemari.id), isFalse);

    final promotedLaci = activeLocs.firstWhere((l) => l.id == laci.id);
    expect(promotedLaci.parentId, kamarUtama.id);

    final activeItems = await db.getItems(household.id);
    final promotedItem = activeItems.firstWhere((i) => i.id == jamTangan.id);
    expect(promotedItem.locationId, kamarUtama.id);

    final outbox = await db.getPendingOutbox();
    expect(outbox.length, 3);
    expect(
      outbox.map((e) => '${e.targetTable}:${e.operation}:${e.recordId}'),
      containsAll([
        'locations:upsert:${laci.id}',
        'items:upsert:${jamTangan.id}',
        'locations:delete:${lemari.id}',
      ]),
    );
  });
}
