import 'package:drift/drift.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';

class MovingProjectDraft {
  const MovingProjectDraft({
    required this.name,
    this.originAddress,
    this.destinationAddress,
    this.targetMoveDate,
    this.status = MovingProjectStatus.planning,
    this.notes,
  });

  final String name;
  final String? originAddress;
  final String? destinationAddress;
  final DateTime? targetMoveDate;
  final MovingProjectStatus status;
  final String? notes;
}

class MovingBoxDraft {
  const MovingBoxDraft({
    this.boxCode,
    this.destinationRoom,
    this.status = MovingBoxStatus.packing,
    this.isFragile = false,
    this.priority = BoxPriority.medium,
    this.weightKg,
    this.notes,
    this.parentLocationId,
  });

  final String? boxCode;
  final String? destinationRoom;
  final MovingBoxStatus status;
  final bool isFragile;
  final BoxPriority priority;
  final double? weightKg;
  final String? notes;
  final String? parentLocationId;
}

class MovingBoxSummary {
  const MovingBoxSummary({
    required this.box,
    required this.items,
    required this.totalQuantity,
    required this.totalValue,
  });

  final MovingBox box;
  final List<Item> items;
  final int totalQuantity;
  final double totalValue;

  int get itemCount => items.length;
  MovingBoxStatus get status => MovingBoxStatus.fromDb(box.status);
  BoxPriority get priority => BoxPriority.fromDb(box.priority);
}

class MovingProjectStats {
  const MovingProjectStats({
    required this.totalBoxes,
    required this.totalItems,
    required this.totalQuantity,
    required this.totalAssetValue,
    required this.totalWeightKg,
    required this.fragileBoxCount,
    required this.countByStatus,
  });

  const MovingProjectStats.empty()
      : totalBoxes = 0,
        totalItems = 0,
        totalQuantity = 0,
        totalAssetValue = 0,
        totalWeightKg = 0,
        fragileBoxCount = 0,
        countByStatus = const {};

  final int totalBoxes;
  final int totalItems;
  final int totalQuantity;
  final double totalAssetValue;
  final double totalWeightKg;
  final int fragileBoxCount;
  final Map<MovingBoxStatus, int> countByStatus;

  int get arrivedOrUnpackedCount =>
      (countByStatus[MovingBoxStatus.arrived] ?? 0) +
      (countByStatus[MovingBoxStatus.unpacked] ?? 0);

  int get unpackedCount => countByStatus[MovingBoxStatus.unpacked] ?? 0;

  double get deliveryProgress =>
      totalBoxes == 0 ? 0 : arrivedOrUnpackedCount / totalBoxes;

  double get unpackProgress =>
      totalBoxes == 0 ? 0 : unpackedCount / totalBoxes;
}

class MovingRepository {
  MovingRepository({required this._db});

  final AppDatabase _db;

  // ==========================================================================
  // MOVING PROJECTS
  // ==========================================================================

