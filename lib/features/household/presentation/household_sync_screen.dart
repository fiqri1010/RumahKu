import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/core/utils/formatters.dart';

class HouseholdSyncScreen extends ConsumerWidget {
  const HouseholdSyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final household = ref.watch(activeHouseholdProvider).value;
    final config = ref.watch(appConfigProvider);
    final syncState = ref.watch(syncControllerProvider);
    final pendingCount = ref.watch(pendingOutboxCountProvider).value ?? 0;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Keluarga & Sinkronisasi')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Household Profile Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: scheme.primaryContainer,
                            child: Icon(
                              Icons.home_outlined,
                              color: scheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  household?.name ?? 'Rumah Utama',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Mata uang: ${household?.currencyCode ?? 'IDR'} (Rupiah)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (household != null)
                            OutlinedButton(
                              onPressed: () => _showRenameDialog(
                                context,
                                ref,
                                household.id,
                                household.name,
                              ),
                              child: const Text('Ubah Nama'),
                            ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kode Undangan Keluarga',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                SelectableText(
                                  household?.inviteCode ?? '—',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.5,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          IconButton.filledTonal(
                            tooltip: 'Salin Kode',
                            onPressed: household == null
                                ? null
                                : () {
                                    Clipboard.setData(
                                      ClipboardData(text: household.inviteCode),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Kode undangan disalin ke clipboard',
                                        ),
                                      ),
                                    );
                                  },
                            icon: const Icon(Icons.copy_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sync Engine Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Sinkronisasi Offline-First',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          config.isCloudConfigured
                              ? Icons.cloud_done_outlined
                              : Icons.offline_pin_outlined,
                          color: scheme.primary,
                        ),
                        title: Text(syncState.status.label),
                        subtitle: Text(
                          config.isCloudConfigured
                              ? 'Terhubung ke Supabase Free Tier (${syncState.lastSyncedAt == null ? 'Belum sinkron' : 'Terakhir: ${formatDateTime(syncState.lastSyncedAt)}'})'
                              : 'Berjalan 100% lokal di SQLite (Drift). Semua data tetap aman tanpa akun cloud.',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Chip(
                            avatar: const Icon(Icons.outbox_outlined, size: 16),
                            label: Text('Antrean Outbox: $pendingCount'),
                          ),
                          const Spacer(),
                          FilledButton.icon(
                            onPressed: (!config.isCloudConfigured ||
                                    syncState.status == SyncStatus.syncing)
                                ? null
                                : () => ref
                                    .read(syncControllerProvider.notifier)
                                    .syncNow(),
                            icon: const Icon(Icons.sync),
                            label: const Text('Sinkron Sekarang'),
                          ),
                        ],
                      ),
                      if (syncState.lastError != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Error terakhir: ${syncState.lastError}',
                          style: TextStyle(color: scheme.error),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Zero-Cost Setup Guide Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.volunteer_activism_outlined,
                              color: scheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Panduan Cloud Sync Gratis Rp 0 (Supabase)',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '1. Buat proyek gratis di supabase.com (tanpa kartu kredit — 500 MB DB + 1 GB Storage).\n'
                        '2. Jalankan file migrasi supabase/migrations/0001_initial_schema.sql di SQL Editor.\n'
                        '3. Isi SUPABASE_URL & SUPABASE_ANON_KEY di file .env lalu jalankan dengan --dart-define-from-file=.env.\n'
                        '4. Aktifkan GitHub Secrets agar workflow supabase_keepalive.yml mencegah auto-pause 7 hari.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    String householdId,
    String currentName,
  ) async {
    final ctrl = TextEditingController(text: currentName);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ubah Nama Rumah'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nama Rumah Tangga'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (confirmed == true && ctrl.text.trim().isNotEmpty) {
      await ref.read(inventoryRepositoryProvider).renameHousehold(
            householdId: householdId,
            newName: ctrl.text,
          );
    }
    ctrl.dispose();
  }
}
