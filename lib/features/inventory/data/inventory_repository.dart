import 'package:drift/drift.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/core/utils/formatters.dart';

class LocationCycleException implements Exception {
  const LocationCycleException(this.message);
  final String message;

  @override
  String toString() => message;
}

class LocationTreeNode {
  const LocationTreeNode({
    required this.location,
    required this.depth,
    required this.breadcrumb,
    required this.children,
    required this.directItemCount,
    required this.totalItemCount,
    required this.totalValue,
  });

  final Location location;
  final int depth;
  final String breadcrumb;
  final List<LocationTreeNode> children;
  final int directItemCount;
  final int totalItemCount;
  final double totalValue;
}

class InventorySummary {
  const InventorySummary({
    required this.totalItems,
    required this.totalQuantity,
    required this.totalLocations,
    required this.totalAssetValue,
    required this.countByAssetType,
    required this.recentItems,
  });

  const InventorySummary.empty()
      : totalItems = 0,
        totalQuantity = 0,
        totalLocations = 0,
        totalAssetValue = 0,
        countByAssetType = const {},
        recentItems = const [];

  final int totalItems;
  final int totalQuantity;
  final int totalLocations;
  final double totalAssetValue;
  final Map<AssetType, int> countByAssetType;
  final List<Item> recentItems;
}

class ItemDraft {
  const ItemDraft({
    required this.name,
    this.locationId,
    this.containerItemId,
    this.category = 'Umum',
    this.assetType = AssetType.general,
    this.quantity = 1,
    this.brand,
    this.modelNumber,
    this.serialNumber,
    this.barcode,
    this.purchasePrice,
    this.purchaseDate,
    this.purchaseStore,
    this.estimatedValue,
    this.warrantyExpiresAt,
    this.condition = ItemCondition.good,
    this.usageMode = UsageMode.dailyStatus,
    this.utilityStatus = UtilityStatus.frequent,
    this.utilityRating,
    this.notes,
  });

  final String name;
  final String? locationId;
  final String? containerItemId;
  final String category;
  final AssetType assetType;
  final int quantity;
  final String? brand;
  final String? modelNumber;
  final String? serialNumber;
  final String? barcode;
  final double? purchasePrice;
  final DateTime? purchaseDate;
  final String? purchaseStore;
  final double? estimatedValue;
  final DateTime? warrantyExpiresAt;
  final ItemCondition condition;
  final UsageMode usageMode;
  final UtilityStatus utilityStatus;
  final int? utilityRating;
  final String? notes;
}

class InventoryRepository {
  InventoryRepository({
    required this._db,
    required this._mediaService,
  });

  final AppDatabase _db;
  final MediaStorageService _mediaService;

  // ==========================================================================
  // HOUSEHOLD
  // ==========================================================================

  Future<void> renameHousehold({
    required String householdId,
    required String newName,
  }) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;
    final now = DateTime.now().toUtc();

