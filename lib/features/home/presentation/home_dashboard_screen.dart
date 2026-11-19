import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/inventory/presentation/widgets/location_form_dialog.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final householdAsync = ref.watch(activeHouseholdProvider);
    final summary = ref.watch(inventorySummaryProvider);
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
    final syncState = ref.watch(syncControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              householdAsync.value?.name ?? 'RumahKu',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              'Inventaris & Aset Rumah Tangga',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ActionChip(
              avatar: Icon(
                _syncIcon(syncState.status),
                size: 16,
                color: _syncColor(syncState.status, scheme),
              ),
              label: Text(
                syncState.pendingCount > 0 &&
                        syncState.status != SyncStatus.localOnly
                    ? '${syncState.status.label} (${syncState.pendingCount})'
                    : syncState.status.label,
              ),
              onPressed: () => context.go('/household'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(syncControllerProvider.notifier).syncNow(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // KPI Bento Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 680;
                final cards = [
                  _KpiCard(
                    title: 'Total Nilai Aset',
                    value: formatIdr(summary.totalAssetValue),
                    subtitle: 'Barang, kendaraan & buku aktif',
                    icon: Icons.account_balance_wallet_outlined,
                    accent: scheme.primary,
                    onTap: () => context.go('/analytics'),
                  ),
                  _KpiCard(
                    title: 'Barang Terdata',
                    value: '${summary.totalItems}',
                    subtitle: '${summary.totalQuantity} total unit',
                    icon: Icons.inventory_2_outlined,
                    accent: const Color(0xFF2563EB),
                    onTap: () => context.go('/items'),
                  ),
                  _KpiCard(
                    title: 'Titik Lokasi',
                    value: '${summary.totalLocations}',
                    subtitle: 'Ruangan, lemari, rak & kardus',
                    icon: Icons.account_tree_outlined,
                    accent: const Color(0xFFD97706),
                    onTap: () => context.go('/locations'),
                  ),
                ];

                if (isWide) {
                  return Row(
                    children: [
                      for (var i = 0; i < cards.length; i++) ...[
                        Expanded(child: cards[i]),
                        if (i < cards.length - 1) const SizedBox(width: 12),
                      ],
                    ],
                  );
                }

                return Column(
                  children: [
                    cards[0],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: cards[1]),
                        const SizedBox(width: 12),
                        Expanded(child: cards[2]),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // Quick Actions
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () => context.push('/items/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Barang'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    final hid = householdAsync.value?.id;
                    if (hid != null) {
                      showLocationFormDialog(
                        context: context,
                        ref: ref,
                        householdId: hid,
                      );
                    }
                  },
                  icon: const Icon(Icons.create_new_folder_outlined),
                  label: const Text('Tambah Lokasi'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Modul RumahKu Grid
            Text(
              'Modul RumahKu',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth >= 900
                    ? 4
                    : (constraints.maxWidth >= 600 ? 3 : 2);
                final modules = [
                  _ModuleShortcut(
                    title: 'Pindahan & QR',
                    subtitle: 'Kardus, cetak stiker, status truk',
                    badge: 'M2',
                    icon: Icons.local_shipping_outlined,
                    color: const Color(0xFFD97706),
                    route: '/moving',
                  ),
                  _ModuleShortcut(
                    title: 'Uang & Manfaat',
                    subtitle: 'Cost-per-use & kandidat declutter',
                    badge: 'M3',
                    icon: Icons.insights_outlined,
                    color: const Color(0xFF0F766E),
                    route: '/analytics',
                  ),
                  _ModuleShortcut(
                    title: 'Garasi Kendaraan',
                    subtitle: 'STNK 1/5 thn, servis & BBM km/L',
                    badge: 'M4',
                    icon: Icons.directions_car_outlined,
                    color: const Color(0xFF2563EB),
                    route: '/garage',
                  ),
                  _ModuleShortcut(
                    title: 'Perpustakaan Buku',
                    subtitle: 'Scan ISBN + AI, progres baca, pinjam',
                    badge: 'M5',
                    icon: Icons.auto_stories_outlined,
                    color: const Color(0xFF7C3AED),
                    route: '/books',
                  ),
                  _ModuleShortcut(
                    title: 'Brankas Berkas',
                    subtitle: 'KTP/SHM/Paspor, PDF OCR & kunci PIN',
                    badge: 'M5',
                    icon: Icons.lock_outline,
                    color: const Color(0xFFBE123C),
                    route: '/documents',
                  ),
                  _ModuleShortcut(
                    title: 'Keluarga & Sync',
                    subtitle: 'Supabase gratis Rp 0 & kode undangan',
                    badge: 'Aktif',
                    icon: Icons.sync_outlined,
                    color: const Color(0xFF0369A1),
                    route: '/household',
                  ),
                ];

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.55,
                  ),
                  itemCount: modules.length,
                  itemBuilder: (context, index) => _ModuleCard(
                    shortcut: modules[index],
                    onTap: () => context.go(modules[index].route),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Recent Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Barang Terbaru',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () => context.go('/items'),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (summary.recentItems.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        size: 48,
                        color: scheme.primary.withValues(alpha: 0.7),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Belum ada barang yang didata',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mulai catat barang elektronik, furnitur, buku, atau kendaraanmu — semua tersimpan aman secara offline.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => context.push('/items/new'),
                        icon: const Icon(Icons.add),
                        label: const Text('Catat Barang Pertama'),
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                child: Column(
                  children: [
                    for (var i = 0; i < summary.recentItems.length; i++) ...[
                      Builder(
                        builder: (context) {
                          final item = summary.recentItems[i];
                          final type = AssetType.fromDb(item.assetType);
                          final locText = item.locationId == null
                              ? 'Belum ada lokasi'
                              : (breadcrumbs[item.locationId!] ?? 'Lokasi');
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: scheme.primaryContainer,
                              child: Icon(
                                type.icon,
                                color: scheme.onPrimaryContainer,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '$locText • ${item.category}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              formatIdr(
                                item.estimatedValue ?? item.purchasePrice,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            onTap: () => context.push('/items/${item.id}'),
                          );
                        },
                      ),
                      if (i < summary.recentItems.length - 1)
                        const Divider(height: 1),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _syncIcon(SyncStatus status) => switch (status) {
        SyncStatus.localOnly => Icons.offline_pin_outlined,
        SyncStatus.idle => Icons.cloud_queue_outlined,
        SyncStatus.syncing => Icons.sync,
        SyncStatus.synced => Icons.cloud_done_outlined,
        SyncStatus.offline => Icons.cloud_off_outlined,
        SyncStatus.error => Icons.error_outline,
      };

  Color _syncColor(SyncStatus status, ColorScheme scheme) => switch (status) {
        SyncStatus.synced => const Color(0xFF15803D),
        SyncStatus.error => scheme.error,
        SyncStatus.offline => const Color(0xFFD97706),
        _ => scheme.primary,
      };
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.accent,
    this.onTap,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: accent, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleShortcut {
  const _ModuleShortcut({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;
  final Color color;
  final String route;
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.shortcut, required this.onTap});

  final _ModuleShortcut shortcut;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(shortcut.icon, color: shortcut.color, size: 22),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: shortcut.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      shortcut.badge,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: shortcut.color,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                shortcut.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                shortcut.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
