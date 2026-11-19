import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/inventory/presentation/item_detail_screen.dart';

class ItemsListScreen extends ConsumerStatefulWidget {
  const ItemsListScreen({super.key});

  @override
  ConsumerState<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends ConsumerState<ItemsListScreen> {
  late final TextEditingController _searchCtrl;
  String? _selectedItemId;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController(
      text: ref.read(itemFilterProvider).query,
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(itemFilterProvider);
    final items = ref.watch(filteredItemsProvider);
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
    final scheme = Theme.of(context).colorScheme;

    // Keep master-detail selection valid if item was deleted or filtered out.
    final activeSelectedId =
        items.any((i) => i.id == _selectedItemId) ? _selectedItemId : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventaris (${items.length})'),
        actions: [
          if (filter.hasActiveFilters)
            TextButton.icon(
              onPressed: () {
                _searchCtrl.clear();
                ref.read(itemFilterProvider.notifier).reset();
              },
              icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
              label: const Text('Reset'),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMasterDetail = constraints.maxWidth >= 900;

          final listColumn = Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) =>
                      ref.read(itemFilterProvider.notifier).setQuery(v),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Cari nama barang, merek, serial, atau lokasi...',
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchCtrl.clear();
                              ref
                                  .read(itemFilterProvider.notifier)
                                  .setQuery('');
                            },
                          )
                        : null,
                  ),
                ),
              ),

              // Active Location filter pill + AssetType filter chips
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    if (filter.locationId != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InputChip(
                          avatar: const Icon(Icons.place_outlined, size: 16),
                          label: Text(
                            breadcrumbs[filter.locationId!] ?? 'Lokasi',
                          ),
                          onDeleted: () => ref
                              .read(itemFilterProvider.notifier)
                              .setLocation(null),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('Semua'),
                        selected: filter.assetType == null,
                        onSelected: (_) => ref
                            .read(itemFilterProvider.notifier)
                            .setAssetType(null),
                      ),
                    ),
                    for (final type in AssetType.values)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          avatar: Icon(type.icon, size: 16),
                          label: Text(type.label),
                          selected: filter.assetType == type,
                          onSelected: (selected) => ref
                              .read(itemFilterProvider.notifier)
                              .setAssetType(selected ? type : null),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 52,
                                color: scheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                filter.hasActiveFilters
                                    ? 'Tidak ada barang yang cocok dengan filter'
                                    : 'Inventaris masih kosong',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed: () {
                                  final locQuery = filter.locationId != null
                                      ? '?locationId=${filter.locationId}'
                                      : '';
                                  context.push('/items/new$locQuery');
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Tambah Barang'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
                        itemCount: items.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected =
                              isMasterDetail && activeSelectedId == item.id;
                          return _ItemListCard(
                            item: item,
                            locationBreadcrumb: item.locationId == null
                                ? 'Belum ditempatkan'
                                : (breadcrumbs[item.locationId!] ?? 'Lokasi'),
                            isSelected: isSelected,
                            onTap: () {
                              if (isMasterDetail) {
                                setState(() => _selectedItemId = item.id);
                              } else {
                                context.push('/items/${item.id}');
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          );

          if (!isMasterDetail) {
            return listColumn;
          }

          // Master-Detail split pane for PC / Desktop / Wide Web
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth >= 1100 ? 440 : 380,
                child: listColumn,
              ),
              VerticalDivider(width: 1, color: scheme.outlineVariant),
              Expanded(
                child: activeSelectedId == null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.touch_app_outlined,
                              size: 48,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Pilih barang di sebelah kiri untuk melihat detail',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      )
                    : ItemDetailContent(
                        itemId: activeSelectedId,
                        onDeleted: () =>
                            setState(() => _selectedItemId = null),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final locQuery = filter.locationId != null
              ? '?locationId=${filter.locationId}'
              : '';
          context.push('/items/new$locQuery');
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}

class _ItemListCard extends StatelessWidget {
  const _ItemListCard({
    required this.item,
    required this.locationBreadcrumb,
    required this.isSelected,
    required this.onTap,
  });

  final Item item;
  final String locationBreadcrumb;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final type = AssetType.fromDb(item.assetType);
    final condition = ItemCondition.fromDb(item.condition);
    final totalVal = InventoryRepository.effectiveItemValue(item);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected
              ? scheme.primary
              : scheme.outlineVariant.withValues(alpha: 0.65),
          width: isSelected ? 1.8 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: scheme.primaryContainer,
                child: Icon(type.icon, color: scheme.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (item.quantity > 1)
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '×${item.quantity}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: 14,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            locationBreadcrumb,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: condition.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            condition.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: condition.color,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                        if (totalVal > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            formatIdr(totalVal),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                          ),
                        ],
                      ],
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
}
