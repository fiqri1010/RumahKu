import 'dart:typed_data';

import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Concrete [SyncAdapter] backed by Supabase Free Tier (PostgreSQL + RLS +
/// Private Storage Buckets).
class SupabaseSyncAdapter implements SyncAdapter {
  SupabaseSyncAdapter(this._client);

  final SupabaseClient _client;

  @override
  bool get isConfigured => true;

  @override
  bool get isAuthenticated => _client.auth.currentSession != null;

  @override
  Future<void> upsertRecord({
    required String table,
    required Map<String, dynamic> payload,
  }) async {
    await _client.from(table).upsert(payload);
  }

  @override
  Future<List<Map<String, dynamic>>> pullDelta({
    required String table,
    required String householdId,
    DateTime? sinceUtc,
  }) async {
    final baseQuery = _client.from(table).select();
    final scoped = table == 'households'
        ? baseQuery.eq('id', householdId)
        : baseQuery.eq('household_id', householdId);

    final filtered = sinceUtc == null
        ? scoped
        : scoped.gt('updated_at', sinceUtc.toUtc().toIso8601String());

    final rows = await filtered.order('updated_at', ascending: true);
    return List<Map<String, dynamic>>.from(rows);
  }

  @override
  Future<String> uploadMedia({
    required String bucket,
    required String remotePath,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    await _client.storage.from(bucket).uploadBinary(
          remotePath,
          bytes,
          fileOptions: FileOptions(
            contentType: mimeType,
            upsert: true,
          ),
        );
    return remotePath;
  }
}
