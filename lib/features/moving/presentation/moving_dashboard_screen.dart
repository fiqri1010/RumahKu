import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/core/utils/formatters.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';
import 'package:rumahku/features/moving/presentation/moving_box_detail_screen.dart';
import 'package:rumahku/features/moving/presentation/moving_providers.dart';
import 'package:rumahku/features/moving/presentation/widgets/box_form_dialog.dart';
import 'package:rumahku/features/moving/presentation/widgets/print_export_dialogs.dart';
import 'package:rumahku/features/moving/presentation/widgets/project_form_dialog.dart';

class MovingDashboardScreen extends ConsumerStatefulWidget {
  const MovingDashboardScreen({super.key});

  @override
  ConsumerState<MovingDashboardScreen> createState() =>
      _MovingDashboardScreenState();
}

class _MovingDashboardScreenState extends ConsumerState<MovingDashboardScreen> {
  final _searchCtrl = TextEditingController();
  String? _selectedBoxId;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _createNewBox(MovingProject project) async {
    final repo = ref.read(movingRepositoryProvider);
    final suggested = await repo.suggestNextBoxCode(project.id);
    if (!mounted) return;
    final created = await showMovingBoxDialog(
      context: context,
      householdId: project.householdId,
      projectId: project.id,
      suggestedBoxCode: suggested,
    );
    if (created != null && mounted) {
      setState(() => _selectedBoxId = created.id);
    }
  }