  Future<MovingProject> createProject({
    required String householdId,
    required MovingProjectDraft draft,
  }) async {
    final now = DateTime.now().toUtc();
    final id = newUuidV7();

    late MovingProject created;
    await _db.transaction(() async {
      await _db.into(_db.movingProjects).insert(
            MovingProjectsCompanion.insert(
              id: id,
              householdId: householdId,
              name: draft.name.trim(),
              originAddress: Value(_nullIfEmpty(draft.originAddress)),
              destinationAddress: Value(_nullIfEmpty(draft.destinationAddress)),
              targetMoveDate: Value(draft.targetMoveDate?.toUtc()),
              status: Value(draft.status.dbValue),
              notes: Value(_nullIfEmpty(draft.notes)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      created = await (_db.select(_db.movingProjects)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_projects',
        recordId: id,
        householdId: householdId,
        operation: 'upsert',
        payload: _projectToPayload(created),
      );
    });
    return created;
  }

  Future<MovingProject> updateProject({
    required String id,
    required MovingProjectDraft draft,
  }) async {
    final now = DateTime.now().toUtc();
    late MovingProject updated;
    await _db.transaction(() async {
      await (_db.update(_db.movingProjects)..where((t) => t.id.equals(id)))
          .write(
        MovingProjectsCompanion(
          name: Value(draft.name.trim()),
          originAddress: Value(_nullIfEmpty(draft.originAddress)),
          destinationAddress: Value(_nullIfEmpty(draft.destinationAddress)),
          targetMoveDate: Value(draft.targetMoveDate?.toUtc()),
          status: Value(draft.status.dbValue),
          notes: Value(_nullIfEmpty(draft.notes)),
          updatedAt: Value(now),
        ),
      );
      updated = await (_db.select(_db.movingProjects)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_projects',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _projectToPayload(updated),
      );
    });
    return updated;
  }

  Future<void> deleteProject(String projectId) async {
    final existing = await (_db.select(_db.movingProjects)
          ..where((t) => t.id.equals(projectId)))
        .getSingleOrNull();
    if (existing == null) return;

    final boxes = await _db.getMovingBoxesForProject(projectId);
    for (final box in boxes) {
      await deleteBox(box.id);
    }

    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await (_db.update(_db.movingProjects)
            ..where((t) => t.id.equals(projectId)))
          .write(
        MovingProjectsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deleted = await (_db.select(_db.movingProjects)
            ..where((t) => t.id.equals(projectId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_projects',
        recordId: deleted.id,
        householdId: deleted.householdId,
        operation: 'delete',
        payload: _projectToPayload(deleted),
      );
    });
  }

  // ==========================================================================
  // MOVING BOXES (LINKED 1:1 TO A `locations` ROW OF KIND `moving_box`)
  // ==========================================================================

  Future<String> suggestNextBoxCode(String projectId) async {
    final existing = await _db.getMovingBoxesForProject(projectId);
    var maxNum = 0;
    final regex = RegExp(r'(\d+)$');
    for (final box in existing) {
      final match = regex.firstMatch(box.boxCode.trim());
      if (match != null) {
        final parsed = int.tryParse(match.group(1)!) ?? 0;
        if (parsed > maxNum) maxNum = parsed;
      }
    }
    final next = maxNum + 1;
    return 'BOX-${next.toString().padLeft(2, '0')}';
  }

  Future<MovingBox> createBox({
    required String householdId,
    required String projectId,
    required MovingBoxDraft draft,
  }) async {
    final now = DateTime.now().toUtc();
    final boxId = newUuidV7();
    final locationId = newUuidV7();
    final resolvedCode = _nullIfEmpty(draft.boxCode) ??
        await suggestNextBoxCode(projectId);
    final labelQr = buildRumahKuQrUri(entityType: 'box', id: boxId);
    final roomText = _nullIfEmpty(draft.destinationRoom);
    final locationName = roomText == null
        ? 'Kardus $resolvedCode'
        : '$resolvedCode ($roomText)';

    late MovingBox createdBox;
    await _db.transaction(() async {
      // 1. Create linked moving_box Location so Unified Asset items live inside it.
      await _db.into(_db.locations).insert(
            LocationsCompanion.insert(
              id: locationId,
              householdId: householdId,
              parentId: Value(draft.parentLocationId),
              name: locationName,
              kind: Value(LocationKind.movingBox.dbValue),
              qrCode: Value(labelQr),
              notes: Value(_nullIfEmpty(draft.notes)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      final createdLoc = await (_db.select(_db.locations)
            ..where((t) => t.id.equals(locationId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'locations',
        recordId: locationId,
        householdId: householdId,
        operation: 'upsert',
        payload: _locationToPayload(createdLoc),
      );

      // 2. Create MovingBox referencing the new Location.
      await _db.into(_db.movingBoxes).insert(
            MovingBoxesCompanion.insert(
              id: boxId,
              householdId: householdId,
              projectId: projectId,
              locationId: locationId,
              boxCode: resolvedCode,
              labelQr: labelQr,
              destinationRoom: Value(roomText),
              status: Value(draft.status.dbValue),
              isFragile: Value(draft.isFragile),
              priority: Value(draft.priority.dbValue),
              weightKg: Value(draft.weightKg),
              notes: Value(_nullIfEmpty(draft.notes)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      createdBox = await (_db.select(_db.movingBoxes)
            ..where((t) => t.id.equals(boxId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_boxes',
        recordId: boxId,
        householdId: householdId,
        operation: 'upsert',
        payload: _boxToPayload(createdBox),
      );
    });
    return createdBox;
  }

  Future<MovingBox> updateBox({
    required String boxId,
    required MovingBoxDraft draft,
  }) async {
    final existing = await _db.getMovingBoxById(boxId);
    if (existing == null) {
      throw StateError('Kardus tidak ditemukan.');
    }

    final now = DateTime.now().toUtc();
    final resolvedCode = _nullIfEmpty(draft.boxCode) ?? existing.boxCode;
    final roomText = _nullIfEmpty(draft.destinationRoom);
    final locationName = roomText == null
        ? 'Kardus $resolvedCode'
        : '$resolvedCode ($roomText)';

    late MovingBox updated;
    await _db.transaction(() async {
      await (_db.update(_db.movingBoxes)..where((t) => t.id.equals(boxId)))
          .write(
        MovingBoxesCompanion(
          boxCode: Value(resolvedCode),
          destinationRoom: Value(roomText),
          status: Value(draft.status.dbValue),
          isFragile: Value(draft.isFragile),
          priority: Value(draft.priority.dbValue),
          weightKg: Value(draft.weightKg),
          notes: Value(_nullIfEmpty(draft.notes)),
          updatedAt: Value(now),
        ),
      );
      updated = await (_db.select(_db.movingBoxes)
            ..where((t) => t.id.equals(boxId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_boxes',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _boxToPayload(updated),
      );

      // Keep linked Location display name & notes aligned.
      await (_db.update(_db.locations)
            ..where((t) => t.id.equals(existing.locationId)))
          .write(
        LocationsCompanion(
          name: Value(locationName),
          notes: Value(_nullIfEmpty(draft.notes)),
          updatedAt: Value(now),
        ),
      );
      final updatedLoc = await (_db.select(_db.locations)
            ..where((t) => t.id.equals(existing.locationId)))
          .getSingleOrNull();
      if (updatedLoc != null) {
        await _db.enqueueOutbox(
          targetTable: 'locations',
          recordId: updatedLoc.id,
          householdId: updatedLoc.householdId,
          operation: 'upsert',
          payload: _locationToPayload(updatedLoc),
        );
      }
    });
    return updated;
  }

  Future<MovingBox> updateBoxStatus({
    required String boxId,
    required MovingBoxStatus status,
  }) async {
    final now = DateTime.now().toUtc();
    late MovingBox updated;
    await _db.transaction(() async {
      await (_db.update(_db.movingBoxes)..where((t) => t.id.equals(boxId)))
          .write(
        MovingBoxesCompanion(
          status: Value(status.dbValue),
          updatedAt: Value(now),
        ),
      );
      updated = await (_db.select(_db.movingBoxes)
            ..where((t) => t.id.equals(boxId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_boxes',
        recordId: updated.id,
        householdId: updated.householdId,
        operation: 'upsert',
        payload: _boxToPayload(updated),
      );
    });
    return updated;
  }

  Future<MovingBox?> advanceBoxStatus(String boxId) async {
    final existing = await _db.getMovingBoxById(boxId);
    if (existing == null) return null;
    final next = MovingBoxStatus.fromDb(existing.status).nextStatus;
    if (next == null) return existing;
    return updateBoxStatus(boxId: boxId, status: next);
  }

  Future<void> deleteBox(
    String boxId, {
    String? returnItemsToLocationId,
  }) async {
    final existing = await _db.getMovingBoxById(boxId);
    if (existing == null) return;

    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      // Preserve all items currently inside the box by moving them back safely.
      final boxItems = await (_db.select(_db.items)
            ..where(
              (t) =>
                  t.locationId.equals(existing.locationId) &
                  t.deletedAt.isNull(),
            ))
          .get();
      for (final item in boxItems) {
        await (_db.update(_db.items)..where((t) => t.id.equals(item.id))).write(
          ItemsCompanion(
            locationId: Value(returnItemsToLocationId),
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

      // Soft-delete the moving_box record.
      await (_db.update(_db.movingBoxes)..where((t) => t.id.equals(boxId)))
          .write(
        MovingBoxesCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deletedBox = await (_db.select(_db.movingBoxes)
            ..where((t) => t.id.equals(boxId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_boxes',
        recordId: deletedBox.id,
        householdId: deletedBox.householdId,
        operation: 'delete',
        payload: _boxToPayload(deletedBox),
      );

      // Soft-delete the linked Location node.
      await (_db.update(_db.locations)
            ..where((t) => t.id.equals(existing.locationId)))
          .write(
        LocationsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      final deletedLoc = await (_db.select(_db.locations)
            ..where((t) => t.id.equals(existing.locationId)))
          .getSingleOrNull();
      if (deletedLoc != null) {
        await _db.enqueueOutbox(
          targetTable: 'locations',
          recordId: deletedLoc.id,
          householdId: deletedLoc.householdId,
          operation: 'delete',
          payload: _locationToPayload(deletedLoc),
        );
      }
    });
  }

  // ==========================================================================
  // BULK PACKING & UNPACKING
  // ==========================================================================

  /// Moves a batch of items into [boxId]'s linked location atomically.
  Future<int> bulkMoveItemsToBox({
    required String boxId,
    required List<String> itemIds,
  }) async {
    if (itemIds.isEmpty) return 0;
    final box = await _db.getMovingBoxById(boxId);
    if (box == null) return 0;

    final uniqueIds = itemIds.toSet().toList();
    final now = DateTime.now().toUtc();
    var movedCount = 0;

    await _db.transaction(() async {
      for (final itemId in uniqueIds) {
        final item = await (_db.select(_db.items)
              ..where((t) => t.id.equals(itemId) & t.deletedAt.isNull()))
            .getSingleOrNull();
        if (item == null || item.locationId == box.locationId) continue;

        await (_db.update(_db.items)..where((t) => t.id.equals(itemId))).write(
          ItemsCompanion(
            locationId: Value(box.locationId),
            updatedAt: Value(now),
          ),
        );
        final refreshed = await (_db.select(_db.items)
              ..where((t) => t.id.equals(itemId)))
            .getSingle();
        await _db.enqueueOutbox(
          targetTable: 'items',
          recordId: refreshed.id,
          householdId: refreshed.householdId,
          operation: 'upsert',
          payload: _itemToPayload(refreshed),
        );
        movedCount++;
      }
    });

    return movedCount;
  }

  /// Packs every active item inside [sourceLocationId] (and optionally all its
  /// nested sub-locations, e.g. an entire bookshelf or cabinet) into [boxId].
  Future<int> bulkMoveLocationToBox({
    required String boxId,
    required String sourceLocationId,
    bool includeSubLocations = true,
  }) async {
    final box = await _db.getMovingBoxById(boxId);
    if (box == null) return 0;

    final allLocs = await _db.getLocations(box.householdId);
    final sourceIds = includeSubLocations
        ? InventoryRepository.collectLocationSubtreeIds(
            sourceLocationId,
            allLocs,
          )
        : {sourceLocationId};
    sourceIds.remove(box.locationId);
    if (sourceIds.isEmpty) return 0;

    final allItems = await _db.getItems(box.householdId);
    final targetItemIds = [
      for (final item in allItems)
        if (item.locationId != null && sourceIds.contains(item.locationId))
          item.id,
    ];
    return bulkMoveItemsToBox(boxId: boxId, itemIds: targetItemIds);
  }

  /// Removes a single item from a box and optionally places it into
  /// [targetLocationId] (or unplaced if null).
  Future<void> removeItemFromBox({
    required String itemId,
    String? targetLocationId,
  }) async {
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await (_db.update(_db.items)..where((t) => t.id.equals(itemId))).write(
        ItemsCompanion(
          locationId: Value(targetLocationId),
          updatedAt: Value(now),
        ),
      );
      final refreshed = await (_db.select(_db.items)
            ..where((t) => t.id.equals(itemId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'items',
        recordId: refreshed.id,
        householdId: refreshed.householdId,
        operation: 'upsert',
        payload: _itemToPayload(refreshed),
      );
    });
  }

  /// Moves all items currently packed in [boxId] into [destinationLocationId]
  /// and marks the box status as [MovingBoxStatus.unpacked] atomically.
  Future<int> unpackBoxToLocation({
    required String boxId,
    required String? destinationLocationId,
  }) async {
    final box = await _db.getMovingBoxById(boxId);
    if (box == null) return 0;

    final now = DateTime.now().toUtc();
    var unpackedCount = 0;

    await _db.transaction(() async {
      final boxItems = await (_db.select(_db.items)
            ..where(
              (t) =>
                  t.locationId.equals(box.locationId) & t.deletedAt.isNull(),
            ))
          .get();

      for (final item in boxItems) {
        await (_db.update(_db.items)..where((t) => t.id.equals(item.id))).write(
          ItemsCompanion(
            locationId: Value(destinationLocationId),
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
        unpackedCount++;
      }

      await (_db.update(_db.movingBoxes)..where((t) => t.id.equals(boxId)))
          .write(
        MovingBoxesCompanion(
          status: Value(MovingBoxStatus.unpacked.dbValue),
          updatedAt: Value(now),
        ),
      );
      final updatedBox = await (_db.select(_db.movingBoxes)
            ..where((t) => t.id.equals(boxId)))
          .getSingle();
      await _db.enqueueOutbox(
        targetTable: 'moving_boxes',
        recordId: updatedBox.id,
        householdId: updatedBox.householdId,
        operation: 'upsert',
        payload: _boxToPayload(updatedBox),
      );
    });

    return unpackedCount;
  }

  // ==========================================================================
  // PURE AGGREGATION HELPERS
  // ==========================================================================

  static List<MovingBoxSummary> buildBoxSummaries(
    List<MovingBox> boxes,
    List<Item> allItems,
  ) {
    final itemsByLoc = <String, List<Item>>{};
    for (final item in allItems) {
      if (item.locationId != null) {
        itemsByLoc.putIfAbsent(item.locationId!, () => []).add(item);
      }
    }

    return [
      for (final box in boxes)
        () {
          final packed = itemsByLoc[box.locationId] ?? const <Item>[];
          final totalQty = packed.fold<int>(0, (s, i) => s + i.quantity);
          final totalVal = packed.fold<double>(
            0,
            (s, i) => s + InventoryRepository.effectiveItemValue(i),
          );
          return MovingBoxSummary(
            box: box,
            items: packed,
            totalQuantity: totalQty,
            totalValue: totalVal,
          );
        }(),
    ];
  }

  static MovingProjectStats computeProjectStats(
    List<MovingBoxSummary> summaries,
  ) {
    if (summaries.isEmpty) return const MovingProjectStats.empty();

    var totalItems = 0;
    var totalQty = 0;
    var totalVal = 0.0;
    var totalWeight = 0.0;
    var fragileCount = 0;
    final byStatus = <MovingBoxStatus, int>{};

    for (final s in summaries) {
      totalItems += s.itemCount;
      totalQty += s.totalQuantity;
      totalVal += s.totalValue;
      totalWeight += s.box.weightKg ?? 0;
      if (s.box.isFragile) fragileCount++;
      final status = s.status;
      byStatus[status] = (byStatus[status] ?? 0) + 1;
    }

    return MovingProjectStats(
      totalBoxes: summaries.length,
      totalItems: totalItems,
      totalQuantity: totalQty,
      totalAssetValue: totalVal,
      totalWeightKg: totalWeight,
      fragileBoxCount: fragileCount,
      countByStatus: byStatus,
    );
  }

  // ==========================================================================
  // PAYLOAD SERIALIZERS FOR SUPABASE POSTGREST
  // ==========================================================================

  Map<String, dynamic> _projectToPayload(MovingProject p) => {
        'id': p.id,
        'household_id': p.householdId,
        'name': p.name,
        'origin_address': p.originAddress,
        'destination_address': p.destinationAddress,
        'target_move_date': p.targetMoveDate?.toUtc().toIso8601String(),
        'status': p.status,
        'notes': p.notes,
        'created_at': p.createdAt.toUtc().toIso8601String(),
        'updated_at': p.updatedAt.toUtc().toIso8601String(),
        'deleted_at': p.deletedAt?.toUtc().toIso8601String(),
      };

  Map<String, dynamic> _boxToPayload(MovingBox b) => {
        'id': b.id,
        'household_id': b.householdId,
        'project_id': b.projectId,
        'location_id': b.locationId,
        'box_code': b.boxCode,
        'label_qr': b.labelQr,
        'destination_room': b.destinationRoom,
        'status': b.status,
        'is_fragile': b.isFragile,
        'priority': b.priority,
        'weight_kg': b.weightKg,
        'notes': b.notes,
        'created_at': b.createdAt.toUtc().toIso8601String(),
        'updated_at': b.updatedAt.toUtc().toIso8601String(),
        'deleted_at': b.deletedAt?.toUtc().toIso8601String(),
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

  String? _nullIfEmpty(String? v) {
    if (v == null) return null;
    final t = v.trim();
    return t.isEmpty ? null : t;
  }
}
