import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';

/// Modal dialog for creating or editing a nested [Location].
Future<bool> showLocationFormDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String householdId,
  Location? existing,
  String? initialParentId,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => _LocationFormDialog(
      householdId: householdId,
      existing: existing,
      initialParentId: initialParentId,
    ),
  );
  return result ?? false;
}

class _LocationFormDialog extends ConsumerStatefulWidget {
  const _LocationFormDialog({
    required this.householdId,
    this.existing,
    this.initialParentId,
  });

  final String householdId;
  final Location? existing;
  final String? initialParentId;

  @override
  ConsumerState<_LocationFormDialog> createState() =>
      _LocationFormDialogState();
}

class _LocationFormDialogState extends ConsumerState<_LocationFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _notesCtrl;
  late LocationKind _kind;
  String? _parentId;
  bool _saving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _notesCtrl = TextEditingController(text: widget.existing?.notes ?? '');
    _kind = widget.existing != null
        ? LocationKind.fromDb(widget.existing!.kind)
        : (widget.initialParentId == null
            ? LocationKind.property
            : LocationKind.room);
    _parentId = widget.existing?.parentId ?? widget.initialParentId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _errorMessage = null;
    });

    final repo = ref.read(inventoryRepositoryProvider);
    try {
      if (widget.existing == null) {
        await repo.createLocation(
          householdId: widget.householdId,
          parentId: _parentId,
          name: _nameCtrl.text,
          kind: _kind,
          notes: _notesCtrl.text,
        );
      } else {
        await repo.updateLocation(
          id: widget.existing!.id,
          name: _nameCtrl.text,
          kind: _kind,
          parentId: _parentId,
          notes: _notesCtrl.text,
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } on LocationCycleException catch (e) {
      setState(() {
        _saving = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _saving = false;
        _errorMessage = 'Gagal menyimpan lokasi: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allLocations = ref.watch(locationsStreamProvider).value ?? const [];
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);

    final excludedIds = widget.existing == null
        ? const <String>{}
        : InventoryRepository.collectLocationSubtreeIds(
            widget.existing!.id,
            allLocations,
          );
    final candidateParents =
        allLocations.where((l) => !excludedIds.contains(l.id)).toList();

    return AlertDialog(
      title: Text(widget.existing == null ? 'Tambah Lokasi' : 'Edit Lokasi'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lokasi *',
                    hintText: 'Contoh: Lemari Buku Kanan / Kamar Tamu',
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama lokasi wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<LocationKind>(
                  initialValue: _kind,
                  decoration: const InputDecoration(labelText: 'Jenis Lokasi'),
                  items: [
                    for (final kind in LocationKind.values)
                      DropdownMenuItem(
                        value: kind,
                        child: Row(
                          children: [
                            Icon(kind.icon, size: 18),
                            const SizedBox(width: 8),
                            Text(kind.label),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _kind = v);
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  initialValue: candidateParents.any((l) => l.id == _parentId)
                      ? _parentId
                      : null,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Berada Di Dalam (Induk)',
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('— Tingkat Atas (Root) —'),
                    ),
                    for (final loc in candidateParents)
                      DropdownMenuItem<String?>(
                        value: loc.id,
                        child: Text(
                          breadcrumbs[loc.id] ?? loc.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (v) => setState(() => _parentId = v),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (Opsional)',
                    hintText: 'Mis. Lantai 2 dekat jendela',
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: Text(_saving ? 'Menyimpan...' : 'Simpan'),
        ),
      ],
    );
  }
}