  Future<void> _confirmDeleteProject(MovingProject project) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hapus Proyek "${project.name}"?'),
        content: const Text(
          'Semua kardus pada proyek ini akan dihapus. Barang-barang yang berada di dalam kardus TIDAK ikut terhapus dan akan otomatis dilepaskan dari kardus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus Proyek'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(movingRepositoryProvider).deleteProject(project.id);
      if (mounted) {
        ref.read(selectedMovingProjectIdProvider.notifier).select(null);
        setState(() => _selectedBoxId = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final household = ref.watch(activeHouseholdProvider).value;
    final projects = ref.watch(movingProjectsStreamProvider).value ?? const [];
    final activeProject = ref.watch(activeMovingProjectProvider);
    final allBoxSummaries = ref.watch(activeBoxSummariesProvider);
    final filteredBoxes = ref.watch(filteredBoxSummariesProvider);
    final stats = ref.watch(activeProjectStatsProvider);
    final filter = ref.watch(boxFilterProvider);
    final scheme = Theme.of(context).colorScheme;

    final activeSelectedBoxId =
        filteredBoxes.any((b) => b.box.id == _selectedBoxId)
            ? _selectedBoxId
            : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mode Pindahan & QR'),
        actions: [
          IconButton(
            tooltip: 'Scan / Cari QR Kardus',
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => context.push('/scan'),
          ),
          if (household != null)
            IconButton(
              tooltip: 'Proyek Pindahan Baru',
              icon: const Icon(Icons.add_business_outlined),
              onPressed: () async {
                final created = await showMovingProjectDialog(
                  context: context,
                  householdId: household.id,
                );
                if (created != null && mounted) {
                  ref
                      .read(selectedMovingProjectIdProvider.notifier)
                      .select(created.id);
                }
              },
            ),
        ],
      ),
      body: household == null
          ? const Center(child: CircularProgressIndicator())
          : activeProject == null
              ? _EmptyMovingProjectsState(
                  onCreateProject: () async {
                    final created = await showMovingProjectDialog(
                      context: context,
                      householdId: household.id,
                    );
                    if (created != null && mounted) {
                      ref
                          .read(selectedMovingProjectIdProvider.notifier)
                          .select(created.id);
                    }
                  },
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final isMasterDetail = constraints.maxWidth >= 900;

                    final leftColumn = ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 92),
                      children: [
                        // Project header card + project switcher
                        _ProjectHeaderCard(
                          project: activeProject,
                          allProjects: projects,
                          stats: stats,
                          onSelectProject: (id) {
                            ref
                                .read(selectedMovingProjectIdProvider.notifier)
                                .select(id);
                            setState(() => _selectedBoxId = null);
                          },
                          onEditProject: () => showMovingProjectDialog(
                            context: context,
                            householdId: household.id,
                            existing: activeProject,
                          ),
                          onDeleteProject: () =>
                              _confirmDeleteProject(activeProject),
                        ),

                        const SizedBox(height: 12),

                        // Quick actions: Print Stickers, Export Manifest, Scan QR
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton.icon(
                              onPressed: () => _createNewBox(activeProject),
                              icon: const Icon(Icons.add_box_outlined, size: 18),
                              label: const Text('Tambah Kardus'),
                            ),
                            FilledButton.tonalIcon(
                              onPressed: allBoxSummaries.isEmpty
                                  ? null
                                  : () => showPrintStickersDialog(
                                        context: context,
                                        ref: ref,
                                        project: activeProject,
                                        boxes: allBoxSummaries,
                                      ),
                              icon: const Icon(Icons.qr_code_2, size: 18),
                              label: const Text('Cetak Stiker QR'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => showExportManifestDialog(
                                context: context,
                                ref: ref,
                                project: activeProject,
                                boxes: allBoxSummaries,
                              ),
                              icon: const Icon(
                                Icons.assignment_outlined,
                                size: 18,
                              ),
                              label: const Text('Manifest PDF/CSV'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => context.push('/scan'),
                              icon: const Icon(
                                Icons.qr_code_scanner,
                                size: 18,
                              ),
                              label: const Text('Scan QR'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Search box (searches box code, room, AND item names inside box!)
                        TextField(
                          controller: _searchCtrl,
                          onChanged: (v) =>
                              ref.read(boxFilterProvider.notifier).setQuery(v),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText:
                                'Cari kode kardus, ruangan, atau nama barang di dalamnya...',
                            suffixIcon: _searchCtrl.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _searchCtrl.clear();
                                      ref
                                          .read(boxFilterProvider.notifier)
                                          .setQuery('');
                                    },
                                  )
                                : null,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Status & Fragile filter chips
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text('Semua (${allBoxSummaries.length})'),
                                  selected: filter.status == null &&
                                      !filter.onlyFragile,
                                  onSelected: (_) => ref
                                      .read(boxFilterProvider.notifier)
                                      .reset(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  avatar: const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 16,
                                    color: Color(0xFFDC2626),
                                  ),
                                  label: Text(
                                    'Pecah Belah (${stats.fragileBoxCount})',
                                  ),
                                  selected: filter.onlyFragile,
                                  onSelected: (v) => ref
                                      .read(boxFilterProvider.notifier)
                                      .setOnlyFragile(v),
                                ),
                              ),
                              for (final st in MovingBoxStatus.values)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(
                                      '${st.label} (${stats.countByStatus[st] ?? 0})',
                                    ),
                                    selected: filter.status == st,
                                    onSelected: (sel) => ref
                                        .read(boxFilterProvider.notifier)
                                        .setStatus(sel ? st : null),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        if (filteredBoxes.isEmpty)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    size: 44,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    filter.hasActiveFilters
                                        ? 'Tidak ada kardus yang cocok dengan filter'
                                        : 'Belum ada kardus di proyek ini',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  if (!filter.hasActiveFilters)
                                    FilledButton.icon(
                                      onPressed: () =>
                                          _createNewBox(activeProject),
                                      icon: const Icon(Icons.add),
                                      label: const Text('Buat Kardus Pertama'),
                                    ),
                                ],
                              ),
                            ),
                          )
                        else
                          for (final summary in filteredBoxes) ...[
                            _MovingBoxCard(
                              summary: summary,
                              isSelected: isMasterDetail &&
                                  activeSelectedBoxId == summary.box.id,
                              onTap: () {
                                if (isMasterDetail) {
                                  setState(
                                    () => _selectedBoxId = summary.box.id,
                                  );
                                } else {
                                  context.push('/moving/box/${summary.box.id}');
                                }
                              },
                              onAdvanceStatus: () => ref
                                  .read(movingRepositoryProvider)
                                  .advanceBoxStatus(summary.box.id),
                            ),
                            const SizedBox(height: 8),
                          ],
                      ],
                    );

                    if (!isMasterDetail) return leftColumn;

                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth >= 1140 ? 480 : 410,
                          child: leftColumn,
                        ),
                        VerticalDivider(width: 1, color: scheme.outlineVariant),
                        Expanded(
                          child: activeSelectedBoxId == null
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.qr_code_2_outlined,
                                        size: 52,
                                        color: scheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Pilih kardus di sebelah kiri untuk melihat QR & daftar isi',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: scheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              : MovingBoxDetailContent(
                                  boxId: activeSelectedBoxId,
                                  onDeleted: () =>
                                      setState(() => _selectedBoxId = null),
                                ),
                        ),
                      ],
                    );
                  },
                ),
      floatingActionButton: activeProject == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _createNewBox(activeProject),
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Kardus Baru'),
            ),
    );
  }
}

