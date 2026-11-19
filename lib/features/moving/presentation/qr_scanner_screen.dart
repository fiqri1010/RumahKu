import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';

/// Cross-platform QR & Box-Code scanner/resolver:
/// - Android / iOS / macOS / Web: live camera scanner + manual/USB scanner input
/// - Windows / Linux (and headless tests): auto-focused USB keyboard-wedge &
///   manual code lookup (`rumahku://box/...`, `rumahku://item/...`, `rumahku://loc/...`, or `BOX-01`).
class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key, this.enableCamera});

  /// Override for tests or desktop fallback. When null, automatically enables
  /// camera only on platforms supported by `mobile_scanner`.
  final bool? enableCamera;

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  final _codeCtrl = TextEditingController();
  bool _resolving = false;
  bool _cameraActive = false;
  String? _errorText;

  bool get _platformSupportsCamera {
    if (widget.enableCamera != null) return widget.enableCamera!;
    if (kIsWeb) return true;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _resolveCode(String rawInput) async {
    final trimmed = rawInput.trim();
    if (trimmed.isEmpty || _resolving) return;

    setState(() {
      _resolving = true;
      _errorText = null;
    });

    final db = ref.read(appDatabaseProvider);
    final household = ref.read(activeHouseholdProvider).value;

    try {
      final parsed = parseRumahKuQrUri(trimmed);
      if (parsed != null) {
        switch (parsed.entityType) {
          case 'box':
            final box = await db.getMovingBoxById(parsed.id);
            if (box != null && mounted) {
              context.go('/moving');
              context.push('/moving/box/${box.id}');
              return;
            }
          case 'item':
            final item = await db.watchItemById(parsed.id).first;
            if (item != null && mounted) {
              context.go('/items');
              context.push('/items/${item.id}');
              return;
            }
          case 'loc':
            if (mounted) {
              ref.read(itemFilterProvider.notifier).setLocation(parsed.id);
              context.go('/items');
              return;
            }
        }
      }

      // Fallback: match MovingBox by human-readable box code (e.g. `BOX-01`)
      if (household != null) {
        final boxByCode = await db.findMovingBoxByCode(household.id, trimmed);
        if (boxByCode != null && mounted) {
          context.go('/moving');
          context.push('/moving/box/${boxByCode.id}');
          return;
        }
      }

      if (mounted) {
        setState(() {
          _resolving = false;
          _errorText =
              'Kode "$trimmed" tidak ditemukan di rumah tangga aktif. Pastikan kode QR RumahKu atau kode kardus (mis. BOX-01) sudah benar.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _resolving = false;
          _errorText = 'Gagal memproses kode: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final canUseCamera = _platformSupportsCamera;

    return Scaffold(
      appBar: AppBar(title: const Text('Scan / Cari Kode QR')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (canUseCamera)
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_cameraActive)
                        SizedBox(
                          height: 260,
                          child: MobileScanner(
                            onDetect: (capture) {
                              for (final barcode in capture.barcodes) {
                                final val = barcode.rawValue;
                                if (val != null && val.isNotEmpty) {
                                  setState(() => _cameraActive = false);
                                  _resolveCode(val);
                                  break;
                                }
                              }
                            },
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                size: 48,
                                color: scheme.primary,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Scan Stiker QR Kardus / Barang',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Arahkan kamera ke stiker QR RumahKu untuk langsung melihat daftar isi & ruangan tujuan.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed: () =>
                                    setState(() => _cameraActive = true),
                                icon: const Icon(Icons.camera_alt_outlined),
                                label: const Text('Buka Kamera Scanner'),
                              ),
                            ],
                          ),
                        ),
                      if (_cameraActive)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton.icon(
                            onPressed: () =>
                                setState(() => _cameraActive = false),
                            icon: const Icon(Icons.stop_circle_outlined),
                            label: const Text('Matikan Kamera'),
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Input Manual / USB Barcode Scanner',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ketik kode kardus (mis. BOX-01) atau tempel/scan payload QR (rumahku://box/... atau rumahku://item/...).',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _codeCtrl,
                        autofocus: !canUseCamera,
                        textInputAction: TextInputAction.search,
                        onSubmitted: _resolveCode,
                        decoration: const InputDecoration(
                          labelText: 'Kode Kardus atau URI QR',
                          hintText: 'BOX-01 atau rumahku://box/...',
                          prefixIcon: Icon(Icons.qr_code_2),
                        ),
                      ),
                      if (_errorText != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          _errorText!,
                          style: TextStyle(color: scheme.error),
                        ),
                      ],
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: _resolving
                            ? null
                            : () => _resolveCode(_codeCtrl.text),
                        icon: const Icon(Icons.search),
                        label: Text(
                          _resolving ? 'Mencari...' : 'Buka Kardus / Barang',
                        ),
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
