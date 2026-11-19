import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';
import 'package:rumahku/features/moving/presentation/moving_providers.dart';
import 'package:rumahku/features/moving/presentation/widgets/box_form_dialog.dart';
import 'package:rumahku/features/moving/presentation/widgets/bulk_move_dialog.dart';
import 'package:rumahku/features/moving/presentation/widgets/print_export_dialogs.dart';

class MovingBoxDetailScreen extends ConsumerWidget {
  const MovingBoxDetailScreen({super.key, required this.boxId});

  final String boxId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(movingBoxSummaryByIdProvider(boxId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          summary == null ? 'Detail Kardus' : 'Kardus ${summary.box.boxCode}',
        ),
      ),
      body: MovingBoxDetailContent(
        boxId: boxId,
        onDeleted: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/moving');
          }
        },
      ),
    );
  }
}

class MovingBoxDetailContent extends ConsumerWidget {
  const MovingBoxDetailContent({
    super.key,
    required this.boxId,
    this.onDeleted,
  });

  final String boxId;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boxAsync = ref.watch(movingBoxDetailStreamProvider(boxId));
    final summary = ref.watch(movingBoxSummaryByIdProvider(boxId));
    final projects = ref.watch(movingProjectsStreamProvider).value ?? const [];
    final scheme = Theme.of(context).colorScheme;

