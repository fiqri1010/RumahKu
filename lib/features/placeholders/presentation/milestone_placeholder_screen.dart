import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class MilestonePlaceholderScreen extends StatelessWidget {
  const MilestonePlaceholderScreen({
    super.key,
    required this.title,
    required this.milestoneTag,
    required this.icon,
    required this.accentColor,
    required this.description,
    required this.plannedFeatures,
  });

  final String title;
  final String milestoneTag;
  final IconData icon;
  final Color accentColor;
  final String description;
  final List<String> plannedFeatures;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(icon, size: 30, color: accentColor),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    'Terjadwal di $milestoneTag — Skema DB Sudah Siap',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: accentColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Text(
                        'Rencana Fitur Modul Ini:',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      for (final feat in plannedFeatures)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: accentColor,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(feat)),
                            ],
                          ),
                        ),
                      const SizedBox(height: 18),
                      FilledButton.icon(
                        onPressed: () => context.go('/items'),
                        icon: const Icon(Icons.inventory_2_outlined),
                        label: const Text('Kelola Aset di Inventaris Sekarang'),
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
}

/// Mobile hub screen for accessing secondary modules (Buku, Berkas, Garasi,
/// Analitik, dan Pengaturan Keluarga/Sync) cleanly from the 5th bottom tab.
class MoreModulesScreen extends StatelessWidget {
  const MoreModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = [
      (
        'Perpustakaan Buku (M5)',
        'Scan ISBN + AI Gemini, progres baca & pinjaman',
        Icons.auto_stories_outlined,
        '/books',
      ),
      (
        'Brankas Berkas (M5)',
        'KTP/KK/Paspor/SHM, PDF OCR & kunci Biometrik/PIN',
        Icons.lock_outline,
        '/documents',
      ),
      (
        'Garasi Kendaraan (M4)',
        'STNK 1 & 5 tahunan, BPKB, servis km & BBM km/L',
        Icons.directions_car_outlined,
        '/garage',
      ),
      (
        'Analitik Uang & Manfaat (M3)',
        'Total aset, Cost-per-Use & kandidat Declutter',
        Icons.insights_outlined,
        '/analytics',
      ),
      (
        'Keluarga & Sinkronisasi',
        'Kode undangan keluarga & Supabase Free Rp 0',
        Icons.sync_outlined,
        '/household',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Modul Lainnya')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final e = entries[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: Icon(e.$3),
              title: Text(e.$1),
              subtitle: Text(e.$2),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(e.$4),
            ),
          );
        },
      ),
    );
  }
}
