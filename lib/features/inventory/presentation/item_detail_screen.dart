import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/inventory/presentation/widgets/attachment_thumbnail.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.itemId});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Barang')),
      body: ItemDetailContent(
        itemId: itemId,
        onDeleted: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/items');
          }
        },
      ),
    );
  }
}

/// Reusable detail pane used both inside [ItemDetailScreen] and inside the
/// Desktop/Web master-detail split view.
class ItemDetailContent extends ConsumerWidget {
  const ItemDetailContent({
    super.key,
    required this.itemId,
    this.onDeleted,
  });

  final String itemId;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(itemDetailStreamProvider(itemId));
    final attachments =
        ref.watch(itemAttachmentsStreamProvider(itemId)).value ?? const [];
    final subItems =
        ref.watch(itemSubItemsStreamProvider(itemId)).value ?? const [];
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
    final scheme = Theme.of(context).colorScheme;

    return itemAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error memuat detail: $err')),
      data: (item) {
        if (item == null) {
          return const Center(child: Text('Barang tidak ditemukan.'));
        }

        final type = AssetType.fromDb(item.assetType);
        final condition = ItemCondition.fromDb(item.condition);
        final utility = UtilityStatus.fromDb(item.utilityStatus);
        final usageMode = UsageMode.fromDb(item.usageMode);
        final locText = item.locationId == null
            ? 'Belum ditempatkan'
            : (breadcrumbs[item.locationId!] ?? 'Lokasi');
        final totalVal = InventoryRepository.effectiveItemValue(item);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: scheme.primaryContainer,
                          child: Icon(
                            type.icon,
                            color: scheme.onPrimaryContainer,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${type.label} • ${item.category} • ${item.quantity} unit',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _TagPill(label: condition.label, color: condition.color),
                        _TagPill(label: utility.label, color: utility.color),
                        if (item.utilityRating != null)
                          _TagPill(
                            label: '★ ${item.utilityRating}/5',
                            color: const Color(0xFFD97706),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () =>
                              context.push('/items/${item.id}/edit'),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _showMoveLocationDialog(context, ref, item),
                          icon: const Icon(Icons.drive_file_move_outlined,
                              size: 18),
                          label: const Text('Pindah Lokasi'),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: scheme.error,
                          ),
                          onPressed: () => _confirmDelete(context, ref, item),
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

            // Location & Financials
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi & Keuangan',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.place_outlined,
                      label: 'Lokasi',
                      value: locText,
                    ),
                    _DetailRow(
                      icon: Icons.payments_outlined,
                      label: 'Harga Beli (per unit)',
                      value: formatIdr(item.purchasePrice),
                    ),
                    _DetailRow(
                      icon: Icons.savings_outlined,
                      label: 'Total Nilai Aset',
                      value: formatIdr(totalVal > 0 ? totalVal : null),
                    ),
                    _DetailRow(
                      icon: Icons.storefront_outlined,
                      label: 'Toko & Tanggal Beli',
                      value:
                          '${item.purchaseStore ?? '—'} (${formatDate(item.purchaseDate)})',
                    ),
                    _DetailRow(
                      icon: Icons.verified_user_outlined,
                      label: 'Batas Garansi',
                      value: formatDate(item.warrantyExpiresAt),
                    ),
                    _DetailRow(
                      icon: Icons.insights_outlined,
                      label: 'Mode Kebermanfaatan',
                      value: usageMode.label,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Identity & QR
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identitas & Kode',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.branding_watermark_outlined,
                      label: 'Merek / Model',
                      value: [
                        if (item.brand != null) item.brand!,
                        if (item.modelNumber != null) item.modelNumber!,
                      ].join(' • ').ifEmpty('—'),
                    ),
                    _DetailRow(
                      icon: Icons.numbers_outlined,
                      label: 'Nomor Seri',
                      value: item.serialNumber ?? '—',
                    ),
                    _DetailRow(
                      icon: Icons.qr_code_2_outlined,
                      label: 'Kode QR RumahKu',
                      value: item.qrCode ?? '—',
                    ),
                    if (item.notes != null && item.notes!.isNotEmpty) ...[
                      const Divider(height: 20),
                      Text(
                        item.notes!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Sub-Items (Nested Assets)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub-Barang di Dalamnya (${subItems.length})',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        TextButton.icon(
                          onPressed: () => context.push(
                            '/items/new?containerItemId=${item.id}'
                            '${item.locationId != null ? '&locationId=${item.locationId}' : ''}',
                          ),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Tambah Sub-Barang'),
                        ),
                      ],
                    ),
                    if (subItems.isEmpty)
                      Text(
                        'Belum ada sub-barang (contoh: helm di motor, aksesoris di dalam tas).',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      )
                    else
                      for (final sub in subItems)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(AssetType.fromDb(sub.assetType).icon),
                          title: Text(sub.name),
                          subtitle: Text(sub.category),
                          trailing: Text(
                            formatIdr(sub.estimatedValue ?? sub.purchasePrice),
                          ),
                          onTap: () => context.push('/items/${sub.id}'),
                        ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Attachments Gallery
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Foto & Struk (${attachments.length})',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        TextButton.icon(
                          onPressed: () => _addPhoto(context, ref, item),
                          icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                          label: const Text('Tambah Foto'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (attachments.isEmpty)
                      Text(
                        'Belum ada lampiran foto atau struk.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      )
                    else
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final att in attachments)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    AttachmentThumbnail(
                                      localPath: att.localPath,
                                      width: 104,
                                      height: 104,
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: IconButton.filled(
                                        visualDensity: VisualDensity.compact,
                                        iconSize: 14,
                                        onPressed: () => ref
                                            .read(inventoryRepositoryProvider)
                                            .deleteAttachment(att.id),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AttachmentKind.fromDb(att.kind).label,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addPhoto(
    BuildContext context,
    WidgetRef ref,
    Item item,
  ) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await ref.read(inventoryRepositoryProvider).addPhotoAttachment(
          householdId: item.householdId,
          itemId: item.id,
          rawImageBytes: bytes,
        );
  }

  Future<void> _showMoveLocationDialog(
    BuildContext context,
    WidgetRef ref,
    Item item,
  ) async {
    final locations = ref.read(locationsStreamProvider).value ?? const [];
    final breadcrumbs = ref.read(locationBreadcrumbMapProvider);
    String? selected = item.locationId;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => AlertDialog(
          title: const Text('Pindah Lokasi Barang'),
          content: DropdownButtonFormField<String?>(
            initialValue:
                locations.any((l) => l.id == selected) ? selected : null,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Lokasi Tujuan'),
            items: [
              const DropdownMenuItem<String?>(
                value: null,
                child: Text('— Belum Ditempatkan —'),
              ),
              for (final loc in locations)
                DropdownMenuItem<String?>(
                  value: loc.id,
                  child: Text(
                    breadcrumbs[loc.id] ?? loc.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: (v) => setModalState(() => selected = v),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Pindahkan'),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      await ref.read(inventoryRepositoryProvider).moveItemLocation(
            itemId: item.id,
            newLocationId: selected,
          );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Item item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Barang?'),
        content: Text('"${item.name}" akan dihapus dari inventaris rumah.'),
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
      await ref.read(inventoryRepositoryProvider).deleteItem(item.id);
      onDeleted?.call();
    }
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: scheme.onSurfaceVariant),
          const SizedBox(width: 10),
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

extension _StringFallback on String {
  String ifEmpty(String fallback) => trim().isEmpty ? fallback : this;
}
