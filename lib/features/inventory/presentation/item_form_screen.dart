import 'dart:typed_data';

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

class _PendingPhoto {
  const _PendingPhoto({required this.bytes, required this.kind});
  final Uint8List bytes;
  final AttachmentKind kind;
}

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({
    super.key,
    this.itemId,
    this.initialLocationId,
    this.initialContainerItemId,
  });

  final String? itemId;
  final String? initialLocationId;
  final String? initialContainerItemId;

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController(text: 'Umum');
  final _qtyCtrl = TextEditingController(text: '1');
  final _brandCtrl = TextEditingController();
  final _modelCtrl = TextEditingController();
  final _serialCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();
  final _purchasePriceCtrl = TextEditingController();
  final _estimatedValueCtrl = TextEditingController();
  final _storeCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _locationId;
  String? _containerItemId;
  AssetType _assetType = AssetType.general;
  ItemCondition _condition = ItemCondition.good;
  UsageMode _usageMode = UsageMode.dailyStatus;
  UtilityStatus _utilityStatus = UtilityStatus.frequent;
  int? _utilityRating;
  DateTime? _purchaseDate;
  DateTime? _warrantyExpiresAt;

  final List<_PendingPhoto> _pendingPhotos = [];
  bool _initialized = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _locationId = widget.initialLocationId;
    _containerItemId = widget.initialContainerItemId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _categoryCtrl.dispose();
    _qtyCtrl.dispose();
    _brandCtrl.dispose();
    _modelCtrl.dispose();
    _serialCtrl.dispose();
    _barcodeCtrl.dispose();
    _purchasePriceCtrl.dispose();
    _estimatedValueCtrl.dispose();
    _storeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _populateFromExisting(Item item) {
    if (_initialized) return;
    _initialized = true;
    _nameCtrl.text = item.name;
    _categoryCtrl.text = item.category;
    _qtyCtrl.text = '${item.quantity}';
    _brandCtrl.text = item.brand ?? '';
    _modelCtrl.text = item.modelNumber ?? '';
    _serialCtrl.text = item.serialNumber ?? '';
    _barcodeCtrl.text = item.barcode ?? '';
    _purchasePriceCtrl.text =
        item.purchasePrice != null ? item.purchasePrice!.round().toString() : '';
    _estimatedValueCtrl.text = item.estimatedValue != null
        ? item.estimatedValue!.round().toString()
        : '';
    _storeCtrl.text = item.purchaseStore ?? '';
    _notesCtrl.text = item.notes ?? '';
    _locationId = item.locationId;
    _containerItemId = item.containerItemId;
    _assetType = AssetType.fromDb(item.assetType);
    _condition = ItemCondition.fromDb(item.condition);
    _usageMode = UsageMode.fromDb(item.usageMode);
    _utilityStatus = UtilityStatus.fromDb(item.utilityStatus);
    _utilityRating = item.utilityRating;
    _purchaseDate = item.purchaseDate;
    _warrantyExpiresAt = item.warrantyExpiresAt;
  }

  double? _parseMoney(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }

  Future<void> _pickPhoto(AttachmentKind kind) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    setState(() {
      _pendingPhotos.add(_PendingPhoto(bytes: bytes, kind: kind));
    });
  }

  Future<void> _pickDate({
    required DateTime? initial,
    required ValueChanged<DateTime?> onSelected,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 30),
    );
    if (picked != null) {
      onSelected(picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final household = ref.read(activeHouseholdProvider).value;
    if (household == null) return;

    setState(() => _saving = true);
    final repo = ref.read(inventoryRepositoryProvider);
    final draft = ItemDraft(
      name: _nameCtrl.text,
      locationId: _locationId,
      containerItemId: _containerItemId,
      category: _categoryCtrl.text,
      assetType: _assetType,
      quantity: int.tryParse(_qtyCtrl.text.trim()) ?? 1,
      brand: _brandCtrl.text,
      modelNumber: _modelCtrl.text,
      serialNumber: _serialCtrl.text,
      barcode: _barcodeCtrl.text,
      purchasePrice: _parseMoney(_purchasePriceCtrl.text),
      purchaseDate: _purchaseDate,
      purchaseStore: _storeCtrl.text,
      estimatedValue: _parseMoney(_estimatedValueCtrl.text),
      warrantyExpiresAt: _warrantyExpiresAt,
      condition: _condition,
      usageMode: _usageMode,
      utilityStatus: _utilityStatus,
      utilityRating: _utilityRating,
      notes: _notesCtrl.text,
    );

    try {
      final Item saved;
      if (widget.itemId == null) {
        saved = await repo.createItem(householdId: household.id, draft: draft);
      } else {
        saved = await repo.updateItem(id: widget.itemId!, draft: draft);
      }

      for (final photo in _pendingPhotos) {
        await repo.addPhotoAttachment(
          householdId: household.id,
          itemId: saved.id,
          rawImageBytes: photo.bytes,
          kind: photo.kind,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.itemId == null
                  ? '"${saved.name}" berhasil disimpan'
                  : '"${saved.name}" berhasil diperbarui',
            ),
          ),
        );
        context.pop(saved.id);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan barang: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.itemId != null;
    if (isEdit) {
      final existingAsync = ref.watch(itemDetailStreamProvider(widget.itemId!));
      if (existingAsync.isLoading && !_initialized) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      final existing = existingAsync.value;
      if (existing != null) {
        _populateFromExisting(existing);
      }
    }

    final locations = ref.watch(locationsStreamProvider).value ?? const [];
    final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
    final allItems = ref.watch(itemsStreamProvider).value ?? const [];
    final candidateContainers =
        allItems.where((i) => i.id != widget.itemId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang Baru'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              label: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _SectionHeader(title: 'Informasi Utama'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nama Barang *',
                            hintText: 'Mis. MacBook Pro M3 / Bor Listrik Bosch',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Nama barang wajib diisi'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<AssetType>(
                                initialValue: _assetType,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Tipe Aset',
                                ),
                                items: [
                                  for (final type in AssetType.values)
                                    DropdownMenuItem(
                                      value: type,
                                      child: Row(
                                        children: [
                                          Icon(type.icon, size: 18),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              type.label,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() {
                                      _assetType = v;
                                      if (v == AssetType.book) {
                                        _usageMode = UsageMode.bookReading;
                                      } else if (v == AssetType.document) {
                                        _usageMode = UsageMode.archiveDoc;
                                      } else if (v == AssetType.vehicle) {
                                        _usageMode = UsageMode.vehicleOdometer;
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _qtyCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Jumlah',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _categoryCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            hintText: 'Mis. Kerja, Dapur, Perkakas, Pakaian',
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String?>(
                          initialValue: locations.any((l) => l.id == _locationId)
                              ? _locationId
                              : null,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Lokasi Penyimpanan',
                          ),
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
                          onChanged: (v) => setState(() => _locationId = v),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String?>(
                          initialValue: candidateContainers
                                  .any((i) => i.id == _containerItemId)
                              ? _containerItemId
                              : null,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Di Dalam Barang Lain (Opsional)',
                            helperText:
                                'Mis. Helm di dalam Motor, atau Lensa di dalam Tas Kamera',
                          ),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('— Tidak Ada (Berdiri Sendiri) —'),
                            ),
                            for (final item in candidateContainers)
                              DropdownMenuItem<String?>(
                                value: item.id,
                                child: Text(
                                  item.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                          onChanged: (v) =>
                              setState(() => _containerItemId = v),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _SectionHeader(title: 'Keuangan & Garansi ("Kemana Uangmu")'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _purchasePriceCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Harga Beli (Rp)',
                                  prefixText: 'Rp ',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _estimatedValueCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Nilai Taksiran (Rp)',
                                  prefixText: 'Rp ',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _storeCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Toko / Tempat Beli',
                            hintText: 'Mis. Tokopedia, IKEA, Dealer Resmi',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _pickDate(
                                  initial: _purchaseDate,
                                  onSelected: (d) =>
                                      setState(() => _purchaseDate = d),
                                ),
                                icon: const Icon(Icons.calendar_today, size: 16),
                                label: Text(
                                  _purchaseDate == null
                                      ? 'Tanggal Beli'
                                      : 'Beli: ${formatDate(_purchaseDate)}',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _pickDate(
                                  initial: _warrantyExpiresAt,
                                  onSelected: (d) =>
                                      setState(() => _warrantyExpiresAt = d),
                                ),
                                icon: const Icon(
                                  Icons.verified_user_outlined,
                                  size: 16,
                                ),
                                label: Text(
                                  _warrantyExpiresAt == null
                                      ? 'Batas Garansi'
                                      : 'Garansi: ${formatDate(_warrantyExpiresAt)}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _SectionHeader(
                  title: 'Kondisi & Kebermanfaatan ("Seberapa Bermanfaat")',
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<ItemCondition>(
                                initialValue: _condition,
                                decoration: const InputDecoration(
                                  labelText: 'Kondisi Fisik',
                                ),
                                items: [
                                  for (final c in ItemCondition.values)
                                    DropdownMenuItem(
                                      value: c,
                                      child: Text(c.label),
                                    ),
                                ],
                                onChanged: (v) {
                                  if (v != null) setState(() => _condition = v);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<UtilityStatus>(
                                initialValue: _utilityStatus,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Status Pemanfaatan',
                                ),
                                items: [
                                  for (final u in UtilityStatus.values)
                                    DropdownMenuItem(
                                      value: u,
                                      child: Text(
                                        u.label,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() => _utilityStatus = v);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<UsageMode>(
                          initialValue: _usageMode,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Mode Pengukuran Kebermanfaatan',
                          ),
                          items: [
                            for (final m in UsageMode.values)
                              DropdownMenuItem(
                                value: m,
                                child: Text(
                                  m.label,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _usageMode = v);
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('Rating Kepuasan / Manfaat:'),
                            const SizedBox(width: 8),
                            for (var star = 1; star <= 5; star++)
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () =>
                                    setState(() => _utilityRating = star),
                                icon: Icon(
                                  (_utilityRating ?? 0) >= star
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _SectionHeader(title: 'Identitas Produk & Catatan'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _brandCtrl,
                                decoration:
                                    const InputDecoration(labelText: 'Merek'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _modelCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Model / Tipe',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _serialCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Nomor Seri',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _barcodeCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Barcode / ISBN',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesCtrl,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Catatan Tambahan',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _SectionHeader(
                  title: 'Foto Barang & Struk (Kompresi Otomatis)',
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _pickPhoto(AttachmentKind.photo),
                              icon: const Icon(Icons.add_a_photo_outlined),
                              label: const Text('Tambah Foto Barang'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _pickPhoto(AttachmentKind.receipt),
                              icon: const Icon(Icons.receipt_long_outlined),
                              label: const Text('Tambah Foto Struk'),
                            ),
                          ],
                        ),
                        if (_pendingPhotos.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (var i = 0; i < _pendingPhotos.length; i++)
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        _pendingPhotos[i].bytes,
                                        width: 88,
                                        height: 88,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: IconButton.filled(
                                        visualDensity: VisualDensity.compact,
                                        iconSize: 14,
                                        onPressed: () => setState(
                                          () => _pendingPhotos.removeAt(i),
                                        ),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
