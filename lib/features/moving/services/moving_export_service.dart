import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';

enum ThermalLabelSize {
  mm80x50('80 × 50 mm (Standar)', 80, 50),
  mm58x40('58 × 40 mm (Mini)', 58, 40);

  const ThermalLabelSize(this.label, this.widthMm, this.heightMm);
  final String label;
  final double widthMm;
  final double heightMm;

  PdfPageFormat get pageFormat => PdfPageFormat(
        widthMm * PdfPageFormat.mm,
        heightMm * PdfPageFormat.mm,
        marginAll: 2.5 * PdfPageFormat.mm,
      );
}

/// Pure Dart generator for RumahKu Moving QR Stickers (A4 & Thermal) and
/// Moving Manifests (PDF & RFC-4180 CSV). Runs 100% offline on all 6 platforms.
class MovingExportService {
  const MovingExportService();

  static const _teal = PdfColor.fromInt(0xFF0F766E);
  static const _danger = PdfColor.fromInt(0xFFDC2626);
  static const _amber = PdfColor.fromInt(0xFFD97706);
  static const _slate = PdfColor.fromInt(0xFF475569);
  static const _border = PdfColor.fromInt(0xFFCBD5E1);
  static const _bgSoft = PdfColor.fromInt(0xFFF8FAFC);

