import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumahku/app/adaptive_shell.dart';
import 'package:rumahku/features/home/presentation/home_dashboard_screen.dart';
import 'package:rumahku/features/household/presentation/household_sync_screen.dart';
import 'package:rumahku/features/inventory/presentation/item_detail_screen.dart';
import 'package:rumahku/features/inventory/presentation/item_form_screen.dart';
import 'package:rumahku/features/inventory/presentation/items_list_screen.dart';
import 'package:rumahku/features/inventory/presentation/locations_tree_screen.dart';
import 'package:rumahku/features/placeholders/presentation/milestone_placeholder_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AdaptiveShell(
          currentLocation: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeDashboardScreen()),
          ),
          GoRoute(
            path: '/items',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ItemsListScreen()),
          ),
          GoRoute(
            path: '/locations',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LocationsTreeScreen()),
          ),
          GoRoute(
            path: '/moving',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonePlaceholderScreen(
                title: 'Mode Pindahan & Stiker QR',
                milestoneTag: 'Milestone 2',
                icon: Icons.local_shipping_outlined,
                accentColor: Color(0xFFD97706),
                description:
                    'Kelola proyek pindahan rumah dengan kardus ber-QR, status pengiriman real-time, dan manifest pindahan.',
                plannedFeatures: [
                  'Buat Proyek Pindahan (alamat asal, tujuan, target tanggal)',
                  'Manajemen Kardus/Box dengan kode QR & ruangan tujuan',
                  'Pindah barang/rak buku secara massal ke kardus (bulk move)',
                  'Lacak status kardus: Packing → Siap Angkut → Di Truk → Sampai → Dibongkar',
                  'Cetak lembar stiker QR A4 / printer thermal & export Manifest PDF/CSV',
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/books',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonePlaceholderScreen(
                title: 'Perpustakaan Buku (Scan ISBN + AI)',
                milestoneTag: 'Milestone 5',
                icon: Icons.auto_stories_outlined,
                accentColor: Color(0xFF7C3AED),
                description:
                    'Katalog perpustakaan pribadi dengan scan ISBN otomatis ke API gratis & AI Gemini (BYOK) khusus melengkapi buku lokal Indonesia.',
                plannedFeatures: [
                  'Scan barcode ISBN-10/13 → Open Library & Google Books API (gratis)',
                  'AI Gemini Free Tier (BYOK) fallback untuk buku lokal Indonesia & foto sampul',
                  'Bulk-scan 1 rak buku sekaligus lewat foto (shelfie)',
                  'Progres baca halaman, seri buku, rating, & Tsundoku Index (buku belum dibaca)',
                  'Pelacakan pinjam-meminjam buku ke teman/keluarga + pengingat kembali',
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/documents',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonePlaceholderScreen(
                title: 'Brankas Berkas & Dokumen Penting',
                milestoneTag: 'Milestone 5',
                icon: Icons.folder_special_outlined,
                accentColor: Color(0xFFBE123C),
                description:
                    'Arsip berkas fisik & digital khas rumah tangga Indonesia bergaya Paperless-ngx dengan kunci Biometrik/PIN.',
                plannedFeatures: [
                  'Preset berkas Indonesia: KTP, KK, Paspor, SIM, SHM, PBB, Ijazah, Polis, STNK/BPKB',
                  'Pelacakan lokasi map/brankas fisik + status Asli vs Fotokopi',
                  'Scan multi-halaman → PDF & pencarian isi teks (OCR Full-Text Search)',
                  'Pengingat kedaluwarsa otomatis (mis. Paspor H-6 bulan, SIM, Asuransi)',
                  'Kunci Brankas Biometrik (Android/iOS/Windows Hello/macOS) + PIN fallback',
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/garage',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonePlaceholderScreen(
                title: 'Garasi & Kendaraan',
                milestoneTag: 'Milestone 4',
                icon: Icons.directions_car_outlined,
                accentColor: Color(0xFF2563EB),
                description:
                    'Modul kendaraan terpadu (motor, mobil, sepeda) terinspirasi LubeLogger — tetap terhitung di total aset rumah & bisa menyimpan sub-barang bagasi.',
                plannedFeatures: [
                  'Data pelat nomor, nomor rangka/mesin, STNK, BPKB, & asuransi',
                  'Pengingat pajak STNK 1 tahunan & ganti kaleng 5 tahunan',
                  'Riwayat servis & pengingat berbasis tanggal ATAU odometer (km)',
                  'Log pengisian BBM dengan hitung otomatis efisiensi km/L',
                  'Kalkulasi Total Cost of Ownership (TCO) & biaya per kilometer (Rp/km)',
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/analytics',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MilestonePlaceholderScreen(
                title: 'Analitik Uang & Kebermanfaatan',
                milestoneTag: 'Milestone 3',
                icon: Icons.insights_outlined,
                accentColor: Color(0xFF0F766E),
                description:
                    'Visualisasi "kemana uangmu" dan "seberapa bermanfaat barangnya" dengan model Hybrid anti-ribet.',
                plannedFeatures: [
                  'Grafik sebaran nilai aset per ruangan, kategori, & tipe aset',
                  'Tombol cepat "+1 Dipakai" & hitung otomatis Cost-per-Use',
                  'Deteksi otomatis barang nganggur (> 6 bulan) sebagai Kandidat Declutter',
                  'Ringkasan dana tertanam di buku belum dibaca & biaya tahunan kendaraan',
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/household',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HouseholdSyncScreen()),
          ),
          GoRoute(
            path: '/more',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MoreModulesScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/items/new',
        builder: (context, state) => ItemFormScreen(
          initialLocationId: state.uri.queryParameters['locationId'],
          initialContainerItemId: state.uri.queryParameters['containerItemId'],
        ),
      ),
      GoRoute(
        path: '/items/:id',
        builder: (context, state) => ItemDetailScreen(
          itemId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/items/:id/edit',
        builder: (context, state) => ItemFormScreen(
          itemId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
});
