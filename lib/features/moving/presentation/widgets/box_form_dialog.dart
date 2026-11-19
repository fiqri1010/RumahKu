import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';

Future<MovingBox?> showMovingBoxDialog({
  required BuildContext context,
  required String householdId,
  required String projectId,
  MovingBox? existing,
  String? suggestedBoxCode,
}) {
  return showDialog<MovingBox>(
    context: context,
    builder: (ctx) => _MovingBoxDialog(
      householdId: householdId,
      projectId: projectId,
      existing: existing,
      suggestedBoxCode: suggestedBoxCode,
    ),
  );
}

class _MovingBoxDialog extends ConsumerStatefulWidget {
  const _MovingBoxDialog({
    required this.householdId,
    required this.projectId,
    this.existing,
    this.suggestedBoxCode,
  });

  final String householdId;
  final String projectId;
  final MovingBox? existing;
  final String? suggestedBoxCode;

  @override
  ConsumerState<_MovingBoxDialog> createState() => _MovingBoxDialogState();
}

class _MovingBoxDialogState extends ConsumerState<_MovingBoxDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeCtrl;
  late final TextEditingController _destRoomCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _notesCtrl;
  late MovingBoxStatus _status;
  late BoxPriority _priority;
  late bool _isFragile;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _codeCtrl = TextEditingController(
      text: widget.existing?.boxCode ?? widget.suggestedBoxCode ?? '',
    );
    _destRoomCtrl =
        TextEditingController(text: widget.existing?.destinationRoom ?? '');
    _weightCtrl = TextEditingController(
      text: widget.existing?.weightKg != null
          ? widget.existing!.weightKg!.toStringAsFixed(1)
          : '',
    );
    _notesCtrl = TextEditingController(text: widget.existing?.notes ?? '');
    _status = widget.existing != null
        ? MovingBoxStatus.fromDb(widget.existing!.status)
        : MovingBoxStatus.packing;
    _priority = widget.existing != null
        ? BoxPriority.fromDb(widget.existing!.priority)
        : BoxPriority.medium;
    _isFragile = widget.existing?.isFragile ?? false;
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _destRoomCtrl.dispose();
    _weightCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final repo = ref.read(movingRepositoryProvider);
    final weight = double.tryParse(_weightCtrl.text.trim().replaceAll(',', '.'));
    final draft = MovingBoxDraft(
      boxCode: _codeCtrl.text,
      destinationRoom: _destRoomCtrl.text,
      status: _status,
      isFragile: _isFragile,
      priority: _priority,
      weightKg: weight,
      notes: _notesCtrl.text,
    );

    try {
      final result = widget.existing == null
          ? await repo.createBox(
              householdId: widget.householdId,
              projectId: widget.projectId,
              draft: draft,
            )
          : await repo.updateBox(boxId: widget.existing!.id, draft: draft);
      if (mounted) Navigator.of(context).pop(result);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan kardus: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final locations = ref.watch(locationsStreamProvider).value ?? const [];
    final roomSuggestions = locations
        .where((l) => l.kind == LocationKind.room.dbValue)
        .map((l) => l.name)
        .toSet()
        .toList();

    return AlertDialog(
      title: Text(isEdit ? 'Edit Kardus Pindahan' : 'Kardus / Box Baru'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _codeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Kode Kardus *',
                          hintText: 'BOX-01',
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Kode wajib diisi'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _weightCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Berat (kg)',
                          hintText: 'Mis. 8.5',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _destRoomCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Ruangan Tujuan',
                    hintText: 'Mis. Dapur / Kamar Utama / Ruang Kerja',
                  ),
                ),
                if (roomSuggestions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final room in roomSuggestions.take(6))
                        ActionChip(
                          visualDensity: VisualDensity.compact,
                          label: Text(room),
                          onPressed: () =>
                              setState(() => _destRoomCtrl.text = room),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<MovingBoxStatus>(
                        initialValue: _status,
                        isExpanded: true,
                        decoration: const InputDecoration(labelText: 'Status'),
                        items: [
                          for (final st in MovingBoxStatus.values)
                            DropdownMenuItem(
                              value: st,
                              child: Text(
                                st.label,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _status = v);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<BoxPriority>(
                        initialValue: _priority,
                        isExpanded: true,
                        decoration:
                            const InputDecoration(labelText: 'Prioritas'),
                        items: [
                          for (final p in BoxPriority.values)
                            DropdownMenuItem(
                              value: p,
                              child: Text(
                                p.label,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _priority = v);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Barang Pecah Belah (Fragile)'),
                  subtitle: const Text(
                    'Menampilkan peringatan merah besar pada stiker QR',
                  ),
                  value: _isFragile,
                  onChanged: (v) => setState(() => _isFragile = v),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan Kardus',
                    hintText: 'Mis. Jangan ditumpuk, berisi piring kaca',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
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
