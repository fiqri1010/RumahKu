import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:printing/printing.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';
import 'package:rumahku/features/moving/services/moving_export_service.dart';

Future<void> showPrintStickersDialog({
  required BuildContext context,
  required WidgetRef ref,
  required MovingProject project,
  required List<MovingBoxSummary> boxes,
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _PrintStickersDialog(
      project: project,
      boxes: boxes,
    ),
  );
}

class _PrintStickersDialog extends ConsumerStatefulWidget {
  const _PrintStickersDialog({
    required this.project,
    required this.boxes,
  });

  final MovingProject project;
  final List<MovingBoxSummary> boxes;

  @override
  ConsumerState<_PrintStickersDialog> createState() =>
      _PrintStickersDialogState();
}

class _PrintStickersDialogState extends ConsumerState<_PrintStickersDialog> {
  bool _busy = false;

  Future<void> _runPrint({
    required String fileName,
    required Future<Uint8List> Function() buildBytes,
    required bool shareOnly,
  }) async {
    setState(() => _busy = true);
    try {
      final bytes = await buildBytes();
      if (shareOnly) {
        await Printing.sharePdf(bytes: bytes, filename: fileName);
      } else {
        await Printing.layoutPdf(
          name: fileName,
          onLayout: (_) async => bytes,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuat PDF stiker: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final exporter = ref.read(movingExportServiceProvider);
    final slug = widget.project.name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    final boxLabel = widget.boxes.length == 1
        ? widget.boxes.first.box.boxCode
        : '${widget.boxes.length} kardus';

    return AlertDialog(
      title: const Text('Cetak Stiker QR Pindahan'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pilih format kertas untuk $boxLabel. Stiker memuat QR RumahKu, ruangan tujuan, tanda pecah belah, dan ringkasan isi.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _ExportOptionTile(
              icon: Icons.grid_view_outlined,
              title: 'Lembar A4 (8 Stiker / Halaman)',
              subtitle: 'Cocok untuk kertas stiker A4 atau HVS + lakban bening',
              enabled: !_busy,
              onPrint: () => _runPrint(
                fileName: 'stiker_a4_$slug.pdf',
                shareOnly: false,
                buildBytes: () => exporter.generateQrStickersA4Pdf(
                  project: widget.project,
                  boxes: widget.boxes,
                ),
              ),
              onShare: () => _runPrint(
                fileName: 'stiker_a4_$slug.pdf',
                shareOnly: true,
                buildBytes: () => exporter.generateQrStickersA4Pdf(
                  project: widget.project,
                  boxes: widget.boxes,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ExportOptionTile(
              icon: Icons.print_outlined,
              title: 'Printer Thermal 80 × 50 mm',
              subtitle: '1 stiker per halaman untuk printer label thermal standar',
              enabled: !_busy,
              onPrint: () => _runPrint(
                fileName: 'stiker_thermal_80x50_$slug.pdf',
                shareOnly: false,
                buildBytes: () => exporter.generateQrStickersThermalPdf(
                  project: widget.project,
                  boxes: widget.boxes,
                  size: ThermalLabelSize.mm80x50,
                ),
              ),
              onShare: () => _runPrint(
                fileName: 'stiker_thermal_80x50_$slug.pdf',
                shareOnly: true,
                buildBytes: () => exporter.generateQrStickersThermalPdf(
                  project: widget.project,
                  boxes: widget.boxes,
                  size: ThermalLabelSize.mm80x50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ExportOptionTile(
              icon: Icons.receipt_outlined,
              title: 'Printer Thermal Mini 58 × 40 mm',
              subtitle: 'Format kompak untuk printer thermal portabel Bluetooth',
              enabled: !_busy,
              onPrint: () => _runPrint(
                fileName: 'stiker_thermal_58x40_$slug.pdf',
                shareOnly: false,
                buildBytes: () => exporter.generateQrStickersThermalPdf(
                  project: widget.project,
                  boxes: widget.boxes,
                  size: ThermalLabelSize.mm58x40,
                ),
              ),
              onShare: () => _runPrint(
                fileName: 'stiker_thermal_58x40_$slug.pdf',
                shareOnly: true,
                buildBytes: () => exporter.generateQrStickersThermalPdf(
                  project: widget.project,
                  boxes: widget.boxes,
                  size: ThermalLabelSize.mm58x40,
                ),
              ),
            ),
            if (_busy) ...[
              const SizedBox(height: 16),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}

Future<void> showExportManifestDialog({
  required BuildContext context,
  required WidgetRef ref,
  required MovingProject project,
  required List<MovingBoxSummary> boxes,
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _ExportManifestDialog(
      project: project,
      boxes: boxes,
    ),
  );
}

class _ExportManifestDialog extends ConsumerStatefulWidget {
  const _ExportManifestDialog({
    required this.project,
    required this.boxes,
  });

  final MovingProject project;
  final List<MovingBoxSummary> boxes;

  @override
  ConsumerState<_ExportManifestDialog> createState() =>
      _ExportManifestDialogState();
}

class _ExportManifestDialogState extends ConsumerState<_ExportManifestDialog> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final exporter = ref.read(movingExportServiceProvider);
    final slug = widget.project.name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    final csvText = exporter.generateManifestCsv(
      project: widget.project,
      boxes: widget.boxes,
    );

    return AlertDialog(
      title: const Text('Export Manifest Pindahan'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Simpan atau cetak daftar lengkap kardus & barang sebagai dokumen serah-terima ekspedisi.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              _ExportOptionTile(
                icon: Icons.picture_as_pdf_outlined,
                title: 'Manifest Pindahan PDF (A4)',
                subtitle: 'Lengkap dengan total aset & kolom ceklis Asal/Tujuan',
                enabled: !_busy,
                onPrint: () async {
                  setState(() => _busy = true);
                  try {
                    final bytes = await exporter.generateManifestPdf(
                      project: widget.project,
                      boxes: widget.boxes,
                    );
                    await Printing.layoutPdf(
                      name: 'manifest_$slug.pdf',
                      onLayout: (_) async => bytes,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    if (context.mounted) {
                      setState(() => _busy = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal membuat PDF: $e')),
                      );
                    }
                  }
                },
                onShare: () async {
                  setState(() => _busy = true);
                  try {
                    final bytes = await exporter.generateManifestPdf(
                      project: widget.project,
                      boxes: widget.boxes,
                    );
                    await Printing.sharePdf(
                      bytes: bytes,
                      filename: 'manifest_$slug.pdf',
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    if (context.mounted) {
                      setState(() => _busy = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal membagikan PDF: $e')),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.table_chart_outlined, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Manifest CSV (Excel / Google Sheets)',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: csvText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Data CSV Manifest disalin ke clipboard',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy_outlined, size: 16),
                            label: const Text('Salin CSV'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 140),
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            csvText,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_busy) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}

class _ExportOptionTile extends StatelessWidget {
  const _ExportOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onPrint,
    required this.onShare,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback onPrint;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: scheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: enabled ? onPrint : null,
                  icon: const Icon(Icons.print_outlined, size: 16),
                  label: const Text('Pratinjau / Cetak'),
                ),
                OutlinedButton.icon(
                  onPressed: enabled ? onShare : null,
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: const Text('Unduh / Bagikan PDF'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