class _EmptyMovingProjectsState extends StatelessWidget {
  const _EmptyMovingProjectsState({required this.onCreateProject});

  final VoidCallback onCreateProject;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD97706).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_shipping_outlined,
                      size: 44,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Siap Pindahan Tanpa Pusing',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Buat proyek pindahan, kelompokkan barang ke kardus ber-QR, cetak stiker A4 atau printer thermal, pantau status kardus sampai dibongkar, dan ekspor manifest serah-terima.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: onCreateProject,
                    icon: const Icon(Icons.add),
                    label: const Text('Buat Proyek Pindahan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectHeaderCard extends StatelessWidget {
  const _ProjectHeaderCard({
    required this.project,
    required this.allProjects,
    required this.stats,
    required this.onSelectProject,
    required this.onEditProject,
    required this.onDeleteProject,
  });

  final MovingProject project;
  final List<MovingProject> allProjects;
  final MovingProjectStats stats;
  final ValueChanged<String> onSelectProject;
  final VoidCallback onEditProject;
  final VoidCallback onDeleteProject;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final projStatus = MovingProjectStatus.fromDb(project.status);
    final pct = (stats.deliveryProgress * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: allProjects.length > 1
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: project.id,
                            isExpanded: true,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                            items: [
                              for (final p in allProjects)
                                DropdownMenuItem(
                                  value: p.id,
                                  child: Text(
                                    p.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                            onChanged: (id) {
                              if (id != null) onSelectProject(id);
                            },
                          ),
                        )
                      : Text(
                          project.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: projStatus.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    projStatus.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: projStatus.color,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'edit') onEditProject();
                    if (v == 'delete') onDeleteProject();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        dense: true,
                        leading: Icon(Icons.edit_outlined),
                        title: Text('Edit Proyek'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        dense: true,
                        leading: Icon(Icons.delete_outline),
                        title: Text('Hapus Proyek'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (project.originAddress != null ||
                project.destinationAddress != null) ...[
              const SizedBox(height: 4),
              Text(
                '${project.originAddress ?? 'Asal'} → ${project.destinationAddress ?? 'Tujuan'}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            if (project.targetMoveDate != null) ...[
              const SizedBox(height: 2),
              Text(
                'Target pindah: ${formatDate(project.targetMoveDate)}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Progres Sampai & Dibongkar',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${stats.arrivedOrUnpackedCount}/${stats.totalBoxes} kardus ($pct%)',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: stats.deliveryProgress,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 6,
              children: [
                _MiniStat(label: 'Kardus', value: '${stats.totalBoxes}'),
                _MiniStat(
                  label: 'Barang',
                  value: '${stats.totalItems} (${stats.totalQuantity} unit)',
                ),
                _MiniStat(
                  label: 'Nilai Pindahan',
                  value: formatIdr(stats.totalAssetValue),
                ),
                if (stats.totalWeightKg > 0)
                  _MiniStat(
                    label: 'Total Berat',
                    value: '${stats.totalWeightKg.toStringAsFixed(1)} kg',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _MovingBoxCard extends StatelessWidget {
  const _MovingBoxCard({
    required this.summary,
    required this.isSelected,
    required this.onTap,
    required this.onAdvanceStatus,
  });

  final MovingBoxSummary summary;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onAdvanceStatus;

  @override
  Widget build(BuildContext context) {
    final box = summary.box;
    final status = summary.status;
    final next = status.nextStatus;
    final scheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected
              ? scheme.primary
              : (box.isFragile
                  ? const Color(0xFFDC2626).withValues(alpha: 0.45)
                  : scheme.outlineVariant.withValues(alpha: 0.65)),
          width: isSelected ? 1.8 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: QrImageView(
                  data: box.labelQr,
                  version: QrVersions.auto,
                  size: 56,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                box.boxCode,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: scheme.primary,
                                    ),
                              ),
                              if (box.isFragile)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDC2626)
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'FRAGILE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: const Color(0xFFDC2626),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: status.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            status.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: status.color,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      box.destinationRoom ?? 'Ruangan tujuan belum diisi',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${summary.itemCount} barang • ${formatIdr(summary.totalValue)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                          ),
                        ),
                        if (next != null)
                          TextButton(
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onPressed: onAdvanceStatus,
                            child: Text('→ ${next.label}'),
                          ),
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