    if (boxAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (summary == null) {
      return const Center(child: Text('Kardus tidak ditemukan atau sudah dihapus.'));
    }

    final box = summary.box;
    final status = summary.status;
    final priority = summary.priority;
    MovingProject? parentProject;
    for (final p in projects) {
      if (p.id == box.projectId) {
        parentProject = p;
        break;
      }
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Hero QR + Box metadata card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: scheme.outlineVariant),
                          ),
                          child: QrImageView(
                            data: box.labelQr,
                            version: QrVersions.auto,
                            size: 112,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      box.boxCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: scheme.primary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.room_outlined,
                                    size: 16,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'Tujuan: ${box.destinationRoom ?? 'Belum ditentukan'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _BadgePill(
                                    label: status.label,
                                    color: status.color,
                                    icon: status.icon,
                                  ),
                                  _BadgePill(
                                    label: priority.label,
                                    color: priority.color,
                                  ),
                                  if (box.isFragile)
                                    const _BadgePill(
                                      label: 'PECAH BELAH',
                                      color: Color(0xFFDC2626),
                                      icon: Icons.warning_amber_rounded,
                                    ),
                                  if (box.weightKg != null)
                                    _BadgePill(
                                      label:
                                          '${box.weightKg!.toStringAsFixed(1)} kg',
                                      color: const Color(0xFF475569),
                                      icon: Icons.scale_outlined,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${summary.itemCount} barang (${summary.totalQuantity} unit) • ${formatIdr(summary.totalValue)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (box.notes != null && box.notes!.isNotEmpty) ...[
                      const Divider(height: 20),
                      Text(
                        box.notes!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () async {
                            final moved = await showBulkMoveToBoxDialog(
                              context: context,
                              box: box,
                            );
                            if (moved > 0 && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '$moved barang dimasukkan ke ${box.boxCode}',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.move_to_inbox_outlined,
                            size: 18,
                          ),
                          label: const Text('Isi Barang (Bulk Move)'),
                        ),
                        if (parentProject != null)
                          FilledButton.tonalIcon(
                            onPressed: () => showPrintStickersDialog(
                              context: context,
                              ref: ref,
                              project: parentProject!,
                              boxes: [summary],
                            ),
                            icon: const Icon(Icons.qr_code_2, size: 18),
                            label: const Text('Cetak Stiker QR'),
                          ),
                        if (summary.items.isNotEmpty ||
                            status != MovingBoxStatus.unpacked)
                          OutlinedButton.icon(
                            onPressed: () =>
                                _showUnpackDialog(context, ref, summary),
                            icon: const Icon(
                              Icons.unarchive_outlined,
                              size: 18,
                            ),
                            label: const Text('Bongkar ke Ruangan'),
                          ),
                        OutlinedButton.icon(
                          onPressed: () => showMovingBoxDialog(
                            context: context,
                            householdId: box.householdId,
                            projectId: box.projectId,
                            existing: box,
                          ),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit'),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: scheme.error,
                          ),
                          onPressed: () =>
                              _confirmDeleteBox(context, ref, summary),
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text('Hapus'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Interactive 5-stage status tracker
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status Perjalanan Kardus',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final step in MovingBoxStatus.values)
                          ChoiceChip(
                            avatar: Icon(
                              step.icon,
                              size: 16,
                              color: step == status
                                  ? scheme.onPrimaryContainer
                                  : step.color,
                            ),
                            label: Text(step.label),
                            selected: step == status,
                            onSelected: (_) {
                              if (step != status) {
                                ref
                                    .read(movingRepositoryProvider)
                                    .updateBoxStatus(
                                      boxId: box.id,
                                      status: step,
                                    );
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Packed items list
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            'Isi Kardus (${summary.itemCount} barang)',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          TextButton.icon(
                            onPressed: () => context
                                .push('/items/new?locationId=${box.locationId}'),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Barang Baru di Kardus'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (summary.items.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 40,
                                color: scheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kardus ini masih kosong. Gunakan tombol "Isi Barang (Bulk Move)" untuk memindahkan barang atau seluruh isi rak ke kardus ini.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          for (var i = 0; i < summary.items.length; i++) ...[
                            _PackedItemTile(
                              item: summary.items[i],
                              onOpen: () => context
                                  .push('/items/${summary.items[i].id}'),
                              onRemove: () => ref
                                  .read(movingRepositoryProvider)
                                  .removeItemFromBox(
                                    itemId: summary.items[i].id,
                                  ),
                            ),
                            if (i < summary.items.length - 1)
                              const Divider(height: 1),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showUnpackDialog(
    BuildContext context,
    WidgetRef ref,
    MovingBoxSummary summary,
  ) async {
    final allLocs = ref.read(locationsStreamProvider).value ?? const [];
    final breadcrumbs = ref.read(locationBreadcrumbMapProvider);
    final destinationCandidates = allLocs
        .where((l) => l.kind != LocationKind.movingBox.dbValue)
        .toList();

    // Auto-preselect location matching destinationRoom name if available.
    String? selectedDestId;
    final targetName = summary.box.destinationRoom?.trim().toLowerCase();
    if (targetName != null && targetName.isNotEmpty) {
      for (final loc in destinationCandidates) {
        if (loc.name.trim().toLowerCase() == targetName) {
          selectedDestId = loc.id;
          break;
        }
      }
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Bongkar Kardus ${summary.box.boxCode}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${summary.itemCount} barang di dalam kardus akan dipindahkan ke lokasi tujuan dan status kardus menjadi "Dibongkar".',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                initialValue: selectedDestId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Pindahkan Isi ke Lokasi',
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('— Belum Ditempatkan —'),
                  ),
                  for (final loc in destinationCandidates)
                    DropdownMenuItem<String?>(
                      value: loc.id,
                      child: Text(
                        breadcrumbs[loc.id] ?? loc.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => selectedDestId = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(ctx).pop(true),
              icon: const Icon(Icons.unarchive_outlined, size: 18),
              label: const Text('Bongkar Sekarang'),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      final unpacked =
          await ref.read(movingRepositoryProvider).unpackBoxToLocation(
                boxId: summary.box.id,
                destinationLocationId: selectedDestId,
              );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Kardus ${summary.box.boxCode} dibongkar ($unpacked barang dipindahkan)',
            ),
          ),
        );
      }
    }
  }

  Future<void> _confirmDeleteBox(
    BuildContext context,
    WidgetRef ref,
    MovingBoxSummary summary,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hapus Kardus ${summary.box.boxCode}?'),
        content: Text(
          summary.itemCount > 0
              ? 'Kardus akan dihapus. ${summary.itemCount} barang di dalamnya TIDAK akan terhapus dan otomatis dikeluarkan dari kardus.'
              : 'Kardus kosong ini akan dihapus dari proyek pindahan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(movingRepositoryProvider).deleteBox(summary.box.id);
      onDeleted?.call();
    }
  }
}

class _PackedItemTile extends StatelessWidget {
  const _PackedItemTile({
    required this.item,
    required this.onOpen,
    required this.onRemove,
  });

  final Item item;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final type = AssetType.fromDb(item.assetType);
    final val = InventoryRepository.effectiveItemValue(item);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(type.icon, size: 18),
      ),
      title: Text(
        item.quantity > 1 ? '${item.name} (×${item.quantity})' : item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        val > 0 ? '${item.category} • ${formatIdr(val)}' : item.category,
      ),
      onTap: onOpen,
      trailing: IconButton(
        tooltip: 'Keluarkan dari kardus',
        icon: const Icon(Icons.remove_circle_outline),
        onPressed: onRemove,
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
