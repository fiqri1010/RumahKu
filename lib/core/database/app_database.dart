import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:rumahku/core/database/tables.dart';
import 'package:rumahku/core/utils/formatters.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Households,
    HouseholdMembers,
    Locations,
    Items,
    ItemAttachments,
    AssetLoans,
    UsageLogs,
    Books,
    Documents,
    Vehicles,
    VehicleServiceLogs,
    VehicleFuelLogs,
    MovingProjects,
    MovingBoxes,
    Reminders,
    SyncOutbox,
    SyncCheckpoints,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults()
      : super(
          driftDatabase(
            name: 'rumahku_db',
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
            ),
          ),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_locations_household ON locations (household_id, deleted_at);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_locations_parent ON locations (parent_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_items_household ON items (household_id, deleted_at);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_items_location ON items (location_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_items_asset_type ON items (household_id, asset_type);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_attachments_item ON item_attachments (item_id);',
          );
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  // ==========================================================================
  // HOUSEHOLD BOOTSTRAP
  // ==========================================================================

  /// Ensures at least one active local household exists on first launch so the
  /// user can use RumahKu immediately offline without forced cloud login.
  Future<Household> ensureDefaultHousehold() async {
    final existing = await (select(households)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    final householdId = newUuidV7();
    final inviteCode = generateInviteCode();
    final rootLocationId = newUuidV7();
    final livingRoomId = newUuidV7();
    final bedroomId = newUuidV7();
    final garageId = newUuidV7();

    await transaction(() async {
      await into(households).insert(
        HouseholdsCompanion.insert(
          id: householdId,
          name: 'Rumah Utama',
          inviteCode: inviteCode,
          currencyCode: const Value('IDR'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      // Seed helpful starter hierarchy so the user sees how locations nest.
      final starterLocations = [
        LocationsCompanion.insert(
          id: rootLocationId,
          householdId: householdId,
          parentId: const Value(null),
          name: 'Rumah Utama',
          kind: const Value('property'),
          qrCode: Value(buildRumahKuQrUri(entityType: 'loc', id: rootLocationId)),
          sortOrder: const Value(0),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
        LocationsCompanion.insert(
          id: livingRoomId,
          householdId: householdId,
          parentId: Value(rootLocationId),
          name: 'Ruang Keluarga',
          kind: const Value('room'),
          qrCode: Value(buildRumahKuQrUri(entityType: 'loc', id: livingRoomId)),
          sortOrder: const Value(1),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
        LocationsCompanion.insert(
          id: bedroomId,
          householdId: householdId,
          parentId: Value(rootLocationId),
          name: 'Kamar Utama',
          kind: const Value('room'),
          qrCode: Value(buildRumahKuQrUri(entityType: 'loc', id: bedroomId)),
          sortOrder: const Value(2),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
        LocationsCompanion.insert(
          id: garageId,
          householdId: householdId,
          parentId: Value(rootLocationId),
          name: 'Garasi',
          kind: const Value('room'),
          qrCode: Value(buildRumahKuQrUri(entityType: 'loc', id: garageId)),
          sortOrder: const Value(3),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      ];

      for (final loc in starterLocations) {
        await into(locations).insert(loc);
      }
    });

    return (select(households)..where((t) => t.id.equals(householdId)))
        .getSingle();
  }

  Stream<Household?> watchActiveHousehold() {
    return (select(households)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  // ==========================================================================
  // LOCATIONS
  // ==========================================================================

  Stream<List<Location>> watchLocations(String householdId) {
    return (select(locations)
          ..where(
            (t) => t.householdId.equals(householdId) & t.deletedAt.isNull(),
          )
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.name),
          ]))
        .watch();
  }

  Future<List<Location>> getLocations(String householdId) {
    return (select(locations)
          ..where(
            (t) => t.householdId.equals(householdId) & t.deletedAt.isNull(),
          )
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.name),
          ]))
        .get();
  }

  /// Returns true if assigning [candidateParentId] as the parent of
  /// [locationId] would introduce a cycle (including self-parenting).
  Future<bool> wouldCreateLocationCycle({
    required String locationId,
    required String? candidateParentId,
  }) async {
    if (candidateParentId == null) return false;
    if (candidateParentId == locationId) return true;

    String? cursor = candidateParentId;
    final visited = <String>{locationId};
    while (cursor != null) {
      if (!visited.add(cursor)) return true;
      final row = await (select(locations)..where((t) => t.id.equals(cursor!)))
          .getSingleOrNull();
      cursor = row?.parentId;
    }
    return false;
  }

  // ==========================================================================
  // ITEMS & ATTACHMENTS
  // ==========================================================================

  Stream<List<Item>> watchItems(String householdId) {
    return (select(items)
          ..where(
            (t) => t.householdId.equals(householdId) & t.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  Future<List<Item>> getItems(String householdId) {
    return (select(items)
          ..where(
            (t) => t.householdId.equals(householdId) & t.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }

  Stream<Item?> watchItemById(String itemId) {
    return (select(items)
          ..where((t) => t.id.equals(itemId) & t.deletedAt.isNull()))
        .watchSingleOrNull();
  }

  Stream<List<Item>> watchSubItems(String containerItemId) {
    return (select(items)
          ..where(
            (t) =>
                t.containerItemId.equals(containerItemId) &
                t.deletedAt.isNull(),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  Stream<List<ItemAttachment>> watchAttachmentsForItem(String itemId) {
    return (select(itemAttachments)
          ..where((t) => t.itemId.equals(itemId) & t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.asc(t.pageOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Future<List<ItemAttachment>> getPendingMediaUploads(String householdId) {
    return (select(itemAttachments)
          ..where(
            (t) =>
                t.householdId.equals(householdId) &
                t.deletedAt.isNull() &
                t.uploadStatus.equals('pending') &
                t.localPath.isNotNull(),
          ))
        .get();
  }

  // ==========================================================================
  // SYNC OUTBOX & CHECKPOINTS
  // ==========================================================================

  Future<void> enqueueOutbox({
    required String targetTable,
    required String recordId,
    required String householdId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await into(syncOutbox).insert(
      SyncOutboxCompanion.insert(
        targetTable: targetTable,
        recordId: recordId,
        householdId: householdId,
        operation: operation,
        payloadJson: jsonEncode(payload),
        queuedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Stream<int> watchPendingOutboxCount() {
    final countExp = syncOutbox.id.count();
    final query = selectOnly(syncOutbox)..addColumns([countExp]);
    return query.watchSingle().map((row) => row.read(countExp) ?? 0);
  }

  Future<List<SyncOutboxData>> getPendingOutbox({int limit = 50}) {
    return (select(syncOutbox)
          ..orderBy([(t) => OrderingTerm.asc(t.id)])
          ..limit(limit))
        .get();
  }

  Future<void> deleteOutboxEntry(int id) async {
    await (delete(syncOutbox)..where((t) => t.id.equals(id))).go();
  }

  Future<void> markOutboxError(int id, String error) async {
    final current =
        await (select(syncOutbox)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (current == null) return;
    await (update(syncOutbox)..where((t) => t.id.equals(id))).write(
      SyncOutboxCompanion(
        retryCount: Value(current.retryCount + 1),
        lastError: Value(error),
      ),
    );
  }

  Future<DateTime?> getCheckpoint(String targetTable) async {
    final row = await (select(syncCheckpoints)
          ..where((t) => t.targetTable.equals(targetTable)))
        .getSingleOrNull();
    return row?.lastPulledAt;
  }

  Future<void> setCheckpoint(String targetTable, DateTime timestamp) async {
    await into(syncCheckpoints).insertOnConflictUpdate(
      SyncCheckpointsCompanion.insert(
        targetTable: targetTable,
        lastPulledAt: timestamp.toUtc(),
      ),
    );
  }

  // ==========================================================================
  // REMOTE DELTA APPLICATION (LAST-WRITE-WINS)
  // ==========================================================================

  /// Applies a remote record from cloud sync using Last-Write-Wins (LWW)
  /// semantics on `updated_at`. Returns `true` if applied, `false` if skipped
  /// because local data is newer.
  Future<bool> applyRemoteRecord(
    String targetTable,
    Map<String, dynamic> remote,
  ) async {
    final remoteUpdatedAt = _parseDateTime(remote['updated_at']);
    if (remoteUpdatedAt == null) return false;

    switch (targetTable) {
      case 'households':
        final id = remote['id'] as String;
        final local =
            await (select(households)..where((t) => t.id.equals(id)))
                .getSingleOrNull();
        if (local != null && local.updatedAt.toUtc().isAfter(remoteUpdatedAt)) {
          return false;
        }
        await into(households).insertOnConflictUpdate(
          HouseholdsCompanion(
            id: Value(id),
            name: Value(remote['name'] as String),
            inviteCode: Value(remote['invite_code'] as String),
            currencyCode: Value((remote['currency_code'] as String?) ?? 'IDR'),
            createdAt: Value(_parseDateTime(remote['created_at']) ?? remoteUpdatedAt),
            updatedAt: Value(remoteUpdatedAt),
            deletedAt: Value(_parseDateTime(remote['deleted_at'])),
          ),
        );
        return true;

      case 'locations':
        final id = remote['id'] as String;
        final local =
            await (select(locations)..where((t) => t.id.equals(id)))
                .getSingleOrNull();
        if (local != null && local.updatedAt.toUtc().isAfter(remoteUpdatedAt)) {
          return false;
        }
        await into(locations).insertOnConflictUpdate(
          LocationsCompanion(
            id: Value(id),
            householdId: Value(remote['household_id'] as String),
            parentId: Value(remote['parent_id'] as String?),
            name: Value(remote['name'] as String),
            kind: Value((remote['kind'] as String?) ?? 'room'),
            qrCode: Value(remote['qr_code'] as String?),
            notes: Value(remote['notes'] as String?),
            sortOrder: Value((remote['sort_order'] as num?)?.toInt() ?? 0),
            createdAt: Value(_parseDateTime(remote['created_at']) ?? remoteUpdatedAt),
            updatedAt: Value(remoteUpdatedAt),
            deletedAt: Value(_parseDateTime(remote['deleted_at'])),
          ),
        );
        return true;

      case 'items':
        final id = remote['id'] as String;
        final local =
            await (select(items)..where((t) => t.id.equals(id)))
                .getSingleOrNull();
        if (local != null && local.updatedAt.toUtc().isAfter(remoteUpdatedAt)) {
          return false;
        }
        final customFieldsRaw = remote['custom_fields_json'];
        final customFieldsStr = customFieldsRaw is String
            ? customFieldsRaw
            : jsonEncode(customFieldsRaw ?? <String, dynamic>{});
        await into(items).insertOnConflictUpdate(
          ItemsCompanion(
            id: Value(id),
            householdId: Value(remote['household_id'] as String),
            locationId: Value(remote['location_id'] as String?),
            containerItemId: Value(remote['container_item_id'] as String?),
            name: Value(remote['name'] as String),
            category: Value((remote['category'] as String?) ?? 'Umum'),
            assetType: Value((remote['asset_type'] as String?) ?? 'general'),
            quantity: Value((remote['quantity'] as num?)?.toInt() ?? 1),
            brand: Value(remote['brand'] as String?),
            modelNumber: Value(remote['model_number'] as String?),
            serialNumber: Value(remote['serial_number'] as String?),
            barcode: Value(remote['barcode'] as String?),
            qrCode: Value(remote['qr_code'] as String?),
            purchasePrice: Value((remote['purchase_price'] as num?)?.toDouble()),
            purchaseDate: Value(_parseDateTime(remote['purchase_date'])),
            purchaseStore: Value(remote['purchase_store'] as String?),
            estimatedValue: Value((remote['estimated_value'] as num?)?.toDouble()),
            warrantyExpiresAt: Value(_parseDateTime(remote['warranty_expires_at'])),
            condition: Value((remote['condition'] as String?) ?? 'good'),
            usageMode: Value((remote['usage_mode'] as String?) ?? 'daily_status'),
            utilityStatus: Value((remote['utility_status'] as String?) ?? 'frequent'),
            utilityRating: Value((remote['utility_rating'] as num?)?.toInt()),
            usageCount: Value((remote['usage_count'] as num?)?.toInt() ?? 0),
            lastUsedAt: Value(_parseDateTime(remote['last_used_at'])),
            notes: Value(remote['notes'] as String?),
            customFieldsJson: Value(customFieldsStr),
            createdAt: Value(_parseDateTime(remote['created_at']) ?? remoteUpdatedAt),
            updatedAt: Value(remoteUpdatedAt),
            deletedAt: Value(_parseDateTime(remote['deleted_at'])),
          ),
        );
        return true;

      case 'item_attachments':
        final id = remote['id'] as String;
        final local =
            await (select(itemAttachments)..where((t) => t.id.equals(id)))
                .getSingleOrNull();
        if (local != null && local.updatedAt.toUtc().isAfter(remoteUpdatedAt)) {
          return false;
        }
        await into(itemAttachments).insertOnConflictUpdate(
          ItemAttachmentsCompanion(
            id: Value(id),
            householdId: Value(remote['household_id'] as String),
            itemId: Value(remote['item_id'] as String),
            kind: Value((remote['kind'] as String?) ?? 'photo'),
            localPath: Value(local?.localPath ?? remote['local_path'] as String?),
            remotePath: Value(remote['remote_path'] as String?),
            mimeType: Value((remote['mime_type'] as String?) ?? 'image/jpeg'),
            fileSizeBytes: Value((remote['file_size_bytes'] as num?)?.toInt()),
            pageOrder: Value((remote['page_order'] as num?)?.toInt() ?? 0),
            isSensitive: Value((remote['is_sensitive'] as bool?) ?? false),
            uploadStatus: Value((remote['upload_status'] as String?) ?? 'synced'),
            createdAt: Value(_parseDateTime(remote['created_at']) ?? remoteUpdatedAt),
            updatedAt: Value(remoteUpdatedAt),
            deletedAt: Value(_parseDateTime(remote['deleted_at'])),
          ),
        );
        return true;

      default:
        return false;
    }
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value.toUtc();
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value)?.toUtc();
    }
    return null;
  }
}
