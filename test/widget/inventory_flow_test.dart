import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/media/media_storage_service.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/sync/sync_adapter.dart';
import 'package:rumahku/main.dart';

AppDatabase _createWidgetTestDb() {
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

Widget _buildTestApp(AppDatabase db) {
  final store = <String, Uint8List>{};
  final media = MediaStorageService(
    saver: ({
      required String fileName,
      required Uint8List bytes,
      required String mimeType,
    }) async {
      final path = 'mem://$fileName';
      store[path] = bytes;
      return path;
    },
    reader: (path) async => store[path],
  );

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      syncAdapterProvider.overrideWithValue(const NoopSyncAdapter()),
      mediaStorageServiceProvider.overrideWithValue(media),
    ],
    child: const RumahKuApp(),
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  testWidgets('Mobile viewport renders NavigationBar and seeded offline household',
      (tester) async {
    final db = _createWidgetTestDb();

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildTestApp(db));
    await tester.pumpAndSettle();

    // Adaptive shell uses NavigationBar on narrow mobile viewports
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);

    // Seeded local household & offline mode chip appear
    expect(find.text('Rumah Utama'), findsOneWidget);
    expect(find.text('Mode Offline Lokal'), findsOneWidget);

    // Navigate to Lokasi tab and verify seeded starter hierarchy
    await tester.tap(find.text('Lokasi'));
    await tester.pumpAndSettle();

    expect(find.text('Hirarki Lokasi'), findsOneWidget);
    expect(find.text('Ruang Keluarga'), findsOneWidget);
    expect(find.text('Kamar Utama'), findsOneWidget);
    expect(find.text('Garasi'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await db.close();
  });

  testWidgets(
      'Desktop viewport uses NavigationRail and supports end-to-end Add Item flow',
      (tester) async {
    final db = _createWidgetTestDb();

    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildTestApp(db));
    await tester.pumpAndSettle();

    // Adaptive shell uses extended NavigationRail on desktop/web viewports
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    // Tap "Tambah Barang" quick action on Beranda
    await tester.tap(find.text('Tambah Barang'));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Barang Baru'), findsOneWidget);

    // Fill item form
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama Barang *'),
      'MacBook Pro M3',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Kategori'),
      'Elektronik',
    );

    // Scroll down to make Harga Beli visible and enter value
    final priceField = find.widgetWithText(TextFormField, 'Harga Beli (Rp)');
    await tester.ensureVisible(priceField);
    await tester.enterText(priceField, '25000000');

    // Save item
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Back on Beranda: KPI and recent items list reflect the newly added item
    expect(find.text('MacBook Pro M3'), findsOneWidget);
    expect(find.text('Rp 25.000.000'), findsWidgets);

    // Switch to Inventaris in desktop NavigationRail and verify master-detail split
    await tester.tap(find.text('Inventaris'));
    await tester.pumpAndSettle();

    expect(find.text('Inventaris (1)'), findsOneWidget);
    expect(find.text('MacBook Pro M3'), findsOneWidget);
    expect(
      find.text('Pilih barang di sebelah kiri untuk melihat detail'),
      findsOneWidget,
    );

    // Click item to open inline desktop detail pane
    await tester.tap(find.text('MacBook Pro M3'));
    await tester.pumpAndSettle();

    expect(find.text('Lokasi & Keuangan'), findsOneWidget);
    expect(find.text('Identitas & Kode'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await db.close();
  });
}
