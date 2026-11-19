import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';

void main() {
  late AppDatabase db;
  late Map<String, Uint8List> memoryMediaStore;
  late MediaStorageService mediaService;
  late InventoryRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    memoryMediaStore = <String, Uint8List>{};
    mediaService = MediaStorageService(
      saver: ({
        required String fileName,
        required Uint8List bytes,
        required String mimeType,
      }) async {
        final path = 'mem://$fileName';
        memoryMediaStore[path] = bytes;
        return path;
      },
      reader: (path) async => memoryMediaStore[path],
    );
    repo = InventoryRepository(db: db, mediaService: mediaService);
  });

  tearDown(() async {
    await db.close();
  });

  test('CRUD items across all AssetTypes, move location, and reject self-container',
      () async {
    final household = await db.ensureDefaultHousehold();
    final locs = await db.getLocations(household.id);
    final ruangKeluarga = locs.firstWhere((l) => l.name == 'Ruang Keluarga');
    final garasi = locs.firstWhere((l) => l.name == 'Garasi');

    final laptop = await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'MacBook Pro M3',
        locationId: ruangKeluarga.id,
        category: 'Elektronik',
        assetType: AssetType.general,
        brand: 'Apple',
        purchasePrice: 28000000,
        estimatedValue: 24000000,
        utilityRating: 5,
      ),
    );
    final motor = await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Honda Vario 160',
        locationId: garasi.id,
        category: 'Kendaraan',
        assetType: AssetType.vehicle,
        purchasePrice: 27000000,
      ),
    );
    final buku = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'Atomic Habits',
        category: 'Pengembangan Diri',
        assetType: AssetType.book,
        purchasePrice: 120000,
      ),
    );
    final akta = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'SHM Rumah Utama',
        category: 'Properti',
        assetType: AssetType.document,
      ),
    );

    expect(laptop.qrCode, startsWith('rumahku://item/'));
    expect(motor.assetType, 'vehicle');
    expect(buku.assetType, 'book');
    expect(akta.assetType, 'document');

    // Update item
    final updatedLaptop = await repo.updateItem(
      id: laptop.id,
      draft: ItemDraft(
        name: 'MacBook Pro M3 14"',
        locationId: ruangKeluarga.id,
        category: 'Kerja',
        purchasePrice: 28000000,
        estimatedValue: 25000000,
      ),
    );
    expect(updatedLaptop.name, 'MacBook Pro M3 14"');
    expect(updatedLaptop.estimatedValue, 25000000);

    // Self-containment must throw ArgumentError
    await expectLater(
      repo.updateItem(
        id: laptop.id,
        draft: ItemDraft(
          name: laptop.name,
          containerItemId: laptop.id,
        ),
      ),
      throwsArgumentError,
    );

    // Move item location
    await repo.moveItemLocation(itemId: laptop.id, newLocationId: garasi.id);
    final moved = await db.watchItemById(laptop.id).first;
    expect(moved?.locationId, garasi.id);

    // Outbox recorded all mutations
    final outbox = await db.getPendingOutbox();
    expect(outbox.length, 6); // 4 creates + 1 update + 1 move
  });

  test('nested sub-items detach cleanly when parent container item is deleted',
      () async {
    final household = await db.ensureDefaultHousehold();
    final motor = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'Honda PCX',
        assetType: AssetType.vehicle,
      ),
    );
    final helm = await repo.createItem(
      householdId: household.id,
      draft: ItemDraft(
        name: 'Helm KYT',
        containerItemId: motor.id,
      ),
    );

    final subItemsBefore = await db.watchSubItems(motor.id).first;
    expect(subItemsBefore.map((i) => i.id), [helm.id]);

    await repo.deleteItem(motor.id);

    final deletedMotor = await db.watchItemById(motor.id).first;
    expect(deletedMotor, isNull);

    final survivingHelm = await db.watchItemById(helm.id).first;
    expect(survivingHelm, isNotNull);
    expect(survivingHelm!.containerItemId, isNull);
  });

  test('addPhotoAttachment compresses oversized image to <=1280px JPEG & sets sensitivity',
      () async {
    final household = await db.ensureDefaultHousehold();
    final item = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(name: 'Paspor RI', assetType: AssetType.document),
    );

    // Generate a real 2000x1000 PNG in memory
    final largeImage = img.Image(width: 2000, height: 1000);
    img.fill(largeImage, color: img.ColorRgb8(15, 118, 110));
    final rawPng = Uint8List.fromList(img.encodePng(largeImage));

    final photoAtt = await repo.addPhotoAttachment(
      householdId: household.id,
      itemId: item.id,
      rawImageBytes: rawPng,
      kind: AttachmentKind.photo,
    );
    final docAtt = await repo.addPhotoAttachment(
      householdId: household.id,
      itemId: item.id,
      rawImageBytes: rawPng,
      kind: AttachmentKind.docScanPdf,
    );

    expect(photoAtt.mimeType, 'image/jpeg');
    expect(photoAtt.isSensitive, isFalse);
    expect(photoAtt.uploadStatus, 'pending');
    expect(docAtt.isSensitive, isTrue);

    final savedBytes = await mediaService.readBytes(photoAtt.localPath!);
    expect(savedBytes, isNotNull);
    final decodedJpg = img.decodeImage(savedBytes!);
    expect(decodedJpg, isNotNull);
    expect(decodedJpg!.width, lessThanOrEqualTo(MediaStorageService.maxDimensionPx));
    expect(decodedJpg.height, lessThanOrEqualTo(MediaStorageService.maxDimensionPx));

    final activeBefore = await db.watchAttachmentsForItem(item.id).first;
    expect(activeBefore.length, 2);

    await repo.deleteAttachment(photoAtt.id);
    final activeAfter = await db.watchAttachmentsForItem(item.id).first;
    expect(activeAfter.map((a) => a.id), [docAtt.id]);
  });

  test('effectiveItemValue and computeSummary exclude disposed items',
      () async {
    final household = await db.ensureDefaultHousehold();
    final locs = await db.getLocations(household.id);

    final activeWithEstimate = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'Kamera Sony',
        quantity: 1,
        purchasePrice: 15000000,
        estimatedValue: 12000000,
        utilityStatus: UtilityStatus.frequent,
      ),
    );
    final activeMultiQty = await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'Kursi Makan',
        quantity: 4,
        purchasePrice: 500000,
        utilityStatus: UtilityStatus.frequent,
      ),
    );
    await repo.createItem(
      householdId: household.id,
      draft: const ItemDraft(
        name: 'Blender Rusak Dijual',
        purchasePrice: 900000,
        utilityStatus: UtilityStatus.disposed,
      ),
    );

    expect(InventoryRepository.effectiveItemValue(activeWithEstimate), 12000000);
    expect(InventoryRepository.effectiveItemValue(activeMultiQty), 2000000);

    final items = await db.getItems(household.id);
    final summary = InventoryRepository.computeSummary(locs, items);

    expect(summary.totalItems, 2);
    expect(summary.totalQuantity, 5);
    expect(summary.totalLocations, locs.length);
    expect(summary.totalAssetValue, 14000000);
  });
}