  /// Generates an A4 sheet PDF containing a 2×4 grid (8 stickers per page) of
  /// crisp vector QR box labels ready to print and cut.
  Future<Uint8List> generateQrStickersA4Pdf({
    required MovingProject project,
    required List<MovingBoxSummary> boxes,
  }) async {
    final doc = pw.Document(
      title: 'Stiker QR Pindahan - ${project.name}',
      author: 'RumahKu',
    );

    const perPage = 8;
    final totalPages = boxes.isEmpty ? 1 : (boxes.length / perPage).ceil();

    for (var pageIdx = 0; pageIdx < totalPages; pageIdx++) {
      final start = pageIdx * perPage;
      final end = (start + perPage).clamp(0, boxes.length);
      final chunk = boxes.isEmpty ? <MovingBoxSummary>[] : boxes.sublist(start, end);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10 * PdfPageFormat.mm),
          build: (context) {
            if (chunk.isEmpty) {
              return pw.Center(
                child: pw.Text(
                  'Belum ada kardus pada proyek "${project.name}".',
                  style: const pw.TextStyle(fontSize: 14),
                ),
              );
            }

            final rows = <pw.Widget>[];
            for (var r = 0; r < 4; r++) {
              final leftIdx = r * 2;
              final rightIdx = leftIdx + 1;
              if (leftIdx >= chunk.length) break;

              rows.add(
                pw.Expanded(
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: [
                      pw.Expanded(
                        child: _buildA4StickerCard(project, chunk[leftIdx]),
                      ),
                      pw.SizedBox(width: 6 * PdfPageFormat.mm),
                      pw.Expanded(
                        child: rightIdx < chunk.length
                            ? _buildA4StickerCard(project, chunk[rightIdx])
                            : pw.SizedBox(),
                      ),
                    ],
                  ),
                ),
              );
              if (r < 3 && (r + 1) * 2 < chunk.length) {
                rows.add(pw.SizedBox(height: 5 * PdfPageFormat.mm));
              }
            }

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'RUMAHKU | STIKER PINDAHAN: ${project.name.toUpperCase()}',
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                        color: _teal,
                      ),
                    ),
                    pw.Text(
                      'Hal ${pageIdx + 1}/$totalPages',
                      style: const pw.TextStyle(fontSize: 8, color: _slate),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4 * PdfPageFormat.mm),
                pw.Expanded(child: pw.Column(children: rows)),
              ],
            );
          },
        ),
      );
    }

    return doc.save();
  }

  /// Generates a 1-sticker-per-page thermal printer PDF (`80×50 mm` or `58×40 mm`).
  Future<Uint8List> generateQrStickersThermalPdf({
    required MovingProject project,
    required List<MovingBoxSummary> boxes,
    ThermalLabelSize size = ThermalLabelSize.mm80x50,
  }) async {
    final doc = pw.Document(
      title: 'Stiker Thermal - ${project.name}',
      author: 'RumahKu',
    );
    final isCompact = size == ThermalLabelSize.mm58x40;

    if (boxes.isEmpty) {
      doc.addPage(
        pw.Page(
          pageFormat: size.pageFormat,
          build: (_) => pw.Center(
            child: pw.Text('Belum ada kardus', style: const pw.TextStyle(fontSize: 9)),
          ),
        ),
      );
      return doc.save();
    }

    for (final summary in boxes) {
      final box = summary.box;
      final previewItems = summary.items
          .take(isCompact ? 2 : 3)
          .map((i) => i.name)
          .join(', ');

      doc.addPage(
        pw.Page(
          pageFormat: size.pageFormat,
          build: (context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 0.8),
              borderRadius: pw.BorderRadius.circular(3),
            ),
            padding: const pw.EdgeInsets.all(4),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: box.labelQr,
                  width: isCompact ? 26 * PdfPageFormat.mm : 34 * PdfPageFormat.mm,
                  height: isCompact ? 26 * PdfPageFormat.mm : 34 * PdfPageFormat.mm,
                ),
                pw.SizedBox(width: 4),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        box.boxCode,
                        style: pw.TextStyle(
                          fontSize: isCompact ? 12 : 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        box.destinationRoom ?? 'Ruangan Belum Diatur',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: isCompact ? 7.5 : 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      if (box.isFragile)
                        pw.Container(
                          margin: const pw.EdgeInsets.only(top: 2),
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          color: PdfColors.black,
                          child: pw.Text(
                            'PECAH BELAH / FRAGILE',
                            style: pw.TextStyle(
                              fontSize: isCompact ? 5.5 : 6.5,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                        ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        '${summary.itemCount} barang (${summary.totalQuantity} unit)'
                        '${box.weightKg != null ? ' | ${box.weightKg!.toStringAsFixed(1)} kg' : ''}',
                        style: pw.TextStyle(fontSize: isCompact ? 6 : 7),
                      ),
                      if (previewItems.isNotEmpty)
                        pw.Text(
                          previewItems,
                          maxLines: 2,
                          style: pw.TextStyle(fontSize: isCompact ? 5.5 : 6.5),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return doc.save();
  }

  /// Generates a complete multi-page Moving Manifest PDF with route info,
  /// asset totals, and per-box handover checklists.
  Future<Uint8List> generateManifestPdf({
    required MovingProject project,
    required List<MovingBoxSummary> boxes,
  }) async {
    final stats = MovingRepository.computeProjectStats(boxes);
    final doc = pw.Document(
      title: 'Manifest Pindahan - ${project.name}',
      author: 'RumahKu',
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(14 * PdfPageFormat.mm),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'MANIFEST PINDAHAN RUMAHKU',
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: _teal,
                  ),
                ),
                pw.Text(
                  'Dicetak: ${formatDate(DateTime.now())}',
                  style: const pw.TextStyle(fontSize: 8.5, color: _slate),
                ),
              ],
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              project.name,
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
            ),
            if (project.originAddress != null || project.destinationAddress != null)
              pw.Text(
                '${project.originAddress ?? 'Asal belum diisi'}  ->  '
                '${project.destinationAddress ?? 'Tujuan belum diisi'}',
                style: const pw.TextStyle(fontSize: 9, color: _slate),
              ),
            if (project.targetMoveDate != null)
              pw.Text(
                'Target Tanggal Pindah: ${formatDate(project.targetMoveDate)}',
                style: const pw.TextStyle(fontSize: 8.5, color: _slate),
              ),
            pw.Divider(color: _border, height: 12),
          ],
        ),
        footer: (context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'RumahKu Offline-First Household Inventory',
              style: const pw.TextStyle(fontSize: 8, color: _slate),
            ),
            pw.Text(
              'Halaman ${context.pageNumber} dari ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 8, color: _slate),
            ),
          ],
        ),
        build: (context) => [
          // Summary KPI box
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: _bgSoft,
              border: pw.Border.all(color: _border),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _kpiCell('Total Kardus', '${stats.totalBoxes}'),
                _kpiCell('Barang Terkemas', '${stats.totalItems} (${stats.totalQuantity} unit)'),
                _kpiCell('Pecah Belah', '${stats.fragileBoxCount} kardus'),
                _kpiCell('Total Berat', '${stats.totalWeightKg.toStringAsFixed(1)} kg'),
                _kpiCell('Total Nilai Aset', formatIdr(stats.totalAssetValue)),
              ],
            ),
          ),
          pw.SizedBox(height: 12),
          if (boxes.isEmpty)
            pw.Text('Belum ada kardus terdaftar pada proyek pindahan ini.')
          else
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 8.5,
                color: PdfColors.white,
              ),
              headerDecoration: const pw.BoxDecoration(color: _teal),
              cellStyle: const pw.TextStyle(fontSize: 8),
              cellAlignment: pw.Alignment.topLeft,
              columnWidths: {
                0: const pw.FixedColumnWidth(52),
                1: const pw.FixedColumnWidth(68),
                2: const pw.FixedColumnWidth(56),
                3: const pw.FlexColumnWidth(2.4),
                4: const pw.FixedColumnWidth(66),
                5: const pw.FixedColumnWidth(52),
              },
              headers: const [
                'Kode',
                'Ruangan Tujuan',
                'Status',
                'Daftar Isi Barang',
                'Nilai (Rp)',
                'Ceklis',
              ],
              data: [
                for (final s in boxes)
                  [
                    '${s.box.boxCode}${s.box.isFragile ? '\n[FRAGILE]' : ''}',
                    s.box.destinationRoom ?? '-',
                    s.status.label,
                    s.items.isEmpty
                        ? '(Kosong)'
                        : s.items
                            .map((i) =>
                                '- ${i.name}${i.quantity > 1 ? ' (x${i.quantity})' : ''}')
                            .join('\n'),
                    formatIdr(s.totalValue),
                    '[ ] Asal\n[ ] Tujuan',
                  ],
              ],
            ),
        ],
      ),
    );

    return doc.save();
  }

  /// Generates an RFC-4180 CSV export of all moving boxes and their contents
  /// (one row per item, or one empty-box row if a box has no items yet).
  String generateManifestCsv({
    required MovingProject project,
    required List<MovingBoxSummary> boxes,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
      [
        'Proyek',
        'Kode Kardus',
        'Status Kardus',
        'Ruangan Tujuan',
        'Pecah Belah',
        'Prioritas',
        'Berat (kg)',
        'Nama Barang',
        'Kategori',
        'Jumlah',
        'Nilai Aset (Rp)',
        'QR Code',
      ].map(_csvCell).join(','),
    );

    for (final summary in boxes) {
      final box = summary.box;
      final statusLabel = summary.status.label;
      final priorityLabel = summary.priority.label;
      final fragileStr = box.isFragile ? 'Ya' : 'Tidak';
      final weightStr = box.weightKg?.toStringAsFixed(1) ?? '';

      if (summary.items.isEmpty) {
        buffer.writeln(
          [
            project.name,
            box.boxCode,
            statusLabel,
            box.destinationRoom ?? '',
            fragileStr,
            priorityLabel,
            weightStr,
            '',
            '',
            '0',
            '0',
            box.labelQr,
          ].map(_csvCell).join(','),
        );
      } else {
        for (final item in summary.items) {
          final val = InventoryRepository.effectiveItemValue(item).round();
          buffer.writeln(
            [
              project.name,
              box.boxCode,
              statusLabel,
              box.destinationRoom ?? '',
              fragileStr,
              priorityLabel,
              weightStr,
              item.name,
              item.category,
              '${item.quantity}',
              '$val',
              box.labelQr,
            ].map(_csvCell).join(','),
          );
        }
      }
    }

    return buffer.toString();
  }

  pw.Widget _buildA4StickerCard(
    MovingProject project,
    MovingBoxSummary summary,
  ) {
    final box = summary.box;
    final priority = summary.priority;
    final itemLines = summary.items.take(4).map((i) {
      return '- ${i.name}${i.quantity > 1 ? ' (x${i.quantity})' : ''}';
    }).toList();
    if (summary.items.length > 4) {
      itemLines.add('+ ${summary.items.length - 4} barang lainnya...');
    }

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: box.isFragile ? _danger : _border,
          width: box.isFragile ? 1.5 : 1,
        ),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Top strip: Box code + Fragile/Priority badge
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                box.boxCode,
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: _teal,
                ),
              ),
              pw.Row(
                children: [
                  if (box.isFragile)
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: pw.BoxDecoration(
                        color: _danger,
                        borderRadius: pw.BorderRadius.circular(3),
                      ),
                      child: pw.Text(
                        'PECAH BELAH',
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                  if (priority == BoxPriority.high) ...[
                    pw.SizedBox(width: 4),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: pw.BoxDecoration(
                        color: _amber,
                        borderRadius: pw.BorderRadius.circular(3),
                      ),
                      child: pw.Text(
                        'BUKA DULUAN',
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Expanded(
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: box.labelQr,
                  width: 24 * PdfPageFormat.mm,
                  height: 24 * PdfPageFormat.mm,
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'TUJUAN:',
                        style: const pw.TextStyle(fontSize: 6.5, color: _slate),
                      ),
                      pw.Text(
                        box.destinationRoom ?? 'Belum ditentukan',
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: 10.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        '${summary.itemCount} barang | ${summary.totalQuantity} unit'
                        '${box.weightKg != null ? ' | ${box.weightKg!.toStringAsFixed(1)} kg' : ''}',
                        style: const pw.TextStyle(fontSize: 7.5, color: _slate),
                      ),
                      pw.SizedBox(height: 3),
                      if (itemLines.isEmpty)
                        pw.Text(
                          '(Kardus masih kosong)',
                          style: const pw.TextStyle(fontSize: 7, color: _slate),
                        )
                      else
                        for (final line in itemLines)
                          pw.Text(
                            line,
                            maxLines: 1,
                            style: const pw.TextStyle(fontSize: 7),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.Divider(color: _border, height: 6),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                project.name,
                maxLines: 1,
                style: const pw.TextStyle(fontSize: 6.5, color: _slate),
              ),
              pw.Text(
                box.labelQr,
                style: const pw.TextStyle(fontSize: 5.5, color: _slate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _kpiCell(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 7.5, color: _slate)),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  String _csvCell(String raw) {
    final needsQuoting = raw.contains(',') ||
        raw.contains('"') ||
        raw.contains('\n') ||
        raw.contains('\r');
    if (!needsQuoting) return raw;
    return '"${raw.replaceAll('"', '""')}"';
  }
}
