import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/inventory/presentation/inventory_providers.dart';
import 'package:rumahku/features/moving/data/moving_repository.dart';

final movingProjectsStreamProvider = StreamProvider<List<MovingProject>>((ref) {
  final household = ref.watch(activeHouseholdProvider).value;
  if (household == null) return Stream.value(const []);
  return ref.watch(appDatabaseProvider).watchMovingProjects(household.id);
});

class SelectedMovingProjectNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String? projectId) => state = projectId;
}

final selectedMovingProjectIdProvider =
    NotifierProvider<SelectedMovingProjectNotifier, String?>(
  SelectedMovingProjectNotifier.new,
);

final activeMovingProjectProvider = Provider<MovingProject?>((ref) {
  final projects = ref.watch(movingProjectsStreamProvider).value ?? const [];
  if (projects.isEmpty) return null;
  final selectedId = ref.watch(selectedMovingProjectIdProvider);
  if (selectedId != null) {
    for (final p in projects) {
      if (p.id == selectedId) return p;
    }
  }
  return projects.first;
});

final movingBoxesStreamProvider = StreamProvider<List<MovingBox>>((ref) {
  final project = ref.watch(activeMovingProjectProvider);
  if (project == null) return Stream.value(const []);
  return ref.watch(appDatabaseProvider).watchMovingBoxesForProject(project.id);
});

final allHouseholdBoxesStreamProvider = StreamProvider<List<MovingBox>>((ref) {
  final household = ref.watch(activeHouseholdProvider).value;
  if (household == null) return Stream.value(const []);
  return ref.watch(appDatabaseProvider).watchAllMovingBoxes(household.id);
});

class BoxFilterState {
  const BoxFilterState({
    this.query = '',
    this.status,
    this.onlyFragile = false,
  });

  final String query;
  final MovingBoxStatus? status;
  final bool onlyFragile;

  bool get hasActiveFilters =>
      query.trim().isNotEmpty || status != null || onlyFragile;

  BoxFilterState copyWith({
    String? query,
    MovingBoxStatus? status,
    bool clearStatus = false,
    bool? onlyFragile,
  }) {
    return BoxFilterState(
      query: query ?? this.query,
      status: clearStatus ? null : (status ?? this.status),
      onlyFragile: onlyFragile ?? this.onlyFragile,
    );
  }
}

class BoxFilterNotifier extends Notifier<BoxFilterState> {
  @override
  BoxFilterState build() => const BoxFilterState();

  void setQuery(String query) => state = state.copyWith(query: query);

  void setStatus(MovingBoxStatus? status) => state = state.copyWith(
        status: status,
        clearStatus: status == null,
      );

  void setOnlyFragile(bool value) => state = state.copyWith(onlyFragile: value);

  void reset() => state = const BoxFilterState();
}

final boxFilterProvider =
    NotifierProvider<BoxFilterNotifier, BoxFilterState>(BoxFilterNotifier.new);

final activeBoxSummariesProvider = Provider<List<MovingBoxSummary>>((ref) {
  final boxes = ref.watch(movingBoxesStreamProvider).value ?? const [];
  final items = ref.watch(itemsStreamProvider).value ?? const [];
  return MovingRepository.buildBoxSummaries(boxes, items);
});

final filteredBoxSummariesProvider = Provider<List<MovingBoxSummary>>((ref) {
  final summaries = ref.watch(activeBoxSummariesProvider);
  final filter = ref.watch(boxFilterProvider);
  final q = filter.query.trim().toLowerCase();

  return summaries.where((s) {
    if (filter.status != null && s.status != filter.status) {
      return false;
    }
    if (filter.onlyFragile && !s.box.isFragile) {
      return false;
    }
    if (q.isNotEmpty) {
      final haystack = [
        s.box.boxCode,
        s.box.destinationRoom ?? '',
        s.box.notes ?? '',
        s.box.labelQr,
        for (final item in s.items) '${item.name} ${item.category}',
      ].join(' ').toLowerCase();
      if (!haystack.contains(q)) return false;
    }
    return true;
  }).toList();
});

final activeProjectStatsProvider = Provider<MovingProjectStats>((ref) {
  final summaries = ref.watch(activeBoxSummariesProvider);
  return MovingRepository.computeProjectStats(summaries);
});

final movingBoxDetailStreamProvider =
    StreamProvider.family<MovingBox?, String>((ref, boxId) {
  return ref.watch(appDatabaseProvider).watchMovingBoxById(boxId);
});

final movingBoxSummaryByIdProvider =
    Provider.family<MovingBoxSummary?, String>((ref, boxId) {
  final box = ref.watch(movingBoxDetailStreamProvider(boxId)).value;
  if (box == null) return null;
  final items = ref.watch(itemsStreamProvider).value ?? const [];
  final summaries = MovingRepository.buildBoxSummaries([box], items);
  return summaries.isEmpty ? null : summaries.first;
});