    await _db.transaction(() async {
      await (_db.update(_db.households)
            ..where((t) => t.id.equals(householdId)))
          .write(
        HouseholdsCompanion(
          name: Value(trimmed),
          updatedAt: Value(now),
        ),
      );
      final updated = await (_db.select(_db.households)
            ..where((t) => t.id.equals(householdId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'households',
        recordId: householdId,
        householdId: householdId,
        operation: 'upsert',
        payload: _householdToPayload(updated),
      );
    });
  }

  // ==========================================================================
  // LOCATIONS
  // ==========================================================================

  Future<Location> createLocation({
    required String householdId,
    String? parentId,
    required String name,
    LocationKind kind = LocationKind.room,
    String? notes,
  }) async {
    final now = DateTime.now().toUtc();
    final id = newUuidV7();
    final qr = buildRumahKuQrUri(entityType: 'loc', id: id);

    late Location created;
    await _db.transaction(() async {
      await _db.into(_db.locations).insert(
            LocationsCompanion.insert(
              id: id,
              householdId: householdId,
              parentId: Value(parentId),
              name: name.trim(),
              kind: Value(kind.dbValue),
              qrCode: Value(qr),
              notes: Value(_nullIfEmpty(notes)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      created = await (_db.select(_db.locations)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'locations',
        recordId: id,
        householdId: householdId,
        operation: 'upsert',
        payload: _locationToPayload(created),
      );
    });
    return created;
  }

  Future<Location> updateLocation({
    required String id,
    required String name,
    required LocationKind kind,
    String? parentId,
    String? notes,
  }) async {
    final createsCycle = await _db.wouldCreateLocationCycle(
      locationId: id,
      candidateParentId: parentId,
    );
    if (createsCycle) {
      throw const LocationCycleException(
        'Lokasi tidak dapat dipindahkan ke dalam dirinya sendiri atau sub-lokasinya.',
      );
    }

    final now = DateTime.now().toUtc();
    late Location updated;
    await _db.transaction(() async {
      await (_db.update(_db.locations)..where((t) => t.id.equals(id))).write(
        LocationsCompanion(
          name: Value(name.trim()),
          kind: Value(kind.dbValue),
          parentId: Value(parentId),
          notes: Value(_nullIfEmpty(notes)),
          updatedAt: Value(now),
        ),
      );
      updated = await (_db.select(_db.locations)..where((t) => t.id.equals(id)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'locations',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _locationToPayload(updated),
      );
    });
    return updated;
  }

  Future<void> deleteLocation(String locationId) async {
    final existing = await (_db.select(_db.locations)
          ..where((t) => t.id.equals(locationId)))
        .getSingleOrNull();
    if (existing == null) return;

    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      // Promote direct children up to existing.parentId so no branch is orphaned.
      final children = await (_db.select(_db.locations)
            ..where(
              (t) => t.parentId.equals(locationId) & t.deletedAt.isNull(),
            ))
          .get();
      for (final child in children) {
        await (_db.update(_db.locations)..where((t) => t.id.equals(child.id)))
            .write(
          LocationsCompanion(
            parentId: Value(existing.parentId),
            updatedAt: Value(now),
          ),
        );
        final refreshed = await (_db.select(_db.locations)
              ..where((t) => t.id.equals(child.id)))
            .getSingle();
        await _db.enqueueOutbox(
          targetTable: 'locations',
          recordId: refreshed.id,
          householdId: refreshed.householdId,
          operation: 'upsert',
          payload: _locationToPayload(refreshed),
        );
      }

      // Move direct items up to existing.parentId as well.
      final locItems = await (_db.select(_db.items)
            ..where(
              (t) => t.locationId.equals(locationId) & t.deletedAt.isNull(),
            ))
          .get();
      for (final item in locItems) {
        await (_db.update(_db.items)..where((t) => t.id.equals(item.id))).write(
          ItemsCompanion(
            locationId: Value(existing.parentId),
            updatedAt: Value(now),
          ),
        );
        final refreshed = await (_db.select(_db.items)
              ..where((t) => t.id.equals(item.id)))
            .getSingle();
        await _db.enqueueOutbox(
          targetTable: 'items',
          recordId: refreshed.id,
          householdId: refreshed.householdId,
          operation: 'upsert',
          payload: _itemToPayload(refreshed),
        );
      }

      // Soft delete the target location.
      await (_db.update(_db.locations)..where((t) => t.id.equals(locationId)))
          .write(
        LocationsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deleted = await (_db.select(_db.locations)
            ..where((t) => t.id.equals(locationId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'locations',
        recordId: deleted.id,
        householdId: deleted.householdId,
        operation: 'delete',
        payload: _locationToPayload(deleted),
      );
    });
  }

  // ==========================================================================
  // ITEMS & ATTACHMENTS
  // ==========================================================================

  Future<Item> createItem({
    required String householdId,
    required ItemDraft draft,
  }) async {
    final now = DateTime.now().toUtc();
    final id = newUuidV7();
    final qr = buildRumahKuQrUri(entityType: 'item', id: id);

    late Item created;
    await _db.transaction(() async {
      await _db.into(_db.items).insert(
            ItemsCompanion.insert(
              id: id,
              householdId: householdId,
              locationId: Value(draft.locationId),
              containerItemId: Value(draft.containerItemId),
              name: draft.name.trim(),
              category: Value(
                draft.category.trim().isEmpty ? 'Umum' : draft.category.trim(),
              ),
              assetType: Value(draft.assetType.dbValue),
              quantity: Value(draft.quantity < 1 ? 1 : draft.quantity),
              brand: Value(_nullIfEmpty(draft.brand)),
              modelNumber: Value(_nullIfEmpty(draft.modelNumber)),
              serialNumber: Value(_nullIfEmpty(draft.serialNumber)),
              barcode: Value(_nullIfEmpty(draft.barcode)),
              qrCode: Value(qr),
              purchasePrice: Value(draft.purchasePrice),
              purchaseDate: Value(draft.purchaseDate?.toUtc()),
              purchaseStore: Value(_nullIfEmpty(draft.purchaseStore)),
              estimatedValue: Value(draft.estimatedValue),
              warrantyExpiresAt: Value(draft.warrantyExpiresAt?.toUtc()),
              condition: Value(draft.condition.dbValue),
              usageMode: Value(draft.usageMode.dbValue),
              utilityStatus: Value(draft.utilityStatus.dbValue),
              utilityRating: Value(draft.utilityRating),
              notes: Value(_nullIfEmpty(draft.notes)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      created =
          await (_db.select(_db.items)..where((t) => t.id.equals(id)))
              .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'items',
        recordId: id,
        householdId: householdId,
        operation: 'upsert',
        payload: _itemToPayload(created),
      );
    });
    return created;
  }

  Future<Item> updateItem({
    required String id,
    required ItemDraft draft,
  }) async {
    if (draft.containerItemId != null && draft.containerItemId == id) {
      throw ArgumentError('Barang tidak dapat dimasukkan ke dalam dirinya sendiri.');
    }

    final now = DateTime.now().toUtc();
    late Item updated;
    await _db.transaction(() async {
      await (_db.update(_db.items)..where((t) => t.id.equals(id))).write(
        ItemsCompanion(
          locationId: Value(draft.locationId),
          containerItemId: Value(draft.containerItemId),
          name: Value(draft.name.trim()),
          category: Value(
            draft.category.trim().isEmpty ? 'Umum' : draft.category.trim(),
          ),
          assetType: Value(draft.assetType.dbValue),
          quantity: Value(draft.quantity < 1 ? 1 : draft.quantity),
          brand: Value(_nullIfEmpty(draft.brand)),
          modelNumber: Value(_nullIfEmpty(draft.modelNumber)),
          serialNumber: Value(_nullIfEmpty(draft.serialNumber)),
          barcode: Value(_nullIfEmpty(draft.barcode)),
          purchasePrice: Value(draft.purchasePrice),
          purchaseDate: Value(draft.purchaseDate?.toUtc()),
          purchaseStore: Value(_nullIfEmpty(draft.purchaseStore)),
          estimatedValue: Value(draft.estimatedValue),
          warrantyExpiresAt: Value(draft.warrantyExpiresAt?.toUtc()),
          condition: Value(draft.condition.dbValue),
          usageMode: Value(draft.usageMode.dbValue),
          utilityStatus: Value(draft.utilityStatus.dbValue),
          utilityRating: Value(draft.utilityRating),
          notes: Value(_nullIfEmpty(draft.notes)),
          updatedAt: Value(now),
        ),
      );
      updated =
          await (_db.select(_db.items)..where((t) => t.id.equals(id)))
              .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'items',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _itemToPayload(updated),
      );
    });
    return updated;
  }

  Future<void> moveItemLocation({
    required String itemId,
    required String? newLocationId,
  }) async {
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await (_db.update(_db.items)..where((t) => t.id.equals(itemId))).write(
        ItemsCompanion(
          locationId: Value(newLocationId),
          updatedAt: Value(now),
        ),
      );
      final updated =
          await (_db.select(_db.items)..where((t) => t.id.equals(itemId)))
              .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'items',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _itemToPayload(updated),
      );
    });
  }

  Future<void> deleteItem(String itemId) async {
    final existing = await (_db.select(_db.items)
          ..where((t) => t.id.equals(itemId)))
        .getSingleOrNull();
    if (existing == null) return;

    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      // Detach nested sub-items rather than silently destroying them.
      await (_db.update(_db.items)
            ..where((t) => t.containerItemId.equals(itemId)))
          .write(
        ItemsCompanion(
          containerItemId: const Value(null),
          updatedAt: Value(now),
        ),
      );

      await (_db.update(_db.items)..where((t) => t.id.equals(itemId))).write(
        ItemsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deleted =
          await (_db.select(_db.items)..where((t) => t.id.equals(itemId)))
              .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'items',
        recordId: deleted.id,
        householdId: deleted.householdId,
        operation: 'delete',
        payload: _itemToPayload(deleted),
      );
    });
  }

  Future<ItemAttachment> addPhotoAttachment({
    required String householdId,
    required String itemId,
    required Uint8List rawImageBytes,
    AttachmentKind kind = AttachmentKind.photo,
    bool? isSensitive,
  }) async {
    final id = newUuidV7();
    final processed = await _mediaService.compressAndSaveImage(
      attachmentId: id,
      rawBytes: rawImageBytes,
    );
    final now = DateTime.now().toUtc();
    final sensitiveFlag = isSensitive ?? kind.isDefaultSensitive;

    late ItemAttachment created;
    await _db.transaction(() async {
      await _db.into(_db.itemAttachments).insert(
            ItemAttachmentsCompanion.insert(
              id: id,
              householdId: householdId,
              itemId: itemId,
              kind: Value(kind.dbValue),
              localPath: Value(processed.localPath),
              mimeType: Value(processed.mimeType),
              fileSizeBytes: Value(processed.fileSizeBytes),
              isSensitive: Value(sensitiveFlag),
              uploadStatus: const Value('pending'),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      created = await (_db.select(_db.itemAttachments)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'item_attachments',
        recordId: id,
        householdId: householdId,
        operation: 'upsert',
        payload: _attachmentToPayload(created),
      );
    });
    return created;
  }

  Future<void> deleteAttachment(String attachmentId) async {
    final existing = await (_db.select(_db.itemAttachments)
          ..where((t) => t.id.equals(attachmentId)))
        .getSingleOrNull();
    if (existing == null) return;

    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await (_db.update(_db.itemAttachments)
            ..where((t) => t.id.equals(attachmentId)))
          .write(
        ItemAttachmentsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deleted = await (_db.select(_db.itemAttachments)
            ..where((t) => t.id.equals(attachmentId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'item_attachments',
        recordId: deleted.id,
        householdId: deleted.householdId,
        operation: 'delete',
        payload: _attachmentToPayload(deleted),
      );
    });
  }

  // ==========================================================================
  // PURE TREE & VALUATION HELPERS
  // ==========================================================================

  /// Computes effective valuation of an active item:
  /// `coalesce(estimatedValue, purchasePrice, 0) * quantity`.
  static double effectiveItemValue(Item item) {
    final unit = item.estimatedValue ?? item.purchasePrice ?? 0;
    return unit * item.quantity;
  }

  /// Builds breadcrumb strings (`Rumah Utama › Kamar Utama › Lemari`) keyed by
  /// location ID.
  static Map<String, String> buildBreadcrumbMap(List<Location> allLocations) {
    final byId = {for (final l in allLocations) l.id: l};
    final result = <String, String>{};

    for (final loc in allLocations) {
      final parts = <String>[];
      final visited = <String>{};
      Location? cursor = loc;
      while (cursor != null && visited.add(cursor.id)) {
        parts.add(cursor.name);
        cursor = cursor.parentId == null ? null : byId[cursor.parentId!];
      }
      result[loc.id] = parts.reversed.join(' › ');
    }
    return result;
  }

  /// Returns a set containing [rootLocationId] and all descendant location IDs.
  static Set<String> collectLocationSubtreeIds(
    String rootLocationId,
    List<Location> allLocations,
  ) {
    final childrenByParent = <String?, List<Location>>{};
    for (final loc in allLocations) {
      childrenByParent.putIfAbsent(loc.parentId, () => []).add(loc);
    }

    final collected = <String>{};
    void visit(String id) {
      if (!collected.add(id)) return;
      for (final child in childrenByParent[id] ?? const <Location>[]) {
        visit(child.id);
      }
    }

    visit(rootLocationId);
    return collected;
  }

  /// Builds a nested [LocationTreeNode] forest with recursive item counts and
  /// total Rupiah valuation rolled up from descendant branches.
  static List<LocationTreeNode> buildLocationTree(
    List<Location> allLocations,
    List<Item> allItems,
  ) {
    final childrenByParent = <String?, List<Location>>{};
    final validIds = {for (final l in allLocations) l.id};
    for (final loc in allLocations) {
      final effectiveParent =
          loc.parentId != null && validIds.contains(loc.parentId)
              ? loc.parentId
              : null;
      childrenByParent.putIfAbsent(effectiveParent, () => []).add(loc);
    }

    final directItemsByLocation = <String, List<Item>>{};
    for (final item in allItems) {
      if (item.locationId != null) {
        directItemsByLocation
            .putIfAbsent(item.locationId!, () => [])
            .add(item);
      }
    }

    final breadcrumbs = buildBreadcrumbMap(allLocations);

    LocationTreeNode buildNode(Location loc, int depth, Set<String> pathGuard) {
      final nextGuard = {...pathGuard, loc.id};
      final rawChildren = childrenByParent[loc.id] ?? const <Location>[];
      final childNodes = <LocationTreeNode>[
        for (final child in rawChildren)
          if (!nextGuard.contains(child.id))
            buildNode(child, depth + 1, nextGuard),
      ];

      final directItems = directItemsByLocation[loc.id] ?? const <Item>[];
      final directValue = directItems.fold<double>(
        0,
        (sum, item) => sum + effectiveItemValue(item),
      );
      final childCount = childNodes.fold<int>(
        0,
        (sum, n) => sum + n.totalItemCount,
      );
      final childValue = childNodes.fold<double>(
        0,
        (sum, n) => sum + n.totalValue,
      );

      return LocationTreeNode(
        location: loc,
        depth: depth,
        breadcrumb: breadcrumbs[loc.id] ?? loc.name,
        children: childNodes,
        directItemCount: directItems.length,
        totalItemCount: directItems.length + childCount,
        totalValue: directValue + childValue,
      );
    }

    final roots = childrenByParent[null] ?? const <Location>[];
    return [for (final root in roots) buildNode(root, 0, const {})];
  }

  static InventorySummary computeSummary(
    List<Location> allLocations,
    List<Item> allItems,
  ) {
    final activeItems = allItems
        .where((i) => i.utilityStatus != UtilityStatus.disposed.dbValue)
        .toList();
    var totalQty = 0;
    var totalVal = 0.0;
    final byType = <AssetType, int>{};

    for (final item in activeItems) {
      totalQty += item.quantity;
      totalVal += effectiveItemValue(item);
      final type = AssetType.fromDb(item.assetType);
      byType[type] = (byType[type] ?? 0) + 1;
    }

    return InventorySummary(
      totalItems: activeItems.length,
      totalQuantity: totalQty,
      totalLocations: allLocations.length,
      totalAssetValue: totalVal,
      countByAssetType: byType,
      recentItems: activeItems.take(6).toList(),
    );
  }

  // ==========================================================================
  // PAYLOAD SERIALIZERS FOR SUPABASE POSTGREST
  // ==========================================================================

  Map<String, dynamic> _householdToPayload(Household h) => {
        'id': h.id,
        'name': h.name,
        'invite_code': h.inviteCode,
        'currency_code': h.currencyCode,
        'created_at': h.createdAt.toUtc().toIso8601String(),
        'updated_at': h.updatedAt.toUtc().toIso8601String(),
        'deleted_at': h.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _locationToPayload(Location l) => {
        'id': l.id,
        'household_id': l.householdId,
        'parent_id': l.parentId,
        'name': l.name,
        'kind': l.kind,
        'qr_code': l.qrCode,
        'notes': l.notes,
        'sort_order': l.sortOrder,
        'created_at': l.createdAt.toUtc().toIso8601String(),
        'updated_at': l.updatedAt.toUtc().toIso8601String(),
        'deleted_at': l.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _itemToPayload(Item i) => {
        'id': i.id,
        'household_id': i.householdId,
        'location_id': i.locationId,
        'container_item_id': i.containerItemId,
        'name': i.name,
        'category': i.category,
        'asset_type': i.assetType,
        'quantity': i.quantity,
        'brand': i.brand,
        'model_number': i.modelNumber,
        'serial_number': i.serialNumber,
        'barcode': i.barcode,
        'qr_code': i.qrCode,
        'purchase_price': i.purchasePrice,
        'purchase_date': i.purchaseDate?.toUtc().toIso8601String(),
        'purchase_store': i.purchaseStore,
        'estimated_value': i.estimatedValue,
        'warranty_expires_at': i.warrantyExpiresAt?.toUtc().toIso8601String(),
        'condition': i.condition,
        'usage_mode': i.usageMode,
        'utility_status': i.utilityStatus,
        'utility_rating': i.utilityRating,
        'usage_count': i.usageCount,
        'last_used_at': i.lastUsedAt?.toUtc().toIso8601String(),
        'notes': i.notes,
        'created_at': i.createdAt.toUtc().toIso8601String(),
        'updated_at': i.updatedAt.toUtc().toIso8601String(),
        'deleted_at': i.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _attachmentToPayload(ItemAttachment a) => {
        'id': a.id,
        'household_id': a.householdId,
        'item_id': a.itemId,
        'kind': a.kind,
        'remote_path': a.remotePath,
        'mime_type': a.mimeType,
        'file_size_bytes': a.fileSizeBytes,
        'page_order': a.pageOrder,
        'is_sensitive': a.isSensitive,
        'upload_status': a.uploadStatus,
        'created_at': a.createdAt.toUtc().toIso8601String(),
        'updated_at': a.updatedAt.toUtc().toIso8601String(),
        'deleted_at': a.deletedAt?.toUtc().toIso8601String(),
      };

  String? _nullIfEmpty(String? v) {
    if (v == null) return null;
    final t = v.trim();
    return t.isEmpty ? null : t;
  }
}
