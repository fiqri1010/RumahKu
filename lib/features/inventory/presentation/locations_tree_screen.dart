import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/inventory/presentation/widgets/location_form_dialog.dart';

class LocationsTreeScreen extends ConsumerStatefulWidget {
  const LocationsTreeScreen({super.key});

  @override
  ConsumerState<LocationsTreeScreen> createState() =>
      _LocationsTreeScreenState();
}

class _LocationsTreeScreenState extends ConsumerState<LocationsTreeScreen> {
  final Set<String> _collapsedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final household = ref.watch(activeHouseholdProvider).value;
    final roots = ref.watch(locationTreeProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hirarki Lokasi'),
        actions: [
          if (household != null)
            IconButton(
              tooltip: 'Tambah Lokasi Utama',
              icon: const Icon(Icons.create_new_folder_outlined),
              onPressed: () => showLocationFormDialog(
                context: context,
                ref: ref,
                householdId: household.id,
              ),
            ),
        ],
      ),
      body: roots.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_tree_outlined,
                      size: 56,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    const Text('Belum ada lokasi tersimpan'),
                    const SizedBox(height: 12),
                    if (household != null)
                      FilledButton.icon(
                        onPressed: () => showLocationFormDialog(
                          context: context,
                          ref: ref,
                          householdId: household.id,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Buat Lokasi Pertama'),
                      ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
              children: [
                Text(
                  'Susun lokasi bersarang: Rumah → Ruangan → Lemari / Rak / Brankas → Kardus.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                for (final root in roots)
                  ..._buildNodeWidgets(context, root, household?.id),
              ],
            ),
      floatingActionButton: household == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => showLocationFormDialog(
                context: context,
                ref: ref,
                householdId: household.id,
              ),
              icon: const Icon(Icons.add),
              label: const Text('Lokasi Baru'),
            ),
    );
  }

  List<Widget> _buildNodeWidgets(
    BuildContext context,
    LocationTreeNode node,
    String? householdId,
  ) {
    final loc = node.location;
    final kind = LocationKind.fromDb(loc.kind);
    final hasChildren = node.children.isNotEmpty;
    final isCollapsed = _collapsedIds.contains(loc.id);
    final scheme = Theme.of(context).colorScheme;

    return [
      Padding(
        padding: EdgeInsets.only(left: node.depth * 18.0, bottom: 8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              ref.read(itemFilterProvider.notifier).setLocation(loc.id);
              context.go('/items');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  if (hasChildren)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        isCollapsed
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isCollapsed) {
                            _collapsedIds.remove(loc.id);
                          } else {
                            _collapsedIds.add(loc.id);
                          }
                        });
                      },
                    )
                  else
                    const SizedBox(width: 40),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: scheme.primaryContainer,
                    child: Icon(
                      kind.icon,
                      size: 18,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${kind.label} • ${node.totalItemCount} barang • ${formatIdr(node.totalValue)}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (householdId != null)
                    PopupMenuButton<String>(
                      onSelected: (action) async {
                        switch (action) {
                          case 'add_child':
                            await showLocationFormDialog(
                              context: context,
                              ref: ref,
                              householdId: householdId,
                              initialParentId: loc.id,
                            );
                          case 'add_item':
                            if (context.mounted) {
                              context.push('/items/new?locationId=${loc.id}');
                            }
                          case 'edit':
                            await showLocationFormDialog(
                              context: context,
                              ref: ref,
                              householdId: householdId,
                              existing: loc,
                            );
                          case 'delete':
                            await _confirmDelete(context, node);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'add_child',
                          child: ListTile(
                            dense: true,
                            leading: Icon(Icons.subdirectory_arrow_right),
                            title: Text('Tambah Sub-Lokasi'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'add_item',
                          child: ListTile(
                            dense: true,
                            leading: Icon(Icons.add_box_outlined),
                            title: Text('Tambah Barang Di Sini'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            dense: true,
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Edit / Pindah Induk'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            dense: true,
                            leading: Icon(Icons.delete_outline),
                            title: Text('Hapus Lokasi'),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      if (hasChildren && !isCollapsed)
        for (final child in node.children)
          ..._buildNodeWidgets(context, child, householdId),
    ];
  }

  Future<void> _confirmDelete(
    BuildContext context,
    LocationTreeNode node,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Lokasi?'),
        content: Text(
          'Lokasi "${node.location.name}" akan dihapus. Sub-lokasi dan ${node.directItemCount} barang di dalamnya akan otomatis dipindahkan ke lokasi induknya agar tidak hilang.',
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
      await ref
          .read(inventoryRepositoryProvider)
          .deleteLocation(node.location.id);
    }
  }
}
