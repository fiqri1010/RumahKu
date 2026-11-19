import 'package:drift/drift.dart';

/// Shared columns for offline-first sync across all household domain tables.
mixin SyncColumns on Table {
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

class Households extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get inviteCode => text().unique()();
  TextColumn get currencyCode => text().withDefault(const Constant('IDR'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class HouseholdMembers extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get userId => text()();
  TextColumn get role => text().withDefault(const Constant('owner'))();
  TextColumn get displayName => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Locations extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get parentId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get kind => text().withDefault(const Constant('room'))();
  TextColumn get qrCode => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Items extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get locationId => text().nullable()();
  TextColumn get containerItemId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get category => text().withDefault(const Constant('Umum'))();
  TextColumn get assetType => text().withDefault(const Constant('general'))();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get brand => text().nullable()();
  TextColumn get modelNumber => text().nullable()();
  TextColumn get serialNumber => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get qrCode => text().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  TextColumn get purchaseStore => text().nullable()();
  RealColumn get estimatedValue => real().nullable()();
  DateTimeColumn get warrantyExpiresAt => dateTime().nullable()();
  TextColumn get condition => text().withDefault(const Constant('good'))();
  TextColumn get usageMode => text().withDefault(const Constant('daily_status'))();
  TextColumn get utilityStatus => text().withDefault(const Constant('frequent'))();
  IntColumn get utilityRating => integer().nullable()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get customFieldsJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ItemAttachments extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get kind => text().withDefault(const Constant('photo'))();
  TextColumn get localPath => text().nullable()();
  TextColumn get remotePath => text().nullable()();
  TextColumn get mimeType => text().withDefault(const Constant('image/jpeg'))();
  IntColumn get fileSizeBytes => integer().nullable()();
  IntColumn get pageOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isSensitive => boolean().withDefault(const Constant(false))();
  TextColumn get uploadStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AssetLoans extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get borrowerName => text()();
  TextColumn get borrowerContact => text().nullable()();
  DateTimeColumn get borrowedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dueReturnAt => dateTime().nullable()();
  DateTimeColumn get returnedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UsageLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get itemId => text().references(Items, #id)();
  DateTimeColumn get usedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Books extends Table with SyncColumns {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get isbn10 => text().nullable()();
  TextColumn get isbn13 => text().nullable()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get authorsJson => text().withDefault(const Constant('[]'))();
  TextColumn get publisher => text().nullable()();
  IntColumn get publishedYear => integer().nullable()();
  IntColumn get pageCount => integer().nullable()();
  TextColumn get language => text().withDefault(const Constant('id'))();
  TextColumn get genreTagsJson => text().withDefault(const Constant('[]'))();
  TextColumn get seriesName => text().nullable()();
  RealColumn get seriesNumber => real().nullable()();
  TextColumn get edition => text().nullable()();
  TextColumn get bookFormat => text().withDefault(const Constant('paperback'))();
  TextColumn get readingStatus => text().withDefault(const Constant('unread'))();
  IntColumn get currentPage => integer().withDefault(const Constant(0))();
  IntColumn get personalRating => integer().nullable()();
  DateTimeColumn get startedReadingAt => dateTime().nullable()();
  DateTimeColumn get finishedReadingAt => dateTime().nullable()();
  TextColumn get synopsis => text().nullable()();
  TextColumn get reviewNotes => text().nullable()();
  TextColumn get metadataSource => text().withDefault(const Constant('manual'))();

  @override
  Set<Column<Object>> get primaryKey => {itemId};
}

class Documents extends Table with SyncColumns {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get relatedItemId => text().nullable()();
  TextColumn get docCategory => text().withDefault(const Constant('other'))();
  TextColumn get docSubtype => text().nullable()();
  TextColumn get documentNumber => text().nullable()();
  TextColumn get ownerMemberName => text().nullable()();
  TextColumn get issuer => text().nullable()();
  DateTimeColumn get issuedAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  BoolColumn get isOriginal => boolean().withDefault(const Constant(true))();
  IntColumn get copyCount => integer().withDefault(const Constant(1))();
  TextColumn get physicalFolderLabel => text().nullable()();
  BoolColumn get isVaultLocked => boolean().withDefault(const Constant(true))();
  TextColumn get ocrExtractedText => text().nullable()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => {itemId};
}

class Vehicles extends Table with SyncColumns {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get vehicleKind => text().withDefault(const Constant('motorcycle'))();
  TextColumn get plateNumber => text().nullable()();
  TextColumn get vinRangka => text().nullable()();
  TextColumn get engineNumber => text().nullable()();
  IntColumn get manufactureYear => integer().nullable()();
  TextColumn get fuelType => text().nullable()();
  IntColumn get currentOdometerKm => integer().withDefault(const Constant(0))();
  DateTimeColumn get stnkAnnualDueAt => dateTime().nullable()();
  DateTimeColumn get stnk5yrDueAt => dateTime().nullable()();
  DateTimeColumn get insuranceDueAt => dateTime().nullable()();
  TextColumn get insuranceProvider => text().nullable()();
  TextColumn get bpkbNumber => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {itemId};
}

class VehicleServiceLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get vehicleId => text().references(Vehicles, #itemId)();
  DateTimeColumn get serviceDate => dateTime()();
  IntColumn get odometerKm => integer().nullable()();
  TextColumn get serviceType => text()();
  TextColumn get workshopName => text().nullable()();
  RealColumn get totalCost => real().withDefault(const Constant(0))();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  IntColumn get nextDueOdometerKm => integer().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class VehicleFuelLogs extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get vehicleId => text().references(Vehicles, #itemId)();
  DateTimeColumn get filledAt => dateTime()();
  IntColumn get odometerKm => integer()();
  RealColumn get liters => real()();
  RealColumn get pricePerLiter => real().nullable()();
  RealColumn get totalCost => real()();
  BoolColumn get isFullTank => boolean().withDefault(const Constant(true))();
  RealColumn get computedKmPerLiter => real().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MovingProjects extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get name => text()();
  TextColumn get originAddress => text().nullable()();
  TextColumn get destinationAddress => text().nullable()();
  DateTimeColumn get targetMoveDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('planning'))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MovingBoxes extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get projectId => text().references(MovingProjects, #id)();
  TextColumn get locationId => text().references(Locations, #id)();
  TextColumn get boxCode => text()();
  TextColumn get labelQr => text()();
  TextColumn get destinationRoom => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('packing'))();
  BoolColumn get isFragile => boolean().withDefault(const Constant(false))();
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  RealColumn get weightKg => real().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Reminders extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get householdId => text().references(Households, #id)();
  TextColumn get itemId => text().nullable()();
  TextColumn get kind => text()();
  TextColumn get title => text()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  IntColumn get dueOdometerKm => integer().nullable()();
  IntColumn get remindDaysBefore => integer().withDefault(const Constant(14))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Local-only table: FIFO queue of mutations waiting to be pushed to Supabase.
class SyncOutbox extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get targetTable => text()();
  TextColumn get recordId => text()();
  TextColumn get householdId => text()();
  TextColumn get operation => text()(); // 'upsert' | 'delete'
  TextColumn get payloadJson => text()();
  DateTimeColumn get queuedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

/// Local-only table: tracks last successful pull timestamp per table.
class SyncCheckpoints extends Table {
  TextColumn get targetTable => text()();
  DateTimeColumn get lastPulledAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {targetTable};
}
