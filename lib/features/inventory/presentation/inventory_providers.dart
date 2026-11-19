import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/database/app_database.dart';
import 'package:rumahku/core/database/domain_enums.dart';
import 'package:rumahku/core/providers.dart';
import 'package:rumahku/features/inventory/data/inventory_repository.dart';

final locationsStreamProvider = StreamProvider<List<Location>>((ref) {
  final household = ref.watch(activeHouseholdProvider).value;
  if (household == null) return Stream.value(const []);
  return ref.watch(appDatabaseProvider).watchLocations(household.id);
});

final itemsStreamProvider = StreamProvider<List<Item>>((ref) {
  final household = ref.watch(activeHouseholdProvider).value;
  if (household == null) return Stream.value(const []);
  return ref.watch(appDatabaseProvider).watchItems(household.id);
});

final locationTreeProvider = Provider<List<LocationTreeNode>>((ref) {
  final locs = ref.watch(locationsStreamProvider).value ?? const [];
  final items = ref.watch(itemsStreamProvider).value ?? const [];
  return InventoryRepository.buildLocationTree(locs, items);
});

final locationBreadcrumbMapProvider = Provider<Map<String, String>>((ref) {
  final locs = ref.watch(locationsStreamProvider).value ?? const [];
  return InventoryRepository.buildBreadcrumbMap(locs);
});

final inventorySummaryProvider = Provider<InventorySummary>((ref) {
  final locs = ref.watch(locationsStreamProvider).value ?? const [];
  final items = ref.watch(itemsStreamProvider).value ?? const [];
  return InventoryRepository.computeSummary(locs, items);
});

class ItemFilterState {
  const ItemFilterState({
    this.query = '',
    this.locationId,
    this.assetType,
    this.condition,
  });

  final String query;
  final String? locationId;
  final AssetType? assetType;
  final ItemCondition? condition;

  bool get hasActiveFilters =>
      query.trim().isNotEmpty ||
      locationId != null ||
      assetType != null ||
      condition != null;

  ItemFilterState copyWith({
    String? query,
    String? locationId,
    bool clearLocation = false,
    AssetType? assetType,
    bool clearAssetType = false,
    ItemCondition? condition,
    bool clearCondition = false,
  }) {
    return ItemFilterState(
      query: query ?? this.query,
      locationId: clearLocation ? null : (locationId ?? this.locationId),
      assetType: clearAssetType ? null : (assetType ?? this.assetType),
      condition: clearCondition ? null : (condition ?? this.condition),
    );
  }
}

class ItemFilterNotifier extends Notifier<ItemFilterState> {
  @override
  ItemFilterState build() => const ItemFilterState();

  void setQuery(String query) => state = state.copyWith(query: query);

  void setLocation(String? locationId) => state = state.copyWith(
        locationId: locationId,
        clearLocation: locationId == null,
      );

  void setAssetType(AssetType? type) => state = state.copyWith(
        assetType: type,
        clearAssetType: type == null,
      );

  void setCondition(ItemCondition? condition) => state = state.copyWith(
        condition: condition,
        clearCondition: condition == null,
      );

  void reset() => state = const ItemFilterState();
}

final itemFilterProvider =
    NotifierProvider<ItemFilterNotifier, ItemFilterState>(
  ItemFilterNotifier.new,
);

final filteredItemsProvider = Provider<List<Item>>((ref) {
  final allItems = ref.watch(itemsStreamProvider).value ?? const [];
  final allLocations = ref.watch(locationsStreamProvider).value ?? const [];
  final breadcrumbs = ref.watch(locationBreadcrumbMapProvider);
  final filter = ref.watch(itemFilterProvider);

  final allowedLocationIds = filter.locationId == null
      ? null
      : InventoryRepository.collectLocationSubtreeIds(
          filter.locationId!,
          allLocations,
        );
  final q = filter.query.trim().toLowerCase();

  return allItems.where((item) {
    if (allowedLocationIds != null &&
        (item.locationId == null ||
            !allowedLocationIds.contains(item.locationId))) {
      return false;
    }
    if (filter.assetType != null &&
        item.assetType != filter.assetType!.dbValue) {
      return false;
    }
    if (filter.condition != null &&
        item.condition != filter.condition!.dbValue) {
      return false;
    }
    if (q.isNotEmpty) {
      final locPath =
          item.locationId == null ? '' : (breadcrumbs[item.locationId!] ?? '');
      final haystack = [
        item.name,
        item.category,
        item.brand ?? '',
        item.modelNumber ?? '',
        item.serialNumber ?? '',
        item.barcode ?? '',
        item.notes ?? '',
        locPath,
      ].join(' ').toLowerCase();
      if (!haystack.contains(q)) return false;
    }
    return true;
  }).toList();
});

final itemDetailStreamProvider = StreamProvider.family<Item?, String>((
  ref,
  itemId,
) {
  return ref.watch(appDatabaseProvider).watchItemById(itemId);
});

final itemAttachmentsStreamProvider =
    StreamProvider.family<List<ItemAttachment>, String>((ref, itemId) {
  return ref.watch(appDatabaseProvider).watchAttachmentsForItem(itemId);
});

final itemSubItemsStreamProvider =
    StreamProvider.family<List<Item>, String>((ref, itemId) {
  return ref.watch(appDatabaseProvider).watchSubItems(itemId);
});
