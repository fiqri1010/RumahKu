import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';

typedef MediaBytesLoader = Future<Uint8List?> Function(String localPath);

/// Orchestrates offline-first FIFO outbox pushing, delta pulling with
/// Last-Write-Wins (LWW) conflict resolution, and pending attachment uploads.
class SyncEngine {
  SyncEngine({
    required this._db,
    required this._adapter,
    this._mediaBytesLoader,
  });

  final AppDatabase _db;
  final SyncAdapter _adapter;
  final MediaBytesLoader? _mediaBytesLoader;

  /// Ordered parent-first tables so foreign keys resolve cleanly during pull.
  static const List<String> syncTables = [
    'households',
    'locations',
    'items',
    'item_attachments',
  ];

  bool _isRunning = false;

  Future<SyncResult> synchronize({
    required String householdId,
    bool isOnline = true,
  }) async {
    if (!_adapter.isConfigured || !_adapter.isAuthenticated || !isOnline) {
      return const SyncResult.noop();
    }
    if (_isRunning) {
      return const SyncResult.noop();
    }

    _isRunning = true;
    var pushed = 0;
    var pulled = 0;
    var skippedLocalNewer = 0;
    var uploadedMedia = 0;

    try {
      // 1. Push pending local mutations (FIFO)
      while (true) {
        final batch = await _db.getPendingOutbox(limit: 50);
        if (batch.isEmpty) break;

        var madeProgress = false;
        for (final entry in batch) {
          try {
            final payload =
                jsonDecode(entry.payloadJson) as Map<String, dynamic>;
            await _adapter.upsertRecord(
              table: entry.targetTable,
              payload: payload,
            );
            await _db.deleteOutboxEntry(entry.id);
            pushed++;
            madeProgress = true;
          } catch (e) {
            await _db.markOutboxError(entry.id, e.toString());
            return SyncResult(
              pushedCount: pushed,
              pulledCount: pulled,
              skippedLocalNewerCount: skippedLocalNewer,
              uploadedMediaCount: uploadedMedia,
              errorMessage: e.toString(),
            );
          }
        }
        if (!madeProgress) break;
      }

      // 2. Upload pending compressed media/attachments
      if (_mediaBytesLoader != null) {
        final pendingMedia = await _db.getPendingMediaUploads(householdId);
        for (final att in pendingMedia) {
          final localPath = att.localPath;
          if (localPath == null) continue;
          final bytes = await _mediaBytesLoader(localPath);
          if (bytes == null) continue;

          final bucket = att.isSensitive ? 'sensitive-docs' : 'item-media';
          final ext = att.mimeType == 'application/pdf' ? '.pdf' : '.jpg';
          final remotePath = '${att.householdId}/${att.itemId}/${att.id}$ext';

          await _adapter.uploadMedia(
            bucket: bucket,
            remotePath: remotePath,
            bytes: bytes,
            mimeType: att.mimeType,
          );

          final now = DateTime.now().toUtc();
          await (_db.update(_db.itemAttachments)
                ..where((t) => t.id.equals(att.id)))
              .write(
            ItemAttachmentsCompanion(
              remotePath: Value(remotePath),
              uploadStatus: const Value('synced'),
              updatedAt: Value(now),
            ),
          );
          uploadedMedia++;
        }
      }

      // 3. Pull remote deltas per table and apply with LWW
      for (final table in syncTables) {
        final since = await _db.getCheckpoint(table);
        final rows = await _adapter.pullDelta(
          table: table,
          householdId: householdId,
          sinceUtc: since,
        );
        DateTime? maxUpdatedAt = since;
        for (final row in rows) {
          final applied = await _db.applyRemoteRecord(table, row);
          if (applied) {
            pulled++;
          } else {
            skippedLocalNewer++;
          }
          final rowTs = DateTime.tryParse('${row['updated_at']}')?.toUtc();
          if (rowTs != null &&
              (maxUpdatedAt == null || rowTs.isAfter(maxUpdatedAt))) {
            maxUpdatedAt = rowTs;
          }
        }
        if (maxUpdatedAt != null) {
          await _db.setCheckpoint(table, maxUpdatedAt);
        }
      }

      return SyncResult(
        pushedCount: pushed,
        pulledCount: pulled,
        skippedLocalNewerCount: skippedLocalNewer,
        uploadedMediaCount: uploadedMedia,
      );
    } catch (e) {
      return SyncResult(
        pushedCount: pushed,
        pulledCount: pulled,
        skippedLocalNewerCount: skippedLocalNewer,
        uploadedMediaCount: uploadedMedia,
        errorMessage: e.toString(),
      );
    } finally {
      _isRunning = false;
    }
  }
}
