import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';

Future<MovingProject?> showMovingProjectDialog({
  required BuildContext context,
  required String householdId,
  MovingProject? existing,
}) {
  return showDialog<MovingProject>(
    context: context,
    builder: (ctx) => _MovingProjectDialog(
      householdId: householdId,
      existing: existing,
    ),
  );
}

class _MovingProjectDialog extends ConsumerStatefulWidget {
  const _MovingProjectDialog({
    required this.householdId,
    this.existing,
  });

  final String householdId;
  final MovingProject? existing;

  @override
  ConsumerState<_MovingProjectDialog> createState() =>
      _MovingProjectDialogState();
}

class _MovingProjectDialogState extends ConsumerState<_MovingProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _originCtrl;
  late final TextEditingController _destCtrl;
  late final TextEditingController _notesCtrl;
  late MovingProjectStatus _status;
  DateTime? _targetDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _originCtrl =
        TextEditingController(text: widget.existing?.originAddress ?? '');
    _destCtrl =
        TextEditingController(text: widget.existing?.destinationAddress ?? '');
    _notesCtrl = TextEditingController(text: widget.existing?.notes ?? '');
    _status = widget.existing != null
        ? MovingProjectStatus.fromDb(widget.existing!.status)
        : MovingProjectStatus.planning;
    _targetDate = widget.existing?.targetMoveDate;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _originCtrl.dispose();
    _destCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? now.add(const Duration(days: 14)),
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      setState(() => _targetDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final repo = ref.read(movingRepositoryProvider);
    final draft = MovingProjectDraft(
      name: _nameCtrl.text,
      originAddress: _originCtrl.text,
      destinationAddress: _destCtrl.text,
      targetMoveDate: _targetDate,
      status: _status,
      notes: _notesCtrl.text,
    );

    try {
      final result = widget.existing == null
          ? await repo.createProject(
              householdId: widget.householdId,
              draft: draft,
            )
          : await repo.updateProject(id: widget.existing!.id, draft: draft);
      if (mounted) Navigator.of(context).pop(result);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan proyek: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return AlertDialog(
      title: Text(isEdit ? 'Edit Proyek Pindahan' : 'Proyek Pindahan Baru'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
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
                    labelText: 'Nama Proyek Pindahan *',
                    hintText: 'Mis. Pindah ke Rumah Bekasi 2026',
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama proyek wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _originCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Asal',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _destCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Tujuan',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<MovingProjectStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: 'Status Proyek'),
                  items: [
                    for (final st in MovingProjectStatus.values)
                      DropdownMenuItem(value: st, child: Text(st.label)),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _status = v);
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(
                    _targetDate == null
                        ? 'Pilih Target Tanggal Pindah'
                        : 'Target Pindah: ${formatDate(_targetDate)}',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (Mis. kontak truk / ekspedisi)',
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
