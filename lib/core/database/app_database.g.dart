// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HouseholdsTable extends Households
    with TableInfo<$HouseholdsTable, Household> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IDR'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    inviteCode,
    currencyCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'households';
  @override
  VerificationContext validateIntegrity(
    Insertable<Household> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_inviteCodeMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Household map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Household(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
    );
  }

  @override
  $HouseholdsTable createAlias(String alias) {
    return $HouseholdsTable(attachedDatabase, alias);
  }
}

class Household extends DataClass implements Insertable<Household> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String inviteCode;
  final String currencyCode;
  const Household({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.currencyCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['invite_code'] = Variable<String>(inviteCode);
    map['currency_code'] = Variable<String>(currencyCode);
    return map;
  }

  HouseholdsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      inviteCode: Value(inviteCode),
      currencyCode: Value(currencyCode),
    );
  }

  factory Household.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Household(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      inviteCode: serializer.fromJson<String>(json['inviteCode']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'inviteCode': serializer.toJson<String>(inviteCode),
      'currencyCode': serializer.toJson<String>(currencyCode),
    };
  }

  Household copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? inviteCode,
    String? currencyCode,
  }) => Household(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    inviteCode: inviteCode ?? this.inviteCode,
    currencyCode: currencyCode ?? this.currencyCode,
  );
  Household copyWithCompanion(HouseholdsCompanion data) {
    return Household(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Household(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('currencyCode: $currencyCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    inviteCode,
    currencyCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Household &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.inviteCode == this.inviteCode &&
          other.currencyCode == this.currencyCode);
}

class HouseholdsCompanion extends UpdateCompanion<Household> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> inviteCode;
  final Value<String> currencyCode;
  final Value<int> rowid;
  const HouseholdsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HouseholdsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String inviteCode,
    this.currencyCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       inviteCode = Value(inviteCode);
  static Insertable<Household> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? inviteCode,
    Expression<String>? currencyCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HouseholdsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? inviteCode,
    Value<String>? currencyCode,
    Value<int>? rowid,
  }) {
    return HouseholdsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      currencyCode: currencyCode ?? this.currencyCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HouseholdMembersTable extends HouseholdMembers
    with TableInfo<$HouseholdMembersTable, HouseholdMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('owner'),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    userId,
    role,
    displayName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'household_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<HouseholdMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HouseholdMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HouseholdMember(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
    );
  }

  @override
  $HouseholdMembersTable createAlias(String alias) {
    return $HouseholdMembersTable(attachedDatabase, alias);
  }
}

