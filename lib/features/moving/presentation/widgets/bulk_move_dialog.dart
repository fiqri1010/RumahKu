import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/moving/presentation/moving_providers.dart';

/// Opens a dual-mode bulk-packing dialog allowing users to either:
/// 1. Multi-select individual items to pack into [box], OR
/// 2. Pack an entire room / shelf / furniture branch in a single tap.
Future<int> showBulkMoveToBoxDialog({
  required BuildContext context,
  required MovingBox box,
}) async {
  final moved = await showDialog<int>(
    context: context,
    builder: (ctx) => _BulkMoveDialog(box: box),
  );
  return moved ?? 0;
}

class _BulkMoveDialog extends ConsumerStatefulWidget {
  const _BulkMoveDialog({required this.box});
  final MovingBox box;

  @override
  ConsumerState<_BulkMoveDialog> createState() => _BulkMoveDialogState();
}

class _BulkMoveDialogState extends ConsumerState<_BulkMoveDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _searchCtrl = TextEditingController();
  final Set<String> _selectedItemIds = <String>{};
  bool _onlyUnboxed = true;
  String? _selectedLocationId;
  bool _includeSubLocations = true;
  bool _working = false;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _moveSelectedItems() async {
    if (_selectedItemIds.isEmpty) return;
    setState(() => _working = true);
    final moved = await ref.read(movingRepositoryProvider).bulkMoveItemsToBox(
          boxId: widget.box.id,
          itemIds: _selectedItemIds.toList(),
        );
    if (mounted) Navigator.of(context).pop(moved);
  }

  Future<void> _moveLocationBranch() async {
    if (_selectedLocationId == null) return;
    setState(() => _working = true);
    final moved =
        await ref.read(movingRepositoryProvider).bulkMoveLocationToBox(
              boxId: widget.box.id,
              sourceLocationId: _selectedLocationId!,
              includeSubLocations: _includeSubLocations,
            );
    if (mounted) Navigator.of(context).pop(moved);
  }

  @override
  Widget build(BuildContext context) {
    final allItems = ref.watch(itemsStreamProvider).value ?? const [];
    final allLocations = ref.watch(locationsStreamProvider).value ?? const [];
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
    final allBoxes =
        ref.watch(allHouseholdBoxesStreamProvider).value ?? const [];
    final boxLocationIds = {for (final b in allBoxes) b.locationId};

    final query = _searchCtrl.text.trim().toLowerCase();
    final candidateItems = allItems.where((item) {
      if (item.locationId == widget.box.locationId) return false;
      if (_onlyUnboxed &&
          item.locationId != null &&
          boxLocationIds.contains(item.locationId)) {
        return false;
      }
      if (query.isNotEmpty) {
        final locPath =
            item.locationId == null ? '' : (breadcrumbs[item.locationId!] ?? '');
        final text = '${item.name} ${item.category} $locPath'.toLowerCase();
        if (!text.contains(query)) return false;
      }
      return true;
    }).toList();

    final nonBoxLocations = allLocations
        .where((l) => l.kind != LocationKind.movingBox.dbValue)
        .toList();

    return AlertDialog(
      title: Text('Isi Kardus ${widget.box.boxCode}'),
      content: SizedBox(
        width: 540,
        height: 460,
        child: Column(
          children: [
            TabBar(
              controller: _tabCtrl,
              onTap: (_) => setState(() {}),
              tabs: [
                Tab(
                  text: _selectedItemIds.isEmpty
                      ? 'Pilih Barang'
                      : 'Pilih Barang (${_selectedItemIds.length})',
                ),
                const Tab(text: 'Pindah 1 Lokasi / Rak'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  // Tab 1: Multi-select items
                  Column(
                    children: [
                      TextField(
                        controller: _searchCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Cari nama barang atau lokasi asal...',
                        ),
                      ),
                      CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Hanya tampilkan barang yang belum masuk kardus',
                        ),
                        value: _onlyUnboxed,
                        onChanged: (v) =>
                            setState(() => _onlyUnboxed = v ?? true),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: candidateItems.isEmpty
                            ? const Center(
                                child: Text(
                                  'Tidak ada barang tersedia untuk dipilih.',
                                ),
                              )
                            : ListView.builder(
                                itemCount: candidateItems.length,
                                itemBuilder: (context, index) {
                                  final item = candidateItems[index];
                                  final checked =
                                      _selectedItemIds.contains(item.id);
                                  final locLabel = item.locationId == null
                                      ? 'Belum ditempatkan'
                                      : (breadcrumbs[item.locationId!] ??
                                          'Lokasi');
                                  return CheckboxListTile(
                                    dense: true,
                                    value: checked,
                                    title: Text(item.name),
                                    subtitle:
                                        Text('$locLabel • ${item.category}'),
                                    onChanged: (v) {
                                      setState(() {
                                        if (v == true) {
                                          _selectedItemIds.add(item.id);
                                        } else {
                                          _selectedItemIds.remove(item.id);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),

                  // Tab 2: Pack whole room / shelf / folder
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Sertakan semua sub-lokasi di dalamnya',
                        ),
                        subtitle: const Text(
                          'Mis. memilih Kamar Utama ikut memindahkan isi Lemari di dalamnya',
                        ),
                        value: _includeSubLocations,
                        onChanged: (v) =>
                            setState(() => _includeSubLocations = v ?? true),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: nonBoxLocations.isEmpty
                            ? const Center(
                                child: Text('Belum ada lokasi sumber.'),
                              )
                            : RadioGroup<String>(
                                groupValue: _selectedLocationId,
                                onChanged: (v) =>
                                    setState(() => _selectedLocationId = v),
                                child: ListView.builder(
                                  itemCount: nonBoxLocations.length,
                                  itemBuilder: (context, index) {
                                    final loc = nonBoxLocations[index];
                                    final ids = _includeSubLocations
                                        ? InventoryRepository
                                            .collectLocationSubtreeIds(
                                            loc.id,
                                            allLocations,
                                          )
                                        : {loc.id};
                                    final count = allItems
                                        .where(
                                          (i) =>
                                              i.locationId != null &&
                                              ids.contains(i.locationId) &&
                                              i.locationId !=
                                                  widget.box.locationId,
                                        )
                                        .length;
                                    final kind = LocationKind.fromDb(loc.kind);
                                    return RadioListTile<String>(
                                      dense: true,
                                      value: loc.id,
                                      secondary: Icon(kind.icon, size: 20),
                                      title: Text(
                                        breadcrumbs[loc.id] ?? loc.name,
                                      ),
                                      subtitle: Text(
                                        '$count barang siap dipindahkan',
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _working ? null : () => Navigator.of(context).pop(0),
          child: const Text('Batal'),
        ),
        FilledButton.icon(
          onPressed: _working
              ? null
              : () {
                  if (_tabCtrl.index == 0) {
                    _moveSelectedItems();
                  } else {
                    _moveLocationBranch();
                  }
                },
          icon: const Icon(Icons.move_to_inbox_outlined, size: 18),
          label: Text(
            _tabCtrl.index == 0
                ? 'Masukkan (${_selectedItemIds.length})'
                : 'Pindahkan Isi Lokasi',
          ),
        ),
      ],
    );
  }
}
