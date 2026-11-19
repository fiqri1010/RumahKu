import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';
import 'package:rumahku/features/moving/services/moving_export_service.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  const exporter = MovingExportService();
  final now = DateTime.utc(2026, 11, 19);

  MovingProject makeProject() => MovingProject(
        id: 'proj-1',
        householdId: 'hh-1',
        name: 'Pindah Rumah, Bekasi "Tahap 1"',
        originAddress: 'Jl. Kemang No. 10',
        destinationAddress: 'Cluster Asri Blok B2',
        targetMoveDate: DateTime.utc(2026, 12, 1),
        status: 'packing',
        notes: 'Truk box jam 08.00',
        createdAt: now,
        updatedAt: now,
      );

  List<MovingBoxSummary> makeBoxes(int count) {
    return List.generate(count, (idx) {
      final num = (idx + 1).toString().padLeft(2, '0');
      final box = MovingBox(
        id: 'box-$num',
        householdId: 'hh-1',
        projectId: 'proj-1',
        locationId: 'loc-$num',
        boxCode: 'BOX-$num',
        labelQr: 'rumahku://box/box-$num',
        destinationRoom: idx.isEven ? 'Dapur, Lantai 1' : 'Kamar Utama',
        status: idx == 0 ? 'ready' : 'packing',
        isFragile: idx == 0,
        priority: idx == 0 ? 'high' : 'medium',
        weightKg: 7.5 + idx,
        notes: idx == 0 ? 'Piring kaca' : null,
        createdAt: now,
        updatedAt: now,
      );
      final items = idx == count - 1
          ? const <Item>[] // leave last box empty to test empty-box export
          : [
              Item(
                id: 'item-$num-a',
                householdId: 'hh-1',
                locationId: 'loc-$num',
                name: 'Piring Keramik "Set $num"',
                category: 'Dapur',
                assetType: 'general',
                quantity: 2,
                purchasePrice: 150000,
                condition: 'good',
                usageMode: 'daily_status',
                utilityStatus: 'frequent',
                usageCount: 0,
                customFieldsJson: '{}',
                createdAt: now,
                updatedAt: now,
              ),
            ];
      return MovingBoxSummary(
        box: box,
        items: items,
        totalQuantity: items.fold(0, (s, i) => s + i.quantity),
        totalValue: items.fold(
          0,
          (s, i) => s + ((i.purchasePrice ?? 0) * i.quantity),
        ),
      );
    });
  }

  test('generateQrStickersA4Pdf builds valid multi-page PDF for >8 boxes',
      () async {
    final bytes = await exporter.generateQrStickersA4Pdf(
      project: makeProject(),
      boxes: makeBoxes(10),
    );
    expect(bytes.length, greaterThan(1000));
    expect(utf8.decode(bytes.sublist(0, 5)), '%PDF-');
  });

  test('generateQrStickersThermalPdf builds valid PDF for 80x50mm and 58x40mm',
      () async {
    final bytes80 = await exporter.generateQrStickersThermalPdf(
      project: makeProject(),
      boxes: makeBoxes(2),
      size: ThermalLabelSize.mm80x50,
    );
    final bytes58 = await exporter.generateQrStickersThermalPdf(
      project: makeProject(),
      boxes: makeBoxes(2),
      size: ThermalLabelSize.mm58x40,
    );

    expect(utf8.decode(bytes80.sublist(0, 5)), '%PDF-');
    expect(utf8.decode(bytes58.sublist(0, 5)), '%PDF-');
  });

  test('generateManifestPdf builds valid A4 manifest document', () async {
    final bytes = await exporter.generateManifestPdf(
      project: makeProject(),
      boxes: makeBoxes(3),
    );
    expect(bytes.length, greaterThan(1000));
    expect(utf8.decode(bytes.sublist(0, 5)), '%PDF-');
  });

  test('generateManifestCsv escapes RFC-4180 quotes/commas and handles empty boxes',
      () {
    final csv = exporter.generateManifestCsv(
      project: makeProject(),
      boxes: makeBoxes(2),
    );
    final lines = csv.trim().split('\n');
    expect(lines.length, 3); // header + 1 item row (BOX-01) + 1 empty box row (BOX-02)
    expect(lines.first, contains('Kode Kardus,Status Kardus,Ruangan Tujuan'));
    // Escaped quotes & commas for project name, destination room, and item name
    expect(lines[1], contains('"Pindah Rumah, Bekasi ""Tahap 1"""'));
    expect(lines[1], contains('"Dapur, Lantai 1"'));
    expect(lines[1], contains('"Piring Keramik ""Set 01"""'));
    expect(lines[1], contains(',300000,rumahku://box/box-01'));
    // Empty box row still included with 0 quantity/value
    expect(lines[2], contains(',BOX-02,Packing,Kamar Utama,Tidak,Sedang,8.5,,,0,0,rumahku://box/box-02'));
  });
}
