import 'dart:typed_data';

enum SyncStatus {
  localOnly('Mode Offline Lokal'),
  idle('Siap Sinkron'),
  syncing('Menyinkronkan...'),
  synced('Tersinkron'),
  offline('Offline (Antre Lokal)'),
  error('Gagal Sinkron');

  const SyncStatus(this.label);
  final String label;
}

class SyncResult {
  const SyncResult({
    required this.pushedCount,
    required this.pulledCount,
    required this.skippedLocalNewerCount,
    required this.uploadedMediaCount,
    this.errorMessage,
  });

  const SyncResult.noop()
      : pushedCount = 0,
        pulledCount = 0,
        skippedLocalNewerCount = 0,
        uploadedMediaCount = 0,
        errorMessage = null;

  final int pushedCount;
  final int pulledCount;
  final int skippedLocalNewerCount;
  final int uploadedMediaCount;
  final String? errorMessage;

  bool get hasError => errorMessage != null;
}

class SyncStateSnapshot {
  const SyncStateSnapshot({
    required this.status,
    required this.pendingCount,
    this.lastSyncedAt,
    this.lastError,
  });

  final SyncStatus status;
  final int pendingCount;
  final DateTime? lastSyncedAt;
  final String? lastError;

  SyncStateSnapshot copyWith({
    SyncStatus? status,
    int? pendingCount,
    DateTime? lastSyncedAt,
    String? lastError,
    bool clearError = false,
  }) {
    return SyncStateSnapshot(
      status: status ?? this.status,
      pendingCount: pendingCount ?? this.pendingCount,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      lastError: clearError ? null : (lastError ?? this.lastError),
    );
  }
}

/// Abstract cloud sync transport allowing RumahKu to run locally with
/// [NoopSyncAdapter] or against Supabase Free Tier with [SupabaseSyncAdapter].
abstract class SyncAdapter {
  bool get isConfigured;
  bool get isAuthenticated;

  Future<void> upsertRecord({
    required String table,
    required Map<String, dynamic> payload,
  });

  Future<List<Map<String, dynamic>>> pullDelta({
    required String table,
    required String householdId,
    DateTime? sinceUtc,
  });

  Future<String> uploadMedia({
    required String bucket,
    required String remotePath,
    required Uint8List bytes,
    required String mimeType,
  });
}

/// Default adapter when `SUPABASE_URL` / `SUPABASE_ANON_KEY` are not supplied.
class NoopSyncAdapter implements SyncAdapter {
  const NoopSyncAdapter();

  @override
  bool get isConfigured => false;

  @override
  bool get isAuthenticated => false;

  @override
  Future<void> upsertRecord({
    required String table,
    required Map<String, dynamic> payload,
  }) async {}

  @override
  Future<List<Map<String, dynamic>>> pullDelta({
    required String table,
    required String householdId,
    DateTime? sinceUtc,
  }) async =>
      const [];

  @override
  Future<String> uploadMedia({
    required String bucket,
    required String remotePath,
    required Uint8List bytes,
    required String mimeType,
  }) async =>
      remotePath;
}