class HouseholdMember extends DataClass implements Insertable<HouseholdMember> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String userId;
  final String role;
  final String displayName;
  const HouseholdMember({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.userId,
    required this.role,
    required this.displayName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['display_name'] = Variable<String>(displayName);
    return map;
  }

  HouseholdMembersCompanion toCompanion(bool nullToAbsent) {
    return HouseholdMembersCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      userId: Value(userId),
      role: Value(role),
      displayName: Value(displayName),
    );
  }

  factory HouseholdMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HouseholdMember(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      displayName: serializer.fromJson<String>(json['displayName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'displayName': serializer.toJson<String>(displayName),
    };
  }

  HouseholdMember copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? userId,
    String? role,
    String? displayName,
  }) => HouseholdMember(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    displayName: displayName ?? this.displayName,
  );
  HouseholdMember copyWithCompanion(HouseholdMembersCompanion data) {
    return HouseholdMember(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdMember(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('displayName: $displayName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    userId,
    role,
    displayName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HouseholdMember &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.displayName == this.displayName);
}

class HouseholdMembersCompanion extends UpdateCompanion<HouseholdMember> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> userId;
  final Value<String> role;
  final Value<String> displayName;
  final Value<int> rowid;
  const HouseholdMembersCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.displayName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HouseholdMembersCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String userId,
    this.role = const Value.absent(),
    this.displayName = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       userId = Value(userId);
  static Insertable<HouseholdMember> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<String>? displayName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (displayName != null) 'display_name': displayName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HouseholdMembersCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? userId,
    Value<String>? role,
    Value<String>? displayName,
    Value<int>? rowid,
  }) {
    return HouseholdMembersCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdMembersCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('displayName: $displayName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('room'),
  );
  static const VerificationMeta _qrCodeMeta = const VerificationMeta('qrCode');
  @override
  late final GeneratedColumn<String> qrCode = GeneratedColumn<String>(
    'qr_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    parentId,
    name,
    kind,
    qrCode,
    notes,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('qr_code')) {
      context.handle(
        _qrCodeMeta,
        qrCode.isAcceptableOrUnknown(data['qr_code']!, _qrCodeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      qrCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_code'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String? parentId;
  final String name;
  final String kind;
  final String? qrCode;
  final String? notes;
  final int sortOrder;
  const Location({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    this.parentId,
    required this.name,
    required this.kind,
    this.qrCode,
    this.notes,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || qrCode != null) {
      map['qr_code'] = Variable<String>(qrCode);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      kind: Value(kind),
      qrCode: qrCode == null && nullToAbsent
          ? const Value.absent()
          : Value(qrCode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      sortOrder: Value(sortOrder),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      qrCode: serializer.fromJson<String?>(json['qrCode']),
      notes: serializer.fromJson<String?>(json['notes']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'parentId': serializer.toJson<String?>(parentId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'qrCode': serializer.toJson<String?>(qrCode),
      'notes': serializer.toJson<String?>(notes),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Location copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    Value<String?> parentId = const Value.absent(),
    String? name,
    String? kind,
    Value<String?> qrCode = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? sortOrder,
  }) => Location(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    parentId: parentId.present ? parentId.value : this.parentId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    qrCode: qrCode.present ? qrCode.value : this.qrCode,
    notes: notes.present ? notes.value : this.notes,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      qrCode: data.qrCode.present ? data.qrCode.value : this.qrCode,
      notes: data.notes.present ? data.notes.value : this.notes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('qrCode: $qrCode, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    parentId,
    name,
    kind,
    qrCode,
    notes,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.qrCode == this.qrCode &&
          other.notes == this.notes &&
          other.sortOrder == this.sortOrder);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String?> parentId;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> qrCode;
  final Value<String?> notes;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const LocationsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    this.parentId = const Value.absent(),
    required String name,
    this.kind = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       name = Value(name);
  static Insertable<Location> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? parentId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? qrCode,
    Expression<String>? notes,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (qrCode != null) 'qr_code': qrCode,
      if (notes != null) 'notes': notes,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String?>? parentId,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? qrCode,
    Value<String?>? notes,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      qrCode: qrCode ?? this.qrCode,
      notes: notes ?? this.notes,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (qrCode.present) {
      map['qr_code'] = Variable<String>(qrCode.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('qrCode: $qrCode, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _containerItemIdMeta = const VerificationMeta(
    'containerItemId',
  );
  @override
  late final GeneratedColumn<String> containerItemId = GeneratedColumn<String>(
    'container_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Umum'),
  );
  static const VerificationMeta _assetTypeMeta = const VerificationMeta(
    'assetType',
  );
  @override
  late final GeneratedColumn<String> assetType = GeneratedColumn<String>(
    'asset_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelNumberMeta = const VerificationMeta(
    'modelNumber',
  );
  @override
  late final GeneratedColumn<String> modelNumber = GeneratedColumn<String>(
    'model_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qrCodeMeta = const VerificationMeta('qrCode');
  @override
  late final GeneratedColumn<String> qrCode = GeneratedColumn<String>(
    'qr_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseStoreMeta = const VerificationMeta(
    'purchaseStore',
  );
  @override
  late final GeneratedColumn<String> purchaseStore = GeneratedColumn<String>(
    'purchase_store',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedValueMeta = const VerificationMeta(
    'estimatedValue',
  );
  @override
  late final GeneratedColumn<double> estimatedValue = GeneratedColumn<double>(
    'estimated_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyExpiresAtMeta = const VerificationMeta(
    'warrantyExpiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyExpiresAt =
      GeneratedColumn<DateTime>(
        'warranty_expires_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('good'),
  );
  static const VerificationMeta _usageModeMeta = const VerificationMeta(
    'usageMode',
  );
  @override
  late final GeneratedColumn<String> usageMode = GeneratedColumn<String>(
    'usage_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('daily_status'),
  );
  static const VerificationMeta _utilityStatusMeta = const VerificationMeta(
    'utilityStatus',
  );
  @override
  late final GeneratedColumn<String> utilityStatus = GeneratedColumn<String>(
    'utility_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('frequent'),
  );
  static const VerificationMeta _utilityRatingMeta = const VerificationMeta(
    'utilityRating',
  );
  @override
  late final GeneratedColumn<int> utilityRating = GeneratedColumn<int>(
    'utility_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFieldsJsonMeta = const VerificationMeta(
    'customFieldsJson',
  );
  @override
  late final GeneratedColumn<String> customFieldsJson = GeneratedColumn<String>(
    'custom_fields_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    locationId,
    containerItemId,
    name,
    category,
    assetType,
    quantity,
    brand,
    modelNumber,
    serialNumber,
    barcode,
    qrCode,
    purchasePrice,
    purchaseDate,
    purchaseStore,
    estimatedValue,
    warrantyExpiresAt,
    condition,
    usageMode,
    utilityStatus,
    utilityRating,
    usageCount,
    lastUsedAt,
    notes,
    customFieldsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    }
    if (data.containsKey('container_item_id')) {
      context.handle(
        _containerItemIdMeta,
        containerItemId.isAcceptableOrUnknown(
          data['container_item_id']!,
          _containerItemIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('asset_type')) {
      context.handle(
        _assetTypeMeta,
        assetType.isAcceptableOrUnknown(data['asset_type']!, _assetTypeMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model_number')) {
      context.handle(
        _modelNumberMeta,
        modelNumber.isAcceptableOrUnknown(
          data['model_number']!,
          _modelNumberMeta,
        ),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('qr_code')) {
      context.handle(
        _qrCodeMeta,
        qrCode.isAcceptableOrUnknown(data['qr_code']!, _qrCodeMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_store')) {
      context.handle(
        _purchaseStoreMeta,
        purchaseStore.isAcceptableOrUnknown(
          data['purchase_store']!,
          _purchaseStoreMeta,
        ),
      );
    }
    if (data.containsKey('estimated_value')) {
      context.handle(
        _estimatedValueMeta,
        estimatedValue.isAcceptableOrUnknown(
          data['estimated_value']!,
          _estimatedValueMeta,
        ),
      );
    }
    if (data.containsKey('warranty_expires_at')) {
      context.handle(
        _warrantyExpiresAtMeta,
        warrantyExpiresAt.isAcceptableOrUnknown(
          data['warranty_expires_at']!,
          _warrantyExpiresAtMeta,
        ),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('usage_mode')) {
      context.handle(
        _usageModeMeta,
        usageMode.isAcceptableOrUnknown(data['usage_mode']!, _usageModeMeta),
      );
    }
    if (data.containsKey('utility_status')) {
      context.handle(
        _utilityStatusMeta,
        utilityStatus.isAcceptableOrUnknown(
          data['utility_status']!,
          _utilityStatusMeta,
        ),
      );
    }
    if (data.containsKey('utility_rating')) {
      context.handle(
        _utilityRatingMeta,
        utilityRating.isAcceptableOrUnknown(
          data['utility_rating']!,
          _utilityRatingMeta,
        ),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('custom_fields_json')) {
      context.handle(
        _customFieldsJsonMeta,
        customFieldsJson.isAcceptableOrUnknown(
          data['custom_fields_json']!,
          _customFieldsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      ),
      containerItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}container_item_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      assetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      modelNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_number'],
      ),
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      qrCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_code'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      purchaseStore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_store'],
      ),
      estimatedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_value'],
      ),
      warrantyExpiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_expires_at'],
      ),
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      usageMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_mode'],
      )!,
      utilityStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}utility_status'],
      )!,
      utilityRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}utility_rating'],
      ),
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      customFieldsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fields_json'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String? locationId;
  final String? containerItemId;
  final String name;
  final String category;
  final String assetType;
  final int quantity;
  final String? brand;
  final String? modelNumber;
  final String? serialNumber;
  final String? barcode;
  final String? qrCode;
  final double? purchasePrice;
  final DateTime? purchaseDate;
  final String? purchaseStore;
  final double? estimatedValue;
  final DateTime? warrantyExpiresAt;
  final String condition;
  final String usageMode;
  final String utilityStatus;
  final int? utilityRating;
  final int usageCount;
  final DateTime? lastUsedAt;
  final String? notes;
  final String customFieldsJson;
  const Item({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    this.locationId,
    this.containerItemId,
    required this.name,
    required this.category,
    required this.assetType,
    required this.quantity,
    this.brand,
    this.modelNumber,
    this.serialNumber,
    this.barcode,
    this.qrCode,
    this.purchasePrice,
    this.purchaseDate,
    this.purchaseStore,
    this.estimatedValue,
    this.warrantyExpiresAt,
    required this.condition,
    required this.usageMode,
    required this.utilityStatus,
    this.utilityRating,
    required this.usageCount,
    this.lastUsedAt,
    this.notes,
    required this.customFieldsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    if (!nullToAbsent || containerItemId != null) {
      map['container_item_id'] = Variable<String>(containerItemId);
    }
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['asset_type'] = Variable<String>(assetType);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || modelNumber != null) {
      map['model_number'] = Variable<String>(modelNumber);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || qrCode != null) {
      map['qr_code'] = Variable<String>(qrCode);
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || purchaseStore != null) {
      map['purchase_store'] = Variable<String>(purchaseStore);
    }
    if (!nullToAbsent || estimatedValue != null) {
      map['estimated_value'] = Variable<double>(estimatedValue);
    }
    if (!nullToAbsent || warrantyExpiresAt != null) {
      map['warranty_expires_at'] = Variable<DateTime>(warrantyExpiresAt);
    }
    map['condition'] = Variable<String>(condition);
    map['usage_mode'] = Variable<String>(usageMode);
    map['utility_status'] = Variable<String>(utilityStatus);
    if (!nullToAbsent || utilityRating != null) {
      map['utility_rating'] = Variable<int>(utilityRating);
    }
    map['usage_count'] = Variable<int>(usageCount);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['custom_fields_json'] = Variable<String>(customFieldsJson);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      containerItemId: containerItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(containerItemId),
      name: Value(name),
      category: Value(category),
      assetType: Value(assetType),
      quantity: Value(quantity),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      modelNumber: modelNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(modelNumber),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      qrCode: qrCode == null && nullToAbsent
          ? const Value.absent()
          : Value(qrCode),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      purchaseStore: purchaseStore == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseStore),
      estimatedValue: estimatedValue == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedValue),
      warrantyExpiresAt: warrantyExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyExpiresAt),
      condition: Value(condition),
      usageMode: Value(usageMode),
      utilityStatus: Value(utilityStatus),
      utilityRating: utilityRating == null && nullToAbsent
          ? const Value.absent()
          : Value(utilityRating),
      usageCount: Value(usageCount),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      customFieldsJson: Value(customFieldsJson),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      containerItemId: serializer.fromJson<String?>(json['containerItemId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      assetType: serializer.fromJson<String>(json['assetType']),
      quantity: serializer.fromJson<int>(json['quantity']),
      brand: serializer.fromJson<String?>(json['brand']),
      modelNumber: serializer.fromJson<String?>(json['modelNumber']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      qrCode: serializer.fromJson<String?>(json['qrCode']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      purchaseStore: serializer.fromJson<String?>(json['purchaseStore']),
      estimatedValue: serializer.fromJson<double?>(json['estimatedValue']),
      warrantyExpiresAt: serializer.fromJson<DateTime?>(
        json['warrantyExpiresAt'],
      ),
      condition: serializer.fromJson<String>(json['condition']),
      usageMode: serializer.fromJson<String>(json['usageMode']),
      utilityStatus: serializer.fromJson<String>(json['utilityStatus']),
      utilityRating: serializer.fromJson<int?>(json['utilityRating']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      customFieldsJson: serializer.fromJson<String>(json['customFieldsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'locationId': serializer.toJson<String?>(locationId),
      'containerItemId': serializer.toJson<String?>(containerItemId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'assetType': serializer.toJson<String>(assetType),
      'quantity': serializer.toJson<int>(quantity),
      'brand': serializer.toJson<String?>(brand),
      'modelNumber': serializer.toJson<String?>(modelNumber),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'barcode': serializer.toJson<String?>(barcode),
      'qrCode': serializer.toJson<String?>(qrCode),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'purchaseStore': serializer.toJson<String?>(purchaseStore),
      'estimatedValue': serializer.toJson<double?>(estimatedValue),
      'warrantyExpiresAt': serializer.toJson<DateTime?>(warrantyExpiresAt),
      'condition': serializer.toJson<String>(condition),
      'usageMode': serializer.toJson<String>(usageMode),
      'utilityStatus': serializer.toJson<String>(utilityStatus),
      'utilityRating': serializer.toJson<int?>(utilityRating),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
      'notes': serializer.toJson<String?>(notes),
      'customFieldsJson': serializer.toJson<String>(customFieldsJson),
    };
  }

  Item copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    Value<String?> locationId = const Value.absent(),
    Value<String?> containerItemId = const Value.absent(),
    String? name,
    String? category,
    String? assetType,
    int? quantity,
    Value<String?> brand = const Value.absent(),
    Value<String?> modelNumber = const Value.absent(),
    Value<String?> serialNumber = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<String?> qrCode = const Value.absent(),
    Value<double?> purchasePrice = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<String?> purchaseStore = const Value.absent(),
    Value<double?> estimatedValue = const Value.absent(),
    Value<DateTime?> warrantyExpiresAt = const Value.absent(),
    String? condition,
    String? usageMode,
    String? utilityStatus,
    Value<int?> utilityRating = const Value.absent(),
    int? usageCount,
    Value<DateTime?> lastUsedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? customFieldsJson,
  }) => Item(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    locationId: locationId.present ? locationId.value : this.locationId,
    containerItemId: containerItemId.present
        ? containerItemId.value
        : this.containerItemId,
    name: name ?? this.name,
    category: category ?? this.category,
    assetType: assetType ?? this.assetType,
    quantity: quantity ?? this.quantity,
    brand: brand.present ? brand.value : this.brand,
    modelNumber: modelNumber.present ? modelNumber.value : this.modelNumber,
    serialNumber: serialNumber.present ? serialNumber.value : this.serialNumber,
    barcode: barcode.present ? barcode.value : this.barcode,
    qrCode: qrCode.present ? qrCode.value : this.qrCode,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    purchaseStore: purchaseStore.present
        ? purchaseStore.value
        : this.purchaseStore,
    estimatedValue: estimatedValue.present
        ? estimatedValue.value
        : this.estimatedValue,
    warrantyExpiresAt: warrantyExpiresAt.present
        ? warrantyExpiresAt.value
        : this.warrantyExpiresAt,
    condition: condition ?? this.condition,
    usageMode: usageMode ?? this.usageMode,
    utilityStatus: utilityStatus ?? this.utilityStatus,
    utilityRating: utilityRating.present
        ? utilityRating.value
        : this.utilityRating,
    usageCount: usageCount ?? this.usageCount,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
    notes: notes.present ? notes.value : this.notes,
    customFieldsJson: customFieldsJson ?? this.customFieldsJson,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      containerItemId: data.containerItemId.present
          ? data.containerItemId.value
          : this.containerItemId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      assetType: data.assetType.present ? data.assetType.value : this.assetType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      brand: data.brand.present ? data.brand.value : this.brand,
      modelNumber: data.modelNumber.present
          ? data.modelNumber.value
          : this.modelNumber,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      qrCode: data.qrCode.present ? data.qrCode.value : this.qrCode,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchaseStore: data.purchaseStore.present
          ? data.purchaseStore.value
          : this.purchaseStore,
      estimatedValue: data.estimatedValue.present
          ? data.estimatedValue.value
          : this.estimatedValue,
      warrantyExpiresAt: data.warrantyExpiresAt.present
          ? data.warrantyExpiresAt.value
          : this.warrantyExpiresAt,
      condition: data.condition.present ? data.condition.value : this.condition,
      usageMode: data.usageMode.present ? data.usageMode.value : this.usageMode,
      utilityStatus: data.utilityStatus.present
          ? data.utilityStatus.value
          : this.utilityStatus,
      utilityRating: data.utilityRating.present
          ? data.utilityRating.value
          : this.utilityRating,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      customFieldsJson: data.customFieldsJson.present
          ? data.customFieldsJson.value
          : this.customFieldsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('locationId: $locationId, ')
          ..write('containerItemId: $containerItemId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('assetType: $assetType, ')
          ..write('quantity: $quantity, ')
          ..write('brand: $brand, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('barcode: $barcode, ')
          ..write('qrCode: $qrCode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchaseStore: $purchaseStore, ')
          ..write('estimatedValue: $estimatedValue, ')
          ..write('warrantyExpiresAt: $warrantyExpiresAt, ')
          ..write('condition: $condition, ')
          ..write('usageMode: $usageMode, ')
          ..write('utilityStatus: $utilityStatus, ')
          ..write('utilityRating: $utilityRating, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('notes: $notes, ')
          ..write('customFieldsJson: $customFieldsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    locationId,
    containerItemId,
    name,
    category,
    assetType,
    quantity,
    brand,
    modelNumber,
    serialNumber,
    barcode,
    qrCode,
    purchasePrice,
    purchaseDate,
    purchaseStore,
    estimatedValue,
    warrantyExpiresAt,
    condition,
    usageMode,
    utilityStatus,
    utilityRating,
    usageCount,
    lastUsedAt,
    notes,
    customFieldsJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.locationId == this.locationId &&
          other.containerItemId == this.containerItemId &&
          other.name == this.name &&
          other.category == this.category &&
          other.assetType == this.assetType &&
          other.quantity == this.quantity &&
          other.brand == this.brand &&
          other.modelNumber == this.modelNumber &&
          other.serialNumber == this.serialNumber &&
          other.barcode == this.barcode &&
          other.qrCode == this.qrCode &&
          other.purchasePrice == this.purchasePrice &&
          other.purchaseDate == this.purchaseDate &&
          other.purchaseStore == this.purchaseStore &&
          other.estimatedValue == this.estimatedValue &&
          other.warrantyExpiresAt == this.warrantyExpiresAt &&
          other.condition == this.condition &&
          other.usageMode == this.usageMode &&
          other.utilityStatus == this.utilityStatus &&
          other.utilityRating == this.utilityRating &&
          other.usageCount == this.usageCount &&
          other.lastUsedAt == this.lastUsedAt &&
          other.notes == this.notes &&
          other.customFieldsJson == this.customFieldsJson);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String?> locationId;
  final Value<String?> containerItemId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> assetType;
  final Value<int> quantity;
  final Value<String?> brand;
  final Value<String?> modelNumber;
  final Value<String?> serialNumber;
  final Value<String?> barcode;
  final Value<String?> qrCode;
  final Value<double?> purchasePrice;
  final Value<DateTime?> purchaseDate;
  final Value<String?> purchaseStore;
  final Value<double?> estimatedValue;
  final Value<DateTime?> warrantyExpiresAt;
  final Value<String> condition;
  final Value<String> usageMode;
  final Value<String> utilityStatus;
  final Value<int?> utilityRating;
  final Value<int> usageCount;
  final Value<DateTime?> lastUsedAt;
  final Value<String?> notes;
  final Value<String> customFieldsJson;
  final Value<int> rowid;
  const ItemsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.containerItemId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.assetType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.brand = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.barcode = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchaseStore = const Value.absent(),
    this.estimatedValue = const Value.absent(),
    this.warrantyExpiresAt = const Value.absent(),
    this.condition = const Value.absent(),
    this.usageMode = const Value.absent(),
    this.utilityStatus = const Value.absent(),
    this.utilityRating = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    this.locationId = const Value.absent(),
    this.containerItemId = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.assetType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.brand = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.barcode = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchaseStore = const Value.absent(),
    this.estimatedValue = const Value.absent(),
    this.warrantyExpiresAt = const Value.absent(),
    this.condition = const Value.absent(),
    this.usageMode = const Value.absent(),
    this.utilityStatus = const Value.absent(),
    this.utilityRating = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.customFieldsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       name = Value(name);
  static Insertable<Item> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? locationId,
    Expression<String>? containerItemId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? assetType,
    Expression<int>? quantity,
    Expression<String>? brand,
    Expression<String>? modelNumber,
    Expression<String>? serialNumber,
    Expression<String>? barcode,
    Expression<String>? qrCode,
    Expression<double>? purchasePrice,
    Expression<DateTime>? purchaseDate,
    Expression<String>? purchaseStore,
    Expression<double>? estimatedValue,
    Expression<DateTime>? warrantyExpiresAt,
    Expression<String>? condition,
    Expression<String>? usageMode,
    Expression<String>? utilityStatus,
    Expression<int>? utilityRating,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsedAt,
    Expression<String>? notes,
    Expression<String>? customFieldsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (locationId != null) 'location_id': locationId,
      if (containerItemId != null) 'container_item_id': containerItemId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (assetType != null) 'asset_type': assetType,
      if (quantity != null) 'quantity': quantity,
      if (brand != null) 'brand': brand,
      if (modelNumber != null) 'model_number': modelNumber,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (barcode != null) 'barcode': barcode,
      if (qrCode != null) 'qr_code': qrCode,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchaseStore != null) 'purchase_store': purchaseStore,
      if (estimatedValue != null) 'estimated_value': estimatedValue,
      if (warrantyExpiresAt != null) 'warranty_expires_at': warrantyExpiresAt,
      if (condition != null) 'condition': condition,
      if (usageMode != null) 'usage_mode': usageMode,
      if (utilityStatus != null) 'utility_status': utilityStatus,
      if (utilityRating != null) 'utility_rating': utilityRating,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (notes != null) 'notes': notes,
      if (customFieldsJson != null) 'custom_fields_json': customFieldsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String?>? locationId,
    Value<String?>? containerItemId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? assetType,
    Value<int>? quantity,
    Value<String?>? brand,
    Value<String?>? modelNumber,
    Value<String?>? serialNumber,
    Value<String?>? barcode,
    Value<String?>? qrCode,
    Value<double?>? purchasePrice,
    Value<DateTime?>? purchaseDate,
    Value<String?>? purchaseStore,
    Value<double?>? estimatedValue,
    Value<DateTime?>? warrantyExpiresAt,
    Value<String>? condition,
    Value<String>? usageMode,
    Value<String>? utilityStatus,
    Value<int?>? utilityRating,
    Value<int>? usageCount,
    Value<DateTime?>? lastUsedAt,
    Value<String?>? notes,
    Value<String>? customFieldsJson,
    Value<int>? rowid,
  }) {
    return ItemsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      locationId: locationId ?? this.locationId,
      containerItemId: containerItemId ?? this.containerItemId,
      name: name ?? this.name,
      category: category ?? this.category,
      assetType: assetType ?? this.assetType,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
      modelNumber: modelNumber ?? this.modelNumber,
      serialNumber: serialNumber ?? this.serialNumber,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchaseStore: purchaseStore ?? this.purchaseStore,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      warrantyExpiresAt: warrantyExpiresAt ?? this.warrantyExpiresAt,
      condition: condition ?? this.condition,
      usageMode: usageMode ?? this.usageMode,
      utilityStatus: utilityStatus ?? this.utilityStatus,
      utilityRating: utilityRating ?? this.utilityRating,
      usageCount: usageCount ?? this.usageCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      notes: notes ?? this.notes,
      customFieldsJson: customFieldsJson ?? this.customFieldsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (containerItemId.present) {
      map['container_item_id'] = Variable<String>(containerItemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (assetType.present) {
      map['asset_type'] = Variable<String>(assetType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (modelNumber.present) {
      map['model_number'] = Variable<String>(modelNumber.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (qrCode.present) {
      map['qr_code'] = Variable<String>(qrCode.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchaseStore.present) {
      map['purchase_store'] = Variable<String>(purchaseStore.value);
    }
    if (estimatedValue.present) {
      map['estimated_value'] = Variable<double>(estimatedValue.value);
    }
    if (warrantyExpiresAt.present) {
      map['warranty_expires_at'] = Variable<DateTime>(warrantyExpiresAt.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (usageMode.present) {
      map['usage_mode'] = Variable<String>(usageMode.value);
    }
    if (utilityStatus.present) {
      map['utility_status'] = Variable<String>(utilityStatus.value);
    }
    if (utilityRating.present) {
      map['utility_rating'] = Variable<int>(utilityRating.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (customFieldsJson.present) {
      map['custom_fields_json'] = Variable<String>(customFieldsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('locationId: $locationId, ')
          ..write('containerItemId: $containerItemId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('assetType: $assetType, ')
          ..write('quantity: $quantity, ')
          ..write('brand: $brand, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('barcode: $barcode, ')
          ..write('qrCode: $qrCode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchaseStore: $purchaseStore, ')
          ..write('estimatedValue: $estimatedValue, ')
          ..write('warrantyExpiresAt: $warrantyExpiresAt, ')
          ..write('condition: $condition, ')
          ..write('usageMode: $usageMode, ')
          ..write('utilityStatus: $utilityStatus, ')
          ..write('utilityRating: $utilityRating, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('notes: $notes, ')
          ..write('customFieldsJson: $customFieldsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemAttachmentsTable extends ItemAttachments
    with TableInfo<$ItemAttachmentsTable, ItemAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('photo'),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remotePathMeta = const VerificationMeta(
    'remotePath',
  );
  @override
  late final GeneratedColumn<String> remotePath = GeneratedColumn<String>(
    'remote_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('image/jpeg'),
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageOrderMeta = const VerificationMeta(
    'pageOrder',
  );
  @override
  late final GeneratedColumn<int> pageOrder = GeneratedColumn<int>(
    'page_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSensitiveMeta = const VerificationMeta(
    'isSensitive',
  );
  @override
  late final GeneratedColumn<bool> isSensitive = GeneratedColumn<bool>(
    'is_sensitive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sensitive" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _uploadStatusMeta = const VerificationMeta(
    'uploadStatus',
  );
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    kind,
    localPath,
    remotePath,
    mimeType,
    fileSizeBytes,
    pageOrder,
    isSensitive,
    uploadStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemAttachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('remote_path')) {
      context.handle(
        _remotePathMeta,
        remotePath.isAcceptableOrUnknown(data['remote_path']!, _remotePathMeta),
      );
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('page_order')) {
      context.handle(
        _pageOrderMeta,
        pageOrder.isAcceptableOrUnknown(data['page_order']!, _pageOrderMeta),
      );
    }
    if (data.containsKey('is_sensitive')) {
      context.handle(
        _isSensitiveMeta,
        isSensitive.isAcceptableOrUnknown(
          data['is_sensitive']!,
          _isSensitiveMeta,
        ),
      );
    }
    if (data.containsKey('upload_status')) {
      context.handle(
        _uploadStatusMeta,
        uploadStatus.isAcceptableOrUnknown(
          data['upload_status']!,
          _uploadStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemAttachment(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      remotePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_path'],
      ),
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      ),
      pageOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_order'],
      )!,
      isSensitive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sensitive'],
      )!,
      uploadStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_status'],
      )!,
    );
  }

  @override
  $ItemAttachmentsTable createAlias(String alias) {
    return $ItemAttachmentsTable(attachedDatabase, alias);
  }
}

class ItemAttachment extends DataClass implements Insertable<ItemAttachment> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String itemId;
  final String kind;
  final String? localPath;
  final String? remotePath;
  final String mimeType;
  final int? fileSizeBytes;
  final int pageOrder;
  final bool isSensitive;
  final String uploadStatus;
  const ItemAttachment({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.itemId,
    required this.kind,
    this.localPath,
    this.remotePath,
    required this.mimeType,
    this.fileSizeBytes,
    required this.pageOrder,
    required this.isSensitive,
    required this.uploadStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['item_id'] = Variable<String>(itemId);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || remotePath != null) {
      map['remote_path'] = Variable<String>(remotePath);
    }
    map['mime_type'] = Variable<String>(mimeType);
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    map['page_order'] = Variable<int>(pageOrder);
    map['is_sensitive'] = Variable<bool>(isSensitive);
    map['upload_status'] = Variable<String>(uploadStatus);
    return map;
  }

  ItemAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return ItemAttachmentsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      itemId: Value(itemId),
      kind: Value(kind),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      remotePath: remotePath == null && nullToAbsent
          ? const Value.absent()
          : Value(remotePath),
      mimeType: Value(mimeType),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      pageOrder: Value(pageOrder),
      isSensitive: Value(isSensitive),
      uploadStatus: Value(uploadStatus),
    );
  }

  factory ItemAttachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemAttachment(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      kind: serializer.fromJson<String>(json['kind']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      remotePath: serializer.fromJson<String?>(json['remotePath']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      pageOrder: serializer.fromJson<int>(json['pageOrder']),
      isSensitive: serializer.fromJson<bool>(json['isSensitive']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'itemId': serializer.toJson<String>(itemId),
      'kind': serializer.toJson<String>(kind),
      'localPath': serializer.toJson<String?>(localPath),
      'remotePath': serializer.toJson<String?>(remotePath),
      'mimeType': serializer.toJson<String>(mimeType),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'pageOrder': serializer.toJson<int>(pageOrder),
      'isSensitive': serializer.toJson<bool>(isSensitive),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
    };
  }

  ItemAttachment copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? itemId,
    String? kind,
    Value<String?> localPath = const Value.absent(),
    Value<String?> remotePath = const Value.absent(),
    String? mimeType,
    Value<int?> fileSizeBytes = const Value.absent(),
    int? pageOrder,
    bool? isSensitive,
    String? uploadStatus,
  }) => ItemAttachment(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    itemId: itemId ?? this.itemId,
    kind: kind ?? this.kind,
    localPath: localPath.present ? localPath.value : this.localPath,
    remotePath: remotePath.present ? remotePath.value : this.remotePath,
    mimeType: mimeType ?? this.mimeType,
    fileSizeBytes: fileSizeBytes.present
        ? fileSizeBytes.value
        : this.fileSizeBytes,
    pageOrder: pageOrder ?? this.pageOrder,
    isSensitive: isSensitive ?? this.isSensitive,
    uploadStatus: uploadStatus ?? this.uploadStatus,
  );
  ItemAttachment copyWithCompanion(ItemAttachmentsCompanion data) {
    return ItemAttachment(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      kind: data.kind.present ? data.kind.value : this.kind,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remotePath: data.remotePath.present
          ? data.remotePath.value
          : this.remotePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      pageOrder: data.pageOrder.present ? data.pageOrder.value : this.pageOrder,
      isSensitive: data.isSensitive.present
          ? data.isSensitive.value
          : this.isSensitive,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemAttachment(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('localPath: $localPath, ')
          ..write('remotePath: $remotePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('pageOrder: $pageOrder, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('uploadStatus: $uploadStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    kind,
    localPath,
    remotePath,
    mimeType,
    fileSizeBytes,
    pageOrder,
    isSensitive,
    uploadStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemAttachment &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.itemId == this.itemId &&
          other.kind == this.kind &&
          other.localPath == this.localPath &&
          other.remotePath == this.remotePath &&
          other.mimeType == this.mimeType &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.pageOrder == this.pageOrder &&
          other.isSensitive == this.isSensitive &&
          other.uploadStatus == this.uploadStatus);
}

class ItemAttachmentsCompanion extends UpdateCompanion<ItemAttachment> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> itemId;
  final Value<String> kind;
  final Value<String?> localPath;
  final Value<String?> remotePath;
  final Value<String> mimeType;
  final Value<int?> fileSizeBytes;
  final Value<int> pageOrder;
  final Value<bool> isSensitive;
  final Value<String> uploadStatus;
  final Value<int> rowid;
  const ItemAttachmentsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.kind = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remotePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.pageOrder = const Value.absent(),
    this.isSensitive = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemAttachmentsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String itemId,
    this.kind = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remotePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.pageOrder = const Value.absent(),
    this.isSensitive = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       itemId = Value(itemId);
  static Insertable<ItemAttachment> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? itemId,
    Expression<String>? kind,
    Expression<String>? localPath,
    Expression<String>? remotePath,
    Expression<String>? mimeType,
    Expression<int>? fileSizeBytes,
    Expression<int>? pageOrder,
    Expression<bool>? isSensitive,
    Expression<String>? uploadStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (itemId != null) 'item_id': itemId,
      if (kind != null) 'kind': kind,
      if (localPath != null) 'local_path': localPath,
      if (remotePath != null) 'remote_path': remotePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (pageOrder != null) 'page_order': pageOrder,
      if (isSensitive != null) 'is_sensitive': isSensitive,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemAttachmentsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? itemId,
    Value<String>? kind,
    Value<String?>? localPath,
    Value<String?>? remotePath,
    Value<String>? mimeType,
    Value<int?>? fileSizeBytes,
    Value<int>? pageOrder,
    Value<bool>? isSensitive,
    Value<String>? uploadStatus,
    Value<int>? rowid,
  }) {
    return ItemAttachmentsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      itemId: itemId ?? this.itemId,
      kind: kind ?? this.kind,
      localPath: localPath ?? this.localPath,
      remotePath: remotePath ?? this.remotePath,
      mimeType: mimeType ?? this.mimeType,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      pageOrder: pageOrder ?? this.pageOrder,
      isSensitive: isSensitive ?? this.isSensitive,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remotePath.present) {
      map['remote_path'] = Variable<String>(remotePath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (pageOrder.present) {
      map['page_order'] = Variable<int>(pageOrder.value);
    }
    if (isSensitive.present) {
      map['is_sensitive'] = Variable<bool>(isSensitive.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemAttachmentsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('localPath: $localPath, ')
          ..write('remotePath: $remotePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('pageOrder: $pageOrder, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetLoansTable extends AssetLoans
    with TableInfo<$AssetLoansTable, AssetLoan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetLoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _borrowerNameMeta = const VerificationMeta(
    'borrowerName',
  );
  @override
  late final GeneratedColumn<String> borrowerName = GeneratedColumn<String>(
    'borrower_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _borrowerContactMeta = const VerificationMeta(
    'borrowerContact',
  );
  @override
  late final GeneratedColumn<String> borrowerContact = GeneratedColumn<String>(
    'borrower_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _borrowedAtMeta = const VerificationMeta(
    'borrowedAt',
  );
  @override
  late final GeneratedColumn<DateTime> borrowedAt = GeneratedColumn<DateTime>(
    'borrowed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dueReturnAtMeta = const VerificationMeta(
    'dueReturnAt',
  );
  @override
  late final GeneratedColumn<DateTime> dueReturnAt = GeneratedColumn<DateTime>(
    'due_return_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    borrowerName,
    borrowerContact,
    borrowedAt,
    dueReturnAt,
    returnedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asset_loans';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssetLoan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('borrower_name')) {
      context.handle(
        _borrowerNameMeta,
        borrowerName.isAcceptableOrUnknown(
          data['borrower_name']!,
          _borrowerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_borrowerNameMeta);
    }
    if (data.containsKey('borrower_contact')) {
      context.handle(
        _borrowerContactMeta,
        borrowerContact.isAcceptableOrUnknown(
          data['borrower_contact']!,
          _borrowerContactMeta,
        ),
      );
    }
    if (data.containsKey('borrowed_at')) {
      context.handle(
        _borrowedAtMeta,
        borrowedAt.isAcceptableOrUnknown(data['borrowed_at']!, _borrowedAtMeta),
      );
    }
    if (data.containsKey('due_return_at')) {
      context.handle(
        _dueReturnAtMeta,
        dueReturnAt.isAcceptableOrUnknown(
          data['due_return_at']!,
          _dueReturnAtMeta,
        ),
      );
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetLoan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetLoan(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      borrowerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}borrower_name'],
      )!,
      borrowerContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}borrower_contact'],
      ),
      borrowedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}borrowed_at'],
      )!,
      dueReturnAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_return_at'],
      ),
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $AssetLoansTable createAlias(String alias) {
    return $AssetLoansTable(attachedDatabase, alias);
  }
}

class AssetLoan extends DataClass implements Insertable<AssetLoan> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String itemId;
  final String borrowerName;
  final String? borrowerContact;
  final DateTime borrowedAt;
  final DateTime? dueReturnAt;
  final DateTime? returnedAt;
  final String? notes;
  const AssetLoan({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.itemId,
    required this.borrowerName,
    this.borrowerContact,
    required this.borrowedAt,
    this.dueReturnAt,
    this.returnedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['item_id'] = Variable<String>(itemId);
    map['borrower_name'] = Variable<String>(borrowerName);
    if (!nullToAbsent || borrowerContact != null) {
      map['borrower_contact'] = Variable<String>(borrowerContact);
    }
    map['borrowed_at'] = Variable<DateTime>(borrowedAt);
    if (!nullToAbsent || dueReturnAt != null) {
      map['due_return_at'] = Variable<DateTime>(dueReturnAt);
    }
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  AssetLoansCompanion toCompanion(bool nullToAbsent) {
    return AssetLoansCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      itemId: Value(itemId),
      borrowerName: Value(borrowerName),
      borrowerContact: borrowerContact == null && nullToAbsent
          ? const Value.absent()
          : Value(borrowerContact),
      borrowedAt: Value(borrowedAt),
      dueReturnAt: dueReturnAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueReturnAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory AssetLoan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetLoan(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      borrowerName: serializer.fromJson<String>(json['borrowerName']),
      borrowerContact: serializer.fromJson<String?>(json['borrowerContact']),
      borrowedAt: serializer.fromJson<DateTime>(json['borrowedAt']),
      dueReturnAt: serializer.fromJson<DateTime?>(json['dueReturnAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'itemId': serializer.toJson<String>(itemId),
      'borrowerName': serializer.toJson<String>(borrowerName),
      'borrowerContact': serializer.toJson<String?>(borrowerContact),
      'borrowedAt': serializer.toJson<DateTime>(borrowedAt),
      'dueReturnAt': serializer.toJson<DateTime?>(dueReturnAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  AssetLoan copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? itemId,
    String? borrowerName,
    Value<String?> borrowerContact = const Value.absent(),
    DateTime? borrowedAt,
    Value<DateTime?> dueReturnAt = const Value.absent(),
    Value<DateTime?> returnedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => AssetLoan(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    itemId: itemId ?? this.itemId,
    borrowerName: borrowerName ?? this.borrowerName,
    borrowerContact: borrowerContact.present
        ? borrowerContact.value
        : this.borrowerContact,
    borrowedAt: borrowedAt ?? this.borrowedAt,
    dueReturnAt: dueReturnAt.present ? dueReturnAt.value : this.dueReturnAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  AssetLoan copyWithCompanion(AssetLoansCompanion data) {
    return AssetLoan(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      borrowerName: data.borrowerName.present
          ? data.borrowerName.value
          : this.borrowerName,
      borrowerContact: data.borrowerContact.present
          ? data.borrowerContact.value
          : this.borrowerContact,
      borrowedAt: data.borrowedAt.present
          ? data.borrowedAt.value
          : this.borrowedAt,
      dueReturnAt: data.dueReturnAt.present
          ? data.dueReturnAt.value
          : this.dueReturnAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetLoan(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('borrowerName: $borrowerName, ')
          ..write('borrowerContact: $borrowerContact, ')
          ..write('borrowedAt: $borrowedAt, ')
          ..write('dueReturnAt: $dueReturnAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    borrowerName,
    borrowerContact,
    borrowedAt,
    dueReturnAt,
    returnedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetLoan &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.itemId == this.itemId &&
          other.borrowerName == this.borrowerName &&
          other.borrowerContact == this.borrowerContact &&
          other.borrowedAt == this.borrowedAt &&
          other.dueReturnAt == this.dueReturnAt &&
          other.returnedAt == this.returnedAt &&
          other.notes == this.notes);
}

class AssetLoansCompanion extends UpdateCompanion<AssetLoan> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> itemId;
  final Value<String> borrowerName;
  final Value<String?> borrowerContact;
  final Value<DateTime> borrowedAt;
  final Value<DateTime?> dueReturnAt;
  final Value<DateTime?> returnedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const AssetLoansCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.borrowerName = const Value.absent(),
    this.borrowerContact = const Value.absent(),
    this.borrowedAt = const Value.absent(),
    this.dueReturnAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetLoansCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String itemId,
    required String borrowerName,
    this.borrowerContact = const Value.absent(),
    this.borrowedAt = const Value.absent(),
    this.dueReturnAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       itemId = Value(itemId),
       borrowerName = Value(borrowerName);
  static Insertable<AssetLoan> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? itemId,
    Expression<String>? borrowerName,
    Expression<String>? borrowerContact,
    Expression<DateTime>? borrowedAt,
    Expression<DateTime>? dueReturnAt,
    Expression<DateTime>? returnedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (itemId != null) 'item_id': itemId,
      if (borrowerName != null) 'borrower_name': borrowerName,
      if (borrowerContact != null) 'borrower_contact': borrowerContact,
      if (borrowedAt != null) 'borrowed_at': borrowedAt,
      if (dueReturnAt != null) 'due_return_at': dueReturnAt,
      if (returnedAt != null) 'returned_at': returnedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetLoansCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? itemId,
    Value<String>? borrowerName,
    Value<String?>? borrowerContact,
    Value<DateTime>? borrowedAt,
    Value<DateTime?>? dueReturnAt,
    Value<DateTime?>? returnedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return AssetLoansCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      itemId: itemId ?? this.itemId,
      borrowerName: borrowerName ?? this.borrowerName,
      borrowerContact: borrowerContact ?? this.borrowerContact,
      borrowedAt: borrowedAt ?? this.borrowedAt,
      dueReturnAt: dueReturnAt ?? this.dueReturnAt,
      returnedAt: returnedAt ?? this.returnedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (borrowerName.present) {
      map['borrower_name'] = Variable<String>(borrowerName.value);
    }
    if (borrowerContact.present) {
      map['borrower_contact'] = Variable<String>(borrowerContact.value);
    }
    if (borrowedAt.present) {
      map['borrowed_at'] = Variable<DateTime>(borrowedAt.value);
    }
    if (dueReturnAt.present) {
      map['due_return_at'] = Variable<DateTime>(dueReturnAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetLoansCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('borrowerName: $borrowerName, ')
          ..write('borrowerContact: $borrowerContact, ')
          ..write('borrowedAt: $borrowedAt, ')
          ..write('dueReturnAt: $dueReturnAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsageLogsTable extends UsageLogs
    with TableInfo<$UsageLogsTable, UsageLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  @override
  late final GeneratedColumn<DateTime> usedAt = GeneratedColumn<DateTime>(
    'used_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    usedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsageLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('used_at')) {
      context.handle(
        _usedAtMeta,
        usedAt.isAcceptableOrUnknown(data['used_at']!, _usedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageLog(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      usedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}used_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $UsageLogsTable createAlias(String alias) {
    return $UsageLogsTable(attachedDatabase, alias);
  }
}

class UsageLog extends DataClass implements Insertable<UsageLog> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String itemId;
  final DateTime usedAt;
  final String? notes;
  const UsageLog({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.itemId,
    required this.usedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['item_id'] = Variable<String>(itemId);
    map['used_at'] = Variable<DateTime>(usedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  UsageLogsCompanion toCompanion(bool nullToAbsent) {
    return UsageLogsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      itemId: Value(itemId),
      usedAt: Value(usedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory UsageLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageLog(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      usedAt: serializer.fromJson<DateTime>(json['usedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'itemId': serializer.toJson<String>(itemId),
      'usedAt': serializer.toJson<DateTime>(usedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  UsageLog copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? itemId,
    DateTime? usedAt,
    Value<String?> notes = const Value.absent(),
  }) => UsageLog(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    itemId: itemId ?? this.itemId,
    usedAt: usedAt ?? this.usedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  UsageLog copyWithCompanion(UsageLogsCompanion data) {
    return UsageLog(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      usedAt: data.usedAt.present ? data.usedAt.value : this.usedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageLog(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('usedAt: $usedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    usedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageLog &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.itemId == this.itemId &&
          other.usedAt == this.usedAt &&
          other.notes == this.notes);
}

class UsageLogsCompanion extends UpdateCompanion<UsageLog> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> itemId;
  final Value<DateTime> usedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const UsageLogsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.usedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsageLogsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String itemId,
    this.usedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       itemId = Value(itemId);
  static Insertable<UsageLog> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? itemId,
    Expression<DateTime>? usedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (itemId != null) 'item_id': itemId,
      if (usedAt != null) 'used_at': usedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsageLogsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? itemId,
    Value<DateTime>? usedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return UsageLogsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      itemId: itemId ?? this.itemId,
      usedAt: usedAt ?? this.usedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (usedAt.present) {
      map['used_at'] = Variable<DateTime>(usedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageLogsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('usedAt: $usedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _isbn10Meta = const VerificationMeta('isbn10');
  @override
  late final GeneratedColumn<String> isbn10 = GeneratedColumn<String>(
    'isbn10',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isbn13Meta = const VerificationMeta('isbn13');
  @override
  late final GeneratedColumn<String> isbn13 = GeneratedColumn<String>(
    'isbn13',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorsJsonMeta = const VerificationMeta(
    'authorsJson',
  );
  @override
  late final GeneratedColumn<String> authorsJson = GeneratedColumn<String>(
    'authors_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedYearMeta = const VerificationMeta(
    'publishedYear',
  );
  @override
  late final GeneratedColumn<int> publishedYear = GeneratedColumn<int>(
    'published_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('id'),
  );
  static const VerificationMeta _genreTagsJsonMeta = const VerificationMeta(
    'genreTagsJson',
  );
  @override
  late final GeneratedColumn<String> genreTagsJson = GeneratedColumn<String>(
    'genre_tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _seriesNameMeta = const VerificationMeta(
    'seriesName',
  );
  @override
  late final GeneratedColumn<String> seriesName = GeneratedColumn<String>(
    'series_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seriesNumberMeta = const VerificationMeta(
    'seriesNumber',
  );
  @override
  late final GeneratedColumn<double> seriesNumber = GeneratedColumn<double>(
    'series_number',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _editionMeta = const VerificationMeta(
    'edition',
  );
  @override
  late final GeneratedColumn<String> edition = GeneratedColumn<String>(
    'edition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookFormatMeta = const VerificationMeta(
    'bookFormat',
  );
  @override
  late final GeneratedColumn<String> bookFormat = GeneratedColumn<String>(
    'book_format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('paperback'),
  );
  static const VerificationMeta _readingStatusMeta = const VerificationMeta(
    'readingStatus',
  );
  @override
  late final GeneratedColumn<String> readingStatus = GeneratedColumn<String>(
    'reading_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unread'),
  );
  static const VerificationMeta _currentPageMeta = const VerificationMeta(
    'currentPage',
  );
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
    'current_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _personalRatingMeta = const VerificationMeta(
    'personalRating',
  );
  @override
  late final GeneratedColumn<int> personalRating = GeneratedColumn<int>(
    'personal_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedReadingAtMeta = const VerificationMeta(
    'startedReadingAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedReadingAt =
      GeneratedColumn<DateTime>(
        'started_reading_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _finishedReadingAtMeta = const VerificationMeta(
    'finishedReadingAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedReadingAt =
      GeneratedColumn<DateTime>(
        'finished_reading_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _synopsisMeta = const VerificationMeta(
    'synopsis',
  );
  @override
  late final GeneratedColumn<String> synopsis = GeneratedColumn<String>(
    'synopsis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewNotesMeta = const VerificationMeta(
    'reviewNotes',
  );
  @override
  late final GeneratedColumn<String> reviewNotes = GeneratedColumn<String>(
    'review_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataSourceMeta = const VerificationMeta(
    'metadataSource',
  );
  @override
  late final GeneratedColumn<String> metadataSource = GeneratedColumn<String>(
    'metadata_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    isbn10,
    isbn13,
    subtitle,
    authorsJson,
    publisher,
    publishedYear,
    pageCount,
    language,
    genreTagsJson,
    seriesName,
    seriesNumber,
    edition,
    bookFormat,
    readingStatus,
    currentPage,
    personalRating,
    startedReadingAt,
    finishedReadingAt,
    synopsis,
    reviewNotes,
    metadataSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('isbn10')) {
      context.handle(
        _isbn10Meta,
        isbn10.isAcceptableOrUnknown(data['isbn10']!, _isbn10Meta),
      );
    }
    if (data.containsKey('isbn13')) {
      context.handle(
        _isbn13Meta,
        isbn13.isAcceptableOrUnknown(data['isbn13']!, _isbn13Meta),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('authors_json')) {
      context.handle(
        _authorsJsonMeta,
        authorsJson.isAcceptableOrUnknown(
          data['authors_json']!,
          _authorsJsonMeta,
        ),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('published_year')) {
      context.handle(
        _publishedYearMeta,
        publishedYear.isAcceptableOrUnknown(
          data['published_year']!,
          _publishedYearMeta,
        ),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('genre_tags_json')) {
      context.handle(
        _genreTagsJsonMeta,
        genreTagsJson.isAcceptableOrUnknown(
          data['genre_tags_json']!,
          _genreTagsJsonMeta,
        ),
      );
    }
    if (data.containsKey('series_name')) {
      context.handle(
        _seriesNameMeta,
        seriesName.isAcceptableOrUnknown(data['series_name']!, _seriesNameMeta),
      );
    }
    if (data.containsKey('series_number')) {
      context.handle(
        _seriesNumberMeta,
        seriesNumber.isAcceptableOrUnknown(
          data['series_number']!,
          _seriesNumberMeta,
        ),
      );
    }
    if (data.containsKey('edition')) {
      context.handle(
        _editionMeta,
        edition.isAcceptableOrUnknown(data['edition']!, _editionMeta),
      );
    }
    if (data.containsKey('book_format')) {
      context.handle(
        _bookFormatMeta,
        bookFormat.isAcceptableOrUnknown(data['book_format']!, _bookFormatMeta),
      );
    }
    if (data.containsKey('reading_status')) {
      context.handle(
        _readingStatusMeta,
        readingStatus.isAcceptableOrUnknown(
          data['reading_status']!,
          _readingStatusMeta,
        ),
      );
    }
    if (data.containsKey('current_page')) {
      context.handle(
        _currentPageMeta,
        currentPage.isAcceptableOrUnknown(
          data['current_page']!,
          _currentPageMeta,
        ),
      );
    }
    if (data.containsKey('personal_rating')) {
      context.handle(
        _personalRatingMeta,
        personalRating.isAcceptableOrUnknown(
          data['personal_rating']!,
          _personalRatingMeta,
        ),
      );
    }
    if (data.containsKey('started_reading_at')) {
      context.handle(
        _startedReadingAtMeta,
        startedReadingAt.isAcceptableOrUnknown(
          data['started_reading_at']!,
          _startedReadingAtMeta,
        ),
      );
    }
    if (data.containsKey('finished_reading_at')) {
      context.handle(
        _finishedReadingAtMeta,
        finishedReadingAt.isAcceptableOrUnknown(
          data['finished_reading_at']!,
          _finishedReadingAtMeta,
        ),
      );
    }
    if (data.containsKey('synopsis')) {
      context.handle(
        _synopsisMeta,
        synopsis.isAcceptableOrUnknown(data['synopsis']!, _synopsisMeta),
      );
    }
    if (data.containsKey('review_notes')) {
      context.handle(
        _reviewNotesMeta,
        reviewNotes.isAcceptableOrUnknown(
          data['review_notes']!,
          _reviewNotesMeta,
        ),
      );
    }
    if (data.containsKey('metadata_source')) {
      context.handle(
        _metadataSourceMeta,
        metadataSource.isAcceptableOrUnknown(
          data['metadata_source']!,
          _metadataSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      isbn10: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn10'],
      ),
      isbn13: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn13'],
      ),
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      authorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authors_json'],
      )!,
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      publishedYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}published_year'],
      ),
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      genreTagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre_tags_json'],
      )!,
      seriesName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series_name'],
      ),
      seriesNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}series_number'],
      ),
      edition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}edition'],
      ),
      bookFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_format'],
      )!,
      readingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_status'],
      )!,
      currentPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_page'],
      )!,
      personalRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}personal_rating'],
      ),
      startedReadingAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_reading_at'],
      ),
      finishedReadingAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_reading_at'],
      ),
      synopsis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synopsis'],
      ),
      reviewNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_notes'],
      ),
      metadataSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_source'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String itemId;
  final String householdId;
  final String? isbn10;
  final String? isbn13;
  final String? subtitle;
  final String authorsJson;
  final String? publisher;
  final int? publishedYear;
  final int? pageCount;
  final String language;
  final String genreTagsJson;
  final String? seriesName;
  final double? seriesNumber;
  final String? edition;
  final String bookFormat;
  final String readingStatus;
  final int currentPage;
  final int? personalRating;
  final DateTime? startedReadingAt;
  final DateTime? finishedReadingAt;
  final String? synopsis;
  final String? reviewNotes;
  final String metadataSource;
  const Book({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.itemId,
    required this.householdId,
    this.isbn10,
    this.isbn13,
    this.subtitle,
    required this.authorsJson,
    this.publisher,
    this.publishedYear,
    this.pageCount,
    required this.language,
    required this.genreTagsJson,
    this.seriesName,
    this.seriesNumber,
    this.edition,
    required this.bookFormat,
    required this.readingStatus,
    required this.currentPage,
    this.personalRating,
    this.startedReadingAt,
    this.finishedReadingAt,
    this.synopsis,
    this.reviewNotes,
    required this.metadataSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['item_id'] = Variable<String>(itemId);
    map['household_id'] = Variable<String>(householdId);
    if (!nullToAbsent || isbn10 != null) {
      map['isbn10'] = Variable<String>(isbn10);
    }
    if (!nullToAbsent || isbn13 != null) {
      map['isbn13'] = Variable<String>(isbn13);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    map['authors_json'] = Variable<String>(authorsJson);
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || publishedYear != null) {
      map['published_year'] = Variable<int>(publishedYear);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    map['language'] = Variable<String>(language);
    map['genre_tags_json'] = Variable<String>(genreTagsJson);
    if (!nullToAbsent || seriesName != null) {
      map['series_name'] = Variable<String>(seriesName);
    }
    if (!nullToAbsent || seriesNumber != null) {
      map['series_number'] = Variable<double>(seriesNumber);
    }
    if (!nullToAbsent || edition != null) {
      map['edition'] = Variable<String>(edition);
    }
    map['book_format'] = Variable<String>(bookFormat);
    map['reading_status'] = Variable<String>(readingStatus);
    map['current_page'] = Variable<int>(currentPage);
    if (!nullToAbsent || personalRating != null) {
      map['personal_rating'] = Variable<int>(personalRating);
    }
    if (!nullToAbsent || startedReadingAt != null) {
      map['started_reading_at'] = Variable<DateTime>(startedReadingAt);
    }
    if (!nullToAbsent || finishedReadingAt != null) {
      map['finished_reading_at'] = Variable<DateTime>(finishedReadingAt);
    }
    if (!nullToAbsent || synopsis != null) {
      map['synopsis'] = Variable<String>(synopsis);
    }
    if (!nullToAbsent || reviewNotes != null) {
      map['review_notes'] = Variable<String>(reviewNotes);
    }
    map['metadata_source'] = Variable<String>(metadataSource);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      itemId: Value(itemId),
      householdId: Value(householdId),
      isbn10: isbn10 == null && nullToAbsent
          ? const Value.absent()
          : Value(isbn10),
      isbn13: isbn13 == null && nullToAbsent
          ? const Value.absent()
          : Value(isbn13),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      authorsJson: Value(authorsJson),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      publishedYear: publishedYear == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedYear),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      language: Value(language),
      genreTagsJson: Value(genreTagsJson),
      seriesName: seriesName == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesName),
      seriesNumber: seriesNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesNumber),
      edition: edition == null && nullToAbsent
          ? const Value.absent()
          : Value(edition),
      bookFormat: Value(bookFormat),
      readingStatus: Value(readingStatus),
      currentPage: Value(currentPage),
      personalRating: personalRating == null && nullToAbsent
          ? const Value.absent()
          : Value(personalRating),
      startedReadingAt: startedReadingAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedReadingAt),
      finishedReadingAt: finishedReadingAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedReadingAt),
      synopsis: synopsis == null && nullToAbsent
          ? const Value.absent()
          : Value(synopsis),
      reviewNotes: reviewNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewNotes),
      metadataSource: Value(metadataSource),
    );
  }

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      itemId: serializer.fromJson<String>(json['itemId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      isbn10: serializer.fromJson<String?>(json['isbn10']),
      isbn13: serializer.fromJson<String?>(json['isbn13']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      authorsJson: serializer.fromJson<String>(json['authorsJson']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      publishedYear: serializer.fromJson<int?>(json['publishedYear']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      language: serializer.fromJson<String>(json['language']),
      genreTagsJson: serializer.fromJson<String>(json['genreTagsJson']),
      seriesName: serializer.fromJson<String?>(json['seriesName']),
      seriesNumber: serializer.fromJson<double?>(json['seriesNumber']),
      edition: serializer.fromJson<String?>(json['edition']),
      bookFormat: serializer.fromJson<String>(json['bookFormat']),
      readingStatus: serializer.fromJson<String>(json['readingStatus']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
      personalRating: serializer.fromJson<int?>(json['personalRating']),
      startedReadingAt: serializer.fromJson<DateTime?>(
        json['startedReadingAt'],
      ),
      finishedReadingAt: serializer.fromJson<DateTime?>(
        json['finishedReadingAt'],
      ),
      synopsis: serializer.fromJson<String?>(json['synopsis']),
      reviewNotes: serializer.fromJson<String?>(json['reviewNotes']),
      metadataSource: serializer.fromJson<String>(json['metadataSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'itemId': serializer.toJson<String>(itemId),
      'householdId': serializer.toJson<String>(householdId),
      'isbn10': serializer.toJson<String?>(isbn10),
      'isbn13': serializer.toJson<String?>(isbn13),
      'subtitle': serializer.toJson<String?>(subtitle),
      'authorsJson': serializer.toJson<String>(authorsJson),
      'publisher': serializer.toJson<String?>(publisher),
      'publishedYear': serializer.toJson<int?>(publishedYear),
      'pageCount': serializer.toJson<int?>(pageCount),
      'language': serializer.toJson<String>(language),
      'genreTagsJson': serializer.toJson<String>(genreTagsJson),
      'seriesName': serializer.toJson<String?>(seriesName),
      'seriesNumber': serializer.toJson<double?>(seriesNumber),
      'edition': serializer.toJson<String?>(edition),
      'bookFormat': serializer.toJson<String>(bookFormat),
      'readingStatus': serializer.toJson<String>(readingStatus),
      'currentPage': serializer.toJson<int>(currentPage),
      'personalRating': serializer.toJson<int?>(personalRating),
      'startedReadingAt': serializer.toJson<DateTime?>(startedReadingAt),
      'finishedReadingAt': serializer.toJson<DateTime?>(finishedReadingAt),
      'synopsis': serializer.toJson<String?>(synopsis),
      'reviewNotes': serializer.toJson<String?>(reviewNotes),
      'metadataSource': serializer.toJson<String>(metadataSource),
    };
  }

  Book copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? itemId,
    String? householdId,
    Value<String?> isbn10 = const Value.absent(),
    Value<String?> isbn13 = const Value.absent(),
    Value<String?> subtitle = const Value.absent(),
    String? authorsJson,
    Value<String?> publisher = const Value.absent(),
    Value<int?> publishedYear = const Value.absent(),
    Value<int?> pageCount = const Value.absent(),
    String? language,
    String? genreTagsJson,
    Value<String?> seriesName = const Value.absent(),
    Value<double?> seriesNumber = const Value.absent(),
    Value<String?> edition = const Value.absent(),
    String? bookFormat,
    String? readingStatus,
    int? currentPage,
    Value<int?> personalRating = const Value.absent(),
    Value<DateTime?> startedReadingAt = const Value.absent(),
    Value<DateTime?> finishedReadingAt = const Value.absent(),
    Value<String?> synopsis = const Value.absent(),
    Value<String?> reviewNotes = const Value.absent(),
    String? metadataSource,
  }) => Book(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    itemId: itemId ?? this.itemId,
    householdId: householdId ?? this.householdId,
    isbn10: isbn10.present ? isbn10.value : this.isbn10,
    isbn13: isbn13.present ? isbn13.value : this.isbn13,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    authorsJson: authorsJson ?? this.authorsJson,
    publisher: publisher.present ? publisher.value : this.publisher,
    publishedYear: publishedYear.present
        ? publishedYear.value
        : this.publishedYear,
    pageCount: pageCount.present ? pageCount.value : this.pageCount,
    language: language ?? this.language,
    genreTagsJson: genreTagsJson ?? this.genreTagsJson,
    seriesName: seriesName.present ? seriesName.value : this.seriesName,
    seriesNumber: seriesNumber.present ? seriesNumber.value : this.seriesNumber,
    edition: edition.present ? edition.value : this.edition,
    bookFormat: bookFormat ?? this.bookFormat,
    readingStatus: readingStatus ?? this.readingStatus,
    currentPage: currentPage ?? this.currentPage,
    personalRating: personalRating.present
        ? personalRating.value
        : this.personalRating,
    startedReadingAt: startedReadingAt.present
        ? startedReadingAt.value
        : this.startedReadingAt,
    finishedReadingAt: finishedReadingAt.present
        ? finishedReadingAt.value
        : this.finishedReadingAt,
    synopsis: synopsis.present ? synopsis.value : this.synopsis,
    reviewNotes: reviewNotes.present ? reviewNotes.value : this.reviewNotes,
    metadataSource: metadataSource ?? this.metadataSource,
  );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      isbn10: data.isbn10.present ? data.isbn10.value : this.isbn10,
      isbn13: data.isbn13.present ? data.isbn13.value : this.isbn13,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      authorsJson: data.authorsJson.present
          ? data.authorsJson.value
          : this.authorsJson,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      publishedYear: data.publishedYear.present
          ? data.publishedYear.value
          : this.publishedYear,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      language: data.language.present ? data.language.value : this.language,
      genreTagsJson: data.genreTagsJson.present
          ? data.genreTagsJson.value
          : this.genreTagsJson,
      seriesName: data.seriesName.present
          ? data.seriesName.value
          : this.seriesName,
      seriesNumber: data.seriesNumber.present
          ? data.seriesNumber.value
          : this.seriesNumber,
      edition: data.edition.present ? data.edition.value : this.edition,
      bookFormat: data.bookFormat.present
          ? data.bookFormat.value
          : this.bookFormat,
      readingStatus: data.readingStatus.present
          ? data.readingStatus.value
          : this.readingStatus,
      currentPage: data.currentPage.present
          ? data.currentPage.value
          : this.currentPage,
      personalRating: data.personalRating.present
          ? data.personalRating.value
          : this.personalRating,
      startedReadingAt: data.startedReadingAt.present
          ? data.startedReadingAt.value
          : this.startedReadingAt,
      finishedReadingAt: data.finishedReadingAt.present
          ? data.finishedReadingAt.value
          : this.finishedReadingAt,
      synopsis: data.synopsis.present ? data.synopsis.value : this.synopsis,
      reviewNotes: data.reviewNotes.present
          ? data.reviewNotes.value
          : this.reviewNotes,
      metadataSource: data.metadataSource.present
          ? data.metadataSource.value
          : this.metadataSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('isbn10: $isbn10, ')
          ..write('isbn13: $isbn13, ')
          ..write('subtitle: $subtitle, ')
          ..write('authorsJson: $authorsJson, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('pageCount: $pageCount, ')
          ..write('language: $language, ')
          ..write('genreTagsJson: $genreTagsJson, ')
          ..write('seriesName: $seriesName, ')
          ..write('seriesNumber: $seriesNumber, ')
          ..write('edition: $edition, ')
          ..write('bookFormat: $bookFormat, ')
          ..write('readingStatus: $readingStatus, ')
          ..write('currentPage: $currentPage, ')
          ..write('personalRating: $personalRating, ')
          ..write('startedReadingAt: $startedReadingAt, ')
          ..write('finishedReadingAt: $finishedReadingAt, ')
          ..write('synopsis: $synopsis, ')
          ..write('reviewNotes: $reviewNotes, ')
          ..write('metadataSource: $metadataSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    isbn10,
    isbn13,
    subtitle,
    authorsJson,
    publisher,
    publishedYear,
    pageCount,
    language,
    genreTagsJson,
    seriesName,
    seriesNumber,
    edition,
    bookFormat,
    readingStatus,
    currentPage,
    personalRating,
    startedReadingAt,
    finishedReadingAt,
    synopsis,
    reviewNotes,
    metadataSource,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.itemId == this.itemId &&
          other.householdId == this.householdId &&
          other.isbn10 == this.isbn10 &&
          other.isbn13 == this.isbn13 &&
          other.subtitle == this.subtitle &&
          other.authorsJson == this.authorsJson &&
          other.publisher == this.publisher &&
          other.publishedYear == this.publishedYear &&
          other.pageCount == this.pageCount &&
          other.language == this.language &&
          other.genreTagsJson == this.genreTagsJson &&
          other.seriesName == this.seriesName &&
          other.seriesNumber == this.seriesNumber &&
          other.edition == this.edition &&
          other.bookFormat == this.bookFormat &&
          other.readingStatus == this.readingStatus &&
          other.currentPage == this.currentPage &&
          other.personalRating == this.personalRating &&
          other.startedReadingAt == this.startedReadingAt &&
          other.finishedReadingAt == this.finishedReadingAt &&
          other.synopsis == this.synopsis &&
          other.reviewNotes == this.reviewNotes &&
          other.metadataSource == this.metadataSource);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> itemId;
  final Value<String> householdId;
  final Value<String?> isbn10;
  final Value<String?> isbn13;
  final Value<String?> subtitle;
  final Value<String> authorsJson;
  final Value<String?> publisher;
  final Value<int?> publishedYear;
  final Value<int?> pageCount;
  final Value<String> language;
  final Value<String> genreTagsJson;
  final Value<String?> seriesName;
  final Value<double?> seriesNumber;
  final Value<String?> edition;
  final Value<String> bookFormat;
  final Value<String> readingStatus;
  final Value<int> currentPage;
  final Value<int?> personalRating;
  final Value<DateTime?> startedReadingAt;
  final Value<DateTime?> finishedReadingAt;
  final Value<String?> synopsis;
  final Value<String?> reviewNotes;
  final Value<String> metadataSource;
  final Value<int> rowid;
  const BooksCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.itemId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.isbn10 = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.authorsJson = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.language = const Value.absent(),
    this.genreTagsJson = const Value.absent(),
    this.seriesName = const Value.absent(),
    this.seriesNumber = const Value.absent(),
    this.edition = const Value.absent(),
    this.bookFormat = const Value.absent(),
    this.readingStatus = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.personalRating = const Value.absent(),
    this.startedReadingAt = const Value.absent(),
    this.finishedReadingAt = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.reviewNotes = const Value.absent(),
    this.metadataSource = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String itemId,
    required String householdId,
    this.isbn10 = const Value.absent(),
    this.isbn13 = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.authorsJson = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.language = const Value.absent(),
    this.genreTagsJson = const Value.absent(),
    this.seriesName = const Value.absent(),
    this.seriesNumber = const Value.absent(),
    this.edition = const Value.absent(),
    this.bookFormat = const Value.absent(),
    this.readingStatus = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.personalRating = const Value.absent(),
    this.startedReadingAt = const Value.absent(),
    this.finishedReadingAt = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.reviewNotes = const Value.absent(),
    this.metadataSource = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       householdId = Value(householdId);
  static Insertable<Book> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? itemId,
    Expression<String>? householdId,
    Expression<String>? isbn10,
    Expression<String>? isbn13,
    Expression<String>? subtitle,
    Expression<String>? authorsJson,
    Expression<String>? publisher,
    Expression<int>? publishedYear,
    Expression<int>? pageCount,
    Expression<String>? language,
    Expression<String>? genreTagsJson,
    Expression<String>? seriesName,
    Expression<double>? seriesNumber,
    Expression<String>? edition,
    Expression<String>? bookFormat,
    Expression<String>? readingStatus,
    Expression<int>? currentPage,
    Expression<int>? personalRating,
    Expression<DateTime>? startedReadingAt,
    Expression<DateTime>? finishedReadingAt,
    Expression<String>? synopsis,
    Expression<String>? reviewNotes,
    Expression<String>? metadataSource,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (itemId != null) 'item_id': itemId,
      if (householdId != null) 'household_id': householdId,
      if (isbn10 != null) 'isbn10': isbn10,
      if (isbn13 != null) 'isbn13': isbn13,
      if (subtitle != null) 'subtitle': subtitle,
      if (authorsJson != null) 'authors_json': authorsJson,
      if (publisher != null) 'publisher': publisher,
      if (publishedYear != null) 'published_year': publishedYear,
      if (pageCount != null) 'page_count': pageCount,
      if (language != null) 'language': language,
      if (genreTagsJson != null) 'genre_tags_json': genreTagsJson,
      if (seriesName != null) 'series_name': seriesName,
      if (seriesNumber != null) 'series_number': seriesNumber,
      if (edition != null) 'edition': edition,
      if (bookFormat != null) 'book_format': bookFormat,
      if (readingStatus != null) 'reading_status': readingStatus,
      if (currentPage != null) 'current_page': currentPage,
      if (personalRating != null) 'personal_rating': personalRating,
      if (startedReadingAt != null) 'started_reading_at': startedReadingAt,
      if (finishedReadingAt != null) 'finished_reading_at': finishedReadingAt,
      if (synopsis != null) 'synopsis': synopsis,
      if (reviewNotes != null) 'review_notes': reviewNotes,
      if (metadataSource != null) 'metadata_source': metadataSource,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? itemId,
    Value<String>? householdId,
    Value<String?>? isbn10,
    Value<String?>? isbn13,
    Value<String?>? subtitle,
    Value<String>? authorsJson,
    Value<String?>? publisher,
    Value<int?>? publishedYear,
    Value<int?>? pageCount,
    Value<String>? language,
    Value<String>? genreTagsJson,
    Value<String?>? seriesName,
    Value<double?>? seriesNumber,
    Value<String?>? edition,
    Value<String>? bookFormat,
    Value<String>? readingStatus,
    Value<int>? currentPage,
    Value<int?>? personalRating,
    Value<DateTime?>? startedReadingAt,
    Value<DateTime?>? finishedReadingAt,
    Value<String?>? synopsis,
    Value<String?>? reviewNotes,
    Value<String>? metadataSource,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      itemId: itemId ?? this.itemId,
      householdId: householdId ?? this.householdId,
      isbn10: isbn10 ?? this.isbn10,
      isbn13: isbn13 ?? this.isbn13,
      subtitle: subtitle ?? this.subtitle,
      authorsJson: authorsJson ?? this.authorsJson,
      publisher: publisher ?? this.publisher,
      publishedYear: publishedYear ?? this.publishedYear,
      pageCount: pageCount ?? this.pageCount,
      language: language ?? this.language,
      genreTagsJson: genreTagsJson ?? this.genreTagsJson,
      seriesName: seriesName ?? this.seriesName,
      seriesNumber: seriesNumber ?? this.seriesNumber,
      edition: edition ?? this.edition,
      bookFormat: bookFormat ?? this.bookFormat,
      readingStatus: readingStatus ?? this.readingStatus,
      currentPage: currentPage ?? this.currentPage,
      personalRating: personalRating ?? this.personalRating,
      startedReadingAt: startedReadingAt ?? this.startedReadingAt,
      finishedReadingAt: finishedReadingAt ?? this.finishedReadingAt,
      synopsis: synopsis ?? this.synopsis,
      reviewNotes: reviewNotes ?? this.reviewNotes,
      metadataSource: metadataSource ?? this.metadataSource,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (isbn10.present) {
      map['isbn10'] = Variable<String>(isbn10.value);
    }
    if (isbn13.present) {
      map['isbn13'] = Variable<String>(isbn13.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (authorsJson.present) {
      map['authors_json'] = Variable<String>(authorsJson.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (publishedYear.present) {
      map['published_year'] = Variable<int>(publishedYear.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (genreTagsJson.present) {
      map['genre_tags_json'] = Variable<String>(genreTagsJson.value);
    }
    if (seriesName.present) {
      map['series_name'] = Variable<String>(seriesName.value);
    }
    if (seriesNumber.present) {
      map['series_number'] = Variable<double>(seriesNumber.value);
    }
    if (edition.present) {
      map['edition'] = Variable<String>(edition.value);
    }
    if (bookFormat.present) {
      map['book_format'] = Variable<String>(bookFormat.value);
    }
    if (readingStatus.present) {
      map['reading_status'] = Variable<String>(readingStatus.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (personalRating.present) {
      map['personal_rating'] = Variable<int>(personalRating.value);
    }
    if (startedReadingAt.present) {
      map['started_reading_at'] = Variable<DateTime>(startedReadingAt.value);
    }
    if (finishedReadingAt.present) {
      map['finished_reading_at'] = Variable<DateTime>(finishedReadingAt.value);
    }
    if (synopsis.present) {
      map['synopsis'] = Variable<String>(synopsis.value);
    }
    if (reviewNotes.present) {
      map['review_notes'] = Variable<String>(reviewNotes.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String>(metadataSource.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('isbn10: $isbn10, ')
          ..write('isbn13: $isbn13, ')
          ..write('subtitle: $subtitle, ')
          ..write('authorsJson: $authorsJson, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('pageCount: $pageCount, ')
          ..write('language: $language, ')
          ..write('genreTagsJson: $genreTagsJson, ')
          ..write('seriesName: $seriesName, ')
          ..write('seriesNumber: $seriesNumber, ')
          ..write('edition: $edition, ')
          ..write('bookFormat: $bookFormat, ')
          ..write('readingStatus: $readingStatus, ')
          ..write('currentPage: $currentPage, ')
          ..write('personalRating: $personalRating, ')
          ..write('startedReadingAt: $startedReadingAt, ')
          ..write('finishedReadingAt: $finishedReadingAt, ')
          ..write('synopsis: $synopsis, ')
          ..write('reviewNotes: $reviewNotes, ')
          ..write('metadataSource: $metadataSource, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _relatedItemIdMeta = const VerificationMeta(
    'relatedItemId',
  );
  @override
  late final GeneratedColumn<String> relatedItemId = GeneratedColumn<String>(
    'related_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _docCategoryMeta = const VerificationMeta(
    'docCategory',
  );
  @override
  late final GeneratedColumn<String> docCategory = GeneratedColumn<String>(
    'doc_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _docSubtypeMeta = const VerificationMeta(
    'docSubtype',
  );
  @override
  late final GeneratedColumn<String> docSubtype = GeneratedColumn<String>(
    'doc_subtype',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerMemberNameMeta = const VerificationMeta(
    'ownerMemberName',
  );
  @override
  late final GeneratedColumn<String> ownerMemberName = GeneratedColumn<String>(
    'owner_member_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issuerMeta = const VerificationMeta('issuer');
  @override
  late final GeneratedColumn<String> issuer = GeneratedColumn<String>(
    'issuer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOriginalMeta = const VerificationMeta(
    'isOriginal',
  );
  @override
  late final GeneratedColumn<bool> isOriginal = GeneratedColumn<bool>(
    'is_original',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_original" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _copyCountMeta = const VerificationMeta(
    'copyCount',
  );
  @override
  late final GeneratedColumn<int> copyCount = GeneratedColumn<int>(
    'copy_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _physicalFolderLabelMeta =
      const VerificationMeta('physicalFolderLabel');
  @override
  late final GeneratedColumn<String> physicalFolderLabel =
      GeneratedColumn<String>(
        'physical_folder_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isVaultLockedMeta = const VerificationMeta(
    'isVaultLocked',
  );
  @override
  late final GeneratedColumn<bool> isVaultLocked = GeneratedColumn<bool>(
    'is_vault_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vault_locked" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ocrExtractedTextMeta = const VerificationMeta(
    'ocrExtractedText',
  );
  @override
  late final GeneratedColumn<String> ocrExtractedText = GeneratedColumn<String>(
    'ocr_extracted_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    relatedItemId,
    docCategory,
    docSubtype,
    documentNumber,
    ownerMemberName,
    issuer,
    issuedAt,
    expiresAt,
    isOriginal,
    copyCount,
    physicalFolderLabel,
    isVaultLocked,
    ocrExtractedText,
    tagsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('related_item_id')) {
      context.handle(
        _relatedItemIdMeta,
        relatedItemId.isAcceptableOrUnknown(
          data['related_item_id']!,
          _relatedItemIdMeta,
        ),
      );
    }
    if (data.containsKey('doc_category')) {
      context.handle(
        _docCategoryMeta,
        docCategory.isAcceptableOrUnknown(
          data['doc_category']!,
          _docCategoryMeta,
        ),
      );
    }
    if (data.containsKey('doc_subtype')) {
      context.handle(
        _docSubtypeMeta,
        docSubtype.isAcceptableOrUnknown(data['doc_subtype']!, _docSubtypeMeta),
      );
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('owner_member_name')) {
      context.handle(
        _ownerMemberNameMeta,
        ownerMemberName.isAcceptableOrUnknown(
          data['owner_member_name']!,
          _ownerMemberNameMeta,
        ),
      );
    }
    if (data.containsKey('issuer')) {
      context.handle(
        _issuerMeta,
        issuer.isAcceptableOrUnknown(data['issuer']!, _issuerMeta),
      );
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('is_original')) {
      context.handle(
        _isOriginalMeta,
        isOriginal.isAcceptableOrUnknown(data['is_original']!, _isOriginalMeta),
      );
    }
    if (data.containsKey('copy_count')) {
      context.handle(
        _copyCountMeta,
        copyCount.isAcceptableOrUnknown(data['copy_count']!, _copyCountMeta),
      );
    }
    if (data.containsKey('physical_folder_label')) {
      context.handle(
        _physicalFolderLabelMeta,
        physicalFolderLabel.isAcceptableOrUnknown(
          data['physical_folder_label']!,
          _physicalFolderLabelMeta,
        ),
      );
    }
    if (data.containsKey('is_vault_locked')) {
      context.handle(
        _isVaultLockedMeta,
        isVaultLocked.isAcceptableOrUnknown(
          data['is_vault_locked']!,
          _isVaultLockedMeta,
        ),
      );
    }
    if (data.containsKey('ocr_extracted_text')) {
      context.handle(
        _ocrExtractedTextMeta,
        ocrExtractedText.isAcceptableOrUnknown(
          data['ocr_extracted_text']!,
          _ocrExtractedTextMeta,
        ),
      );
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      relatedItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_item_id'],
      ),
      docCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_category'],
      )!,
      docSubtype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_subtype'],
      ),
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      ),
      ownerMemberName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_member_name'],
      ),
      issuer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer'],
      ),
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      isOriginal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_original'],
      )!,
      copyCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}copy_count'],
      )!,
      physicalFolderLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}physical_folder_label'],
      ),
      isVaultLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vault_locked'],
      )!,
      ocrExtractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_extracted_text'],
      ),
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String itemId;
  final String householdId;
  final String? relatedItemId;
  final String docCategory;
  final String? docSubtype;
  final String? documentNumber;
  final String? ownerMemberName;
  final String? issuer;
  final DateTime? issuedAt;
  final DateTime? expiresAt;
  final bool isOriginal;
  final int copyCount;
  final String? physicalFolderLabel;
  final bool isVaultLocked;
  final String? ocrExtractedText;
  final String tagsJson;
  const Document({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.itemId,
    required this.householdId,
    this.relatedItemId,
    required this.docCategory,
    this.docSubtype,
    this.documentNumber,
    this.ownerMemberName,
    this.issuer,
    this.issuedAt,
    this.expiresAt,
    required this.isOriginal,
    required this.copyCount,
    this.physicalFolderLabel,
    required this.isVaultLocked,
    this.ocrExtractedText,
    required this.tagsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['item_id'] = Variable<String>(itemId);
    map['household_id'] = Variable<String>(householdId);
    if (!nullToAbsent || relatedItemId != null) {
      map['related_item_id'] = Variable<String>(relatedItemId);
    }
    map['doc_category'] = Variable<String>(docCategory);
    if (!nullToAbsent || docSubtype != null) {
      map['doc_subtype'] = Variable<String>(docSubtype);
    }
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || ownerMemberName != null) {
      map['owner_member_name'] = Variable<String>(ownerMemberName);
    }
    if (!nullToAbsent || issuer != null) {
      map['issuer'] = Variable<String>(issuer);
    }
    if (!nullToAbsent || issuedAt != null) {
      map['issued_at'] = Variable<DateTime>(issuedAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['is_original'] = Variable<bool>(isOriginal);
    map['copy_count'] = Variable<int>(copyCount);
    if (!nullToAbsent || physicalFolderLabel != null) {
      map['physical_folder_label'] = Variable<String>(physicalFolderLabel);
    }
    map['is_vault_locked'] = Variable<bool>(isVaultLocked);
    if (!nullToAbsent || ocrExtractedText != null) {
      map['ocr_extracted_text'] = Variable<String>(ocrExtractedText);
    }
    map['tags_json'] = Variable<String>(tagsJson);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      itemId: Value(itemId),
      householdId: Value(householdId),
      relatedItemId: relatedItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedItemId),
      docCategory: Value(docCategory),
      docSubtype: docSubtype == null && nullToAbsent
          ? const Value.absent()
          : Value(docSubtype),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      ownerMemberName: ownerMemberName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerMemberName),
      issuer: issuer == null && nullToAbsent
          ? const Value.absent()
          : Value(issuer),
      issuedAt: issuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(issuedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      isOriginal: Value(isOriginal),
      copyCount: Value(copyCount),
      physicalFolderLabel: physicalFolderLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(physicalFolderLabel),
      isVaultLocked: Value(isVaultLocked),
      ocrExtractedText: ocrExtractedText == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrExtractedText),
      tagsJson: Value(tagsJson),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      itemId: serializer.fromJson<String>(json['itemId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      relatedItemId: serializer.fromJson<String?>(json['relatedItemId']),
      docCategory: serializer.fromJson<String>(json['docCategory']),
      docSubtype: serializer.fromJson<String?>(json['docSubtype']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      ownerMemberName: serializer.fromJson<String?>(json['ownerMemberName']),
      issuer: serializer.fromJson<String?>(json['issuer']),
      issuedAt: serializer.fromJson<DateTime?>(json['issuedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      isOriginal: serializer.fromJson<bool>(json['isOriginal']),
      copyCount: serializer.fromJson<int>(json['copyCount']),
      physicalFolderLabel: serializer.fromJson<String?>(
        json['physicalFolderLabel'],
      ),
      isVaultLocked: serializer.fromJson<bool>(json['isVaultLocked']),
      ocrExtractedText: serializer.fromJson<String?>(json['ocrExtractedText']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'itemId': serializer.toJson<String>(itemId),
      'householdId': serializer.toJson<String>(householdId),
      'relatedItemId': serializer.toJson<String?>(relatedItemId),
      'docCategory': serializer.toJson<String>(docCategory),
      'docSubtype': serializer.toJson<String?>(docSubtype),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'ownerMemberName': serializer.toJson<String?>(ownerMemberName),
      'issuer': serializer.toJson<String?>(issuer),
      'issuedAt': serializer.toJson<DateTime?>(issuedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'isOriginal': serializer.toJson<bool>(isOriginal),
      'copyCount': serializer.toJson<int>(copyCount),
      'physicalFolderLabel': serializer.toJson<String?>(physicalFolderLabel),
      'isVaultLocked': serializer.toJson<bool>(isVaultLocked),
      'ocrExtractedText': serializer.toJson<String?>(ocrExtractedText),
      'tagsJson': serializer.toJson<String>(tagsJson),
    };
  }

  Document copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? itemId,
    String? householdId,
    Value<String?> relatedItemId = const Value.absent(),
    String? docCategory,
    Value<String?> docSubtype = const Value.absent(),
    Value<String?> documentNumber = const Value.absent(),
    Value<String?> ownerMemberName = const Value.absent(),
    Value<String?> issuer = const Value.absent(),
    Value<DateTime?> issuedAt = const Value.absent(),
    Value<DateTime?> expiresAt = const Value.absent(),
    bool? isOriginal,
    int? copyCount,
    Value<String?> physicalFolderLabel = const Value.absent(),
    bool? isVaultLocked,
    Value<String?> ocrExtractedText = const Value.absent(),
    String? tagsJson,
  }) => Document(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    itemId: itemId ?? this.itemId,
    householdId: householdId ?? this.householdId,
    relatedItemId: relatedItemId.present
        ? relatedItemId.value
        : this.relatedItemId,
    docCategory: docCategory ?? this.docCategory,
    docSubtype: docSubtype.present ? docSubtype.value : this.docSubtype,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    ownerMemberName: ownerMemberName.present
        ? ownerMemberName.value
        : this.ownerMemberName,
    issuer: issuer.present ? issuer.value : this.issuer,
    issuedAt: issuedAt.present ? issuedAt.value : this.issuedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    isOriginal: isOriginal ?? this.isOriginal,
    copyCount: copyCount ?? this.copyCount,
    physicalFolderLabel: physicalFolderLabel.present
        ? physicalFolderLabel.value
        : this.physicalFolderLabel,
    isVaultLocked: isVaultLocked ?? this.isVaultLocked,
    ocrExtractedText: ocrExtractedText.present
        ? ocrExtractedText.value
        : this.ocrExtractedText,
    tagsJson: tagsJson ?? this.tagsJson,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      relatedItemId: data.relatedItemId.present
          ? data.relatedItemId.value
          : this.relatedItemId,
      docCategory: data.docCategory.present
          ? data.docCategory.value
          : this.docCategory,
      docSubtype: data.docSubtype.present
          ? data.docSubtype.value
          : this.docSubtype,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      ownerMemberName: data.ownerMemberName.present
          ? data.ownerMemberName.value
          : this.ownerMemberName,
      issuer: data.issuer.present ? data.issuer.value : this.issuer,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isOriginal: data.isOriginal.present
          ? data.isOriginal.value
          : this.isOriginal,
      copyCount: data.copyCount.present ? data.copyCount.value : this.copyCount,
      physicalFolderLabel: data.physicalFolderLabel.present
          ? data.physicalFolderLabel.value
          : this.physicalFolderLabel,
      isVaultLocked: data.isVaultLocked.present
          ? data.isVaultLocked.value
          : this.isVaultLocked,
      ocrExtractedText: data.ocrExtractedText.present
          ? data.ocrExtractedText.value
          : this.ocrExtractedText,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('relatedItemId: $relatedItemId, ')
          ..write('docCategory: $docCategory, ')
          ..write('docSubtype: $docSubtype, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('ownerMemberName: $ownerMemberName, ')
          ..write('issuer: $issuer, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isOriginal: $isOriginal, ')
          ..write('copyCount: $copyCount, ')
          ..write('physicalFolderLabel: $physicalFolderLabel, ')
          ..write('isVaultLocked: $isVaultLocked, ')
          ..write('ocrExtractedText: $ocrExtractedText, ')
          ..write('tagsJson: $tagsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    relatedItemId,
    docCategory,
    docSubtype,
    documentNumber,
    ownerMemberName,
    issuer,
    issuedAt,
    expiresAt,
    isOriginal,
    copyCount,
    physicalFolderLabel,
    isVaultLocked,
    ocrExtractedText,
    tagsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.itemId == this.itemId &&
          other.householdId == this.householdId &&
          other.relatedItemId == this.relatedItemId &&
          other.docCategory == this.docCategory &&
          other.docSubtype == this.docSubtype &&
          other.documentNumber == this.documentNumber &&
          other.ownerMemberName == this.ownerMemberName &&
          other.issuer == this.issuer &&
          other.issuedAt == this.issuedAt &&
          other.expiresAt == this.expiresAt &&
          other.isOriginal == this.isOriginal &&
          other.copyCount == this.copyCount &&
          other.physicalFolderLabel == this.physicalFolderLabel &&
          other.isVaultLocked == this.isVaultLocked &&
          other.ocrExtractedText == this.ocrExtractedText &&
          other.tagsJson == this.tagsJson);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> itemId;
  final Value<String> householdId;
  final Value<String?> relatedItemId;
  final Value<String> docCategory;
  final Value<String?> docSubtype;
  final Value<String?> documentNumber;
  final Value<String?> ownerMemberName;
  final Value<String?> issuer;
  final Value<DateTime?> issuedAt;
  final Value<DateTime?> expiresAt;
  final Value<bool> isOriginal;
  final Value<int> copyCount;
  final Value<String?> physicalFolderLabel;
  final Value<bool> isVaultLocked;
  final Value<String?> ocrExtractedText;
  final Value<String> tagsJson;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.itemId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.relatedItemId = const Value.absent(),
    this.docCategory = const Value.absent(),
    this.docSubtype = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.ownerMemberName = const Value.absent(),
    this.issuer = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isOriginal = const Value.absent(),
    this.copyCount = const Value.absent(),
    this.physicalFolderLabel = const Value.absent(),
    this.isVaultLocked = const Value.absent(),
    this.ocrExtractedText = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String itemId,
    required String householdId,
    this.relatedItemId = const Value.absent(),
    this.docCategory = const Value.absent(),
    this.docSubtype = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.ownerMemberName = const Value.absent(),
    this.issuer = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isOriginal = const Value.absent(),
    this.copyCount = const Value.absent(),
    this.physicalFolderLabel = const Value.absent(),
    this.isVaultLocked = const Value.absent(),
    this.ocrExtractedText = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       householdId = Value(householdId);
  static Insertable<Document> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? itemId,
    Expression<String>? householdId,
    Expression<String>? relatedItemId,
    Expression<String>? docCategory,
    Expression<String>? docSubtype,
    Expression<String>? documentNumber,
    Expression<String>? ownerMemberName,
    Expression<String>? issuer,
    Expression<DateTime>? issuedAt,
    Expression<DateTime>? expiresAt,
    Expression<bool>? isOriginal,
    Expression<int>? copyCount,
    Expression<String>? physicalFolderLabel,
    Expression<bool>? isVaultLocked,
    Expression<String>? ocrExtractedText,
    Expression<String>? tagsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (itemId != null) 'item_id': itemId,
      if (householdId != null) 'household_id': householdId,
      if (relatedItemId != null) 'related_item_id': relatedItemId,
      if (docCategory != null) 'doc_category': docCategory,
      if (docSubtype != null) 'doc_subtype': docSubtype,
      if (documentNumber != null) 'document_number': documentNumber,
      if (ownerMemberName != null) 'owner_member_name': ownerMemberName,
      if (issuer != null) 'issuer': issuer,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isOriginal != null) 'is_original': isOriginal,
      if (copyCount != null) 'copy_count': copyCount,
      if (physicalFolderLabel != null)
        'physical_folder_label': physicalFolderLabel,
      if (isVaultLocked != null) 'is_vault_locked': isVaultLocked,
      if (ocrExtractedText != null) 'ocr_extracted_text': ocrExtractedText,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? itemId,
    Value<String>? householdId,
    Value<String?>? relatedItemId,
    Value<String>? docCategory,
    Value<String?>? docSubtype,
    Value<String?>? documentNumber,
    Value<String?>? ownerMemberName,
    Value<String?>? issuer,
    Value<DateTime?>? issuedAt,
    Value<DateTime?>? expiresAt,
    Value<bool>? isOriginal,
    Value<int>? copyCount,
    Value<String?>? physicalFolderLabel,
    Value<bool>? isVaultLocked,
    Value<String?>? ocrExtractedText,
    Value<String>? tagsJson,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      itemId: itemId ?? this.itemId,
      householdId: householdId ?? this.householdId,
      relatedItemId: relatedItemId ?? this.relatedItemId,
      docCategory: docCategory ?? this.docCategory,
      docSubtype: docSubtype ?? this.docSubtype,
      documentNumber: documentNumber ?? this.documentNumber,
      ownerMemberName: ownerMemberName ?? this.ownerMemberName,
      issuer: issuer ?? this.issuer,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isOriginal: isOriginal ?? this.isOriginal,
      copyCount: copyCount ?? this.copyCount,
      physicalFolderLabel: physicalFolderLabel ?? this.physicalFolderLabel,
      isVaultLocked: isVaultLocked ?? this.isVaultLocked,
      ocrExtractedText: ocrExtractedText ?? this.ocrExtractedText,
      tagsJson: tagsJson ?? this.tagsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (relatedItemId.present) {
      map['related_item_id'] = Variable<String>(relatedItemId.value);
    }
    if (docCategory.present) {
      map['doc_category'] = Variable<String>(docCategory.value);
    }
    if (docSubtype.present) {
      map['doc_subtype'] = Variable<String>(docSubtype.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (ownerMemberName.present) {
      map['owner_member_name'] = Variable<String>(ownerMemberName.value);
    }
    if (issuer.present) {
      map['issuer'] = Variable<String>(issuer.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (isOriginal.present) {
      map['is_original'] = Variable<bool>(isOriginal.value);
    }
    if (copyCount.present) {
      map['copy_count'] = Variable<int>(copyCount.value);
    }
    if (physicalFolderLabel.present) {
      map['physical_folder_label'] = Variable<String>(
        physicalFolderLabel.value,
      );
    }
    if (isVaultLocked.present) {
      map['is_vault_locked'] = Variable<bool>(isVaultLocked.value);
    }
    if (ocrExtractedText.present) {
      map['ocr_extracted_text'] = Variable<String>(ocrExtractedText.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('relatedItemId: $relatedItemId, ')
          ..write('docCategory: $docCategory, ')
          ..write('docSubtype: $docSubtype, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('ownerMemberName: $ownerMemberName, ')
          ..write('issuer: $issuer, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isOriginal: $isOriginal, ')
          ..write('copyCount: $copyCount, ')
          ..write('physicalFolderLabel: $physicalFolderLabel, ')
          ..write('isVaultLocked: $isVaultLocked, ')
          ..write('ocrExtractedText: $ocrExtractedText, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _vehicleKindMeta = const VerificationMeta(
    'vehicleKind',
  );
  @override
  late final GeneratedColumn<String> vehicleKind = GeneratedColumn<String>(
    'vehicle_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('motorcycle'),
  );
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vinRangkaMeta = const VerificationMeta(
    'vinRangka',
  );
  @override
  late final GeneratedColumn<String> vinRangka = GeneratedColumn<String>(
    'vin_rangka',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _engineNumberMeta = const VerificationMeta(
    'engineNumber',
  );
  @override
  late final GeneratedColumn<String> engineNumber = GeneratedColumn<String>(
    'engine_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufactureYearMeta = const VerificationMeta(
    'manufactureYear',
  );
  @override
  late final GeneratedColumn<int> manufactureYear = GeneratedColumn<int>(
    'manufacture_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentOdometerKmMeta = const VerificationMeta(
    'currentOdometerKm',
  );
  @override
  late final GeneratedColumn<int> currentOdometerKm = GeneratedColumn<int>(
    'current_odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stnkAnnualDueAtMeta = const VerificationMeta(
    'stnkAnnualDueAt',
  );
  @override
  late final GeneratedColumn<DateTime> stnkAnnualDueAt =
      GeneratedColumn<DateTime>(
        'stnk_annual_due_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _stnk5yrDueAtMeta = const VerificationMeta(
    'stnk5yrDueAt',
  );
  @override
  late final GeneratedColumn<DateTime> stnk5yrDueAt = GeneratedColumn<DateTime>(
    'stnk5yr_due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _insuranceDueAtMeta = const VerificationMeta(
    'insuranceDueAt',
  );
  @override
  late final GeneratedColumn<DateTime> insuranceDueAt =
      GeneratedColumn<DateTime>(
        'insurance_due_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _insuranceProviderMeta = const VerificationMeta(
    'insuranceProvider',
  );
  @override
  late final GeneratedColumn<String> insuranceProvider =
      GeneratedColumn<String>(
        'insurance_provider',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bpkbNumberMeta = const VerificationMeta(
    'bpkbNumber',
  );
  @override
  late final GeneratedColumn<String> bpkbNumber = GeneratedColumn<String>(
    'bpkb_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    vehicleKind,
    plateNumber,
    vinRangka,
    engineNumber,
    manufactureYear,
    fuelType,
    currentOdometerKm,
    stnkAnnualDueAt,
    stnk5yrDueAt,
    insuranceDueAt,
    insuranceProvider,
    bpkbNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('vehicle_kind')) {
      context.handle(
        _vehicleKindMeta,
        vehicleKind.isAcceptableOrUnknown(
          data['vehicle_kind']!,
          _vehicleKindMeta,
        ),
      );
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    }
    if (data.containsKey('vin_rangka')) {
      context.handle(
        _vinRangkaMeta,
        vinRangka.isAcceptableOrUnknown(data['vin_rangka']!, _vinRangkaMeta),
      );
    }
    if (data.containsKey('engine_number')) {
      context.handle(
        _engineNumberMeta,
        engineNumber.isAcceptableOrUnknown(
          data['engine_number']!,
          _engineNumberMeta,
        ),
      );
    }
    if (data.containsKey('manufacture_year')) {
      context.handle(
        _manufactureYearMeta,
        manufactureYear.isAcceptableOrUnknown(
          data['manufacture_year']!,
          _manufactureYearMeta,
        ),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    }
    if (data.containsKey('current_odometer_km')) {
      context.handle(
        _currentOdometerKmMeta,
        currentOdometerKm.isAcceptableOrUnknown(
          data['current_odometer_km']!,
          _currentOdometerKmMeta,
        ),
      );
    }
    if (data.containsKey('stnk_annual_due_at')) {
      context.handle(
        _stnkAnnualDueAtMeta,
        stnkAnnualDueAt.isAcceptableOrUnknown(
          data['stnk_annual_due_at']!,
          _stnkAnnualDueAtMeta,
        ),
      );
    }
    if (data.containsKey('stnk5yr_due_at')) {
      context.handle(
        _stnk5yrDueAtMeta,
        stnk5yrDueAt.isAcceptableOrUnknown(
          data['stnk5yr_due_at']!,
          _stnk5yrDueAtMeta,
        ),
      );
    }
    if (data.containsKey('insurance_due_at')) {
      context.handle(
        _insuranceDueAtMeta,
        insuranceDueAt.isAcceptableOrUnknown(
          data['insurance_due_at']!,
          _insuranceDueAtMeta,
        ),
      );
    }
    if (data.containsKey('insurance_provider')) {
      context.handle(
        _insuranceProviderMeta,
        insuranceProvider.isAcceptableOrUnknown(
          data['insurance_provider']!,
          _insuranceProviderMeta,
        ),
      );
    }
    if (data.containsKey('bpkb_number')) {
      context.handle(
        _bpkbNumberMeta,
        bpkbNumber.isAcceptableOrUnknown(data['bpkb_number']!, _bpkbNumberMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      vehicleKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_kind'],
      )!,
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      ),
      vinRangka: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin_rangka'],
      ),
      engineNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_number'],
      ),
      manufactureYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manufacture_year'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      ),
      currentOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_odometer_km'],
      )!,
      stnkAnnualDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}stnk_annual_due_at'],
      ),
      stnk5yrDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}stnk5yr_due_at'],
      ),
      insuranceDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}insurance_due_at'],
      ),
      insuranceProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insurance_provider'],
      ),
      bpkbNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bpkb_number'],
      ),
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String itemId;
  final String householdId;
  final String vehicleKind;
  final String? plateNumber;
  final String? vinRangka;
  final String? engineNumber;
  final int? manufactureYear;
  final String? fuelType;
  final int currentOdometerKm;
  final DateTime? stnkAnnualDueAt;
  final DateTime? stnk5yrDueAt;
  final DateTime? insuranceDueAt;
  final String? insuranceProvider;
  final String? bpkbNumber;
  const Vehicle({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.itemId,
    required this.householdId,
    required this.vehicleKind,
    this.plateNumber,
    this.vinRangka,
    this.engineNumber,
    this.manufactureYear,
    this.fuelType,
    required this.currentOdometerKm,
    this.stnkAnnualDueAt,
    this.stnk5yrDueAt,
    this.insuranceDueAt,
    this.insuranceProvider,
    this.bpkbNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['item_id'] = Variable<String>(itemId);
    map['household_id'] = Variable<String>(householdId);
    map['vehicle_kind'] = Variable<String>(vehicleKind);
    if (!nullToAbsent || plateNumber != null) {
      map['plate_number'] = Variable<String>(plateNumber);
    }
    if (!nullToAbsent || vinRangka != null) {
      map['vin_rangka'] = Variable<String>(vinRangka);
    }
    if (!nullToAbsent || engineNumber != null) {
      map['engine_number'] = Variable<String>(engineNumber);
    }
    if (!nullToAbsent || manufactureYear != null) {
      map['manufacture_year'] = Variable<int>(manufactureYear);
    }
    if (!nullToAbsent || fuelType != null) {
      map['fuel_type'] = Variable<String>(fuelType);
    }
    map['current_odometer_km'] = Variable<int>(currentOdometerKm);
    if (!nullToAbsent || stnkAnnualDueAt != null) {
      map['stnk_annual_due_at'] = Variable<DateTime>(stnkAnnualDueAt);
    }
    if (!nullToAbsent || stnk5yrDueAt != null) {
      map['stnk5yr_due_at'] = Variable<DateTime>(stnk5yrDueAt);
    }
    if (!nullToAbsent || insuranceDueAt != null) {
      map['insurance_due_at'] = Variable<DateTime>(insuranceDueAt);
    }
    if (!nullToAbsent || insuranceProvider != null) {
      map['insurance_provider'] = Variable<String>(insuranceProvider);
    }
    if (!nullToAbsent || bpkbNumber != null) {
      map['bpkb_number'] = Variable<String>(bpkbNumber);
    }
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      itemId: Value(itemId),
      householdId: Value(householdId),
      vehicleKind: Value(vehicleKind),
      plateNumber: plateNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(plateNumber),
      vinRangka: vinRangka == null && nullToAbsent
          ? const Value.absent()
          : Value(vinRangka),
      engineNumber: engineNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(engineNumber),
      manufactureYear: manufactureYear == null && nullToAbsent
          ? const Value.absent()
          : Value(manufactureYear),
      fuelType: fuelType == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelType),
      currentOdometerKm: Value(currentOdometerKm),
      stnkAnnualDueAt: stnkAnnualDueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(stnkAnnualDueAt),
      stnk5yrDueAt: stnk5yrDueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(stnk5yrDueAt),
      insuranceDueAt: insuranceDueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(insuranceDueAt),
      insuranceProvider: insuranceProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(insuranceProvider),
      bpkbNumber: bpkbNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(bpkbNumber),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      itemId: serializer.fromJson<String>(json['itemId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      vehicleKind: serializer.fromJson<String>(json['vehicleKind']),
      plateNumber: serializer.fromJson<String?>(json['plateNumber']),
      vinRangka: serializer.fromJson<String?>(json['vinRangka']),
      engineNumber: serializer.fromJson<String?>(json['engineNumber']),
      manufactureYear: serializer.fromJson<int?>(json['manufactureYear']),
      fuelType: serializer.fromJson<String?>(json['fuelType']),
      currentOdometerKm: serializer.fromJson<int>(json['currentOdometerKm']),
      stnkAnnualDueAt: serializer.fromJson<DateTime?>(json['stnkAnnualDueAt']),
      stnk5yrDueAt: serializer.fromJson<DateTime?>(json['stnk5yrDueAt']),
      insuranceDueAt: serializer.fromJson<DateTime?>(json['insuranceDueAt']),
      insuranceProvider: serializer.fromJson<String?>(
        json['insuranceProvider'],
      ),
      bpkbNumber: serializer.fromJson<String?>(json['bpkbNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'itemId': serializer.toJson<String>(itemId),
      'householdId': serializer.toJson<String>(householdId),
      'vehicleKind': serializer.toJson<String>(vehicleKind),
      'plateNumber': serializer.toJson<String?>(plateNumber),
      'vinRangka': serializer.toJson<String?>(vinRangka),
      'engineNumber': serializer.toJson<String?>(engineNumber),
      'manufactureYear': serializer.toJson<int?>(manufactureYear),
      'fuelType': serializer.toJson<String?>(fuelType),
      'currentOdometerKm': serializer.toJson<int>(currentOdometerKm),
      'stnkAnnualDueAt': serializer.toJson<DateTime?>(stnkAnnualDueAt),
      'stnk5yrDueAt': serializer.toJson<DateTime?>(stnk5yrDueAt),
      'insuranceDueAt': serializer.toJson<DateTime?>(insuranceDueAt),
      'insuranceProvider': serializer.toJson<String?>(insuranceProvider),
      'bpkbNumber': serializer.toJson<String?>(bpkbNumber),
    };
  }

  Vehicle copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? itemId,
    String? householdId,
    String? vehicleKind,
    Value<String?> plateNumber = const Value.absent(),
    Value<String?> vinRangka = const Value.absent(),
    Value<String?> engineNumber = const Value.absent(),
    Value<int?> manufactureYear = const Value.absent(),
    Value<String?> fuelType = const Value.absent(),
    int? currentOdometerKm,
    Value<DateTime?> stnkAnnualDueAt = const Value.absent(),
    Value<DateTime?> stnk5yrDueAt = const Value.absent(),
    Value<DateTime?> insuranceDueAt = const Value.absent(),
    Value<String?> insuranceProvider = const Value.absent(),
    Value<String?> bpkbNumber = const Value.absent(),
  }) => Vehicle(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    itemId: itemId ?? this.itemId,
    householdId: householdId ?? this.householdId,
    vehicleKind: vehicleKind ?? this.vehicleKind,
    plateNumber: plateNumber.present ? plateNumber.value : this.plateNumber,
    vinRangka: vinRangka.present ? vinRangka.value : this.vinRangka,
    engineNumber: engineNumber.present ? engineNumber.value : this.engineNumber,
    manufactureYear: manufactureYear.present
        ? manufactureYear.value
        : this.manufactureYear,
    fuelType: fuelType.present ? fuelType.value : this.fuelType,
    currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
    stnkAnnualDueAt: stnkAnnualDueAt.present
        ? stnkAnnualDueAt.value
        : this.stnkAnnualDueAt,
    stnk5yrDueAt: stnk5yrDueAt.present ? stnk5yrDueAt.value : this.stnk5yrDueAt,
    insuranceDueAt: insuranceDueAt.present
        ? insuranceDueAt.value
        : this.insuranceDueAt,
    insuranceProvider: insuranceProvider.present
        ? insuranceProvider.value
        : this.insuranceProvider,
    bpkbNumber: bpkbNumber.present ? bpkbNumber.value : this.bpkbNumber,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      vehicleKind: data.vehicleKind.present
          ? data.vehicleKind.value
          : this.vehicleKind,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      vinRangka: data.vinRangka.present ? data.vinRangka.value : this.vinRangka,
      engineNumber: data.engineNumber.present
          ? data.engineNumber.value
          : this.engineNumber,
      manufactureYear: data.manufactureYear.present
          ? data.manufactureYear.value
          : this.manufactureYear,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      currentOdometerKm: data.currentOdometerKm.present
          ? data.currentOdometerKm.value
          : this.currentOdometerKm,
      stnkAnnualDueAt: data.stnkAnnualDueAt.present
          ? data.stnkAnnualDueAt.value
          : this.stnkAnnualDueAt,
      stnk5yrDueAt: data.stnk5yrDueAt.present
          ? data.stnk5yrDueAt.value
          : this.stnk5yrDueAt,
      insuranceDueAt: data.insuranceDueAt.present
          ? data.insuranceDueAt.value
          : this.insuranceDueAt,
      insuranceProvider: data.insuranceProvider.present
          ? data.insuranceProvider.value
          : this.insuranceProvider,
      bpkbNumber: data.bpkbNumber.present
          ? data.bpkbNumber.value
          : this.bpkbNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleKind: $vehicleKind, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('vinRangka: $vinRangka, ')
          ..write('engineNumber: $engineNumber, ')
          ..write('manufactureYear: $manufactureYear, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('stnkAnnualDueAt: $stnkAnnualDueAt, ')
          ..write('stnk5yrDueAt: $stnk5yrDueAt, ')
          ..write('insuranceDueAt: $insuranceDueAt, ')
          ..write('insuranceProvider: $insuranceProvider, ')
          ..write('bpkbNumber: $bpkbNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    itemId,
    householdId,
    vehicleKind,
    plateNumber,
    vinRangka,
    engineNumber,
    manufactureYear,
    fuelType,
    currentOdometerKm,
    stnkAnnualDueAt,
    stnk5yrDueAt,
    insuranceDueAt,
    insuranceProvider,
    bpkbNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.itemId == this.itemId &&
          other.householdId == this.householdId &&
          other.vehicleKind == this.vehicleKind &&
          other.plateNumber == this.plateNumber &&
          other.vinRangka == this.vinRangka &&
          other.engineNumber == this.engineNumber &&
          other.manufactureYear == this.manufactureYear &&
          other.fuelType == this.fuelType &&
          other.currentOdometerKm == this.currentOdometerKm &&
          other.stnkAnnualDueAt == this.stnkAnnualDueAt &&
          other.stnk5yrDueAt == this.stnk5yrDueAt &&
          other.insuranceDueAt == this.insuranceDueAt &&
          other.insuranceProvider == this.insuranceProvider &&
          other.bpkbNumber == this.bpkbNumber);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> itemId;
  final Value<String> householdId;
  final Value<String> vehicleKind;
  final Value<String?> plateNumber;
  final Value<String?> vinRangka;
  final Value<String?> engineNumber;
  final Value<int?> manufactureYear;
  final Value<String?> fuelType;
  final Value<int> currentOdometerKm;
  final Value<DateTime?> stnkAnnualDueAt;
  final Value<DateTime?> stnk5yrDueAt;
  final Value<DateTime?> insuranceDueAt;
  final Value<String?> insuranceProvider;
  final Value<String?> bpkbNumber;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.itemId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.vehicleKind = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.vinRangka = const Value.absent(),
    this.engineNumber = const Value.absent(),
    this.manufactureYear = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    this.stnkAnnualDueAt = const Value.absent(),
    this.stnk5yrDueAt = const Value.absent(),
    this.insuranceDueAt = const Value.absent(),
    this.insuranceProvider = const Value.absent(),
    this.bpkbNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String itemId,
    required String householdId,
    this.vehicleKind = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.vinRangka = const Value.absent(),
    this.engineNumber = const Value.absent(),
    this.manufactureYear = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    this.stnkAnnualDueAt = const Value.absent(),
    this.stnk5yrDueAt = const Value.absent(),
    this.insuranceDueAt = const Value.absent(),
    this.insuranceProvider = const Value.absent(),
    this.bpkbNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       householdId = Value(householdId);
  static Insertable<Vehicle> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? itemId,
    Expression<String>? householdId,
    Expression<String>? vehicleKind,
    Expression<String>? plateNumber,
    Expression<String>? vinRangka,
    Expression<String>? engineNumber,
    Expression<int>? manufactureYear,
    Expression<String>? fuelType,
    Expression<int>? currentOdometerKm,
    Expression<DateTime>? stnkAnnualDueAt,
    Expression<DateTime>? stnk5yrDueAt,
    Expression<DateTime>? insuranceDueAt,
    Expression<String>? insuranceProvider,
    Expression<String>? bpkbNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (itemId != null) 'item_id': itemId,
      if (householdId != null) 'household_id': householdId,
      if (vehicleKind != null) 'vehicle_kind': vehicleKind,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (vinRangka != null) 'vin_rangka': vinRangka,
      if (engineNumber != null) 'engine_number': engineNumber,
      if (manufactureYear != null) 'manufacture_year': manufactureYear,
      if (fuelType != null) 'fuel_type': fuelType,
      if (currentOdometerKm != null) 'current_odometer_km': currentOdometerKm,
      if (stnkAnnualDueAt != null) 'stnk_annual_due_at': stnkAnnualDueAt,
      if (stnk5yrDueAt != null) 'stnk5yr_due_at': stnk5yrDueAt,
      if (insuranceDueAt != null) 'insurance_due_at': insuranceDueAt,
      if (insuranceProvider != null) 'insurance_provider': insuranceProvider,
      if (bpkbNumber != null) 'bpkb_number': bpkbNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? itemId,
    Value<String>? householdId,
    Value<String>? vehicleKind,
    Value<String?>? plateNumber,
    Value<String?>? vinRangka,
    Value<String?>? engineNumber,
    Value<int?>? manufactureYear,
    Value<String?>? fuelType,
    Value<int>? currentOdometerKm,
    Value<DateTime?>? stnkAnnualDueAt,
    Value<DateTime?>? stnk5yrDueAt,
    Value<DateTime?>? insuranceDueAt,
    Value<String?>? insuranceProvider,
    Value<String?>? bpkbNumber,
    Value<int>? rowid,
  }) {
    return VehiclesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      itemId: itemId ?? this.itemId,
      householdId: householdId ?? this.householdId,
      vehicleKind: vehicleKind ?? this.vehicleKind,
      plateNumber: plateNumber ?? this.plateNumber,
      vinRangka: vinRangka ?? this.vinRangka,
      engineNumber: engineNumber ?? this.engineNumber,
      manufactureYear: manufactureYear ?? this.manufactureYear,
      fuelType: fuelType ?? this.fuelType,
      currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
      stnkAnnualDueAt: stnkAnnualDueAt ?? this.stnkAnnualDueAt,
      stnk5yrDueAt: stnk5yrDueAt ?? this.stnk5yrDueAt,
      insuranceDueAt: insuranceDueAt ?? this.insuranceDueAt,
      insuranceProvider: insuranceProvider ?? this.insuranceProvider,
      bpkbNumber: bpkbNumber ?? this.bpkbNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (vehicleKind.present) {
      map['vehicle_kind'] = Variable<String>(vehicleKind.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (vinRangka.present) {
      map['vin_rangka'] = Variable<String>(vinRangka.value);
    }
    if (engineNumber.present) {
      map['engine_number'] = Variable<String>(engineNumber.value);
    }
    if (manufactureYear.present) {
      map['manufacture_year'] = Variable<int>(manufactureYear.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (currentOdometerKm.present) {
      map['current_odometer_km'] = Variable<int>(currentOdometerKm.value);
    }
    if (stnkAnnualDueAt.present) {
      map['stnk_annual_due_at'] = Variable<DateTime>(stnkAnnualDueAt.value);
    }
    if (stnk5yrDueAt.present) {
      map['stnk5yr_due_at'] = Variable<DateTime>(stnk5yrDueAt.value);
    }
    if (insuranceDueAt.present) {
      map['insurance_due_at'] = Variable<DateTime>(insuranceDueAt.value);
    }
    if (insuranceProvider.present) {
      map['insurance_provider'] = Variable<String>(insuranceProvider.value);
    }
    if (bpkbNumber.present) {
      map['bpkb_number'] = Variable<String>(bpkbNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('itemId: $itemId, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleKind: $vehicleKind, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('vinRangka: $vinRangka, ')
          ..write('engineNumber: $engineNumber, ')
          ..write('manufactureYear: $manufactureYear, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('stnkAnnualDueAt: $stnkAnnualDueAt, ')
          ..write('stnk5yrDueAt: $stnk5yrDueAt, ')
          ..write('insuranceDueAt: $insuranceDueAt, ')
          ..write('insuranceProvider: $insuranceProvider, ')
          ..write('bpkbNumber: $bpkbNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehicleServiceLogsTable extends VehicleServiceLogs
    with TableInfo<$VehicleServiceLogsTable, VehicleServiceLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleServiceLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (item_id)',
    ),
  );
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
    'service_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
    'odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workshopNameMeta = const VerificationMeta(
    'workshopName',
  );
  @override
  late final GeneratedColumn<String> workshopName = GeneratedColumn<String>(
    'workshop_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueOdometerKmMeta = const VerificationMeta(
    'nextDueOdometerKm',
  );
  @override
  late final GeneratedColumn<int> nextDueOdometerKm = GeneratedColumn<int>(
    'next_due_odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    vehicleId,
    serviceDate,
    odometerKm,
    serviceType,
    workshopName,
    totalCost,
    nextDueDate,
    nextDueOdometerKm,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_service_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleServiceLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('workshop_name')) {
      context.handle(
        _workshopNameMeta,
        workshopName.isAcceptableOrUnknown(
          data['workshop_name']!,
          _workshopNameMeta,
        ),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('next_due_odometer_km')) {
      context.handle(
        _nextDueOdometerKmMeta,
        nextDueOdometerKm.isAcceptableOrUnknown(
          data['next_due_odometer_km']!,
          _nextDueOdometerKmMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleServiceLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleServiceLog(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}service_date'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_km'],
      ),
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      workshopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workshop_name'],
      ),
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      nextDueOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_odometer_km'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $VehicleServiceLogsTable createAlias(String alias) {
    return $VehicleServiceLogsTable(attachedDatabase, alias);
  }
}

class VehicleServiceLog extends DataClass
    implements Insertable<VehicleServiceLog> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String vehicleId;
  final DateTime serviceDate;
  final int? odometerKm;
  final String serviceType;
  final String? workshopName;
  final double totalCost;
  final DateTime? nextDueDate;
  final int? nextDueOdometerKm;
  final String? notes;
  const VehicleServiceLog({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.vehicleId,
    required this.serviceDate,
    this.odometerKm,
    required this.serviceType,
    this.workshopName,
    required this.totalCost,
    this.nextDueDate,
    this.nextDueOdometerKm,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['service_date'] = Variable<DateTime>(serviceDate);
    if (!nullToAbsent || odometerKm != null) {
      map['odometer_km'] = Variable<int>(odometerKm);
    }
    map['service_type'] = Variable<String>(serviceType);
    if (!nullToAbsent || workshopName != null) {
      map['workshop_name'] = Variable<String>(workshopName);
    }
    map['total_cost'] = Variable<double>(totalCost);
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || nextDueOdometerKm != null) {
      map['next_due_odometer_km'] = Variable<int>(nextDueOdometerKm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  VehicleServiceLogsCompanion toCompanion(bool nullToAbsent) {
    return VehicleServiceLogsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      vehicleId: Value(vehicleId),
      serviceDate: Value(serviceDate),
      odometerKm: odometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerKm),
      serviceType: Value(serviceType),
      workshopName: workshopName == null && nullToAbsent
          ? const Value.absent()
          : Value(workshopName),
      totalCost: Value(totalCost),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      nextDueOdometerKm: nextDueOdometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueOdometerKm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory VehicleServiceLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleServiceLog(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      odometerKm: serializer.fromJson<int?>(json['odometerKm']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      workshopName: serializer.fromJson<String?>(json['workshopName']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      nextDueOdometerKm: serializer.fromJson<int?>(json['nextDueOdometerKm']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'odometerKm': serializer.toJson<int?>(odometerKm),
      'serviceType': serializer.toJson<String>(serviceType),
      'workshopName': serializer.toJson<String?>(workshopName),
      'totalCost': serializer.toJson<double>(totalCost),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'nextDueOdometerKm': serializer.toJson<int?>(nextDueOdometerKm),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  VehicleServiceLog copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? vehicleId,
    DateTime? serviceDate,
    Value<int?> odometerKm = const Value.absent(),
    String? serviceType,
    Value<String?> workshopName = const Value.absent(),
    double? totalCost,
    Value<DateTime?> nextDueDate = const Value.absent(),
    Value<int?> nextDueOdometerKm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => VehicleServiceLog(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    vehicleId: vehicleId ?? this.vehicleId,
    serviceDate: serviceDate ?? this.serviceDate,
    odometerKm: odometerKm.present ? odometerKm.value : this.odometerKm,
    serviceType: serviceType ?? this.serviceType,
    workshopName: workshopName.present ? workshopName.value : this.workshopName,
    totalCost: totalCost ?? this.totalCost,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    nextDueOdometerKm: nextDueOdometerKm.present
        ? nextDueOdometerKm.value
        : this.nextDueOdometerKm,
    notes: notes.present ? notes.value : this.notes,
  );
  VehicleServiceLog copyWithCompanion(VehicleServiceLogsCompanion data) {
    return VehicleServiceLog(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      workshopName: data.workshopName.present
          ? data.workshopName.value
          : this.workshopName,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      nextDueOdometerKm: data.nextDueOdometerKm.present
          ? data.nextDueOdometerKm.value
          : this.nextDueOdometerKm,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleServiceLog(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('serviceType: $serviceType, ')
          ..write('workshopName: $workshopName, ')
          ..write('totalCost: $totalCost, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometerKm: $nextDueOdometerKm, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    vehicleId,
    serviceDate,
    odometerKm,
    serviceType,
    workshopName,
    totalCost,
    nextDueDate,
    nextDueOdometerKm,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleServiceLog &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.vehicleId == this.vehicleId &&
          other.serviceDate == this.serviceDate &&
          other.odometerKm == this.odometerKm &&
          other.serviceType == this.serviceType &&
          other.workshopName == this.workshopName &&
          other.totalCost == this.totalCost &&
          other.nextDueDate == this.nextDueDate &&
          other.nextDueOdometerKm == this.nextDueOdometerKm &&
          other.notes == this.notes);
}

class VehicleServiceLogsCompanion extends UpdateCompanion<VehicleServiceLog> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> vehicleId;
  final Value<DateTime> serviceDate;
  final Value<int?> odometerKm;
  final Value<String> serviceType;
  final Value<String?> workshopName;
  final Value<double> totalCost;
  final Value<DateTime?> nextDueDate;
  final Value<int?> nextDueOdometerKm;
  final Value<String?> notes;
  final Value<int> rowid;
  const VehicleServiceLogsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.workshopName = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometerKm = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleServiceLogsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String vehicleId,
    required DateTime serviceDate,
    this.odometerKm = const Value.absent(),
    required String serviceType,
    this.workshopName = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometerKm = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       vehicleId = Value(vehicleId),
       serviceDate = Value(serviceDate),
       serviceType = Value(serviceType);
  static Insertable<VehicleServiceLog> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? vehicleId,
    Expression<DateTime>? serviceDate,
    Expression<int>? odometerKm,
    Expression<String>? serviceType,
    Expression<String>? workshopName,
    Expression<double>? totalCost,
    Expression<DateTime>? nextDueDate,
    Expression<int>? nextDueOdometerKm,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (serviceDate != null) 'service_date': serviceDate,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (serviceType != null) 'service_type': serviceType,
      if (workshopName != null) 'workshop_name': workshopName,
      if (totalCost != null) 'total_cost': totalCost,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (nextDueOdometerKm != null) 'next_due_odometer_km': nextDueOdometerKm,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleServiceLogsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? vehicleId,
    Value<DateTime>? serviceDate,
    Value<int?>? odometerKm,
    Value<String>? serviceType,
    Value<String?>? workshopName,
    Value<double>? totalCost,
    Value<DateTime?>? nextDueDate,
    Value<int?>? nextDueOdometerKm,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return VehicleServiceLogsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      vehicleId: vehicleId ?? this.vehicleId,
      serviceDate: serviceDate ?? this.serviceDate,
      odometerKm: odometerKm ?? this.odometerKm,
      serviceType: serviceType ?? this.serviceType,
      workshopName: workshopName ?? this.workshopName,
      totalCost: totalCost ?? this.totalCost,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      nextDueOdometerKm: nextDueOdometerKm ?? this.nextDueOdometerKm,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (workshopName.present) {
      map['workshop_name'] = Variable<String>(workshopName.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (nextDueOdometerKm.present) {
      map['next_due_odometer_km'] = Variable<int>(nextDueOdometerKm.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleServiceLogsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('serviceType: $serviceType, ')
          ..write('workshopName: $workshopName, ')
          ..write('totalCost: $totalCost, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometerKm: $nextDueOdometerKm, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehicleFuelLogsTable extends VehicleFuelLogs
    with TableInfo<$VehicleFuelLogsTable, VehicleFuelLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleFuelLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (item_id)',
    ),
  );
  static const VerificationMeta _filledAtMeta = const VerificationMeta(
    'filledAt',
  );
  @override
  late final GeneratedColumn<DateTime> filledAt = GeneratedColumn<DateTime>(
    'filled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerLiterMeta = const VerificationMeta(
    'pricePerLiter',
  );
  @override
  late final GeneratedColumn<double> pricePerLiter = GeneratedColumn<double>(
    'price_per_liter',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFullTankMeta = const VerificationMeta(
    'isFullTank',
  );
  @override
  late final GeneratedColumn<bool> isFullTank = GeneratedColumn<bool>(
    'is_full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _computedKmPerLiterMeta =
      const VerificationMeta('computedKmPerLiter');
  @override
  late final GeneratedColumn<double> computedKmPerLiter =
      GeneratedColumn<double>(
        'computed_km_per_liter',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    vehicleId,
    filledAt,
    odometerKm,
    liters,
    pricePerLiter,
    totalCost,
    isFullTank,
    computedKmPerLiter,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_fuel_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleFuelLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('filled_at')) {
      context.handle(
        _filledAtMeta,
        filledAt.isAcceptableOrUnknown(data['filled_at']!, _filledAtMeta),
      );
    } else if (isInserting) {
      context.missing(_filledAtMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('price_per_liter')) {
      context.handle(
        _pricePerLiterMeta,
        pricePerLiter.isAcceptableOrUnknown(
          data['price_per_liter']!,
          _pricePerLiterMeta,
        ),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('is_full_tank')) {
      context.handle(
        _isFullTankMeta,
        isFullTank.isAcceptableOrUnknown(
          data['is_full_tank']!,
          _isFullTankMeta,
        ),
      );
    }
    if (data.containsKey('computed_km_per_liter')) {
      context.handle(
        _computedKmPerLiterMeta,
        computedKmPerLiter.isAcceptableOrUnknown(
          data['computed_km_per_liter']!,
          _computedKmPerLiterMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleFuelLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleFuelLog(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      filledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}filled_at'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_km'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      )!,
      pricePerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_liter'],
      ),
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      isFullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_tank'],
      )!,
      computedKmPerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}computed_km_per_liter'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $VehicleFuelLogsTable createAlias(String alias) {
    return $VehicleFuelLogsTable(attachedDatabase, alias);
  }
}

class VehicleFuelLog extends DataClass implements Insertable<VehicleFuelLog> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String vehicleId;
  final DateTime filledAt;
  final int odometerKm;
  final double liters;
  final double? pricePerLiter;
  final double totalCost;
  final bool isFullTank;
  final double? computedKmPerLiter;
  final String? notes;
  const VehicleFuelLog({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.vehicleId,
    required this.filledAt,
    required this.odometerKm,
    required this.liters,
    this.pricePerLiter,
    required this.totalCost,
    required this.isFullTank,
    this.computedKmPerLiter,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['filled_at'] = Variable<DateTime>(filledAt);
    map['odometer_km'] = Variable<int>(odometerKm);
    map['liters'] = Variable<double>(liters);
    if (!nullToAbsent || pricePerLiter != null) {
      map['price_per_liter'] = Variable<double>(pricePerLiter);
    }
    map['total_cost'] = Variable<double>(totalCost);
    map['is_full_tank'] = Variable<bool>(isFullTank);
    if (!nullToAbsent || computedKmPerLiter != null) {
      map['computed_km_per_liter'] = Variable<double>(computedKmPerLiter);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  VehicleFuelLogsCompanion toCompanion(bool nullToAbsent) {
    return VehicleFuelLogsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      vehicleId: Value(vehicleId),
      filledAt: Value(filledAt),
      odometerKm: Value(odometerKm),
      liters: Value(liters),
      pricePerLiter: pricePerLiter == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerLiter),
      totalCost: Value(totalCost),
      isFullTank: Value(isFullTank),
      computedKmPerLiter: computedKmPerLiter == null && nullToAbsent
          ? const Value.absent()
          : Value(computedKmPerLiter),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory VehicleFuelLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleFuelLog(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      filledAt: serializer.fromJson<DateTime>(json['filledAt']),
      odometerKm: serializer.fromJson<int>(json['odometerKm']),
      liters: serializer.fromJson<double>(json['liters']),
      pricePerLiter: serializer.fromJson<double?>(json['pricePerLiter']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      isFullTank: serializer.fromJson<bool>(json['isFullTank']),
      computedKmPerLiter: serializer.fromJson<double?>(
        json['computedKmPerLiter'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'filledAt': serializer.toJson<DateTime>(filledAt),
      'odometerKm': serializer.toJson<int>(odometerKm),
      'liters': serializer.toJson<double>(liters),
      'pricePerLiter': serializer.toJson<double?>(pricePerLiter),
      'totalCost': serializer.toJson<double>(totalCost),
      'isFullTank': serializer.toJson<bool>(isFullTank),
      'computedKmPerLiter': serializer.toJson<double?>(computedKmPerLiter),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  VehicleFuelLog copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? vehicleId,
    DateTime? filledAt,
    int? odometerKm,
    double? liters,
    Value<double?> pricePerLiter = const Value.absent(),
    double? totalCost,
    bool? isFullTank,
    Value<double?> computedKmPerLiter = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => VehicleFuelLog(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    vehicleId: vehicleId ?? this.vehicleId,
    filledAt: filledAt ?? this.filledAt,
    odometerKm: odometerKm ?? this.odometerKm,
    liters: liters ?? this.liters,
    pricePerLiter: pricePerLiter.present
        ? pricePerLiter.value
        : this.pricePerLiter,
    totalCost: totalCost ?? this.totalCost,
    isFullTank: isFullTank ?? this.isFullTank,
    computedKmPerLiter: computedKmPerLiter.present
        ? computedKmPerLiter.value
        : this.computedKmPerLiter,
    notes: notes.present ? notes.value : this.notes,
  );
  VehicleFuelLog copyWithCompanion(VehicleFuelLogsCompanion data) {
    return VehicleFuelLog(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      filledAt: data.filledAt.present ? data.filledAt.value : this.filledAt,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      liters: data.liters.present ? data.liters.value : this.liters,
      pricePerLiter: data.pricePerLiter.present
          ? data.pricePerLiter.value
          : this.pricePerLiter,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      isFullTank: data.isFullTank.present
          ? data.isFullTank.value
          : this.isFullTank,
      computedKmPerLiter: data.computedKmPerLiter.present
          ? data.computedKmPerLiter.value
          : this.computedKmPerLiter,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleFuelLog(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('filledAt: $filledAt, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('liters: $liters, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('computedKmPerLiter: $computedKmPerLiter, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    vehicleId,
    filledAt,
    odometerKm,
    liters,
    pricePerLiter,
    totalCost,
    isFullTank,
    computedKmPerLiter,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleFuelLog &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.vehicleId == this.vehicleId &&
          other.filledAt == this.filledAt &&
          other.odometerKm == this.odometerKm &&
          other.liters == this.liters &&
          other.pricePerLiter == this.pricePerLiter &&
          other.totalCost == this.totalCost &&
          other.isFullTank == this.isFullTank &&
          other.computedKmPerLiter == this.computedKmPerLiter &&
          other.notes == this.notes);
}

class VehicleFuelLogsCompanion extends UpdateCompanion<VehicleFuelLog> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> vehicleId;
  final Value<DateTime> filledAt;
  final Value<int> odometerKm;
  final Value<double> liters;
  final Value<double?> pricePerLiter;
  final Value<double> totalCost;
  final Value<bool> isFullTank;
  final Value<double?> computedKmPerLiter;
  final Value<String?> notes;
  final Value<int> rowid;
  const VehicleFuelLogsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.filledAt = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.liters = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.computedKmPerLiter = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleFuelLogsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String vehicleId,
    required DateTime filledAt,
    required int odometerKm,
    required double liters,
    this.pricePerLiter = const Value.absent(),
    required double totalCost,
    this.isFullTank = const Value.absent(),
    this.computedKmPerLiter = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       vehicleId = Value(vehicleId),
       filledAt = Value(filledAt),
       odometerKm = Value(odometerKm),
       liters = Value(liters),
       totalCost = Value(totalCost);
  static Insertable<VehicleFuelLog> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? vehicleId,
    Expression<DateTime>? filledAt,
    Expression<int>? odometerKm,
    Expression<double>? liters,
    Expression<double>? pricePerLiter,
    Expression<double>? totalCost,
    Expression<bool>? isFullTank,
    Expression<double>? computedKmPerLiter,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (filledAt != null) 'filled_at': filledAt,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (liters != null) 'liters': liters,
      if (pricePerLiter != null) 'price_per_liter': pricePerLiter,
      if (totalCost != null) 'total_cost': totalCost,
      if (isFullTank != null) 'is_full_tank': isFullTank,
      if (computedKmPerLiter != null)
        'computed_km_per_liter': computedKmPerLiter,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleFuelLogsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? vehicleId,
    Value<DateTime>? filledAt,
    Value<int>? odometerKm,
    Value<double>? liters,
    Value<double?>? pricePerLiter,
    Value<double>? totalCost,
    Value<bool>? isFullTank,
    Value<double?>? computedKmPerLiter,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return VehicleFuelLogsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      vehicleId: vehicleId ?? this.vehicleId,
      filledAt: filledAt ?? this.filledAt,
      odometerKm: odometerKm ?? this.odometerKm,
      liters: liters ?? this.liters,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      totalCost: totalCost ?? this.totalCost,
      isFullTank: isFullTank ?? this.isFullTank,
      computedKmPerLiter: computedKmPerLiter ?? this.computedKmPerLiter,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (filledAt.present) {
      map['filled_at'] = Variable<DateTime>(filledAt.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (pricePerLiter.present) {
      map['price_per_liter'] = Variable<double>(pricePerLiter.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (isFullTank.present) {
      map['is_full_tank'] = Variable<bool>(isFullTank.value);
    }
    if (computedKmPerLiter.present) {
      map['computed_km_per_liter'] = Variable<double>(computedKmPerLiter.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleFuelLogsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('filledAt: $filledAt, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('liters: $liters, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('computedKmPerLiter: $computedKmPerLiter, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovingProjectsTable extends MovingProjects
    with TableInfo<$MovingProjectsTable, MovingProject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovingProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originAddressMeta = const VerificationMeta(
    'originAddress',
  );
  @override
  late final GeneratedColumn<String> originAddress = GeneratedColumn<String>(
    'origin_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _destinationAddressMeta =
      const VerificationMeta('destinationAddress');
  @override
  late final GeneratedColumn<String> destinationAddress =
      GeneratedColumn<String>(
        'destination_address',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetMoveDateMeta = const VerificationMeta(
    'targetMoveDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetMoveDate =
      GeneratedColumn<DateTime>(
        'target_move_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planning'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    name,
    originAddress,
    destinationAddress,
    targetMoveDate,
    status,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moving_projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovingProject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('origin_address')) {
      context.handle(
        _originAddressMeta,
        originAddress.isAcceptableOrUnknown(
          data['origin_address']!,
          _originAddressMeta,
        ),
      );
    }
    if (data.containsKey('destination_address')) {
      context.handle(
        _destinationAddressMeta,
        destinationAddress.isAcceptableOrUnknown(
          data['destination_address']!,
          _destinationAddressMeta,
        ),
      );
    }
    if (data.containsKey('target_move_date')) {
      context.handle(
        _targetMoveDateMeta,
        targetMoveDate.isAcceptableOrUnknown(
          data['target_move_date']!,
          _targetMoveDateMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovingProject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovingProject(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      originAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_address'],
      ),
      destinationAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_address'],
      ),
      targetMoveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_move_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MovingProjectsTable createAlias(String alias) {
    return $MovingProjectsTable(attachedDatabase, alias);
  }
}

class MovingProject extends DataClass implements Insertable<MovingProject> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String name;
  final String? originAddress;
  final String? destinationAddress;
  final DateTime? targetMoveDate;
  final String status;
  final String? notes;
  const MovingProject({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.name,
    this.originAddress,
    this.destinationAddress,
    this.targetMoveDate,
    required this.status,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || originAddress != null) {
      map['origin_address'] = Variable<String>(originAddress);
    }
    if (!nullToAbsent || destinationAddress != null) {
      map['destination_address'] = Variable<String>(destinationAddress);
    }
    if (!nullToAbsent || targetMoveDate != null) {
      map['target_move_date'] = Variable<DateTime>(targetMoveDate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MovingProjectsCompanion toCompanion(bool nullToAbsent) {
    return MovingProjectsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      name: Value(name),
      originAddress: originAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(originAddress),
      destinationAddress: destinationAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationAddress),
      targetMoveDate: targetMoveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetMoveDate),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MovingProject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovingProject(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      originAddress: serializer.fromJson<String?>(json['originAddress']),
      destinationAddress: serializer.fromJson<String?>(
        json['destinationAddress'],
      ),
      targetMoveDate: serializer.fromJson<DateTime?>(json['targetMoveDate']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'name': serializer.toJson<String>(name),
      'originAddress': serializer.toJson<String?>(originAddress),
      'destinationAddress': serializer.toJson<String?>(destinationAddress),
      'targetMoveDate': serializer.toJson<DateTime?>(targetMoveDate),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MovingProject copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? name,
    Value<String?> originAddress = const Value.absent(),
    Value<String?> destinationAddress = const Value.absent(),
    Value<DateTime?> targetMoveDate = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
  }) => MovingProject(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    name: name ?? this.name,
    originAddress: originAddress.present
        ? originAddress.value
        : this.originAddress,
    destinationAddress: destinationAddress.present
        ? destinationAddress.value
        : this.destinationAddress,
    targetMoveDate: targetMoveDate.present
        ? targetMoveDate.value
        : this.targetMoveDate,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
  );
  MovingProject copyWithCompanion(MovingProjectsCompanion data) {
    return MovingProject(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      originAddress: data.originAddress.present
          ? data.originAddress.value
          : this.originAddress,
      destinationAddress: data.destinationAddress.present
          ? data.destinationAddress.value
          : this.destinationAddress,
      targetMoveDate: data.targetMoveDate.present
          ? data.targetMoveDate.value
          : this.targetMoveDate,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovingProject(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('originAddress: $originAddress, ')
          ..write('destinationAddress: $destinationAddress, ')
          ..write('targetMoveDate: $targetMoveDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    name,
    originAddress,
    destinationAddress,
    targetMoveDate,
    status,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovingProject &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.originAddress == this.originAddress &&
          other.destinationAddress == this.destinationAddress &&
          other.targetMoveDate == this.targetMoveDate &&
          other.status == this.status &&
          other.notes == this.notes);
}

class MovingProjectsCompanion extends UpdateCompanion<MovingProject> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> name;
  final Value<String?> originAddress;
  final Value<String?> destinationAddress;
  final Value<DateTime?> targetMoveDate;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> rowid;
  const MovingProjectsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.originAddress = const Value.absent(),
    this.destinationAddress = const Value.absent(),
    this.targetMoveDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovingProjectsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String name,
    this.originAddress = const Value.absent(),
    this.destinationAddress = const Value.absent(),
    this.targetMoveDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       name = Value(name);
  static Insertable<MovingProject> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<String>? originAddress,
    Expression<String>? destinationAddress,
    Expression<DateTime>? targetMoveDate,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (originAddress != null) 'origin_address': originAddress,
      if (destinationAddress != null) 'destination_address': destinationAddress,
      if (targetMoveDate != null) 'target_move_date': targetMoveDate,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovingProjectsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? name,
    Value<String?>? originAddress,
    Value<String?>? destinationAddress,
    Value<DateTime?>? targetMoveDate,
    Value<String>? status,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return MovingProjectsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      originAddress: originAddress ?? this.originAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      targetMoveDate: targetMoveDate ?? this.targetMoveDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (originAddress.present) {
      map['origin_address'] = Variable<String>(originAddress.value);
    }
    if (destinationAddress.present) {
      map['destination_address'] = Variable<String>(destinationAddress.value);
    }
    if (targetMoveDate.present) {
      map['target_move_date'] = Variable<DateTime>(targetMoveDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovingProjectsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('originAddress: $originAddress, ')
          ..write('destinationAddress: $destinationAddress, ')
          ..write('targetMoveDate: $targetMoveDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovingBoxesTable extends MovingBoxes
    with TableInfo<$MovingBoxesTable, MovingBox> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovingBoxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES moving_projects (id)',
    ),
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES locations (id)',
    ),
  );
  static const VerificationMeta _boxCodeMeta = const VerificationMeta(
    'boxCode',
  );
  @override
  late final GeneratedColumn<String> boxCode = GeneratedColumn<String>(
    'box_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelQrMeta = const VerificationMeta(
    'labelQr',
  );
  @override
  late final GeneratedColumn<String> labelQr = GeneratedColumn<String>(
    'label_qr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationRoomMeta = const VerificationMeta(
    'destinationRoom',
  );
  @override
  late final GeneratedColumn<String> destinationRoom = GeneratedColumn<String>(
    'destination_room',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('packing'),
  );
  static const VerificationMeta _isFragileMeta = const VerificationMeta(
    'isFragile',
  );
  @override
  late final GeneratedColumn<bool> isFragile = GeneratedColumn<bool>(
    'is_fragile',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fragile" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    projectId,
    locationId,
    boxCode,
    labelQr,
    destinationRoom,
    status,
    isFragile,
    priority,
    weightKg,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moving_boxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovingBox> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('box_code')) {
      context.handle(
        _boxCodeMeta,
        boxCode.isAcceptableOrUnknown(data['box_code']!, _boxCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_boxCodeMeta);
    }
    if (data.containsKey('label_qr')) {
      context.handle(
        _labelQrMeta,
        labelQr.isAcceptableOrUnknown(data['label_qr']!, _labelQrMeta),
      );
    } else if (isInserting) {
      context.missing(_labelQrMeta);
    }
    if (data.containsKey('destination_room')) {
      context.handle(
        _destinationRoomMeta,
        destinationRoom.isAcceptableOrUnknown(
          data['destination_room']!,
          _destinationRoomMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_fragile')) {
      context.handle(
        _isFragileMeta,
        isFragile.isAcceptableOrUnknown(data['is_fragile']!, _isFragileMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovingBox map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovingBox(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      boxCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}box_code'],
      )!,
      labelQr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_qr'],
      )!,
      destinationRoom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_room'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isFragile: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fragile'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MovingBoxesTable createAlias(String alias) {
    return $MovingBoxesTable(attachedDatabase, alias);
  }
}

class MovingBox extends DataClass implements Insertable<MovingBox> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String projectId;
  final String locationId;
  final String boxCode;
  final String labelQr;
  final String? destinationRoom;
  final String status;
  final bool isFragile;
  final String priority;
  final double? weightKg;
  final String? notes;
  const MovingBox({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    required this.projectId,
    required this.locationId,
    required this.boxCode,
    required this.labelQr,
    this.destinationRoom,
    required this.status,
    required this.isFragile,
    required this.priority,
    this.weightKg,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['project_id'] = Variable<String>(projectId);
    map['location_id'] = Variable<String>(locationId);
    map['box_code'] = Variable<String>(boxCode);
    map['label_qr'] = Variable<String>(labelQr);
    if (!nullToAbsent || destinationRoom != null) {
      map['destination_room'] = Variable<String>(destinationRoom);
    }
    map['status'] = Variable<String>(status);
    map['is_fragile'] = Variable<bool>(isFragile);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MovingBoxesCompanion toCompanion(bool nullToAbsent) {
    return MovingBoxesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      projectId: Value(projectId),
      locationId: Value(locationId),
      boxCode: Value(boxCode),
      labelQr: Value(labelQr),
      destinationRoom: destinationRoom == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationRoom),
      status: Value(status),
      isFragile: Value(isFragile),
      priority: Value(priority),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MovingBox.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovingBox(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      projectId: serializer.fromJson<String>(json['projectId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      boxCode: serializer.fromJson<String>(json['boxCode']),
      labelQr: serializer.fromJson<String>(json['labelQr']),
      destinationRoom: serializer.fromJson<String?>(json['destinationRoom']),
      status: serializer.fromJson<String>(json['status']),
      isFragile: serializer.fromJson<bool>(json['isFragile']),
      priority: serializer.fromJson<String>(json['priority']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'projectId': serializer.toJson<String>(projectId),
      'locationId': serializer.toJson<String>(locationId),
      'boxCode': serializer.toJson<String>(boxCode),
      'labelQr': serializer.toJson<String>(labelQr),
      'destinationRoom': serializer.toJson<String?>(destinationRoom),
      'status': serializer.toJson<String>(status),
      'isFragile': serializer.toJson<bool>(isFragile),
      'priority': serializer.toJson<String>(priority),
      'weightKg': serializer.toJson<double?>(weightKg),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MovingBox copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    String? projectId,
    String? locationId,
    String? boxCode,
    String? labelQr,
    Value<String?> destinationRoom = const Value.absent(),
    String? status,
    bool? isFragile,
    String? priority,
    Value<double?> weightKg = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => MovingBox(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    projectId: projectId ?? this.projectId,
    locationId: locationId ?? this.locationId,
    boxCode: boxCode ?? this.boxCode,
    labelQr: labelQr ?? this.labelQr,
    destinationRoom: destinationRoom.present
        ? destinationRoom.value
        : this.destinationRoom,
    status: status ?? this.status,
    isFragile: isFragile ?? this.isFragile,
    priority: priority ?? this.priority,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    notes: notes.present ? notes.value : this.notes,
  );
  MovingBox copyWithCompanion(MovingBoxesCompanion data) {
    return MovingBox(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      boxCode: data.boxCode.present ? data.boxCode.value : this.boxCode,
      labelQr: data.labelQr.present ? data.labelQr.value : this.labelQr,
      destinationRoom: data.destinationRoom.present
          ? data.destinationRoom.value
          : this.destinationRoom,
      status: data.status.present ? data.status.value : this.status,
      isFragile: data.isFragile.present ? data.isFragile.value : this.isFragile,
      priority: data.priority.present ? data.priority.value : this.priority,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovingBox(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('projectId: $projectId, ')
          ..write('locationId: $locationId, ')
          ..write('boxCode: $boxCode, ')
          ..write('labelQr: $labelQr, ')
          ..write('destinationRoom: $destinationRoom, ')
          ..write('status: $status, ')
          ..write('isFragile: $isFragile, ')
          ..write('priority: $priority, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    projectId,
    locationId,
    boxCode,
    labelQr,
    destinationRoom,
    status,
    isFragile,
    priority,
    weightKg,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovingBox &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.projectId == this.projectId &&
          other.locationId == this.locationId &&
          other.boxCode == this.boxCode &&
          other.labelQr == this.labelQr &&
          other.destinationRoom == this.destinationRoom &&
          other.status == this.status &&
          other.isFragile == this.isFragile &&
          other.priority == this.priority &&
          other.weightKg == this.weightKg &&
          other.notes == this.notes);
}

class MovingBoxesCompanion extends UpdateCompanion<MovingBox> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String> projectId;
  final Value<String> locationId;
  final Value<String> boxCode;
  final Value<String> labelQr;
  final Value<String?> destinationRoom;
  final Value<String> status;
  final Value<bool> isFragile;
  final Value<String> priority;
  final Value<double?> weightKg;
  final Value<String?> notes;
  final Value<int> rowid;
  const MovingBoxesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.boxCode = const Value.absent(),
    this.labelQr = const Value.absent(),
    this.destinationRoom = const Value.absent(),
    this.status = const Value.absent(),
    this.isFragile = const Value.absent(),
    this.priority = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovingBoxesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    required String projectId,
    required String locationId,
    required String boxCode,
    required String labelQr,
    this.destinationRoom = const Value.absent(),
    this.status = const Value.absent(),
    this.isFragile = const Value.absent(),
    this.priority = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       projectId = Value(projectId),
       locationId = Value(locationId),
       boxCode = Value(boxCode),
       labelQr = Value(labelQr);
  static Insertable<MovingBox> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? projectId,
    Expression<String>? locationId,
    Expression<String>? boxCode,
    Expression<String>? labelQr,
    Expression<String>? destinationRoom,
    Expression<String>? status,
    Expression<bool>? isFragile,
    Expression<String>? priority,
    Expression<double>? weightKg,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (projectId != null) 'project_id': projectId,
      if (locationId != null) 'location_id': locationId,
      if (boxCode != null) 'box_code': boxCode,
      if (labelQr != null) 'label_qr': labelQr,
      if (destinationRoom != null) 'destination_room': destinationRoom,
      if (status != null) 'status': status,
      if (isFragile != null) 'is_fragile': isFragile,
      if (priority != null) 'priority': priority,
      if (weightKg != null) 'weight_kg': weightKg,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovingBoxesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String>? projectId,
    Value<String>? locationId,
    Value<String>? boxCode,
    Value<String>? labelQr,
    Value<String?>? destinationRoom,
    Value<String>? status,
    Value<bool>? isFragile,
    Value<String>? priority,
    Value<double?>? weightKg,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return MovingBoxesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      projectId: projectId ?? this.projectId,
      locationId: locationId ?? this.locationId,
      boxCode: boxCode ?? this.boxCode,
      labelQr: labelQr ?? this.labelQr,
      destinationRoom: destinationRoom ?? this.destinationRoom,
      status: status ?? this.status,
      isFragile: isFragile ?? this.isFragile,
      priority: priority ?? this.priority,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (boxCode.present) {
      map['box_code'] = Variable<String>(boxCode.value);
    }
    if (labelQr.present) {
      map['label_qr'] = Variable<String>(labelQr.value);
    }
    if (destinationRoom.present) {
      map['destination_room'] = Variable<String>(destinationRoom.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isFragile.present) {
      map['is_fragile'] = Variable<bool>(isFragile.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovingBoxesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('projectId: $projectId, ')
          ..write('locationId: $locationId, ')
          ..write('boxCode: $boxCode, ')
          ..write('labelQr: $labelQr, ')
          ..write('destinationRoom: $destinationRoom, ')
          ..write('status: $status, ')
          ..write('isFragile: $isFragile, ')
          ..write('priority: $priority, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES households (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueOdometerKmMeta = const VerificationMeta(
    'dueOdometerKm',
  );
  @override
  late final GeneratedColumn<int> dueOdometerKm = GeneratedColumn<int>(
    'due_odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindDaysBeforeMeta = const VerificationMeta(
    'remindDaysBefore',
  );
  @override
  late final GeneratedColumn<int> remindDaysBefore = GeneratedColumn<int>(
    'remind_days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    kind,
    title,
    dueAt,
    dueOdometerKm,
    remindDaysBefore,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('due_odometer_km')) {
      context.handle(
        _dueOdometerKmMeta,
        dueOdometerKm.isAcceptableOrUnknown(
          data['due_odometer_km']!,
          _dueOdometerKmMeta,
        ),
      );
    }
    if (data.containsKey('remind_days_before')) {
      context.handle(
        _remindDaysBeforeMeta,
        remindDaysBefore.isAcceptableOrUnknown(
          data['remind_days_before']!,
          _remindDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      dueOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_odometer_km'],
      ),
      remindDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_days_before'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String householdId;
  final String? itemId;
  final String kind;
  final String title;
  final DateTime? dueAt;
  final int? dueOdometerKm;
  final int remindDaysBefore;
  final bool isCompleted;
  final DateTime? completedAt;
  const Reminder({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.householdId,
    this.itemId,
    required this.kind,
    required this.title,
    this.dueAt,
    this.dueOdometerKm,
    required this.remindDaysBefore,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<String>(itemId);
    }
    map['kind'] = Variable<String>(kind);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || dueOdometerKm != null) {
      map['due_odometer_km'] = Variable<int>(dueOdometerKm);
    }
    map['remind_days_before'] = Variable<int>(remindDaysBefore);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      householdId: Value(householdId),
      itemId: itemId == null && nullToAbsent
          ? const Value.absent()
          : Value(itemId),
      kind: Value(kind),
      title: Value(title),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      dueOdometerKm: dueOdometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(dueOdometerKm),
      remindDaysBefore: Value(remindDaysBefore),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      itemId: serializer.fromJson<String?>(json['itemId']),
      kind: serializer.fromJson<String>(json['kind']),
      title: serializer.fromJson<String>(json['title']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      dueOdometerKm: serializer.fromJson<int?>(json['dueOdometerKm']),
      remindDaysBefore: serializer.fromJson<int>(json['remindDaysBefore']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'itemId': serializer.toJson<String?>(itemId),
      'kind': serializer.toJson<String>(kind),
      'title': serializer.toJson<String>(title),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'dueOdometerKm': serializer.toJson<int?>(dueOdometerKm),
      'remindDaysBefore': serializer.toJson<int>(remindDaysBefore),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Reminder copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? householdId,
    Value<String?> itemId = const Value.absent(),
    String? kind,
    String? title,
    Value<DateTime?> dueAt = const Value.absent(),
    Value<int?> dueOdometerKm = const Value.absent(),
    int? remindDaysBefore,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => Reminder(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    itemId: itemId.present ? itemId.value : this.itemId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    dueOdometerKm: dueOdometerKm.present
        ? dueOdometerKm.value
        : this.dueOdometerKm,
    remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      dueOdometerKm: data.dueOdometerKm.present
          ? data.dueOdometerKm.value
          : this.dueOdometerKm,
      remindDaysBefore: data.remindDaysBefore.present
          ? data.remindDaysBefore.value
          : this.remindDaysBefore,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('dueAt: $dueAt, ')
          ..write('dueOdometerKm: $dueOdometerKm, ')
          ..write('remindDaysBefore: $remindDaysBefore, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    householdId,
    itemId,
    kind,
    title,
    dueAt,
    dueOdometerKm,
    remindDaysBefore,
    isCompleted,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.itemId == this.itemId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.dueAt == this.dueAt &&
          other.dueOdometerKm == this.dueOdometerKm &&
          other.remindDaysBefore == this.remindDaysBefore &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> householdId;
  final Value<String?> itemId;
  final Value<String> kind;
  final Value<String> title;
  final Value<DateTime?> dueAt;
  final Value<int?> dueOdometerKm;
  final Value<int> remindDaysBefore;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.dueOdometerKm = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String householdId,
    this.itemId = const Value.absent(),
    required String kind,
    required String title,
    this.dueAt = const Value.absent(),
    this.dueOdometerKm = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       kind = Value(kind),
       title = Value(title);
  static Insertable<Reminder> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<String>? itemId,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<DateTime>? dueAt,
    Expression<int>? dueOdometerKm,
    Expression<int>? remindDaysBefore,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (itemId != null) 'item_id': itemId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (dueAt != null) 'due_at': dueAt,
      if (dueOdometerKm != null) 'due_odometer_km': dueOdometerKm,
      if (remindDaysBefore != null) 'remind_days_before': remindDaysBefore,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? householdId,
    Value<String?>? itemId,
    Value<String>? kind,
    Value<String>? title,
    Value<DateTime?>? dueAt,
    Value<int?>? dueOdometerKm,
    Value<int>? remindDaysBefore,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      itemId: itemId ?? this.itemId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      dueAt: dueAt ?? this.dueAt,
      dueOdometerKm: dueOdometerKm ?? this.dueOdometerKm,
      remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (dueOdometerKm.present) {
      map['due_odometer_km'] = Variable<int>(dueOdometerKm.value);
    }
    if (remindDaysBefore.present) {
      map['remind_days_before'] = Variable<int>(remindDaysBefore.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('dueAt: $dueAt, ')
          ..write('dueOdometerKm: $dueOdometerKm, ')
          ..write('remindDaysBefore: $remindDaysBefore, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queuedAtMeta = const VerificationMeta(
    'queuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
    'queued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetTable,
    recordId,
    householdId,
    operation,
    payloadJson,
    queuedAt,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('queued_at')) {
      context.handle(
        _queuedAtMeta,
        queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      queuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}queued_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxData extends DataClass implements Insertable<SyncOutboxData> {
  final int id;
  final String targetTable;
  final String recordId;
  final String householdId;
  final String operation;
  final String payloadJson;
  final DateTime queuedAt;
  final int retryCount;
  final String? lastError;
  const SyncOutboxData({
    required this.id,
    required this.targetTable,
    required this.recordId,
    required this.householdId,
    required this.operation,
    required this.payloadJson,
    required this.queuedAt,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['record_id'] = Variable<String>(recordId);
    map['household_id'] = Variable<String>(householdId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['queued_at'] = Variable<DateTime>(queuedAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordId: Value(recordId),
      householdId: Value(householdId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      queuedAt: Value(queuedAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxData(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      householdId: serializer.fromJson<String>(json['householdId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordId': serializer.toJson<String>(recordId),
      'householdId': serializer.toJson<String>(householdId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncOutboxData copyWith({
    int? id,
    String? targetTable,
    String? recordId,
    String? householdId,
    String? operation,
    String? payloadJson,
    DateTime? queuedAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncOutboxData(
    id: id ?? this.id,
    targetTable: targetTable ?? this.targetTable,
    recordId: recordId ?? this.recordId,
    householdId: householdId ?? this.householdId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    queuedAt: queuedAt ?? this.queuedAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncOutboxData copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxData(
      id: data.id.present ? data.id.value : this.id,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('householdId: $householdId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetTable,
    recordId,
    householdId,
    operation,
    payloadJson,
    queuedAt,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordId == this.recordId &&
          other.householdId == this.householdId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.queuedAt == this.queuedAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxData> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> recordId;
  final Value<String> householdId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<DateTime> queuedAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  const SyncOutboxCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String recordId,
    required String householdId,
    required String operation,
    required String payloadJson,
    this.queuedAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : targetTable = Value(targetTable),
       recordId = Value(recordId),
       householdId = Value(householdId),
       operation = Value(operation),
       payloadJson = Value(payloadJson);
  static Insertable<SyncOutboxData> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? recordId,
    Expression<String>? householdId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<DateTime>? queuedAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (recordId != null) 'record_id': recordId,
      if (householdId != null) 'household_id': householdId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (queuedAt != null) 'queued_at': queuedAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<int>? id,
    Value<String>? targetTable,
    Value<String>? recordId,
    Value<String>? householdId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<DateTime>? queuedAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
  }) {
    return SyncOutboxCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordId: recordId ?? this.recordId,
      householdId: householdId ?? this.householdId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      queuedAt: queuedAt ?? this.queuedAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('householdId: $householdId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $SyncCheckpointsTable extends SyncCheckpoints
    with TableInfo<$SyncCheckpointsTable, SyncCheckpoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncCheckpointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPulledAtMeta = const VerificationMeta(
    'lastPulledAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPulledAt = GeneratedColumn<DateTime>(
    'last_pulled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [targetTable, lastPulledAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_checkpoints';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncCheckpoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('last_pulled_at')) {
      context.handle(
        _lastPulledAtMeta,
        lastPulledAt.isAcceptableOrUnknown(
          data['last_pulled_at']!,
          _lastPulledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastPulledAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {targetTable};
  @override
  SyncCheckpoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncCheckpoint(
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      lastPulledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_pulled_at'],
      )!,
    );
  }

  @override
  $SyncCheckpointsTable createAlias(String alias) {
    return $SyncCheckpointsTable(attachedDatabase, alias);
  }
}

class SyncCheckpoint extends DataClass implements Insertable<SyncCheckpoint> {
  final String targetTable;
  final DateTime lastPulledAt;
  const SyncCheckpoint({required this.targetTable, required this.lastPulledAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['target_table'] = Variable<String>(targetTable);
    map['last_pulled_at'] = Variable<DateTime>(lastPulledAt);
    return map;
  }

  SyncCheckpointsCompanion toCompanion(bool nullToAbsent) {
    return SyncCheckpointsCompanion(
      targetTable: Value(targetTable),
      lastPulledAt: Value(lastPulledAt),
    );
  }

  factory SyncCheckpoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncCheckpoint(
      targetTable: serializer.fromJson<String>(json['targetTable']),
      lastPulledAt: serializer.fromJson<DateTime>(json['lastPulledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'targetTable': serializer.toJson<String>(targetTable),
      'lastPulledAt': serializer.toJson<DateTime>(lastPulledAt),
    };
  }

  SyncCheckpoint copyWith({String? targetTable, DateTime? lastPulledAt}) =>
      SyncCheckpoint(
        targetTable: targetTable ?? this.targetTable,
        lastPulledAt: lastPulledAt ?? this.lastPulledAt,
      );
  SyncCheckpoint copyWithCompanion(SyncCheckpointsCompanion data) {
    return SyncCheckpoint(
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      lastPulledAt: data.lastPulledAt.present
          ? data.lastPulledAt.value
          : this.lastPulledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncCheckpoint(')
          ..write('targetTable: $targetTable, ')
          ..write('lastPulledAt: $lastPulledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(targetTable, lastPulledAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncCheckpoint &&
          other.targetTable == this.targetTable &&
          other.lastPulledAt == this.lastPulledAt);
}

class SyncCheckpointsCompanion extends UpdateCompanion<SyncCheckpoint> {
  final Value<String> targetTable;
  final Value<DateTime> lastPulledAt;
  final Value<int> rowid;
  const SyncCheckpointsCompanion({
    this.targetTable = const Value.absent(),
    this.lastPulledAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncCheckpointsCompanion.insert({
    required String targetTable,
    required DateTime lastPulledAt,
    this.rowid = const Value.absent(),
  }) : targetTable = Value(targetTable),
       lastPulledAt = Value(lastPulledAt);
  static Insertable<SyncCheckpoint> custom({
    Expression<String>? targetTable,
    Expression<DateTime>? lastPulledAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (targetTable != null) 'target_table': targetTable,
      if (lastPulledAt != null) 'last_pulled_at': lastPulledAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncCheckpointsCompanion copyWith({
    Value<String>? targetTable,
    Value<DateTime>? lastPulledAt,
    Value<int>? rowid,
  }) {
    return SyncCheckpointsCompanion(
      targetTable: targetTable ?? this.targetTable,
      lastPulledAt: lastPulledAt ?? this.lastPulledAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (lastPulledAt.present) {
      map['last_pulled_at'] = Variable<DateTime>(lastPulledAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncCheckpointsCompanion(')
          ..write('targetTable: $targetTable, ')
          ..write('lastPulledAt: $lastPulledAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HouseholdsTable households = $HouseholdsTable(this);
  late final $HouseholdMembersTable householdMembers = $HouseholdMembersTable(
    this,
  );
  late final $LocationsTable locations = $LocationsTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemAttachmentsTable itemAttachments = $ItemAttachmentsTable(
    this,
  );
  late final $AssetLoansTable assetLoans = $AssetLoansTable(this);
  late final $UsageLogsTable usageLogs = $UsageLogsTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $VehicleServiceLogsTable vehicleServiceLogs =
      $VehicleServiceLogsTable(this);
  late final $VehicleFuelLogsTable vehicleFuelLogs = $VehicleFuelLogsTable(
    this,
  );
  late final $MovingProjectsTable movingProjects = $MovingProjectsTable(this);
  late final $MovingBoxesTable movingBoxes = $MovingBoxesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $SyncCheckpointsTable syncCheckpoints = $SyncCheckpointsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    households,
    householdMembers,
    locations,
    items,
    itemAttachments,
    assetLoans,
    usageLogs,
    books,
    documents,
    vehicles,
    vehicleServiceLogs,
    vehicleFuelLogs,
    movingProjects,
    movingBoxes,
    reminders,
    syncOutbox,
    syncCheckpoints,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$HouseholdsTableCreateCompanionBuilder = HouseholdsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String name,
  required String inviteCode,
  Value<String> currencyCode,
  Value<int> rowid,
});
typedef $$HouseholdsTableUpdateCompanionBuilder = HouseholdsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> name,
  Value<String> inviteCode,
  Value<String> currencyCode,
  Value<int> rowid,
});

final class $$HouseholdsTableReferences
    extends BaseReferences<_$AppDatabase, $HouseholdsTable, Household> {
  $$HouseholdsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HouseholdMembersTable, List<HouseholdMember>>
  _householdMembersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.householdMembers,
    aliasName: 'households__id__household_members__household_id',
  );

  $$HouseholdMembersTableProcessedTableManager get householdMembersRefs {
    final manager = $$HouseholdMembersTableTableManager(
      $_db,
      $_db.householdMembers,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _householdMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocationsTable, List<Location>>
  _locationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.locations,
    aliasName: 'households__id__locations__household_id',
  );

  $$LocationsTableProcessedTableManager get locationsRefs {
    final manager = $$LocationsTableTableManager(
      $_db,
      $_db.locations,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_locationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: 'households__id__items__household_id',
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItemAttachmentsTable, List<ItemAttachment>>
  _itemAttachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itemAttachments,
    aliasName: 'households__id__item_attachments__household_id',
  );

  $$ItemAttachmentsTableProcessedTableManager get itemAttachmentsRefs {
    final manager = $$ItemAttachmentsTableTableManager(
      $_db,
      $_db.itemAttachments,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _itemAttachmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssetLoansTable, List<AssetLoan>>
  _assetLoansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assetLoans,
    aliasName: 'households__id__asset_loans__household_id',
  );

  $$AssetLoansTableProcessedTableManager get assetLoansRefs {
    final manager = $$AssetLoansTableTableManager(
      $_db,
      $_db.assetLoans,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetLoansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsageLogsTable, List<UsageLog>>
  _usageLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.usageLogs,
    aliasName: 'households__id__usage_logs__household_id',
  );

  $$UsageLogsTableProcessedTableManager get usageLogsRefs {
    final manager = $$UsageLogsTableTableManager(
      $_db,
      $_db.usageLogs,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usageLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BooksTable, List<Book>> _booksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.books,
    aliasName: 'households__id__books__household_id',
  );

  $$BooksTableProcessedTableManager get booksRefs {
    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_booksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'households__id__documents__household_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.vehicles,
    aliasName: 'households__id__vehicles__household_id',
  );

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehicleServiceLogsTable, List<VehicleServiceLog>>
  _vehicleServiceLogsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vehicleServiceLogs,
        aliasName: 'households__id__vehicle_service_logs__household_id',
      );

  $$VehicleServiceLogsTableProcessedTableManager get vehicleServiceLogsRefs {
    final manager = $$VehicleServiceLogsTableTableManager(
      $_db,
      $_db.vehicleServiceLogs,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vehicleServiceLogsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehicleFuelLogsTable, List<VehicleFuelLog>>
  _vehicleFuelLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vehicleFuelLogs,
    aliasName: 'households__id__vehicle_fuel_logs__household_id',
  );

  $$VehicleFuelLogsTableProcessedTableManager get vehicleFuelLogsRefs {
    final manager = $$VehicleFuelLogsTableTableManager(
      $_db,
      $_db.vehicleFuelLogs,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vehicleFuelLogsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovingProjectsTable, List<MovingProject>>
  _movingProjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movingProjects,
    aliasName: 'households__id__moving_projects__household_id',
  );

  $$MovingProjectsTableProcessedTableManager get movingProjectsRefs {
    final manager = $$MovingProjectsTableTableManager(
      $_db,
      $_db.movingProjects,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_movingProjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovingBoxesTable, List<MovingBox>>
  _movingBoxesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movingBoxes,
    aliasName: 'households__id__moving_boxes__household_id',
  );

  $$MovingBoxesTableProcessedTableManager get movingBoxesRefs {
    final manager = $$MovingBoxesTableTableManager(
      $_db,
      $_db.movingBoxes,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_movingBoxesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'households__id__reminders__household_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.householdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HouseholdsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> householdMembersRefs(
    Expression<bool> Function($$HouseholdMembersTableFilterComposer f) f,
  ) {
    final $$HouseholdMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.householdMembers,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdMembersTableFilterComposer(
            $db: $db,
            $table: $db.householdMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> locationsRefs(
    Expression<bool> Function($$LocationsTableFilterComposer f) f,
  ) {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableFilterComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemAttachmentsRefs(
    Expression<bool> Function($$ItemAttachmentsTableFilterComposer f) f,
  ) {
    final $$ItemAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAttachments,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.itemAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assetLoansRefs(
    Expression<bool> Function($$AssetLoansTableFilterComposer f) f,
  ) {
    final $$AssetLoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assetLoans,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetLoansTableFilterComposer(
            $db: $db,
            $table: $db.assetLoans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usageLogsRefs(
    Expression<bool> Function($$UsageLogsTableFilterComposer f) f,
  ) {
    final $$UsageLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableFilterComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> booksRefs(
    Expression<bool> Function($$BooksTableFilterComposer f) f,
  ) {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehiclesRefs(
    Expression<bool> Function($$VehiclesTableFilterComposer f) f,
  ) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehicleServiceLogsRefs(
    Expression<bool> Function($$VehicleServiceLogsTableFilterComposer f) f,
  ) {
    final $$VehicleServiceLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleServiceLogs,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleServiceLogsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleServiceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehicleFuelLogsRefs(
    Expression<bool> Function($$VehicleFuelLogsTableFilterComposer f) f,
  ) {
    final $$VehicleFuelLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleFuelLogs,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleFuelLogsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleFuelLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movingProjectsRefs(
    Expression<bool> Function($$MovingProjectsTableFilterComposer f) f,
  ) {
    final $$MovingProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingProjects,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingProjectsTableFilterComposer(
            $db: $db,
            $table: $db.movingProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movingBoxesRefs(
    Expression<bool> Function($$MovingBoxesTableFilterComposer f) f,
  ) {
    final $$MovingBoxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableFilterComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HouseholdsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HouseholdsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  Expression<T> householdMembersRefs<T extends Object>(
    Expression<T> Function($$HouseholdMembersTableAnnotationComposer a) f,
  ) {
    final $$HouseholdMembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.householdMembers,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdMembersTableAnnotationComposer(
            $db: $db,
            $table: $db.householdMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> locationsRefs<T extends Object>(
    Expression<T> Function($$LocationsTableAnnotationComposer a) f,
  ) {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itemAttachmentsRefs<T extends Object>(
    Expression<T> Function($$ItemAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$ItemAttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAttachments,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.itemAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assetLoansRefs<T extends Object>(
    Expression<T> Function($$AssetLoansTableAnnotationComposer a) f,
  ) {
    final $$AssetLoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assetLoans,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetLoansTableAnnotationComposer(
            $db: $db,
            $table: $db.assetLoans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usageLogsRefs<T extends Object>(
    Expression<T> Function($$UsageLogsTableAnnotationComposer a) f,
  ) {
    final $$UsageLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> booksRefs<T extends Object>(
    Expression<T> Function($$BooksTableAnnotationComposer a) f,
  ) {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vehiclesRefs<T extends Object>(
    Expression<T> Function($$VehiclesTableAnnotationComposer a) f,
  ) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vehicleServiceLogsRefs<T extends Object>(
    Expression<T> Function($$VehicleServiceLogsTableAnnotationComposer a) f,
  ) {
    final $$VehicleServiceLogsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vehicleServiceLogs,
          getReferencedColumn: (t) => t.householdId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VehicleServiceLogsTableAnnotationComposer(
                $db: $db,
                $table: $db.vehicleServiceLogs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> vehicleFuelLogsRefs<T extends Object>(
    Expression<T> Function($$VehicleFuelLogsTableAnnotationComposer a) f,
  ) {
    final $$VehicleFuelLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleFuelLogs,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleFuelLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleFuelLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movingProjectsRefs<T extends Object>(
    Expression<T> Function($$MovingProjectsTableAnnotationComposer a) f,
  ) {
    final $$MovingProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingProjects,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.movingProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movingBoxesRefs<T extends Object>(
    Expression<T> Function($$MovingBoxesTableAnnotationComposer a) f,
  ) {
    final $$MovingBoxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableAnnotationComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.householdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HouseholdsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HouseholdsTable,
          Household,
          $$HouseholdsTableFilterComposer,
          $$HouseholdsTableOrderingComposer,
          $$HouseholdsTableAnnotationComposer,
          $$HouseholdsTableCreateCompanionBuilder,
          $$HouseholdsTableUpdateCompanionBuilder,
          (Household, $$HouseholdsTableReferences),
          Household,
          PrefetchHooks Function({
            bool householdMembersRefs,
            bool locationsRefs,
            bool itemsRefs,
            bool itemAttachmentsRefs,
            bool assetLoansRefs,
            bool usageLogsRefs,
            bool booksRefs,
            bool documentsRefs,
            bool vehiclesRefs,
            bool vehicleServiceLogsRefs,
            bool vehicleFuelLogsRefs,
            bool movingProjectsRefs,
            bool movingBoxesRefs,
            bool remindersRefs,
          })
        > {
  $$HouseholdsTableTableManager(_$AppDatabase db, $HouseholdsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> inviteCode = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                inviteCode: inviteCode,
                currencyCode: currencyCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String inviteCode,
                Value<String> currencyCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                inviteCode: inviteCode,
                currencyCode: currencyCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HouseholdsTable, Household>(table),
                  $$HouseholdsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdMembersRefs = false,
                locationsRefs = false,
                itemsRefs = false,
                itemAttachmentsRefs = false,
                assetLoansRefs = false,
                usageLogsRefs = false,
                booksRefs = false,
                documentsRefs = false,
                vehiclesRefs = false,
                vehicleServiceLogsRefs = false,
                vehicleFuelLogsRefs = false,
                movingProjectsRefs = false,
                movingBoxesRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (householdMembersRefs) db.householdMembers,
                    if (locationsRefs) db.locations,
                    if (itemsRefs) db.items,
                    if (itemAttachmentsRefs) db.itemAttachments,
                    if (assetLoansRefs) db.assetLoans,
                    if (usageLogsRefs) db.usageLogs,
                    if (booksRefs) db.books,
                    if (documentsRefs) db.documents,
                    if (vehiclesRefs) db.vehicles,
                    if (vehicleServiceLogsRefs) db.vehicleServiceLogs,
                    if (vehicleFuelLogsRefs) db.vehicleFuelLogs,
                    if (movingProjectsRefs) db.movingProjects,
                    if (movingBoxesRefs) db.movingBoxes,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (householdMembersRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          HouseholdMember,
                          $HouseholdMembersTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._householdMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).householdMembersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (locationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Location,
                          $LocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._locationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).locationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (itemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Item,
                          $ItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._itemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (itemAttachmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          ItemAttachment,
                          $ItemAttachmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._itemAttachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemAttachmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (assetLoansRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          AssetLoan,
                          $AssetLoansTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._assetLoansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).assetLoansRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (usageLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          UsageLog,
                          $UsageLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._usageLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).usageLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (booksRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Book,
                          $BooksTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._booksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).booksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Document,
                          $DocumentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (vehiclesRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Vehicle,
                          $VehiclesTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._vehiclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).vehiclesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (vehicleServiceLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          VehicleServiceLog,
                          $VehicleServiceLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._vehicleServiceLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).vehicleServiceLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (vehicleFuelLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          VehicleFuelLog,
                          $VehicleFuelLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._vehicleFuelLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).vehicleFuelLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (movingProjectsRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          MovingProject,
                          $MovingProjectsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._movingProjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).movingProjectsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (movingBoxesRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          MovingBox,
                          $MovingBoxesTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._movingBoxesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).movingBoxesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedDataByColumns<
                          Household,
                          $HouseholdsTable,
                          Reminder,
                          $RemindersTable
                        >(
                          currentTable: table,
                          referencedTable: $$HouseholdsTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HouseholdsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'household_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HouseholdsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HouseholdsTable,
      Household,
      $$HouseholdsTableFilterComposer,
      $$HouseholdsTableOrderingComposer,
      $$HouseholdsTableAnnotationComposer,
      $$HouseholdsTableCreateCompanionBuilder,
      $$HouseholdsTableUpdateCompanionBuilder,
      (Household, $$HouseholdsTableReferences),
      Household,
      PrefetchHooks Function({
        bool householdMembersRefs,
        bool locationsRefs,
        bool itemsRefs,
        bool itemAttachmentsRefs,
        bool assetLoansRefs,
        bool usageLogsRefs,
        bool booksRefs,
        bool documentsRefs,
        bool vehiclesRefs,
        bool vehicleServiceLogsRefs,
        bool vehicleFuelLogsRefs,
        bool movingProjectsRefs,
        bool movingBoxesRefs,
        bool remindersRefs,
      })
    >;
typedef $$HouseholdMembersTableCreateCompanionBuilder =
    HouseholdMembersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String userId,
      Value<String> role,
      Value<String> displayName,
      Value<int> rowid,
    });
typedef $$HouseholdMembersTableUpdateCompanionBuilder =
    HouseholdMembersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> userId,
      Value<String> role,
      Value<String> displayName,
      Value<int> rowid,
    });

final class $$HouseholdMembersTableReferences
    extends
        BaseReferences<_$AppDatabase, $HouseholdMembersTable, HouseholdMember> {
  $$HouseholdMembersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('household_members__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HouseholdMembersTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdMembersTable> {
  $$HouseholdMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HouseholdMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HouseholdMembersTable,
          HouseholdMember,
          $$HouseholdMembersTableFilterComposer,
          $$HouseholdMembersTableOrderingComposer,
          $$HouseholdMembersTableAnnotationComposer,
          $$HouseholdMembersTableCreateCompanionBuilder,
          $$HouseholdMembersTableUpdateCompanionBuilder,
          (HouseholdMember, $$HouseholdMembersTableReferences),
          HouseholdMember,
          PrefetchHooks Function({bool householdId})
        > {
  $$HouseholdMembersTableTableManager(
    _$AppDatabase db,
    $HouseholdMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdMembersCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                userId: userId,
                role: role,
                displayName: displayName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String userId,
                Value<String> role = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdMembersCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                userId: userId,
                role: role,
                displayName: displayName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HouseholdMembersTable, HouseholdMember>(table),
                  $$HouseholdMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$HouseholdMembersTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$HouseholdMembersTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HouseholdMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HouseholdMembersTable,
      HouseholdMember,
      $$HouseholdMembersTableFilterComposer,
      $$HouseholdMembersTableOrderingComposer,
      $$HouseholdMembersTableAnnotationComposer,
      $$HouseholdMembersTableCreateCompanionBuilder,
      $$HouseholdMembersTableUpdateCompanionBuilder,
      (HouseholdMember, $$HouseholdMembersTableReferences),
      HouseholdMember,
      PrefetchHooks Function({bool householdId})
    >;
typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String householdId,
  Value<String?> parentId,
  required String name,
  Value<String> kind,
  Value<String?> qrCode,
  Value<String?> notes,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> householdId,
  Value<String?> parentId,
  Value<String> name,
  Value<String> kind,
  Value<String?> qrCode,
  Value<String?> notes,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$LocationsTableReferences
    extends BaseReferences<_$AppDatabase, $LocationsTable, Location> {
  $$LocationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('locations__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovingBoxesTable, List<MovingBox>>
  _movingBoxesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movingBoxes,
    aliasName: 'locations__id__moving_boxes__location_id',
  );

  $$MovingBoxesTableProcessedTableManager get movingBoxesRefs {
    final manager = $$MovingBoxesTableTableManager(
      $_db,
      $_db.movingBoxes,
    ).filter((f) => f.locationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_movingBoxesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movingBoxesRefs(
    Expression<bool> Function($$MovingBoxesTableFilterComposer f) f,
  ) {
    final $$MovingBoxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.locationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableFilterComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get qrCode =>
      $composableBuilder(column: $table.qrCode, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movingBoxesRefs<T extends Object>(
    Expression<T> Function($$MovingBoxesTableAnnotationComposer a) f,
  ) {
    final $$MovingBoxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.locationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableAnnotationComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, $$LocationsTableReferences),
          Location,
          PrefetchHooks Function({bool householdId, bool movingBoxesRefs})
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> qrCode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                parentId: parentId,
                name: name,
                kind: kind,
                qrCode: qrCode,
                notes: notes,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                Value<String?> parentId = const Value.absent(),
                required String name,
                Value<String> kind = const Value.absent(),
                Value<String?> qrCode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                parentId: parentId,
                name: name,
                kind: kind,
                qrCode: qrCode,
                notes: notes,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocationsTable, Location>(table),
                  $$LocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({householdId = false, movingBoxesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (movingBoxesRefs) db.movingBoxes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$LocationsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$LocationsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movingBoxesRefs)
                        await $_getPrefetchedDataByColumns<
                          Location,
                          $LocationsTable,
                          MovingBox,
                          $MovingBoxesTable
                        >(
                          currentTable: table,
                          referencedTable: $$LocationsTableReferences
                              ._movingBoxesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocationsTableReferences(
                                db,
                                table,
                                p0,
                              ).movingBoxesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'location_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, $$LocationsTableReferences),
      Location,
      PrefetchHooks Function({bool householdId, bool movingBoxesRefs})
    >;
typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String householdId,
  Value<String?> locationId,
  Value<String?> containerItemId,
  required String name,
  Value<String> category,
  Value<String> assetType,
  Value<int> quantity,
  Value<String?> brand,
  Value<String?> modelNumber,
  Value<String?> serialNumber,
  Value<String?> barcode,
  Value<String?> qrCode,
  Value<double?> purchasePrice,
  Value<DateTime?> purchaseDate,
  Value<String?> purchaseStore,
  Value<double?> estimatedValue,
  Value<DateTime?> warrantyExpiresAt,
  Value<String> condition,
  Value<String> usageMode,
  Value<String> utilityStatus,
  Value<int?> utilityRating,
  Value<int> usageCount,
  Value<DateTime?> lastUsedAt,
  Value<String?> notes,
  Value<String> customFieldsJson,
  Value<int> rowid,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> householdId,
  Value<String?> locationId,
  Value<String?> containerItemId,
  Value<String> name,
  Value<String> category,
  Value<String> assetType,
  Value<int> quantity,
  Value<String?> brand,
  Value<String?> modelNumber,
  Value<String?> serialNumber,
  Value<String?> barcode,
  Value<String?> qrCode,
  Value<double?> purchasePrice,
  Value<DateTime?> purchaseDate,
  Value<String?> purchaseStore,
  Value<double?> estimatedValue,
  Value<DateTime?> warrantyExpiresAt,
  Value<String> condition,
  Value<String> usageMode,
  Value<String> utilityStatus,
  Value<int?> utilityRating,
  Value<int> usageCount,
  Value<DateTime?> lastUsedAt,
  Value<String?> notes,
  Value<String> customFieldsJson,
  Value<int> rowid,
});

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('items__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ItemAttachmentsTable, List<ItemAttachment>>
  _itemAttachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itemAttachments,
    aliasName: 'items__id__item_attachments__item_id',
  );

  $$ItemAttachmentsTableProcessedTableManager get itemAttachmentsRefs {
    final manager = $$ItemAttachmentsTableTableManager(
      $_db,
      $_db.itemAttachments,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _itemAttachmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssetLoansTable, List<AssetLoan>>
  _assetLoansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assetLoans,
    aliasName: 'items__id__asset_loans__item_id',
  );

  $$AssetLoansTableProcessedTableManager get assetLoansRefs {
    final manager = $$AssetLoansTableTableManager(
      $_db,
      $_db.assetLoans,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetLoansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsageLogsTable, List<UsageLog>>
  _usageLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.usageLogs,
    aliasName: 'items__id__usage_logs__item_id',
  );

  $$UsageLogsTableProcessedTableManager get usageLogsRefs {
    final manager = $$UsageLogsTableTableManager(
      $_db,
      $_db.usageLogs,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usageLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BooksTable, List<Book>> _booksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.books,
    aliasName: 'items__id__books__item_id',
  );

  $$BooksTableProcessedTableManager get booksRefs {
    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_booksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'items__id__documents__item_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.vehicles,
    aliasName: 'items__id__vehicles__item_id',
  );

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get containerItemId => $composableBuilder(
    column: $table.containerItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseStore => $composableBuilder(
    column: $table.purchaseStore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyExpiresAt => $composableBuilder(
    column: $table.warrantyExpiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageMode => $composableBuilder(
    column: $table.usageMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get utilityStatus => $composableBuilder(
    column: $table.utilityStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get utilityRating => $composableBuilder(
    column: $table.utilityRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFieldsJson => $composableBuilder(
    column: $table.customFieldsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itemAttachmentsRefs(
    Expression<bool> Function($$ItemAttachmentsTableFilterComposer f) f,
  ) {
    final $$ItemAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAttachments,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.itemAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assetLoansRefs(
    Expression<bool> Function($$AssetLoansTableFilterComposer f) f,
  ) {
    final $$AssetLoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assetLoans,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetLoansTableFilterComposer(
            $db: $db,
            $table: $db.assetLoans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usageLogsRefs(
    Expression<bool> Function($$UsageLogsTableFilterComposer f) f,
  ) {
    final $$UsageLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableFilterComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> booksRefs(
    Expression<bool> Function($$BooksTableFilterComposer f) f,
  ) {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehiclesRefs(
    Expression<bool> Function($$VehiclesTableFilterComposer f) f,
  ) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get containerItemId => $composableBuilder(
    column: $table.containerItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseStore => $composableBuilder(
    column: $table.purchaseStore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyExpiresAt => $composableBuilder(
    column: $table.warrantyExpiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageMode => $composableBuilder(
    column: $table.usageMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get utilityStatus => $composableBuilder(
    column: $table.utilityStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get utilityRating => $composableBuilder(
    column: $table.utilityRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFieldsJson => $composableBuilder(
    column: $table.customFieldsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get containerItemId => $composableBuilder(
    column: $table.containerItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get assetType =>
      $composableBuilder(column: $table.assetType, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get qrCode =>
      $composableBuilder(column: $table.qrCode, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchaseStore => $composableBuilder(
    column: $table.purchaseStore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get warrantyExpiresAt => $composableBuilder(
    column: $table.warrantyExpiresAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get usageMode =>
      $composableBuilder(column: $table.usageMode, builder: (column) => column);

  GeneratedColumn<String> get utilityStatus => $composableBuilder(
    column: $table.utilityStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get utilityRating => $composableBuilder(
    column: $table.utilityRating,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get customFieldsJson => $composableBuilder(
    column: $table.customFieldsJson,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itemAttachmentsRefs<T extends Object>(
    Expression<T> Function($$ItemAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$ItemAttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAttachments,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.itemAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assetLoansRefs<T extends Object>(
    Expression<T> Function($$AssetLoansTableAnnotationComposer a) f,
  ) {
    final $$AssetLoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assetLoans,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetLoansTableAnnotationComposer(
            $db: $db,
            $table: $db.assetLoans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usageLogsRefs<T extends Object>(
    Expression<T> Function($$UsageLogsTableAnnotationComposer a) f,
  ) {
    final $$UsageLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageLogs,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.usageLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> booksRefs<T extends Object>(
    Expression<T> Function($$BooksTableAnnotationComposer a) f,
  ) {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vehiclesRefs<T extends Object>(
    Expression<T> Function($$VehiclesTableAnnotationComposer a) f,
  ) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({
            bool householdId,
            bool itemAttachmentsRefs,
            bool assetLoansRefs,
            bool usageLogsRefs,
            bool booksRefs,
            bool documentsRefs,
            bool vehiclesRefs,
          })
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String?> locationId = const Value.absent(),
                Value<String?> containerItemId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> assetType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> qrCode = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> purchaseStore = const Value.absent(),
                Value<double?> estimatedValue = const Value.absent(),
                Value<DateTime?> warrantyExpiresAt = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> usageMode = const Value.absent(),
                Value<String> utilityStatus = const Value.absent(),
                Value<int?> utilityRating = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> customFieldsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                locationId: locationId,
                containerItemId: containerItemId,
                name: name,
                category: category,
                assetType: assetType,
                quantity: quantity,
                brand: brand,
                modelNumber: modelNumber,
                serialNumber: serialNumber,
                barcode: barcode,
                qrCode: qrCode,
                purchasePrice: purchasePrice,
                purchaseDate: purchaseDate,
                purchaseStore: purchaseStore,
                estimatedValue: estimatedValue,
                warrantyExpiresAt: warrantyExpiresAt,
                condition: condition,
                usageMode: usageMode,
                utilityStatus: utilityStatus,
                utilityRating: utilityRating,
                usageCount: usageCount,
                lastUsedAt: lastUsedAt,
                notes: notes,
                customFieldsJson: customFieldsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                Value<String?> locationId = const Value.absent(),
                Value<String?> containerItemId = const Value.absent(),
                required String name,
                Value<String> category = const Value.absent(),
                Value<String> assetType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> qrCode = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> purchaseStore = const Value.absent(),
                Value<double?> estimatedValue = const Value.absent(),
                Value<DateTime?> warrantyExpiresAt = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> usageMode = const Value.absent(),
                Value<String> utilityStatus = const Value.absent(),
                Value<int?> utilityRating = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> customFieldsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                locationId: locationId,
                containerItemId: containerItemId,
                name: name,
                category: category,
                assetType: assetType,
                quantity: quantity,
                brand: brand,
                modelNumber: modelNumber,
                serialNumber: serialNumber,
                barcode: barcode,
                qrCode: qrCode,
                purchasePrice: purchasePrice,
                purchaseDate: purchaseDate,
                purchaseStore: purchaseStore,
                estimatedValue: estimatedValue,
                warrantyExpiresAt: warrantyExpiresAt,
                condition: condition,
                usageMode: usageMode,
                utilityStatus: utilityStatus,
                utilityRating: utilityRating,
                usageCount: usageCount,
                lastUsedAt: lastUsedAt,
                notes: notes,
                customFieldsJson: customFieldsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemsTable, Item>(table),
                  $$ItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                householdId = false,
                itemAttachmentsRefs = false,
                assetLoansRefs = false,
                usageLogsRefs = false,
                booksRefs = false,
                documentsRefs = false,
                vehiclesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itemAttachmentsRefs) db.itemAttachments,
                    if (assetLoansRefs) db.assetLoans,
                    if (usageLogsRefs) db.usageLogs,
                    if (booksRefs) db.books,
                    if (documentsRefs) db.documents,
                    if (vehiclesRefs) db.vehicles,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$ItemsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$ItemsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itemAttachmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          ItemAttachment,
                          $ItemAttachmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._itemAttachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemAttachmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (assetLoansRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          AssetLoan,
                          $AssetLoansTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._assetLoansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).assetLoansRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (usageLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          UsageLog,
                          $UsageLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._usageLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).usageLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (booksRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          Book,
                          $BooksTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._booksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(db, table, p0).booksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          Document,
                          $DocumentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (vehiclesRefs)
                        await $_getPrefetchedDataByColumns<
                          Item,
                          $ItemsTable,
                          Vehicle,
                          $VehiclesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._vehiclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).vehiclesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({
        bool householdId,
        bool itemAttachmentsRefs,
        bool assetLoansRefs,
        bool usageLogsRefs,
        bool booksRefs,
        bool documentsRefs,
        bool vehiclesRefs,
      })
    >;
typedef $$ItemAttachmentsTableCreateCompanionBuilder =
    ItemAttachmentsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String itemId,
      Value<String> kind,
      Value<String?> localPath,
      Value<String?> remotePath,
      Value<String> mimeType,
      Value<int?> fileSizeBytes,
      Value<int> pageOrder,
      Value<bool> isSensitive,
      Value<String> uploadStatus,
      Value<int> rowid,
    });
typedef $$ItemAttachmentsTableUpdateCompanionBuilder =
    ItemAttachmentsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> itemId,
      Value<String> kind,
      Value<String?> localPath,
      Value<String?> remotePath,
      Value<String> mimeType,
      Value<int?> fileSizeBytes,
      Value<int> pageOrder,
      Value<bool> isSensitive,
      Value<String> uploadStatus,
      Value<int> rowid,
    });

final class $$ItemAttachmentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ItemAttachmentsTable, ItemAttachment> {
  $$ItemAttachmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('item_attachments__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('item_attachments__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $ItemAttachmentsTable> {
  $$ItemAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageOrder => $composableBuilder(
    column: $table.pageOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemAttachmentsTable> {
  $$ItemAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageOrder => $composableBuilder(
    column: $table.pageOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemAttachmentsTable> {
  $$ItemAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageOrder =>
      $composableBuilder(column: $table.pageOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemAttachmentsTable,
          ItemAttachment,
          $$ItemAttachmentsTableFilterComposer,
          $$ItemAttachmentsTableOrderingComposer,
          $$ItemAttachmentsTableAnnotationComposer,
          $$ItemAttachmentsTableCreateCompanionBuilder,
          $$ItemAttachmentsTableUpdateCompanionBuilder,
          (ItemAttachment, $$ItemAttachmentsTableReferences),
          ItemAttachment,
          PrefetchHooks Function({bool householdId, bool itemId})
        > {
  $$ItemAttachmentsTableTableManager(
    _$AppDatabase db,
    $ItemAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemAttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemAttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> remotePath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<int> pageOrder = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemAttachmentsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                kind: kind,
                localPath: localPath,
                remotePath: remotePath,
                mimeType: mimeType,
                fileSizeBytes: fileSizeBytes,
                pageOrder: pageOrder,
                isSensitive: isSensitive,
                uploadStatus: uploadStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String itemId,
                Value<String> kind = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> remotePath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<int> pageOrder = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemAttachmentsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                kind: kind,
                localPath: localPath,
                remotePath: remotePath,
                mimeType: mimeType,
                fileSizeBytes: fileSizeBytes,
                pageOrder: pageOrder,
                isSensitive: isSensitive,
                uploadStatus: uploadStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemAttachmentsTable, ItemAttachment>(table),
                  $$ItemAttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$ItemAttachmentsTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$ItemAttachmentsTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$ItemAttachmentsTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$ItemAttachmentsTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemAttachmentsTable,
      ItemAttachment,
      $$ItemAttachmentsTableFilterComposer,
      $$ItemAttachmentsTableOrderingComposer,
      $$ItemAttachmentsTableAnnotationComposer,
      $$ItemAttachmentsTableCreateCompanionBuilder,
      $$ItemAttachmentsTableUpdateCompanionBuilder,
      (ItemAttachment, $$ItemAttachmentsTableReferences),
      ItemAttachment,
      PrefetchHooks Function({bool householdId, bool itemId})
    >;
typedef $$AssetLoansTableCreateCompanionBuilder = AssetLoansCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String householdId,
  required String itemId,
  required String borrowerName,
  Value<String?> borrowerContact,
  Value<DateTime> borrowedAt,
  Value<DateTime?> dueReturnAt,
  Value<DateTime?> returnedAt,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$AssetLoansTableUpdateCompanionBuilder = AssetLoansCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> householdId,
  Value<String> itemId,
  Value<String> borrowerName,
  Value<String?> borrowerContact,
  Value<DateTime> borrowedAt,
  Value<DateTime?> dueReturnAt,
  Value<DateTime?> returnedAt,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$AssetLoansTableReferences
    extends BaseReferences<_$AppDatabase, $AssetLoansTable, AssetLoan> {
  $$AssetLoansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('asset_loans__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('asset_loans__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AssetLoansTableFilterComposer
    extends Composer<_$AppDatabase, $AssetLoansTable> {
  $$AssetLoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get borrowerName => $composableBuilder(
    column: $table.borrowerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get borrowerContact => $composableBuilder(
    column: $table.borrowerContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get borrowedAt => $composableBuilder(
    column: $table.borrowedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueReturnAt => $composableBuilder(
    column: $table.dueReturnAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetLoansTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetLoansTable> {
  $$AssetLoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get borrowerName => $composableBuilder(
    column: $table.borrowerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get borrowerContact => $composableBuilder(
    column: $table.borrowerContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get borrowedAt => $composableBuilder(
    column: $table.borrowedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueReturnAt => $composableBuilder(
    column: $table.dueReturnAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetLoansTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetLoansTable> {
  $$AssetLoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get borrowerName => $composableBuilder(
    column: $table.borrowerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get borrowerContact => $composableBuilder(
    column: $table.borrowerContact,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get borrowedAt => $composableBuilder(
    column: $table.borrowedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueReturnAt => $composableBuilder(
    column: $table.dueReturnAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetLoansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetLoansTable,
          AssetLoan,
          $$AssetLoansTableFilterComposer,
          $$AssetLoansTableOrderingComposer,
          $$AssetLoansTableAnnotationComposer,
          $$AssetLoansTableCreateCompanionBuilder,
          $$AssetLoansTableUpdateCompanionBuilder,
          (AssetLoan, $$AssetLoansTableReferences),
          AssetLoan,
          PrefetchHooks Function({bool householdId, bool itemId})
        > {
  $$AssetLoansTableTableManager(_$AppDatabase db, $AssetLoansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetLoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetLoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetLoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> borrowerName = const Value.absent(),
                Value<String?> borrowerContact = const Value.absent(),
                Value<DateTime> borrowedAt = const Value.absent(),
                Value<DateTime?> dueReturnAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetLoansCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                borrowerName: borrowerName,
                borrowerContact: borrowerContact,
                borrowedAt: borrowedAt,
                dueReturnAt: dueReturnAt,
                returnedAt: returnedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String itemId,
                required String borrowerName,
                Value<String?> borrowerContact = const Value.absent(),
                Value<DateTime> borrowedAt = const Value.absent(),
                Value<DateTime?> dueReturnAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetLoansCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                borrowerName: borrowerName,
                borrowerContact: borrowerContact,
                borrowedAt: borrowedAt,
                dueReturnAt: dueReturnAt,
                returnedAt: returnedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AssetLoansTable, AssetLoan>(table),
                  $$AssetLoansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$AssetLoansTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$AssetLoansTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$AssetLoansTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$AssetLoansTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AssetLoansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetLoansTable,
      AssetLoan,
      $$AssetLoansTableFilterComposer,
      $$AssetLoansTableOrderingComposer,
      $$AssetLoansTableAnnotationComposer,
      $$AssetLoansTableCreateCompanionBuilder,
      $$AssetLoansTableUpdateCompanionBuilder,
      (AssetLoan, $$AssetLoansTableReferences),
      AssetLoan,
      PrefetchHooks Function({bool householdId, bool itemId})
    >;
typedef $$UsageLogsTableCreateCompanionBuilder = UsageLogsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String householdId,
  required String itemId,
  Value<DateTime> usedAt,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$UsageLogsTableUpdateCompanionBuilder = UsageLogsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> householdId,
  Value<String> itemId,
  Value<DateTime> usedAt,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$UsageLogsTableReferences
    extends BaseReferences<_$AppDatabase, $UsageLogsTable, UsageLog> {
  $$UsageLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('usage_logs__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('usage_logs__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsageLogsTableFilterComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageLogsTable> {
  $$UsageLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get usedAt =>
      $composableBuilder(column: $table.usedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsageLogsTable,
          UsageLog,
          $$UsageLogsTableFilterComposer,
          $$UsageLogsTableOrderingComposer,
          $$UsageLogsTableAnnotationComposer,
          $$UsageLogsTableCreateCompanionBuilder,
          $$UsageLogsTableUpdateCompanionBuilder,
          (UsageLog, $$UsageLogsTableReferences),
          UsageLog,
          PrefetchHooks Function({bool householdId, bool itemId})
        > {
  $$UsageLogsTableTableManager(_$AppDatabase db, $UsageLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<DateTime> usedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsageLogsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                usedAt: usedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String itemId,
                Value<DateTime> usedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsageLogsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                usedAt: usedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsageLogsTable, UsageLog>(table),
                  $$UsageLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$UsageLogsTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$UsageLogsTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$UsageLogsTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$UsageLogsTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UsageLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsageLogsTable,
      UsageLog,
      $$UsageLogsTableFilterComposer,
      $$UsageLogsTableOrderingComposer,
      $$UsageLogsTableAnnotationComposer,
      $$UsageLogsTableCreateCompanionBuilder,
      $$UsageLogsTableUpdateCompanionBuilder,
      (UsageLog, $$UsageLogsTableReferences),
      UsageLog,
      PrefetchHooks Function({bool householdId, bool itemId})
    >;
typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String itemId,
  required String householdId,
  Value<String?> isbn10,
  Value<String?> isbn13,
  Value<String?> subtitle,
  Value<String> authorsJson,
  Value<String?> publisher,
  Value<int?> publishedYear,
  Value<int?> pageCount,
  Value<String> language,
  Value<String> genreTagsJson,
  Value<String?> seriesName,
  Value<double?> seriesNumber,
  Value<String?> edition,
  Value<String> bookFormat,
  Value<String> readingStatus,
  Value<int> currentPage,
  Value<int?> personalRating,
  Value<DateTime?> startedReadingAt,
  Value<DateTime?> finishedReadingAt,
  Value<String?> synopsis,
  Value<String?> reviewNotes,
  Value<String> metadataSource,
  Value<int> rowid,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> itemId,
  Value<String> householdId,
  Value<String?> isbn10,
  Value<String?> isbn13,
  Value<String?> subtitle,
  Value<String> authorsJson,
  Value<String?> publisher,
  Value<int?> publishedYear,
  Value<int?> pageCount,
  Value<String> language,
  Value<String> genreTagsJson,
  Value<String?> seriesName,
  Value<double?> seriesNumber,
  Value<String?> edition,
  Value<String> bookFormat,
  Value<String> readingStatus,
  Value<int> currentPage,
  Value<int?> personalRating,
  Value<DateTime?> startedReadingAt,
  Value<DateTime?> finishedReadingAt,
  Value<String?> synopsis,
  Value<String?> reviewNotes,
  Value<String> metadataSource,
  Value<int> rowid,
});

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('books__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('books__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbn10 => $composableBuilder(
    column: $table.isbn10,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbn13 => $composableBuilder(
    column: $table.isbn13,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorsJson => $composableBuilder(
    column: $table.authorsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get publishedYear => $composableBuilder(
    column: $table.publishedYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genreTagsJson => $composableBuilder(
    column: $table.genreTagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seriesName => $composableBuilder(
    column: $table.seriesName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get edition => $composableBuilder(
    column: $table.edition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookFormat => $composableBuilder(
    column: $table.bookFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedReadingAt => $composableBuilder(
    column: $table.startedReadingAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedReadingAt => $composableBuilder(
    column: $table.finishedReadingAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewNotes => $composableBuilder(
    column: $table.reviewNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn10 => $composableBuilder(
    column: $table.isbn10,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn13 => $composableBuilder(
    column: $table.isbn13,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorsJson => $composableBuilder(
    column: $table.authorsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get publishedYear => $composableBuilder(
    column: $table.publishedYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genreTagsJson => $composableBuilder(
    column: $table.genreTagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seriesName => $composableBuilder(
    column: $table.seriesName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get edition => $composableBuilder(
    column: $table.edition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookFormat => $composableBuilder(
    column: $table.bookFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedReadingAt => $composableBuilder(
    column: $table.startedReadingAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedReadingAt => $composableBuilder(
    column: $table.finishedReadingAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewNotes => $composableBuilder(
    column: $table.reviewNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get isbn10 =>
      $composableBuilder(column: $table.isbn10, builder: (column) => column);

  GeneratedColumn<String> get isbn13 =>
      $composableBuilder(column: $table.isbn13, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get authorsJson => $composableBuilder(
    column: $table.authorsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<int> get publishedYear => $composableBuilder(
    column: $table.publishedYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get genreTagsJson => $composableBuilder(
    column: $table.genreTagsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seriesName => $composableBuilder(
    column: $table.seriesName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get edition =>
      $composableBuilder(column: $table.edition, builder: (column) => column);

  GeneratedColumn<String> get bookFormat => $composableBuilder(
    column: $table.bookFormat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingStatus => $composableBuilder(
    column: $table.readingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get personalRating => $composableBuilder(
    column: $table.personalRating,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedReadingAt => $composableBuilder(
    column: $table.startedReadingAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finishedReadingAt => $composableBuilder(
    column: $table.finishedReadingAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get synopsis =>
      $composableBuilder(column: $table.synopsis, builder: (column) => column);

  GeneratedColumn<String> get reviewNotes => $composableBuilder(
    column: $table.reviewNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => column,
  );

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, $$BooksTableReferences),
          Book,
          PrefetchHooks Function({bool itemId, bool householdId})
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String?> isbn10 = const Value.absent(),
                Value<String?> isbn13 = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String> authorsJson = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> publishedYear = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> genreTagsJson = const Value.absent(),
                Value<String?> seriesName = const Value.absent(),
                Value<double?> seriesNumber = const Value.absent(),
                Value<String?> edition = const Value.absent(),
                Value<String> bookFormat = const Value.absent(),
                Value<String> readingStatus = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int?> personalRating = const Value.absent(),
                Value<DateTime?> startedReadingAt = const Value.absent(),
                Value<DateTime?> finishedReadingAt = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> reviewNotes = const Value.absent(),
                Value<String> metadataSource = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                isbn10: isbn10,
                isbn13: isbn13,
                subtitle: subtitle,
                authorsJson: authorsJson,
                publisher: publisher,
                publishedYear: publishedYear,
                pageCount: pageCount,
                language: language,
                genreTagsJson: genreTagsJson,
                seriesName: seriesName,
                seriesNumber: seriesNumber,
                edition: edition,
                bookFormat: bookFormat,
                readingStatus: readingStatus,
                currentPage: currentPage,
                personalRating: personalRating,
                startedReadingAt: startedReadingAt,
                finishedReadingAt: finishedReadingAt,
                synopsis: synopsis,
                reviewNotes: reviewNotes,
                metadataSource: metadataSource,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String itemId,
                required String householdId,
                Value<String?> isbn10 = const Value.absent(),
                Value<String?> isbn13 = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String> authorsJson = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> publishedYear = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> genreTagsJson = const Value.absent(),
                Value<String?> seriesName = const Value.absent(),
                Value<double?> seriesNumber = const Value.absent(),
                Value<String?> edition = const Value.absent(),
                Value<String> bookFormat = const Value.absent(),
                Value<String> readingStatus = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<int?> personalRating = const Value.absent(),
                Value<DateTime?> startedReadingAt = const Value.absent(),
                Value<DateTime?> finishedReadingAt = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> reviewNotes = const Value.absent(),
                Value<String> metadataSource = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                isbn10: isbn10,
                isbn13: isbn13,
                subtitle: subtitle,
                authorsJson: authorsJson,
                publisher: publisher,
                publishedYear: publishedYear,
                pageCount: pageCount,
                language: language,
                genreTagsJson: genreTagsJson,
                seriesName: seriesName,
                seriesNumber: seriesNumber,
                edition: edition,
                bookFormat: bookFormat,
                readingStatus: readingStatus,
                currentPage: currentPage,
                personalRating: personalRating,
                startedReadingAt: startedReadingAt,
                finishedReadingAt: finishedReadingAt,
                synopsis: synopsis,
                reviewNotes: reviewNotes,
                metadataSource: metadataSource,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BooksTable, Book>(table),
                  $$BooksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false, householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$BooksTableReferences._itemIdTable(
                          db,
                        ),
                        referencedColumn: $$BooksTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$BooksTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$BooksTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, $$BooksTableReferences),
      Book,
      PrefetchHooks Function({bool itemId, bool householdId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String itemId,
  required String householdId,
  Value<String?> relatedItemId,
  Value<String> docCategory,
  Value<String?> docSubtype,
  Value<String?> documentNumber,
  Value<String?> ownerMemberName,
  Value<String?> issuer,
  Value<DateTime?> issuedAt,
  Value<DateTime?> expiresAt,
  Value<bool> isOriginal,
  Value<int> copyCount,
  Value<String?> physicalFolderLabel,
  Value<bool> isVaultLocked,
  Value<String?> ocrExtractedText,
  Value<String> tagsJson,
  Value<int> rowid,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> itemId,
  Value<String> householdId,
  Value<String?> relatedItemId,
  Value<String> docCategory,
  Value<String?> docSubtype,
  Value<String?> documentNumber,
  Value<String?> ownerMemberName,
  Value<String?> issuer,
  Value<DateTime?> issuedAt,
  Value<DateTime?> expiresAt,
  Value<bool> isOriginal,
  Value<int> copyCount,
  Value<String?> physicalFolderLabel,
  Value<bool> isVaultLocked,
  Value<String?> ocrExtractedText,
  Value<String> tagsJson,
  Value<int> rowid,
});

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('documents__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('documents__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedItemId => $composableBuilder(
    column: $table.relatedItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get docCategory => $composableBuilder(
    column: $table.docCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get docSubtype => $composableBuilder(
    column: $table.docSubtype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerMemberName => $composableBuilder(
    column: $table.ownerMemberName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOriginal => $composableBuilder(
    column: $table.isOriginal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get copyCount => $composableBuilder(
    column: $table.copyCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get physicalFolderLabel => $composableBuilder(
    column: $table.physicalFolderLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVaultLocked => $composableBuilder(
    column: $table.isVaultLocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedItemId => $composableBuilder(
    column: $table.relatedItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get docCategory => $composableBuilder(
    column: $table.docCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get docSubtype => $composableBuilder(
    column: $table.docSubtype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerMemberName => $composableBuilder(
    column: $table.ownerMemberName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOriginal => $composableBuilder(
    column: $table.isOriginal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get copyCount => $composableBuilder(
    column: $table.copyCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get physicalFolderLabel => $composableBuilder(
    column: $table.physicalFolderLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVaultLocked => $composableBuilder(
    column: $table.isVaultLocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get relatedItemId => $composableBuilder(
    column: $table.relatedItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get docCategory => $composableBuilder(
    column: $table.docCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get docSubtype => $composableBuilder(
    column: $table.docSubtype,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerMemberName => $composableBuilder(
    column: $table.ownerMemberName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issuer =>
      $composableBuilder(column: $table.issuer, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get isOriginal => $composableBuilder(
    column: $table.isOriginal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get copyCount =>
      $composableBuilder(column: $table.copyCount, builder: (column) => column);

  GeneratedColumn<String> get physicalFolderLabel => $composableBuilder(
    column: $table.physicalFolderLabel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVaultLocked => $composableBuilder(
    column: $table.isVaultLocked,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool itemId, bool householdId})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String?> relatedItemId = const Value.absent(),
                Value<String> docCategory = const Value.absent(),
                Value<String?> docSubtype = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<String?> ownerMemberName = const Value.absent(),
                Value<String?> issuer = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<bool> isOriginal = const Value.absent(),
                Value<int> copyCount = const Value.absent(),
                Value<String?> physicalFolderLabel = const Value.absent(),
                Value<bool> isVaultLocked = const Value.absent(),
                Value<String?> ocrExtractedText = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                relatedItemId: relatedItemId,
                docCategory: docCategory,
                docSubtype: docSubtype,
                documentNumber: documentNumber,
                ownerMemberName: ownerMemberName,
                issuer: issuer,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                isOriginal: isOriginal,
                copyCount: copyCount,
                physicalFolderLabel: physicalFolderLabel,
                isVaultLocked: isVaultLocked,
                ocrExtractedText: ocrExtractedText,
                tagsJson: tagsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String itemId,
                required String householdId,
                Value<String?> relatedItemId = const Value.absent(),
                Value<String> docCategory = const Value.absent(),
                Value<String?> docSubtype = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<String?> ownerMemberName = const Value.absent(),
                Value<String?> issuer = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<bool> isOriginal = const Value.absent(),
                Value<int> copyCount = const Value.absent(),
                Value<String?> physicalFolderLabel = const Value.absent(),
                Value<bool> isVaultLocked = const Value.absent(),
                Value<String?> ocrExtractedText = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                relatedItemId: relatedItemId,
                docCategory: docCategory,
                docSubtype: docSubtype,
                documentNumber: documentNumber,
                ownerMemberName: ownerMemberName,
                issuer: issuer,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                isOriginal: isOriginal,
                copyCount: copyCount,
                physicalFolderLabel: physicalFolderLabel,
                isVaultLocked: isVaultLocked,
                ocrExtractedText: ocrExtractedText,
                tagsJson: tagsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false, householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$DocumentsTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$DocumentsTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$DocumentsTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$DocumentsTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool itemId, bool householdId})
    >;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String itemId,
  required String householdId,
  Value<String> vehicleKind,
  Value<String?> plateNumber,
  Value<String?> vinRangka,
  Value<String?> engineNumber,
  Value<int?> manufactureYear,
  Value<String?> fuelType,
  Value<int> currentOdometerKm,
  Value<DateTime?> stnkAnnualDueAt,
  Value<DateTime?> stnk5yrDueAt,
  Value<DateTime?> insuranceDueAt,
  Value<String?> insuranceProvider,
  Value<String?> bpkbNumber,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> itemId,
  Value<String> householdId,
  Value<String> vehicleKind,
  Value<String?> plateNumber,
  Value<String?> vinRangka,
  Value<String?> engineNumber,
  Value<int?> manufactureYear,
  Value<String?> fuelType,
  Value<int> currentOdometerKm,
  Value<DateTime?> stnkAnnualDueAt,
  Value<DateTime?> stnk5yrDueAt,
  Value<DateTime?> insuranceDueAt,
  Value<String?> insuranceProvider,
  Value<String?> bpkbNumber,
  Value<int> rowid,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('vehicles__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('vehicles__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleKind => $composableBuilder(
    column: $table.vehicleKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vinRangka => $composableBuilder(
    column: $table.vinRangka,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get manufactureYear => $composableBuilder(
    column: $table.manufactureYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get stnkAnnualDueAt => $composableBuilder(
    column: $table.stnkAnnualDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get stnk5yrDueAt => $composableBuilder(
    column: $table.stnk5yrDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get insuranceDueAt => $composableBuilder(
    column: $table.insuranceDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get insuranceProvider => $composableBuilder(
    column: $table.insuranceProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bpkbNumber => $composableBuilder(
    column: $table.bpkbNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleKind => $composableBuilder(
    column: $table.vehicleKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vinRangka => $composableBuilder(
    column: $table.vinRangka,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get manufactureYear => $composableBuilder(
    column: $table.manufactureYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get stnkAnnualDueAt => $composableBuilder(
    column: $table.stnkAnnualDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get stnk5yrDueAt => $composableBuilder(
    column: $table.stnk5yrDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get insuranceDueAt => $composableBuilder(
    column: $table.insuranceDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get insuranceProvider => $composableBuilder(
    column: $table.insuranceProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bpkbNumber => $composableBuilder(
    column: $table.bpkbNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get vehicleKind => $composableBuilder(
    column: $table.vehicleKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vinRangka =>
      $composableBuilder(column: $table.vinRangka, builder: (column) => column);

  GeneratedColumn<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get manufactureYear => $composableBuilder(
    column: $table.manufactureYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get stnkAnnualDueAt => $composableBuilder(
    column: $table.stnkAnnualDueAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get stnk5yrDueAt => $composableBuilder(
    column: $table.stnk5yrDueAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get insuranceDueAt => $composableBuilder(
    column: $table.insuranceDueAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get insuranceProvider => $composableBuilder(
    column: $table.insuranceProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bpkbNumber => $composableBuilder(
    column: $table.bpkbNumber,
    builder: (column) => column,
  );

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({bool itemId, bool householdId})
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> vehicleKind = const Value.absent(),
                Value<String?> plateNumber = const Value.absent(),
                Value<String?> vinRangka = const Value.absent(),
                Value<String?> engineNumber = const Value.absent(),
                Value<int?> manufactureYear = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
                Value<int> currentOdometerKm = const Value.absent(),
                Value<DateTime?> stnkAnnualDueAt = const Value.absent(),
                Value<DateTime?> stnk5yrDueAt = const Value.absent(),
                Value<DateTime?> insuranceDueAt = const Value.absent(),
                Value<String?> insuranceProvider = const Value.absent(),
                Value<String?> bpkbNumber = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                vehicleKind: vehicleKind,
                plateNumber: plateNumber,
                vinRangka: vinRangka,
                engineNumber: engineNumber,
                manufactureYear: manufactureYear,
                fuelType: fuelType,
                currentOdometerKm: currentOdometerKm,
                stnkAnnualDueAt: stnkAnnualDueAt,
                stnk5yrDueAt: stnk5yrDueAt,
                insuranceDueAt: insuranceDueAt,
                insuranceProvider: insuranceProvider,
                bpkbNumber: bpkbNumber,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String itemId,
                required String householdId,
                Value<String> vehicleKind = const Value.absent(),
                Value<String?> plateNumber = const Value.absent(),
                Value<String?> vinRangka = const Value.absent(),
                Value<String?> engineNumber = const Value.absent(),
                Value<int?> manufactureYear = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
                Value<int> currentOdometerKm = const Value.absent(),
                Value<DateTime?> stnkAnnualDueAt = const Value.absent(),
                Value<DateTime?> stnk5yrDueAt = const Value.absent(),
                Value<DateTime?> insuranceDueAt = const Value.absent(),
                Value<String?> insuranceProvider = const Value.absent(),
                Value<String?> bpkbNumber = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                itemId: itemId,
                householdId: householdId,
                vehicleKind: vehicleKind,
                plateNumber: plateNumber,
                vinRangka: vinRangka,
                engineNumber: engineNumber,
                manufactureYear: manufactureYear,
                fuelType: fuelType,
                currentOdometerKm: currentOdometerKm,
                stnkAnnualDueAt: stnkAnnualDueAt,
                stnk5yrDueAt: stnk5yrDueAt,
                insuranceDueAt: insuranceDueAt,
                insuranceProvider: insuranceProvider,
                bpkbNumber: bpkbNumber,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, Vehicle>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false, householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$VehiclesTableReferences._itemIdTable(
                          db,
                        ),
                        referencedColumn: $$VehiclesTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$VehiclesTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$VehiclesTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({bool itemId, bool householdId})
    >;
typedef $$VehicleServiceLogsTableCreateCompanionBuilder =
    VehicleServiceLogsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String vehicleId,
      required DateTime serviceDate,
      Value<int?> odometerKm,
      required String serviceType,
      Value<String?> workshopName,
      Value<double> totalCost,
      Value<DateTime?> nextDueDate,
      Value<int?> nextDueOdometerKm,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$VehicleServiceLogsTableUpdateCompanionBuilder =
    VehicleServiceLogsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> vehicleId,
      Value<DateTime> serviceDate,
      Value<int?> odometerKm,
      Value<String> serviceType,
      Value<String?> workshopName,
      Value<double> totalCost,
      Value<DateTime?> nextDueDate,
      Value<int?> nextDueOdometerKm,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$VehicleServiceLogsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VehicleServiceLogsTable,
          VehicleServiceLog
        > {
  $$VehicleServiceLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('vehicle_service_logs__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VehicleServiceLogsTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleServiceLogsTable> {
  $$VehicleServiceLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueOdometerKm => $composableBuilder(
    column: $table.nextDueOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleServiceLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleServiceLogsTable> {
  $$VehicleServiceLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueOdometerKm => $composableBuilder(
    column: $table.nextDueOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleServiceLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleServiceLogsTable> {
  $$VehicleServiceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextDueOdometerKm => $composableBuilder(
    column: $table.nextDueOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleServiceLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleServiceLogsTable,
          VehicleServiceLog,
          $$VehicleServiceLogsTableFilterComposer,
          $$VehicleServiceLogsTableOrderingComposer,
          $$VehicleServiceLogsTableAnnotationComposer,
          $$VehicleServiceLogsTableCreateCompanionBuilder,
          $$VehicleServiceLogsTableUpdateCompanionBuilder,
          (VehicleServiceLog, $$VehicleServiceLogsTableReferences),
          VehicleServiceLog,
          PrefetchHooks Function({bool householdId})
        > {
  $$VehicleServiceLogsTableTableManager(
    _$AppDatabase db,
    $VehicleServiceLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleServiceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleServiceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleServiceLogsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> serviceDate = const Value.absent(),
                Value<int?> odometerKm = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<String?> workshopName = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometerKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleServiceLogsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                vehicleId: vehicleId,
                serviceDate: serviceDate,
                odometerKm: odometerKm,
                serviceType: serviceType,
                workshopName: workshopName,
                totalCost: totalCost,
                nextDueDate: nextDueDate,
                nextDueOdometerKm: nextDueOdometerKm,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String vehicleId,
                required DateTime serviceDate,
                Value<int?> odometerKm = const Value.absent(),
                required String serviceType,
                Value<String?> workshopName = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometerKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleServiceLogsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                vehicleId: vehicleId,
                serviceDate: serviceDate,
                odometerKm: odometerKm,
                serviceType: serviceType,
                workshopName: workshopName,
                totalCost: totalCost,
                nextDueDate: nextDueDate,
                nextDueOdometerKm: nextDueOdometerKm,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehicleServiceLogsTable, VehicleServiceLog>(
                    table,
                  ),
                  $$VehicleServiceLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$VehicleServiceLogsTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$VehicleServiceLogsTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VehicleServiceLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleServiceLogsTable,
      VehicleServiceLog,
      $$VehicleServiceLogsTableFilterComposer,
      $$VehicleServiceLogsTableOrderingComposer,
      $$VehicleServiceLogsTableAnnotationComposer,
      $$VehicleServiceLogsTableCreateCompanionBuilder,
      $$VehicleServiceLogsTableUpdateCompanionBuilder,
      (VehicleServiceLog, $$VehicleServiceLogsTableReferences),
      VehicleServiceLog,
      PrefetchHooks Function({bool householdId})
    >;
typedef $$VehicleFuelLogsTableCreateCompanionBuilder =
    VehicleFuelLogsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String vehicleId,
      required DateTime filledAt,
      required int odometerKm,
      required double liters,
      Value<double?> pricePerLiter,
      required double totalCost,
      Value<bool> isFullTank,
      Value<double?> computedKmPerLiter,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$VehicleFuelLogsTableUpdateCompanionBuilder =
    VehicleFuelLogsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> vehicleId,
      Value<DateTime> filledAt,
      Value<int> odometerKm,
      Value<double> liters,
      Value<double?> pricePerLiter,
      Value<double> totalCost,
      Value<bool> isFullTank,
      Value<double?> computedKmPerLiter,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$VehicleFuelLogsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VehicleFuelLogsTable, VehicleFuelLog> {
  $$VehicleFuelLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('vehicle_fuel_logs__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VehicleFuelLogsTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleFuelLogsTable> {
  $$VehicleFuelLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get filledAt => $composableBuilder(
    column: $table.filledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get computedKmPerLiter => $composableBuilder(
    column: $table.computedKmPerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleFuelLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleFuelLogsTable> {
  $$VehicleFuelLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get filledAt => $composableBuilder(
    column: $table.filledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get computedKmPerLiter => $composableBuilder(
    column: $table.computedKmPerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleFuelLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleFuelLogsTable> {
  $$VehicleFuelLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get filledAt =>
      $composableBuilder(column: $table.filledAt, builder: (column) => column);

  GeneratedColumn<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => column,
  );

  GeneratedColumn<double> get computedKmPerLiter => $composableBuilder(
    column: $table.computedKmPerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleFuelLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleFuelLogsTable,
          VehicleFuelLog,
          $$VehicleFuelLogsTableFilterComposer,
          $$VehicleFuelLogsTableOrderingComposer,
          $$VehicleFuelLogsTableAnnotationComposer,
          $$VehicleFuelLogsTableCreateCompanionBuilder,
          $$VehicleFuelLogsTableUpdateCompanionBuilder,
          (VehicleFuelLog, $$VehicleFuelLogsTableReferences),
          VehicleFuelLog,
          PrefetchHooks Function({bool householdId})
        > {
  $$VehicleFuelLogsTableTableManager(
    _$AppDatabase db,
    $VehicleFuelLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleFuelLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleFuelLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleFuelLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> filledAt = const Value.absent(),
                Value<int> odometerKm = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<double?> pricePerLiter = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<double?> computedKmPerLiter = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleFuelLogsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                vehicleId: vehicleId,
                filledAt: filledAt,
                odometerKm: odometerKm,
                liters: liters,
                pricePerLiter: pricePerLiter,
                totalCost: totalCost,
                isFullTank: isFullTank,
                computedKmPerLiter: computedKmPerLiter,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String vehicleId,
                required DateTime filledAt,
                required int odometerKm,
                required double liters,
                Value<double?> pricePerLiter = const Value.absent(),
                required double totalCost,
                Value<bool> isFullTank = const Value.absent(),
                Value<double?> computedKmPerLiter = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleFuelLogsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                vehicleId: vehicleId,
                filledAt: filledAt,
                odometerKm: odometerKm,
                liters: liters,
                pricePerLiter: pricePerLiter,
                totalCost: totalCost,
                isFullTank: isFullTank,
                computedKmPerLiter: computedKmPerLiter,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehicleFuelLogsTable, VehicleFuelLog>(table),
                  $$VehicleFuelLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$VehicleFuelLogsTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$VehicleFuelLogsTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VehicleFuelLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleFuelLogsTable,
      VehicleFuelLog,
      $$VehicleFuelLogsTableFilterComposer,
      $$VehicleFuelLogsTableOrderingComposer,
      $$VehicleFuelLogsTableAnnotationComposer,
      $$VehicleFuelLogsTableCreateCompanionBuilder,
      $$VehicleFuelLogsTableUpdateCompanionBuilder,
      (VehicleFuelLog, $$VehicleFuelLogsTableReferences),
      VehicleFuelLog,
      PrefetchHooks Function({bool householdId})
    >;
typedef $$MovingProjectsTableCreateCompanionBuilder =
    MovingProjectsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String name,
      Value<String?> originAddress,
      Value<String?> destinationAddress,
      Value<DateTime?> targetMoveDate,
      Value<String> status,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$MovingProjectsTableUpdateCompanionBuilder =
    MovingProjectsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> name,
      Value<String?> originAddress,
      Value<String?> destinationAddress,
      Value<DateTime?> targetMoveDate,
      Value<String> status,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$MovingProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $MovingProjectsTable, MovingProject> {
  $$MovingProjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) => db.households
      .createAlias('moving_projects__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovingBoxesTable, List<MovingBox>>
  _movingBoxesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movingBoxes,
    aliasName: 'moving_projects__id__moving_boxes__project_id',
  );

  $$MovingBoxesTableProcessedTableManager get movingBoxesRefs {
    final manager = $$MovingBoxesTableTableManager(
      $_db,
      $_db.movingBoxes,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_movingBoxesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MovingProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $MovingProjectsTable> {
  $$MovingProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originAddress => $composableBuilder(
    column: $table.originAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationAddress => $composableBuilder(
    column: $table.destinationAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetMoveDate => $composableBuilder(
    column: $table.targetMoveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movingBoxesRefs(
    Expression<bool> Function($$MovingBoxesTableFilterComposer f) f,
  ) {
    final $$MovingBoxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableFilterComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovingProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovingProjectsTable> {
  $$MovingProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originAddress => $composableBuilder(
    column: $table.originAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationAddress => $composableBuilder(
    column: $table.destinationAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetMoveDate => $composableBuilder(
    column: $table.targetMoveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovingProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovingProjectsTable> {
  $$MovingProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get originAddress => $composableBuilder(
    column: $table.originAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationAddress => $composableBuilder(
    column: $table.destinationAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetMoveDate => $composableBuilder(
    column: $table.targetMoveDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movingBoxesRefs<T extends Object>(
    Expression<T> Function($$MovingBoxesTableAnnotationComposer a) f,
  ) {
    final $$MovingBoxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movingBoxes,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingBoxesTableAnnotationComposer(
            $db: $db,
            $table: $db.movingBoxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MovingProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovingProjectsTable,
          MovingProject,
          $$MovingProjectsTableFilterComposer,
          $$MovingProjectsTableOrderingComposer,
          $$MovingProjectsTableAnnotationComposer,
          $$MovingProjectsTableCreateCompanionBuilder,
          $$MovingProjectsTableUpdateCompanionBuilder,
          (MovingProject, $$MovingProjectsTableReferences),
          MovingProject,
          PrefetchHooks Function({bool householdId, bool movingBoxesRefs})
        > {
  $$MovingProjectsTableTableManager(
    _$AppDatabase db,
    $MovingProjectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovingProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovingProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovingProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> originAddress = const Value.absent(),
                Value<String?> destinationAddress = const Value.absent(),
                Value<DateTime?> targetMoveDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovingProjectsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                name: name,
                originAddress: originAddress,
                destinationAddress: destinationAddress,
                targetMoveDate: targetMoveDate,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String name,
                Value<String?> originAddress = const Value.absent(),
                Value<String?> destinationAddress = const Value.absent(),
                Value<DateTime?> targetMoveDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovingProjectsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                name: name,
                originAddress: originAddress,
                destinationAddress: destinationAddress,
                targetMoveDate: targetMoveDate,
                status: status,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovingProjectsTable, MovingProject>(table),
                  $$MovingProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({householdId = false, movingBoxesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (movingBoxesRefs) db.movingBoxes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$MovingProjectsTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$MovingProjectsTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movingBoxesRefs)
                        await $_getPrefetchedDataByColumns<
                          MovingProject,
                          $MovingProjectsTable,
                          MovingBox,
                          $MovingBoxesTable
                        >(
                          currentTable: table,
                          referencedTable: $$MovingProjectsTableReferences
                              ._movingBoxesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MovingProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).movingBoxesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MovingProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovingProjectsTable,
      MovingProject,
      $$MovingProjectsTableFilterComposer,
      $$MovingProjectsTableOrderingComposer,
      $$MovingProjectsTableAnnotationComposer,
      $$MovingProjectsTableCreateCompanionBuilder,
      $$MovingProjectsTableUpdateCompanionBuilder,
      (MovingProject, $$MovingProjectsTableReferences),
      MovingProject,
      PrefetchHooks Function({bool householdId, bool movingBoxesRefs})
    >;
typedef $$MovingBoxesTableCreateCompanionBuilder =
    MovingBoxesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String householdId,
      required String projectId,
      required String locationId,
      required String boxCode,
      required String labelQr,
      Value<String?> destinationRoom,
      Value<String> status,
      Value<bool> isFragile,
      Value<String> priority,
      Value<double?> weightKg,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$MovingBoxesTableUpdateCompanionBuilder =
    MovingBoxesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> householdId,
      Value<String> projectId,
      Value<String> locationId,
      Value<String> boxCode,
      Value<String> labelQr,
      Value<String?> destinationRoom,
      Value<String> status,
      Value<bool> isFragile,
      Value<String> priority,
      Value<double?> weightKg,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$MovingBoxesTableReferences
    extends BaseReferences<_$AppDatabase, $MovingBoxesTable, MovingBox> {
  $$MovingBoxesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('moving_boxes__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MovingProjectsTable _projectIdTable(_$AppDatabase db) => db
      .movingProjects
      .createAlias('moving_boxes__project_id__moving_projects__id');

  $$MovingProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$MovingProjectsTableTableManager(
      $_db,
      $_db.movingProjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocationsTable _locationIdTable(_$AppDatabase db) =>
      db.locations.createAlias('moving_boxes__location_id__locations__id');

  $$LocationsTableProcessedTableManager get locationId {
    final $_column = $_itemColumn<String>('location_id')!;

    final manager = $$LocationsTableTableManager(
      $_db,
      $_db.locations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovingBoxesTableFilterComposer
    extends Composer<_$AppDatabase, $MovingBoxesTable> {
  $$MovingBoxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boxCode => $composableBuilder(
    column: $table.boxCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelQr => $composableBuilder(
    column: $table.labelQr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationRoom => $composableBuilder(
    column: $table.destinationRoom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFragile => $composableBuilder(
    column: $table.isFragile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovingProjectsTableFilterComposer get projectId {
    final $$MovingProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.movingProjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingProjectsTableFilterComposer(
            $db: $db,
            $table: $db.movingProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableFilterComposer get locationId {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableFilterComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovingBoxesTableOrderingComposer
    extends Composer<_$AppDatabase, $MovingBoxesTable> {
  $$MovingBoxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boxCode => $composableBuilder(
    column: $table.boxCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelQr => $composableBuilder(
    column: $table.labelQr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationRoom => $composableBuilder(
    column: $table.destinationRoom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFragile => $composableBuilder(
    column: $table.isFragile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovingProjectsTableOrderingComposer get projectId {
    final $$MovingProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.movingProjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.movingProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableOrderingComposer get locationId {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableOrderingComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovingBoxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovingBoxesTable> {
  $$MovingBoxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boxCode =>
      $composableBuilder(column: $table.boxCode, builder: (column) => column);

  GeneratedColumn<String> get labelQr =>
      $composableBuilder(column: $table.labelQr, builder: (column) => column);

  GeneratedColumn<String> get destinationRoom => $composableBuilder(
    column: $table.destinationRoom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isFragile =>
      $composableBuilder(column: $table.isFragile, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MovingProjectsTableAnnotationComposer get projectId {
    final $$MovingProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.movingProjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovingProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.movingProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableAnnotationComposer get locationId {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovingBoxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovingBoxesTable,
          MovingBox,
          $$MovingBoxesTableFilterComposer,
          $$MovingBoxesTableOrderingComposer,
          $$MovingBoxesTableAnnotationComposer,
          $$MovingBoxesTableCreateCompanionBuilder,
          $$MovingBoxesTableUpdateCompanionBuilder,
          (MovingBox, $$MovingBoxesTableReferences),
          MovingBox,
          PrefetchHooks Function({
            bool householdId,
            bool projectId,
            bool locationId,
          })
        > {
  $$MovingBoxesTableTableManager(_$AppDatabase db, $MovingBoxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovingBoxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovingBoxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovingBoxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> boxCode = const Value.absent(),
                Value<String> labelQr = const Value.absent(),
                Value<String?> destinationRoom = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isFragile = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovingBoxesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                projectId: projectId,
                locationId: locationId,
                boxCode: boxCode,
                labelQr: labelQr,
                destinationRoom: destinationRoom,
                status: status,
                isFragile: isFragile,
                priority: priority,
                weightKg: weightKg,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                required String projectId,
                required String locationId,
                required String boxCode,
                required String labelQr,
                Value<String?> destinationRoom = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isFragile = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovingBoxesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                projectId: projectId,
                locationId: locationId,
                boxCode: boxCode,
                labelQr: labelQr,
                destinationRoom: destinationRoom,
                status: status,
                isFragile: isFragile,
                priority: priority,
                weightKg: weightKg,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovingBoxesTable, MovingBox>(table),
                  $$MovingBoxesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({householdId = false, projectId = false, locationId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (householdId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.householdId,
                            referencedTable: $$MovingBoxesTableReferences
                                ._householdIdTable(db),
                            referencedColumn: $$MovingBoxesTableReferences
                                ._householdIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (projectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.projectId,
                            referencedTable: $$MovingBoxesTableReferences
                                ._projectIdTable(db),
                            referencedColumn: $$MovingBoxesTableReferences
                                ._projectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (locationId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.locationId,
                            referencedTable: $$MovingBoxesTableReferences
                                ._locationIdTable(db),
                            referencedColumn: $$MovingBoxesTableReferences
                                ._locationIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MovingBoxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovingBoxesTable,
      MovingBox,
      $$MovingBoxesTableFilterComposer,
      $$MovingBoxesTableOrderingComposer,
      $$MovingBoxesTableAnnotationComposer,
      $$MovingBoxesTableCreateCompanionBuilder,
      $$MovingBoxesTableUpdateCompanionBuilder,
      (MovingBox, $$MovingBoxesTableReferences),
      MovingBox,
      PrefetchHooks Function({
        bool householdId,
        bool projectId,
        bool locationId,
      })
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String id,
  required String householdId,
  Value<String?> itemId,
  required String kind,
  required String title,
  Value<DateTime?> dueAt,
  Value<int?> dueOdometerKm,
  Value<int> remindDaysBefore,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> householdId,
  Value<String?> itemId,
  Value<String> kind,
  Value<String> title,
  Value<DateTime?> dueAt,
  Value<int?> dueOdometerKm,
  Value<int> remindDaysBefore,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HouseholdsTable _householdIdTable(_$AppDatabase db) =>
      db.households.createAlias('reminders__household_id__households__id');

  $$HouseholdsTableProcessedTableManager get householdId {
    final $_column = $_itemColumn<String>('household_id')!;

    final manager = $$HouseholdsTableTableManager(
      $_db,
      $_db.households,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_householdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueOdometerKm => $composableBuilder(
    column: $table.dueOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HouseholdsTableFilterComposer get householdId {
    final $$HouseholdsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableFilterComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueOdometerKm => $composableBuilder(
    column: $table.dueOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HouseholdsTableOrderingComposer get householdId {
    final $$HouseholdsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableOrderingComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<int> get dueOdometerKm => $composableBuilder(
    column: $table.dueOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$HouseholdsTableAnnotationComposer get householdId {
    final $$HouseholdsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.householdId,
      referencedTable: $db.households,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HouseholdsTableAnnotationComposer(
            $db: $db,
            $table: $db.households,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, $$RemindersTableReferences),
          Reminder,
          PrefetchHooks Function({bool householdId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String?> itemId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<int?> dueOdometerKm = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                kind: kind,
                title: title,
                dueAt: dueAt,
                dueOdometerKm: dueOdometerKm,
                remindDaysBefore: remindDaysBefore,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String householdId,
                Value<String?> itemId = const Value.absent(),
                required String kind,
                required String title,
                Value<DateTime?> dueAt = const Value.absent(),
                Value<int?> dueOdometerKm = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                householdId: householdId,
                itemId: itemId,
                kind: kind,
                title: title,
                dueAt: dueAt,
                dueOdometerKm: dueOdometerKm,
                remindDaysBefore: remindDaysBefore,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({householdId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (householdId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.householdId,
                        referencedTable: $$RemindersTableReferences
                            ._householdIdTable(db),
                        referencedColumn: $$RemindersTableReferences
                            ._householdIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, $$RemindersTableReferences),
      Reminder,
      PrefetchHooks Function({bool householdId})
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder = SyncOutboxCompanion Function({
  Value<int> id,
  required String targetTable,
  required String recordId,
  required String householdId,
  required String operation,
  required String payloadJson,
  Value<DateTime> queuedAt,
  Value<int> retryCount,
  Value<String?> lastError,
});
typedef $$SyncOutboxTableUpdateCompanionBuilder = SyncOutboxCompanion Function({
  Value<int> id,
  Value<String> targetTable,
  Value<String> recordId,
  Value<String> householdId,
  Value<String> operation,
  Value<String> payloadJson,
  Value<DateTime> queuedAt,
  Value<int> retryCount,
  Value<String?> lastError,
});

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxData,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxData,
            BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxData>,
          ),
          SyncOutboxData,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> queuedAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncOutboxCompanion(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                householdId: householdId,
                operation: operation,
                payloadJson: payloadJson,
                queuedAt: queuedAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String targetTable,
                required String recordId,
                required String householdId,
                required String operation,
                required String payloadJson,
                Value<DateTime> queuedAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                id: id,
                targetTable: targetTable,
                recordId: recordId,
                householdId: householdId,
                operation: operation,
                payloadJson: payloadJson,
                queuedAt: queuedAt,
                retryCount: retryCount,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncOutboxTable, SyncOutboxData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncOutboxTable,
                    SyncOutboxData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxData,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxData,
        BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxData>,
      ),
      SyncOutboxData,
      PrefetchHooks Function()
    >;
typedef $$SyncCheckpointsTableCreateCompanionBuilder =
    SyncCheckpointsCompanion Function({
      required String targetTable,
      required DateTime lastPulledAt,
      Value<int> rowid,
    });
typedef $$SyncCheckpointsTableUpdateCompanionBuilder =
    SyncCheckpointsCompanion Function({
      Value<String> targetTable,
      Value<DateTime> lastPulledAt,
      Value<int> rowid,
    });

class $$SyncCheckpointsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncCheckpointsTable> {
  $$SyncCheckpointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncCheckpointsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncCheckpointsTable> {
  $$SyncCheckpointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncCheckpointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncCheckpointsTable> {
  $$SyncCheckpointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPulledAt => $composableBuilder(
    column: $table.lastPulledAt,
    builder: (column) => column,
  );
}

class $$SyncCheckpointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncCheckpointsTable,
          SyncCheckpoint,
          $$SyncCheckpointsTableFilterComposer,
          $$SyncCheckpointsTableOrderingComposer,
          $$SyncCheckpointsTableAnnotationComposer,
          $$SyncCheckpointsTableCreateCompanionBuilder,
          $$SyncCheckpointsTableUpdateCompanionBuilder,
          (
            SyncCheckpoint,
            BaseReferences<
              _$AppDatabase,
              $SyncCheckpointsTable,
              SyncCheckpoint
            >,
          ),
          SyncCheckpoint,
          PrefetchHooks Function()
        > {
  $$SyncCheckpointsTableTableManager(
    _$AppDatabase db,
    $SyncCheckpointsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncCheckpointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncCheckpointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncCheckpointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> targetTable = const Value.absent(),
                Value<DateTime> lastPulledAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCheckpointsCompanion(
                targetTable: targetTable,
                lastPulledAt: lastPulledAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String targetTable,
                required DateTime lastPulledAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncCheckpointsCompanion.insert(
                targetTable: targetTable,
                lastPulledAt: lastPulledAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncCheckpointsTable, SyncCheckpoint>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncCheckpointsTable,
                    SyncCheckpoint
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncCheckpointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncCheckpointsTable,
      SyncCheckpoint,
      $$SyncCheckpointsTableFilterComposer,
      $$SyncCheckpointsTableOrderingComposer,
      $$SyncCheckpointsTableAnnotationComposer,
      $$SyncCheckpointsTableCreateCompanionBuilder,
      $$SyncCheckpointsTableUpdateCompanionBuilder,
      (
        SyncCheckpoint,
        BaseReferences<_$AppDatabase, $SyncCheckpointsTable, SyncCheckpoint>,
      ),
      SyncCheckpoint,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db, _db.households);
  $$HouseholdMembersTableTableManager get householdMembers =>
      $$HouseholdMembersTableTableManager(_db, _db.householdMembers);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$ItemAttachmentsTableTableManager get itemAttachments =>
      $$ItemAttachmentsTableTableManager(_db, _db.itemAttachments);
  $$AssetLoansTableTableManager get assetLoans =>
      $$AssetLoansTableTableManager(_db, _db.assetLoans);
  $$UsageLogsTableTableManager get usageLogs =>
      $$UsageLogsTableTableManager(_db, _db.usageLogs);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$VehicleServiceLogsTableTableManager get vehicleServiceLogs =>
      $$VehicleServiceLogsTableTableManager(_db, _db.vehicleServiceLogs);
  $$VehicleFuelLogsTableTableManager get vehicleFuelLogs =>
      $$VehicleFuelLogsTableTableManager(_db, _db.vehicleFuelLogs);
  $$MovingProjectsTableTableManager get movingProjects =>
      $$MovingProjectsTableTableManager(_db, _db.movingProjects);
  $$MovingBoxesTableTableManager get movingBoxes =>
      $$MovingBoxesTableTableManager(_db, _db.movingBoxes);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$SyncCheckpointsTableTableManager get syncCheckpoints =>
      $$SyncCheckpointsTableTableManager(_db, _db.syncCheckpoints);
}
