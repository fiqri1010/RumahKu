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

  testWidgets(
      'End-to-end Moving workflow: create project, create QR box, advance status, & resolve via QR lookup',
      (tester) async {
    final db = _createWidgetTestDb();

    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildTestApp(db));
    await tester.pumpAndSettle();

    // Navigate to Pindahan tab via NavigationRail
    await tester.tap(find.text('Pindahan'));
    await tester.pumpAndSettle();

    expect(find.text('Siap Pindahan Tanpa Pusing'), findsOneWidget);

    // Create a moving project
    await tester.tap(find.text('Buat Proyek Pindahan'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama Proyek Pindahan *'),
      'Pindah ke Rumah Baru',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Alamat Asal'),
      'Apartemen Lama',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Alamat Tujuan'),
      'Rumah Baru BSD',
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Pindah ke Rumah Baru'), findsOneWidget);
    expect(find.text('Belum ada kardus di proyek ini'), findsOneWidget);

    // Create first moving box
    await tester.tap(find.text('Tambah Kardus'));
    await tester.pumpAndSettle();

    final codeField = tester.widget<TextFormField>(
      find.widgetWithText(TextFormField, 'Kode Kardus *'),
    );
    expect(codeField.controller?.text, 'BOX-01');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ruangan Tujuan'),
      'Dapur',
    );
    await tester.tap(find.text('Barang Pecah Belah (Fragile)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Box appears in list AND auto-opens in Desktop master-detail pane
    expect(find.text('BOX-01'), findsWidgets);
    expect(find.text('FRAGILE'), findsOneWidget);
    expect(find.text('Status Perjalanan Kardus'), findsOneWidget);

    // Advance box status in 1 tap: Packing -> Siap Angkut
    await tester.tap(find.text('→ Siap Angkut'));
    await tester.pumpAndSettle();

    expect(find.text('→ Di Truk'), findsOneWidget);

    // Open Scan QR screen and resolve BOX-01 via manual/USB code lookup
    await tester.tap(find.text('Scan QR'));
    await tester.pumpAndSettle();

    expect(find.text('Scan / Cari Kode QR'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, 'Kode Kardus atau URI QR'),
      'BOX-01',
    );
    await tester.tap(find.text('Buka Kardus / Barang'));
    await tester.pumpAndSettle();

    // Navigates straight to MovingBoxDetailScreen for BOX-01
    expect(find.text('Kardus BOX-01'), findsOneWidget);
    expect(find.text('PECAH BELAH'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await db.close();
  });
}
