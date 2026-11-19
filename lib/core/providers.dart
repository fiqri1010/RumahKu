import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/config/app_config.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/core/sync/supabase_sync_adapter.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/core/sync/sync_engine.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';
import 'package:rumahku/features/moving/services/moving_export_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.defaults();
  ref.onDispose(db.close);
  return db;
});

final mediaStorageServiceProvider = Provider<MediaStorageService>(
  (ref) => MediaStorageService(),
);

final syncAdapterProvider = Provider<SyncAdapter>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.isCloudConfigured) {
    return const NoopSyncAdapter();
  }
  return SupabaseSyncAdapter(Supabase.instance.client);
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final adapter = ref.watch(syncAdapterProvider);
  final media = ref.watch(mediaStorageServiceProvider);
  return SyncEngine(
    db: db,
    adapter: adapter,
    mediaBytesLoader: media.readBytes,
  );
});

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepository(
    db: ref.watch(appDatabaseProvider),
    mediaService: ref.watch(mediaStorageServiceProvider),
  );
});

final movingRepositoryProvider = Provider<MovingRepository>((ref) {
  return MovingRepository(db: ref.watch(appDatabaseProvider));
});

final movingExportServiceProvider = Provider<MovingExportService>(
  (ref) => const MovingExportService(),
);

/// Bootstraps the default local household if none exists, then streams it.
final activeHouseholdProvider = StreamProvider<Household?>((ref) async* {
  final db = ref.watch(appDatabaseProvider);
  await db.ensureDefaultHousehold();
  yield* db.watchActiveHousehold();
});

final pendingOutboxCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchPendingOutboxCount();
});

class SyncController extends Notifier<SyncStateSnapshot> {
  StreamSubscription<List<ConnectivityResult>>? _connSub;

  @override
  SyncStateSnapshot build() {
    final adapter = ref.watch(syncAdapterProvider);
    final pending = ref.watch(pendingOutboxCountProvider).value ?? 0;

    if (!adapter.isConfigured) {
      return SyncStateSnapshot(
        status: SyncStatus.localOnly,
        pendingCount: pending,
      );
    }

    _connSub?.cancel();
    _connSub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online) {
        unawaited(syncNow());
      } else {
        state = state.copyWith(status: SyncStatus.offline);
      }
    });
    ref.onDispose(() => _connSub?.cancel());

    return SyncStateSnapshot(
      status: adapter.isAuthenticated ? SyncStatus.idle : SyncStatus.localOnly,
      pendingCount: pending,
    );
  }

  Future<SyncResult> syncNow() async {
    final adapter = ref.read(syncAdapterProvider);
    final pending = ref.read(pendingOutboxCountProvider).value ?? 0;
    if (!adapter.isConfigured || !adapter.isAuthenticated) {
      state = SyncStateSnapshot(
        status: SyncStatus.localOnly,
        pendingCount: pending,
      );
      return const SyncResult.noop();
    }

    final household = ref.read(activeHouseholdProvider).value;
    if (household == null) return const SyncResult.noop();

    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity.any((r) => r != ConnectivityResult.none);
    if (!isOnline) {
      state = state.copyWith(status: SyncStatus.offline, pendingCount: pending);
      return const SyncResult.noop();
    }

    state = state.copyWith(
      status: SyncStatus.syncing,
      pendingCount: pending,
      clearError: true,
    );

    final result = await ref.read(syncEngineProvider).synchronize(
          householdId: household.id,
          isOnline: true,
        );

    final remaining = ref.read(pendingOutboxCountProvider).value ?? 0;
    if (result.hasError) {
      state = state.copyWith(
        status: SyncStatus.error,
        pendingCount: remaining,
        lastError: result.errorMessage,
      );
    } else {
      state = state.copyWith(
        status: SyncStatus.synced,
        pendingCount: remaining,
        lastSyncedAt: DateTime.now(),
        clearError: true,
      );
    }
    return result;
  }
}

final syncControllerProvider =
    NotifierProvider<SyncController, SyncStateSnapshot>(SyncController.new);
