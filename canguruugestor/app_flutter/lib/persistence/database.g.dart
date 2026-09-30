// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Profiles extends Table with TableInfo<Profiles, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Profiles(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (currency = \'BRL\')',
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currency,
    locale,
    timezone,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  Profiles createAlias(String alias) {
    return Profiles(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String currency;
  final String locale;
  final String timezone;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const Profile({
    required this.id,
    required this.currency,
    required this.locale,
    required this.timezone,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['currency'] = Variable<String>(currency);
    map['locale'] = Variable<String>(locale);
    map['timezone'] = Variable<String>(timezone);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      currency: Value(currency),
      locale: Value(locale),
      timezone: Value(timezone),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      currency: serializer.fromJson<String>(json['currency']),
      locale: serializer.fromJson<String>(json['locale']),
      timezone: serializer.fromJson<String>(json['timezone']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'currency': serializer.toJson<String>(currency),
      'locale': serializer.toJson<String>(locale),
      'timezone': serializer.toJson<String>(timezone),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  Profile copyWith({
    String? id,
    String? currency,
    String? locale,
    String? timezone,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => Profile(
    id: id ?? this.id,
    currency: currency ?? this.currency,
    locale: locale ?? this.locale,
    timezone: timezone ?? this.timezone,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      currency: data.currency.present ? data.currency.value : this.currency,
      locale: data.locale.present ? data.locale.value : this.locale,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('locale: $locale, ')
          ..write('timezone: $timezone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currency,
    locale,
    timezone,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.currency == this.currency &&
          other.locale == this.locale &&
          other.timezone == this.timezone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> currency;
  final Value<String> locale;
  final Value<String> timezone;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.locale = const Value.absent(),
    this.timezone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String currency,
    required String locale,
    required String timezone,
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       currency = Value(currency),
       locale = Value(locale),
       timezone = Value(timezone),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? currency,
    Expression<String>? locale,
    Expression<String>? timezone,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currency != null) 'currency': currency,
      if (locale != null) 'locale': locale,
      if (timezone != null) 'timezone': timezone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? currency,
    Value<String>? locale,
    Value<String>? timezone,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      locale: locale ?? this.locale,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('locale: $locale, ')
          ..write('timezone: $timezone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class LedgerAccounts extends Table
    with TableInfo<LedgerAccounts, LedgerAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LedgerAccounts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'asset\', \'income\', \'expense\', \'equity\', \'liability\'))',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileId, kind, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  LedgerAccounts createAlias(String alias) {
    return LedgerAccounts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class LedgerAccount extends DataClass implements Insertable<LedgerAccount> {
  final String id;
  final String profileId;
  final String kind;
  final String createdAt;
  const LedgerAccount({
    required this.id,
    required this.profileId,
    required this.kind,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['kind'] = Variable<String>(kind);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  LedgerAccountsCompanion toCompanion(bool nullToAbsent) {
    return LedgerAccountsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      kind: Value(kind),
      createdAt: Value(createdAt),
    );
  }

  factory LedgerAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerAccount(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      kind: serializer.fromJson<String>(json['kind']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'kind': serializer.toJson<String>(kind),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  LedgerAccount copyWith({
    String? id,
    String? profileId,
    String? kind,
    String? createdAt,
  }) => LedgerAccount(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    kind: kind ?? this.kind,
    createdAt: createdAt ?? this.createdAt,
  );
  LedgerAccount copyWithCompanion(LedgerAccountsCompanion data) {
    return LedgerAccount(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      kind: data.kind.present ? data.kind.value : this.kind,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerAccount(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, kind, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerAccount &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.kind == this.kind &&
          other.createdAt == this.createdAt);
}

class LedgerAccountsCompanion extends UpdateCompanion<LedgerAccount> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> kind;
  final Value<String> createdAt;
  final Value<int> rowid;
  const LedgerAccountsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.kind = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LedgerAccountsCompanion.insert({
    required String id,
    required String profileId,
    required String kind,
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       kind = Value(kind),
       createdAt = Value(createdAt);
  static Insertable<LedgerAccount> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? kind,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (kind != null) 'kind': kind,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LedgerAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? kind,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return LedgerAccountsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      kind: kind ?? this.kind,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerAccountsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Accounts extends Table with TableInfo<Accounts, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Accounts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY REFERENCES ledger_accounts(id)',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) BETWEEN 1 AND 80)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (kind IN (\'bank\', \'wallet\'))',
  );
  static const VerificationMeta _openedOnMeta = const VerificationMeta(
    'openedOn',
  );
  late final GeneratedColumn<String> openedOn = GeneratedColumn<String>(
    'opened_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  late final GeneratedColumn<int> archived = GeneratedColumn<int>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (archived IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    kind,
    openedOn,
    archived,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
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
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('opened_on')) {
      context.handle(
        _openedOnMeta,
        openedOn.isAcceptableOrUnknown(data['opened_on']!, _openedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_openedOnMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      openedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opened_on'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  Accounts createAlias(String alias) {
    return Accounts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String profileId;
  final String name;
  final String kind;
  final String openedOn;
  final int archived;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const Account({
    required this.id,
    required this.profileId,
    required this.name,
    required this.kind,
    required this.openedOn,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['opened_on'] = Variable<String>(openedOn);
    map['archived'] = Variable<int>(archived);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      kind: Value(kind),
      openedOn: Value(openedOn),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      openedOn: serializer.fromJson<String>(json['opened_on']),
      archived: serializer.fromJson<int>(json['archived']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'opened_on': serializer.toJson<String>(openedOn),
      'archived': serializer.toJson<int>(archived),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  Account copyWith({
    String? id,
    String? profileId,
    String? name,
    String? kind,
    String? openedOn,
    int? archived,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => Account(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    openedOn: openedOn ?? this.openedOn,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      openedOn: data.openedOn.present ? data.openedOn.value : this.openedOn,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('openedOn: $openedOn, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    name,
    kind,
    openedOn,
    archived,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.openedOn == this.openedOn &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> openedOn;
  final Value<int> archived;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.openedOn = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    required String kind,
    required String openedOn,
    this.archived = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       kind = Value(kind),
       openedOn = Value(openedOn),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? openedOn,
    Expression<int>? archived,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (openedOn != null) 'opened_on': openedOn,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? openedOn,
    Value<int>? archived,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      openedOn: openedOn ?? this.openedOn,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (openedOn.present) {
      map['opened_on'] = Variable<String>(openedOn.value);
    }
    if (archived.present) {
      map['archived'] = Variable<int>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('openedOn: $openedOn, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Categories extends Table with TableInfo<Categories, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) BETWEEN 1 AND 80)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (kind IN (\'income\', \'expense\'))',
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES categories(id)',
  );
  static const VerificationMeta _costNatureMeta = const VerificationMeta(
    'costNature',
  );
  late final GeneratedColumn<String> costNature = GeneratedColumn<String>(
    'cost_nature',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (cost_nature IN (\'fixed\', \'variable\'))',
  );
  static const VerificationMeta _essentialMeta = const VerificationMeta(
    'essential',
  );
  late final GeneratedColumn<int> essential = GeneratedColumn<int>(
    'essential',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (essential IN (0, 1))',
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  late final GeneratedColumn<int> archived = GeneratedColumn<int>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (archived IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    kind,
    parentId,
    costNature,
    essential,
    archived,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
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
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('cost_nature')) {
      context.handle(
        _costNatureMeta,
        costNature.isAcceptableOrUnknown(data['cost_nature']!, _costNatureMeta),
      );
    } else if (isInserting) {
      context.missing(_costNatureMeta);
    }
    if (data.containsKey('essential')) {
      context.handle(
        _essentialMeta,
        essential.isAcceptableOrUnknown(data['essential']!, _essentialMeta),
      );
    } else if (isInserting) {
      context.missing(_essentialMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      costNature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_nature'],
      )!,
      essential: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}essential'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'CHECK(parent_id IS NULL OR parent_id != id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String profileId;
  final String name;
  final String kind;
  final String? parentId;
  final String costNature;
  final int essential;
  final int archived;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const Category({
    required this.id,
    required this.profileId,
    required this.name,
    required this.kind,
    this.parentId,
    required this.costNature,
    required this.essential,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['cost_nature'] = Variable<String>(costNature);
    map['essential'] = Variable<int>(essential);
    map['archived'] = Variable<int>(archived);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      kind: Value(kind),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      costNature: Value(costNature),
      essential: Value(essential),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      parentId: serializer.fromJson<String?>(json['parent_id']),
      costNature: serializer.fromJson<String>(json['cost_nature']),
      essential: serializer.fromJson<int>(json['essential']),
      archived: serializer.fromJson<int>(json['archived']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'parent_id': serializer.toJson<String?>(parentId),
      'cost_nature': serializer.toJson<String>(costNature),
      'essential': serializer.toJson<int>(essential),
      'archived': serializer.toJson<int>(archived),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  Category copyWith({
    String? id,
    String? profileId,
    String? name,
    String? kind,
    Value<String?> parentId = const Value.absent(),
    String? costNature,
    int? essential,
    int? archived,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => Category(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    parentId: parentId.present ? parentId.value : this.parentId,
    costNature: costNature ?? this.costNature,
    essential: essential ?? this.essential,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      costNature: data.costNature.present
          ? data.costNature.value
          : this.costNature,
      essential: data.essential.present ? data.essential.value : this.essential,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    name,
    kind,
    parentId,
    costNature,
    essential,
    archived,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.parentId == this.parentId &&
          other.costNature == this.costNature &&
          other.essential == this.essential &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> parentId;
  final Value<String> costNature;
  final Value<int> essential;
  final Value<int> archived;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.parentId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    required String kind,
    this.parentId = const Value.absent(),
    required String costNature,
    required int essential,
    this.archived = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       kind = Value(kind),
       costNature = Value(costNature),
       essential = Value(essential),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? parentId,
    Expression<String>? costNature,
    Expression<int>? essential,
    Expression<int>? archived,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (parentId != null) 'parent_id': parentId,
      if (costNature != null) 'cost_nature': costNature,
      if (essential != null) 'essential': essential,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? parentId,
    Value<String>? costNature,
    Value<int>? essential,
    Value<int>? archived,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      parentId: parentId ?? this.parentId,
      costNature: costNature ?? this.costNature,
      essential: essential ?? this.essential,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (costNature.present) {
      map['cost_nature'] = Variable<String>(costNature.value);
    }
    if (essential.present) {
      map['essential'] = Variable<int>(essential.value);
    }
    if (archived.present) {
      map['archived'] = Variable<int>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('parentId: $parentId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class FinancialEvents extends Table
    with TableInfo<FinancialEvents, FinancialEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FinancialEvents(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'opening_balance\', \'income\', \'expense\', \'transfer\', \'reversal\', \'card_purchase\', \'card_opening\', \'card_payment\'))',
  );
  static const VerificationMeta _effectiveDateMeta = const VerificationMeta(
    'effectiveDate',
  );
  late final GeneratedColumn<String> effectiveDate = GeneratedColumn<String>(
    'effective_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (length(trim(description)) BETWEEN 1 AND 160)',
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _reversalOfMeta = const VerificationMeta(
    'reversalOf',
  );
  late final GeneratedColumn<String> reversalOf = GeneratedColumn<String>(
    'reversal_of',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'UNIQUE REFERENCES financial_events(id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    kind,
    effectiveDate,
    description,
    idempotencyKey,
    reversalOf,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('effective_date')) {
      context.handle(
        _effectiveDateMeta,
        effectiveDate.isAcceptableOrUnknown(
          data['effective_date']!,
          _effectiveDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('reversal_of')) {
      context.handle(
        _reversalOfMeta,
        reversalOf.isAcceptableOrUnknown(data['reversal_of']!, _reversalOfMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, idempotencyKey},
  ];
  @override
  FinancialEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      effectiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      reversalOf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reversal_of'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  FinancialEvents createAlias(String alias) {
    return FinancialEvents(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(profile_id, idempotency_key)',
    'CHECK((kind = \'reversal\' AND reversal_of IS NOT NULL)OR(kind != \'reversal\' AND reversal_of IS NULL))',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class FinancialEvent extends DataClass implements Insertable<FinancialEvent> {
  final String id;
  final String profileId;
  final String kind;
  final String effectiveDate;
  final String description;
  final String idempotencyKey;
  final String? reversalOf;
  final String createdAt;
  const FinancialEvent({
    required this.id,
    required this.profileId,
    required this.kind,
    required this.effectiveDate,
    required this.description,
    required this.idempotencyKey,
    this.reversalOf,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['kind'] = Variable<String>(kind);
    map['effective_date'] = Variable<String>(effectiveDate);
    map['description'] = Variable<String>(description);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    if (!nullToAbsent || reversalOf != null) {
      map['reversal_of'] = Variable<String>(reversalOf);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  FinancialEventsCompanion toCompanion(bool nullToAbsent) {
    return FinancialEventsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      kind: Value(kind),
      effectiveDate: Value(effectiveDate),
      description: Value(description),
      idempotencyKey: Value(idempotencyKey),
      reversalOf: reversalOf == null && nullToAbsent
          ? const Value.absent()
          : Value(reversalOf),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialEvent(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      kind: serializer.fromJson<String>(json['kind']),
      effectiveDate: serializer.fromJson<String>(json['effective_date']),
      description: serializer.fromJson<String>(json['description']),
      idempotencyKey: serializer.fromJson<String>(json['idempotency_key']),
      reversalOf: serializer.fromJson<String?>(json['reversal_of']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'kind': serializer.toJson<String>(kind),
      'effective_date': serializer.toJson<String>(effectiveDate),
      'description': serializer.toJson<String>(description),
      'idempotency_key': serializer.toJson<String>(idempotencyKey),
      'reversal_of': serializer.toJson<String?>(reversalOf),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  FinancialEvent copyWith({
    String? id,
    String? profileId,
    String? kind,
    String? effectiveDate,
    String? description,
    String? idempotencyKey,
    Value<String?> reversalOf = const Value.absent(),
    String? createdAt,
  }) => FinancialEvent(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    kind: kind ?? this.kind,
    effectiveDate: effectiveDate ?? this.effectiveDate,
    description: description ?? this.description,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    reversalOf: reversalOf.present ? reversalOf.value : this.reversalOf,
    createdAt: createdAt ?? this.createdAt,
  );
  FinancialEvent copyWithCompanion(FinancialEventsCompanion data) {
    return FinancialEvent(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      kind: data.kind.present ? data.kind.value : this.kind,
      effectiveDate: data.effectiveDate.present
          ? data.effectiveDate.value
          : this.effectiveDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      reversalOf: data.reversalOf.present
          ? data.reversalOf.value
          : this.reversalOf,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialEvent(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('kind: $kind, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('description: $description, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('reversalOf: $reversalOf, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    kind,
    effectiveDate,
    description,
    idempotencyKey,
    reversalOf,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialEvent &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.kind == this.kind &&
          other.effectiveDate == this.effectiveDate &&
          other.description == this.description &&
          other.idempotencyKey == this.idempotencyKey &&
          other.reversalOf == this.reversalOf &&
          other.createdAt == this.createdAt);
}

class FinancialEventsCompanion extends UpdateCompanion<FinancialEvent> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> kind;
  final Value<String> effectiveDate;
  final Value<String> description;
  final Value<String> idempotencyKey;
  final Value<String?> reversalOf;
  final Value<String> createdAt;
  final Value<int> rowid;
  const FinancialEventsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.kind = const Value.absent(),
    this.effectiveDate = const Value.absent(),
    this.description = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.reversalOf = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialEventsCompanion.insert({
    required String id,
    required String profileId,
    required String kind,
    required String effectiveDate,
    required String description,
    required String idempotencyKey,
    this.reversalOf = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       kind = Value(kind),
       effectiveDate = Value(effectiveDate),
       description = Value(description),
       idempotencyKey = Value(idempotencyKey),
       createdAt = Value(createdAt);
  static Insertable<FinancialEvent> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? kind,
    Expression<String>? effectiveDate,
    Expression<String>? description,
    Expression<String>? idempotencyKey,
    Expression<String>? reversalOf,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (kind != null) 'kind': kind,
      if (effectiveDate != null) 'effective_date': effectiveDate,
      if (description != null) 'description': description,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (reversalOf != null) 'reversal_of': reversalOf,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? kind,
    Value<String>? effectiveDate,
    Value<String>? description,
    Value<String>? idempotencyKey,
    Value<String?>? reversalOf,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return FinancialEventsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      kind: kind ?? this.kind,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      description: description ?? this.description,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      reversalOf: reversalOf ?? this.reversalOf,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (effectiveDate.present) {
      map['effective_date'] = Variable<String>(effectiveDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (reversalOf.present) {
      map['reversal_of'] = Variable<String>(reversalOf.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialEventsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('kind: $kind, ')
          ..write('effectiveDate: $effectiveDate, ')
          ..write('description: $description, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('reversalOf: $reversalOf, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Postings extends Table with TableInfo<Postings, Posting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Postings(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES financial_events(id)',
  );
  static const VerificationMeta _ledgerAccountIdMeta = const VerificationMeta(
    'ledgerAccountId',
  );
  late final GeneratedColumn<String> ledgerAccountId = GeneratedColumn<String>(
    'ledger_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES ledger_accounts(id)',
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (sequence IN (0, 1))',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents != 0 AND amount_cents BETWEEN -9007199254740991 AND 9007199254740991)',
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES categories(id)',
  );
  static const VerificationMeta _costNatureMeta = const VerificationMeta(
    'costNature',
  );
  late final GeneratedColumn<String> costNature = GeneratedColumn<String>(
    'cost_nature',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (cost_nature IN (\'fixed\', \'variable\'))',
  );
  static const VerificationMeta _essentialMeta = const VerificationMeta(
    'essential',
  );
  late final GeneratedColumn<int> essential = GeneratedColumn<int>(
    'essential',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (essential IN (0, 1))',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    eventId,
    ledgerAccountId,
    sequence,
    amountCents,
    categoryId,
    costNature,
    essential,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'postings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Posting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('ledger_account_id')) {
      context.handle(
        _ledgerAccountIdMeta,
        ledgerAccountId.isAcceptableOrUnknown(
          data['ledger_account_id']!,
          _ledgerAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ledgerAccountIdMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('cost_nature')) {
      context.handle(
        _costNatureMeta,
        costNature.isAcceptableOrUnknown(data['cost_nature']!, _costNatureMeta),
      );
    }
    if (data.containsKey('essential')) {
      context.handle(
        _essentialMeta,
        essential.isAcceptableOrUnknown(data['essential']!, _essentialMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {eventId, sequence},
  ];
  @override
  Posting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Posting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      ledgerAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_account_id'],
      )!,
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      costNature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_nature'],
      ),
      essential: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}essential'],
      ),
    );
  }

  @override
  Postings createAlias(String alias) {
    return Postings(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(event_id, sequence)'];
  @override
  bool get dontWriteConstraints => true;
}

class Posting extends DataClass implements Insertable<Posting> {
  final String id;
  final String profileId;
  final String eventId;
  final String ledgerAccountId;
  final int sequence;
  final int amountCents;
  final String? categoryId;
  final String? costNature;
  final int? essential;
  const Posting({
    required this.id,
    required this.profileId,
    required this.eventId,
    required this.ledgerAccountId,
    required this.sequence,
    required this.amountCents,
    this.categoryId,
    this.costNature,
    this.essential,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['event_id'] = Variable<String>(eventId);
    map['ledger_account_id'] = Variable<String>(ledgerAccountId);
    map['sequence'] = Variable<int>(sequence);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || costNature != null) {
      map['cost_nature'] = Variable<String>(costNature);
    }
    if (!nullToAbsent || essential != null) {
      map['essential'] = Variable<int>(essential);
    }
    return map;
  }

  PostingsCompanion toCompanion(bool nullToAbsent) {
    return PostingsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      eventId: Value(eventId),
      ledgerAccountId: Value(ledgerAccountId),
      sequence: Value(sequence),
      amountCents: Value(amountCents),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      costNature: costNature == null && nullToAbsent
          ? const Value.absent()
          : Value(costNature),
      essential: essential == null && nullToAbsent
          ? const Value.absent()
          : Value(essential),
    );
  }

  factory Posting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Posting(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      eventId: serializer.fromJson<String>(json['event_id']),
      ledgerAccountId: serializer.fromJson<String>(json['ledger_account_id']),
      sequence: serializer.fromJson<int>(json['sequence']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
      categoryId: serializer.fromJson<String?>(json['category_id']),
      costNature: serializer.fromJson<String?>(json['cost_nature']),
      essential: serializer.fromJson<int?>(json['essential']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'event_id': serializer.toJson<String>(eventId),
      'ledger_account_id': serializer.toJson<String>(ledgerAccountId),
      'sequence': serializer.toJson<int>(sequence),
      'amount_cents': serializer.toJson<int>(amountCents),
      'category_id': serializer.toJson<String?>(categoryId),
      'cost_nature': serializer.toJson<String?>(costNature),
      'essential': serializer.toJson<int?>(essential),
    };
  }

  Posting copyWith({
    String? id,
    String? profileId,
    String? eventId,
    String? ledgerAccountId,
    int? sequence,
    int? amountCents,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> costNature = const Value.absent(),
    Value<int?> essential = const Value.absent(),
  }) => Posting(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    eventId: eventId ?? this.eventId,
    ledgerAccountId: ledgerAccountId ?? this.ledgerAccountId,
    sequence: sequence ?? this.sequence,
    amountCents: amountCents ?? this.amountCents,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    costNature: costNature.present ? costNature.value : this.costNature,
    essential: essential.present ? essential.value : this.essential,
  );
  Posting copyWithCompanion(PostingsCompanion data) {
    return Posting(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      ledgerAccountId: data.ledgerAccountId.present
          ? data.ledgerAccountId.value
          : this.ledgerAccountId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      costNature: data.costNature.present
          ? data.costNature.value
          : this.costNature,
      essential: data.essential.present ? data.essential.value : this.essential,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Posting(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('eventId: $eventId, ')
          ..write('ledgerAccountId: $ledgerAccountId, ')
          ..write('sequence: $sequence, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    eventId,
    ledgerAccountId,
    sequence,
    amountCents,
    categoryId,
    costNature,
    essential,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Posting &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.eventId == this.eventId &&
          other.ledgerAccountId == this.ledgerAccountId &&
          other.sequence == this.sequence &&
          other.amountCents == this.amountCents &&
          other.categoryId == this.categoryId &&
          other.costNature == this.costNature &&
          other.essential == this.essential);
}

class PostingsCompanion extends UpdateCompanion<Posting> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> eventId;
  final Value<String> ledgerAccountId;
  final Value<int> sequence;
  final Value<int> amountCents;
  final Value<String?> categoryId;
  final Value<String?> costNature;
  final Value<int?> essential;
  final Value<int> rowid;
  const PostingsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.eventId = const Value.absent(),
    this.ledgerAccountId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostingsCompanion.insert({
    required String id,
    required String profileId,
    required String eventId,
    required String ledgerAccountId,
    required int sequence,
    required int amountCents,
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       eventId = Value(eventId),
       ledgerAccountId = Value(ledgerAccountId),
       sequence = Value(sequence),
       amountCents = Value(amountCents);
  static Insertable<Posting> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? eventId,
    Expression<String>? ledgerAccountId,
    Expression<int>? sequence,
    Expression<int>? amountCents,
    Expression<String>? categoryId,
    Expression<String>? costNature,
    Expression<int>? essential,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (eventId != null) 'event_id': eventId,
      if (ledgerAccountId != null) 'ledger_account_id': ledgerAccountId,
      if (sequence != null) 'sequence': sequence,
      if (amountCents != null) 'amount_cents': amountCents,
      if (categoryId != null) 'category_id': categoryId,
      if (costNature != null) 'cost_nature': costNature,
      if (essential != null) 'essential': essential,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostingsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? eventId,
    Value<String>? ledgerAccountId,
    Value<int>? sequence,
    Value<int>? amountCents,
    Value<String?>? categoryId,
    Value<String?>? costNature,
    Value<int?>? essential,
    Value<int>? rowid,
  }) {
    return PostingsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      eventId: eventId ?? this.eventId,
      ledgerAccountId: ledgerAccountId ?? this.ledgerAccountId,
      sequence: sequence ?? this.sequence,
      amountCents: amountCents ?? this.amountCents,
      categoryId: categoryId ?? this.categoryId,
      costNature: costNature ?? this.costNature,
      essential: essential ?? this.essential,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (ledgerAccountId.present) {
      map['ledger_account_id'] = Variable<String>(ledgerAccountId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (costNature.present) {
      map['cost_nature'] = Variable<String>(costNature.value);
    }
    if (essential.present) {
      map['essential'] = Variable<int>(essential.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostingsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('eventId: $eventId, ')
          ..write('ledgerAccountId: $ledgerAccountId, ')
          ..write('sequence: $sequence, ')
          ..write('amountCents: $amountCents, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class OperationReceipts extends Table
    with TableInfo<OperationReceipts, OperationReceipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  OperationReceipts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _commandMeta = const VerificationMeta(
    'command',
  );
  late final GeneratedColumn<String> command = GeneratedColumn<String>(
    'command',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (command IN (\'create_account\', \'create_category\', \'record\', \'reverse\', \'create_card\', \'purchase\', \'pay_invoice\', \'create_schedule\', \'create_series\', \'revise_series\', \'pause_series\', \'resume_series\', \'edit_scheduled\', \'skip_scheduled\', \'settle_scheduled\', \'save_objective\', \'save_goal\', \'move_goal_funds\', \'set_goal_status\'))',
  );
  static const VerificationMeta _fingerprintMeta = const VerificationMeta(
    'fingerprint',
  );
  late final GeneratedColumn<String> fingerprint = GeneratedColumn<String>(
    'fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _resultIdMeta = const VerificationMeta(
    'resultId',
  );
  late final GeneratedColumn<String> resultId = GeneratedColumn<String>(
    'result_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    command,
    fingerprint,
    resultId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'operation_receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<OperationReceipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('command')) {
      context.handle(
        _commandMeta,
        command.isAcceptableOrUnknown(data['command']!, _commandMeta),
      );
    } else if (isInserting) {
      context.missing(_commandMeta);
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
        _fingerprintMeta,
        fingerprint.isAcceptableOrUnknown(
          data['fingerprint']!,
          _fingerprintMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fingerprintMeta);
    }
    if (data.containsKey('result_id')) {
      context.handle(
        _resultIdMeta,
        resultId.isAcceptableOrUnknown(data['result_id']!, _resultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_resultIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OperationReceipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OperationReceipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      command: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}command'],
      )!,
      fingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fingerprint'],
      )!,
      resultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  OperationReceipts createAlias(String alias) {
    return OperationReceipts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class OperationReceipt extends DataClass
    implements Insertable<OperationReceipt> {
  final String id;
  final String profileId;
  final String command;
  final String fingerprint;
  final String resultId;
  final String createdAt;
  const OperationReceipt({
    required this.id,
    required this.profileId,
    required this.command,
    required this.fingerprint,
    required this.resultId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['command'] = Variable<String>(command);
    map['fingerprint'] = Variable<String>(fingerprint);
    map['result_id'] = Variable<String>(resultId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  OperationReceiptsCompanion toCompanion(bool nullToAbsent) {
    return OperationReceiptsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      command: Value(command),
      fingerprint: Value(fingerprint),
      resultId: Value(resultId),
      createdAt: Value(createdAt),
    );
  }

  factory OperationReceipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OperationReceipt(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      command: serializer.fromJson<String>(json['command']),
      fingerprint: serializer.fromJson<String>(json['fingerprint']),
      resultId: serializer.fromJson<String>(json['result_id']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'command': serializer.toJson<String>(command),
      'fingerprint': serializer.toJson<String>(fingerprint),
      'result_id': serializer.toJson<String>(resultId),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  OperationReceipt copyWith({
    String? id,
    String? profileId,
    String? command,
    String? fingerprint,
    String? resultId,
    String? createdAt,
  }) => OperationReceipt(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    command: command ?? this.command,
    fingerprint: fingerprint ?? this.fingerprint,
    resultId: resultId ?? this.resultId,
    createdAt: createdAt ?? this.createdAt,
  );
  OperationReceipt copyWithCompanion(OperationReceiptsCompanion data) {
    return OperationReceipt(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      command: data.command.present ? data.command.value : this.command,
      fingerprint: data.fingerprint.present
          ? data.fingerprint.value
          : this.fingerprint,
      resultId: data.resultId.present ? data.resultId.value : this.resultId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OperationReceipt(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('command: $command, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('resultId: $resultId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, command, fingerprint, resultId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OperationReceipt &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.command == this.command &&
          other.fingerprint == this.fingerprint &&
          other.resultId == this.resultId &&
          other.createdAt == this.createdAt);
}

class OperationReceiptsCompanion extends UpdateCompanion<OperationReceipt> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> command;
  final Value<String> fingerprint;
  final Value<String> resultId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const OperationReceiptsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.command = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.resultId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OperationReceiptsCompanion.insert({
    required String id,
    required String profileId,
    required String command,
    required String fingerprint,
    required String resultId,
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       command = Value(command),
       fingerprint = Value(fingerprint),
       resultId = Value(resultId),
       createdAt = Value(createdAt);
  static Insertable<OperationReceipt> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? command,
    Expression<String>? fingerprint,
    Expression<String>? resultId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (command != null) 'command': command,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (resultId != null) 'result_id': resultId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OperationReceiptsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? command,
    Value<String>? fingerprint,
    Value<String>? resultId,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return OperationReceiptsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      command: command ?? this.command,
      fingerprint: fingerprint ?? this.fingerprint,
      resultId: resultId ?? this.resultId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (command.present) {
      map['command'] = Variable<String>(command.value);
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<String>(fingerprint.value);
    }
    if (resultId.present) {
      map['result_id'] = Variable<String>(resultId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('command: $command, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('resultId: $resultId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CreditCards extends Table with TableInfo<CreditCards, CreditCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CreditCards(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY REFERENCES ledger_accounts(id)',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) BETWEEN 1 AND 80)',
  );
  static const VerificationMeta _openedOnMeta = const VerificationMeta(
    'openedOn',
  );
  late final GeneratedColumn<String> openedOn = GeneratedColumn<String>(
    'opened_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _limitCentsMeta = const VerificationMeta(
    'limitCents',
  );
  late final GeneratedColumn<int> limitCents = GeneratedColumn<int>(
    'limit_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(limit_cents) = \'integer\' AND limit_cents BETWEEN 0 AND 9007199254740991)',
  );
  static const VerificationMeta _closingDayMeta = const VerificationMeta(
    'closingDay',
  );
  late final GeneratedColumn<int> closingDay = GeneratedColumn<int>(
    'closing_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (closing_day BETWEEN 1 AND 31)',
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (due_day BETWEEN 1 AND 31)',
  );
  static const VerificationMeta _closingPolicyMeta = const VerificationMeta(
    'closingPolicy',
  );
  late final GeneratedColumn<String> closingPolicy = GeneratedColumn<String>(
    'closing_policy',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (closing_policy IN (\'next\', \'current\'))',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    openedOn,
    limitCents,
    closingDay,
    dueDay,
    closingPolicy,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('opened_on')) {
      context.handle(
        _openedOnMeta,
        openedOn.isAcceptableOrUnknown(data['opened_on']!, _openedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_openedOnMeta);
    }
    if (data.containsKey('limit_cents')) {
      context.handle(
        _limitCentsMeta,
        limitCents.isAcceptableOrUnknown(data['limit_cents']!, _limitCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_limitCentsMeta);
    }
    if (data.containsKey('closing_day')) {
      context.handle(
        _closingDayMeta,
        closingDay.isAcceptableOrUnknown(data['closing_day']!, _closingDayMeta),
      );
    } else if (isInserting) {
      context.missing(_closingDayMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDayMeta);
    }
    if (data.containsKey('closing_policy')) {
      context.handle(
        _closingPolicyMeta,
        closingPolicy.isAcceptableOrUnknown(
          data['closing_policy']!,
          _closingPolicyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_closingPolicyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      openedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opened_on'],
      )!,
      limitCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}limit_cents'],
      )!,
      closingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}closing_day'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      )!,
      closingPolicy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closing_policy'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  CreditCards createAlias(String alias) {
    return CreditCards(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CreditCard extends DataClass implements Insertable<CreditCard> {
  final String id;
  final String profileId;
  final String name;
  final String openedOn;
  final int limitCents;
  final int closingDay;
  final int dueDay;
  final String closingPolicy;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const CreditCard({
    required this.id,
    required this.profileId,
    required this.name,
    required this.openedOn,
    required this.limitCents,
    required this.closingDay,
    required this.dueDay,
    required this.closingPolicy,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    map['opened_on'] = Variable<String>(openedOn);
    map['limit_cents'] = Variable<int>(limitCents);
    map['closing_day'] = Variable<int>(closingDay);
    map['due_day'] = Variable<int>(dueDay);
    map['closing_policy'] = Variable<String>(closingPolicy);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  CreditCardsCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      openedOn: Value(openedOn),
      limitCents: Value(limitCents),
      closingDay: Value(closingDay),
      dueDay: Value(dueDay),
      closingPolicy: Value(closingPolicy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory CreditCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCard(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      name: serializer.fromJson<String>(json['name']),
      openedOn: serializer.fromJson<String>(json['opened_on']),
      limitCents: serializer.fromJson<int>(json['limit_cents']),
      closingDay: serializer.fromJson<int>(json['closing_day']),
      dueDay: serializer.fromJson<int>(json['due_day']),
      closingPolicy: serializer.fromJson<String>(json['closing_policy']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'opened_on': serializer.toJson<String>(openedOn),
      'limit_cents': serializer.toJson<int>(limitCents),
      'closing_day': serializer.toJson<int>(closingDay),
      'due_day': serializer.toJson<int>(dueDay),
      'closing_policy': serializer.toJson<String>(closingPolicy),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  CreditCard copyWith({
    String? id,
    String? profileId,
    String? name,
    String? openedOn,
    int? limitCents,
    int? closingDay,
    int? dueDay,
    String? closingPolicy,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => CreditCard(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    openedOn: openedOn ?? this.openedOn,
    limitCents: limitCents ?? this.limitCents,
    closingDay: closingDay ?? this.closingDay,
    dueDay: dueDay ?? this.dueDay,
    closingPolicy: closingPolicy ?? this.closingPolicy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  CreditCard copyWithCompanion(CreditCardsCompanion data) {
    return CreditCard(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      openedOn: data.openedOn.present ? data.openedOn.value : this.openedOn,
      limitCents: data.limitCents.present
          ? data.limitCents.value
          : this.limitCents,
      closingDay: data.closingDay.present
          ? data.closingDay.value
          : this.closingDay,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      closingPolicy: data.closingPolicy.present
          ? data.closingPolicy.value
          : this.closingPolicy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCard(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('openedOn: $openedOn, ')
          ..write('limitCents: $limitCents, ')
          ..write('closingDay: $closingDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('closingPolicy: $closingPolicy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    name,
    openedOn,
    limitCents,
    closingDay,
    dueDay,
    closingPolicy,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCard &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.openedOn == this.openedOn &&
          other.limitCents == this.limitCents &&
          other.closingDay == this.closingDay &&
          other.dueDay == this.dueDay &&
          other.closingPolicy == this.closingPolicy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class CreditCardsCompanion extends UpdateCompanion<CreditCard> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<String> openedOn;
  final Value<int> limitCents;
  final Value<int> closingDay;
  final Value<int> dueDay;
  final Value<String> closingPolicy;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const CreditCardsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.openedOn = const Value.absent(),
    this.limitCents = const Value.absent(),
    this.closingDay = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.closingPolicy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditCardsCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    required String openedOn,
    required int limitCents,
    required int closingDay,
    required int dueDay,
    required String closingPolicy,
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       openedOn = Value(openedOn),
       limitCents = Value(limitCents),
       closingDay = Value(closingDay),
       dueDay = Value(dueDay),
       closingPolicy = Value(closingPolicy),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CreditCard> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<String>? openedOn,
    Expression<int>? limitCents,
    Expression<int>? closingDay,
    Expression<int>? dueDay,
    Expression<String>? closingPolicy,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (openedOn != null) 'opened_on': openedOn,
      if (limitCents != null) 'limit_cents': limitCents,
      if (closingDay != null) 'closing_day': closingDay,
      if (dueDay != null) 'due_day': dueDay,
      if (closingPolicy != null) 'closing_policy': closingPolicy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<String>? openedOn,
    Value<int>? limitCents,
    Value<int>? closingDay,
    Value<int>? dueDay,
    Value<String>? closingPolicy,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return CreditCardsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      openedOn: openedOn ?? this.openedOn,
      limitCents: limitCents ?? this.limitCents,
      closingDay: closingDay ?? this.closingDay,
      dueDay: dueDay ?? this.dueDay,
      closingPolicy: closingPolicy ?? this.closingPolicy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (openedOn.present) {
      map['opened_on'] = Variable<String>(openedOn.value);
    }
    if (limitCents.present) {
      map['limit_cents'] = Variable<int>(limitCents.value);
    }
    if (closingDay.present) {
      map['closing_day'] = Variable<int>(closingDay.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (closingPolicy.present) {
      map['closing_policy'] = Variable<String>(closingPolicy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('openedOn: $openedOn, ')
          ..write('limitCents: $limitCents, ')
          ..write('closingDay: $closingDay, ')
          ..write('dueDay: $dueDay, ')
          ..write('closingPolicy: $closingPolicy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CardOperations extends Table
    with TableInfo<CardOperations, CardOperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CardOperations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY REFERENCES financial_events(id)',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES credit_cards(id)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'purchase\', \'opening_debt\'))',
  );
  static const VerificationMeta _billingOnMeta = const VerificationMeta(
    'billingOn',
  );
  late final GeneratedColumn<String> billingOn = GeneratedColumn<String>(
    'billing_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _installmentCountMeta = const VerificationMeta(
    'installmentCount',
  );
  late final GeneratedColumn<int> installmentCount = GeneratedColumn<int>(
    'installment_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (installment_count BETWEEN 1 AND 360)',
  );
  static const VerificationMeta _totalCentsMeta = const VerificationMeta(
    'totalCents',
  );
  late final GeneratedColumn<int> totalCents = GeneratedColumn<int>(
    'total_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(total_cents) = \'integer\' AND total_cents BETWEEN 1 AND 9007199254740991)',
  );
  static const VerificationMeta _reconciledMeta = const VerificationMeta(
    'reconciled',
  );
  late final GeneratedColumn<int> reconciled = GeneratedColumn<int>(
    'reconciled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (reconciled IN (0, 1))',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    cardId,
    kind,
    billingOn,
    installmentCount,
    totalCents,
    reconciled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardOperation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('billing_on')) {
      context.handle(
        _billingOnMeta,
        billingOn.isAcceptableOrUnknown(data['billing_on']!, _billingOnMeta),
      );
    } else if (isInserting) {
      context.missing(_billingOnMeta);
    }
    if (data.containsKey('installment_count')) {
      context.handle(
        _installmentCountMeta,
        installmentCount.isAcceptableOrUnknown(
          data['installment_count']!,
          _installmentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentCountMeta);
    }
    if (data.containsKey('total_cents')) {
      context.handle(
        _totalCentsMeta,
        totalCents.isAcceptableOrUnknown(data['total_cents']!, _totalCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCentsMeta);
    }
    if (data.containsKey('reconciled')) {
      context.handle(
        _reconciledMeta,
        reconciled.isAcceptableOrUnknown(data['reconciled']!, _reconciledMeta),
      );
    } else if (isInserting) {
      context.missing(_reconciledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardOperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardOperation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      billingOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_on'],
      )!,
      installmentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_count'],
      )!,
      totalCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cents'],
      )!,
      reconciled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reconciled'],
      )!,
    );
  }

  @override
  CardOperations createAlias(String alias) {
    return CardOperations(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'CHECK(installment_count <= total_cents)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class CardOperation extends DataClass implements Insertable<CardOperation> {
  final String id;
  final String profileId;
  final String cardId;
  final String kind;
  final String billingOn;
  final int installmentCount;
  final int totalCents;
  final int reconciled;
  const CardOperation({
    required this.id,
    required this.profileId,
    required this.cardId,
    required this.kind,
    required this.billingOn,
    required this.installmentCount,
    required this.totalCents,
    required this.reconciled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['card_id'] = Variable<String>(cardId);
    map['kind'] = Variable<String>(kind);
    map['billing_on'] = Variable<String>(billingOn);
    map['installment_count'] = Variable<int>(installmentCount);
    map['total_cents'] = Variable<int>(totalCents);
    map['reconciled'] = Variable<int>(reconciled);
    return map;
  }

  CardOperationsCompanion toCompanion(bool nullToAbsent) {
    return CardOperationsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      cardId: Value(cardId),
      kind: Value(kind),
      billingOn: Value(billingOn),
      installmentCount: Value(installmentCount),
      totalCents: Value(totalCents),
      reconciled: Value(reconciled),
    );
  }

  factory CardOperation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardOperation(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      cardId: serializer.fromJson<String>(json['card_id']),
      kind: serializer.fromJson<String>(json['kind']),
      billingOn: serializer.fromJson<String>(json['billing_on']),
      installmentCount: serializer.fromJson<int>(json['installment_count']),
      totalCents: serializer.fromJson<int>(json['total_cents']),
      reconciled: serializer.fromJson<int>(json['reconciled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'card_id': serializer.toJson<String>(cardId),
      'kind': serializer.toJson<String>(kind),
      'billing_on': serializer.toJson<String>(billingOn),
      'installment_count': serializer.toJson<int>(installmentCount),
      'total_cents': serializer.toJson<int>(totalCents),
      'reconciled': serializer.toJson<int>(reconciled),
    };
  }

  CardOperation copyWith({
    String? id,
    String? profileId,
    String? cardId,
    String? kind,
    String? billingOn,
    int? installmentCount,
    int? totalCents,
    int? reconciled,
  }) => CardOperation(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    cardId: cardId ?? this.cardId,
    kind: kind ?? this.kind,
    billingOn: billingOn ?? this.billingOn,
    installmentCount: installmentCount ?? this.installmentCount,
    totalCents: totalCents ?? this.totalCents,
    reconciled: reconciled ?? this.reconciled,
  );
  CardOperation copyWithCompanion(CardOperationsCompanion data) {
    return CardOperation(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      kind: data.kind.present ? data.kind.value : this.kind,
      billingOn: data.billingOn.present ? data.billingOn.value : this.billingOn,
      installmentCount: data.installmentCount.present
          ? data.installmentCount.value
          : this.installmentCount,
      totalCents: data.totalCents.present
          ? data.totalCents.value
          : this.totalCents,
      reconciled: data.reconciled.present
          ? data.reconciled.value
          : this.reconciled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardOperation(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('kind: $kind, ')
          ..write('billingOn: $billingOn, ')
          ..write('installmentCount: $installmentCount, ')
          ..write('totalCents: $totalCents, ')
          ..write('reconciled: $reconciled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    cardId,
    kind,
    billingOn,
    installmentCount,
    totalCents,
    reconciled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardOperation &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.cardId == this.cardId &&
          other.kind == this.kind &&
          other.billingOn == this.billingOn &&
          other.installmentCount == this.installmentCount &&
          other.totalCents == this.totalCents &&
          other.reconciled == this.reconciled);
}

class CardOperationsCompanion extends UpdateCompanion<CardOperation> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> cardId;
  final Value<String> kind;
  final Value<String> billingOn;
  final Value<int> installmentCount;
  final Value<int> totalCents;
  final Value<int> reconciled;
  final Value<int> rowid;
  const CardOperationsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.kind = const Value.absent(),
    this.billingOn = const Value.absent(),
    this.installmentCount = const Value.absent(),
    this.totalCents = const Value.absent(),
    this.reconciled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardOperationsCompanion.insert({
    required String id,
    required String profileId,
    required String cardId,
    required String kind,
    required String billingOn,
    required int installmentCount,
    required int totalCents,
    required int reconciled,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       cardId = Value(cardId),
       kind = Value(kind),
       billingOn = Value(billingOn),
       installmentCount = Value(installmentCount),
       totalCents = Value(totalCents),
       reconciled = Value(reconciled);
  static Insertable<CardOperation> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? cardId,
    Expression<String>? kind,
    Expression<String>? billingOn,
    Expression<int>? installmentCount,
    Expression<int>? totalCents,
    Expression<int>? reconciled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (cardId != null) 'card_id': cardId,
      if (kind != null) 'kind': kind,
      if (billingOn != null) 'billing_on': billingOn,
      if (installmentCount != null) 'installment_count': installmentCount,
      if (totalCents != null) 'total_cents': totalCents,
      if (reconciled != null) 'reconciled': reconciled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardOperationsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? cardId,
    Value<String>? kind,
    Value<String>? billingOn,
    Value<int>? installmentCount,
    Value<int>? totalCents,
    Value<int>? reconciled,
    Value<int>? rowid,
  }) {
    return CardOperationsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      cardId: cardId ?? this.cardId,
      kind: kind ?? this.kind,
      billingOn: billingOn ?? this.billingOn,
      installmentCount: installmentCount ?? this.installmentCount,
      totalCents: totalCents ?? this.totalCents,
      reconciled: reconciled ?? this.reconciled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (billingOn.present) {
      map['billing_on'] = Variable<String>(billingOn.value);
    }
    if (installmentCount.present) {
      map['installment_count'] = Variable<int>(installmentCount.value);
    }
    if (totalCents.present) {
      map['total_cents'] = Variable<int>(totalCents.value);
    }
    if (reconciled.present) {
      map['reconciled'] = Variable<int>(reconciled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardOperationsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('kind: $kind, ')
          ..write('billingOn: $billingOn, ')
          ..write('installmentCount: $installmentCount, ')
          ..write('totalCents: $totalCents, ')
          ..write('reconciled: $reconciled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Invoices extends Table with TableInfo<Invoices, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Invoices(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES credit_cards(id)',
  );
  static const VerificationMeta _closingOnMeta = const VerificationMeta(
    'closingOn',
  );
  late final GeneratedColumn<String> closingOn = GeneratedColumn<String>(
    'closing_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _dueOnMeta = const VerificationMeta('dueOn');
  late final GeneratedColumn<String> dueOn = GeneratedColumn<String>(
    'due_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (due_on > closing_on)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    cardId,
    closingOn,
    dueOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('closing_on')) {
      context.handle(
        _closingOnMeta,
        closingOn.isAcceptableOrUnknown(data['closing_on']!, _closingOnMeta),
      );
    } else if (isInserting) {
      context.missing(_closingOnMeta);
    }
    if (data.containsKey('due_on')) {
      context.handle(
        _dueOnMeta,
        dueOn.isAcceptableOrUnknown(data['due_on']!, _dueOnMeta),
      );
    } else if (isInserting) {
      context.missing(_dueOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardId, closingOn},
  ];
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      closingOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closing_on'],
      )!,
      dueOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_on'],
      )!,
    );
  }

  @override
  Invoices createAlias(String alias) {
    return Invoices(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(card_id, closing_on)'];
  @override
  bool get dontWriteConstraints => true;
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final String id;
  final String profileId;
  final String cardId;
  final String closingOn;
  final String dueOn;
  const Invoice({
    required this.id,
    required this.profileId,
    required this.cardId,
    required this.closingOn,
    required this.dueOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['card_id'] = Variable<String>(cardId);
    map['closing_on'] = Variable<String>(closingOn);
    map['due_on'] = Variable<String>(dueOn);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      cardId: Value(cardId),
      closingOn: Value(closingOn),
      dueOn: Value(dueOn),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      cardId: serializer.fromJson<String>(json['card_id']),
      closingOn: serializer.fromJson<String>(json['closing_on']),
      dueOn: serializer.fromJson<String>(json['due_on']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'card_id': serializer.toJson<String>(cardId),
      'closing_on': serializer.toJson<String>(closingOn),
      'due_on': serializer.toJson<String>(dueOn),
    };
  }

  Invoice copyWith({
    String? id,
    String? profileId,
    String? cardId,
    String? closingOn,
    String? dueOn,
  }) => Invoice(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    cardId: cardId ?? this.cardId,
    closingOn: closingOn ?? this.closingOn,
    dueOn: dueOn ?? this.dueOn,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      closingOn: data.closingOn.present ? data.closingOn.value : this.closingOn,
      dueOn: data.dueOn.present ? data.dueOn.value : this.dueOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('closingOn: $closingOn, ')
          ..write('dueOn: $dueOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, cardId, closingOn, dueOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.cardId == this.cardId &&
          other.closingOn == this.closingOn &&
          other.dueOn == this.dueOn);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> cardId;
  final Value<String> closingOn;
  final Value<String> dueOn;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.closingOn = const Value.absent(),
    this.dueOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    required String id,
    required String profileId,
    required String cardId,
    required String closingOn,
    required String dueOn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       cardId = Value(cardId),
       closingOn = Value(closingOn),
       dueOn = Value(dueOn);
  static Insertable<Invoice> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? cardId,
    Expression<String>? closingOn,
    Expression<String>? dueOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (cardId != null) 'card_id': cardId,
      if (closingOn != null) 'closing_on': closingOn,
      if (dueOn != null) 'due_on': dueOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? cardId,
    Value<String>? closingOn,
    Value<String>? dueOn,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      cardId: cardId ?? this.cardId,
      closingOn: closingOn ?? this.closingOn,
      dueOn: dueOn ?? this.dueOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (closingOn.present) {
      map['closing_on'] = Variable<String>(closingOn.value);
    }
    if (dueOn.present) {
      map['due_on'] = Variable<String>(dueOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('closingOn: $closingOn, ')
          ..write('dueOn: $dueOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class InvoiceItems extends Table with TableInfo<InvoiceItems, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InvoiceItems(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _operationIdMeta = const VerificationMeta(
    'operationId',
  );
  late final GeneratedColumn<String> operationId = GeneratedColumn<String>(
    'operation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES card_operations(id)',
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES invoices(id)',
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (sequence BETWEEN 1 AND 360)',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents BETWEEN 1 AND 9007199254740991)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    operationId,
    invoiceId,
    sequence,
    amountCents,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('operation_id')) {
      context.handle(
        _operationIdMeta,
        operationId.isAcceptableOrUnknown(
          data['operation_id']!,
          _operationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {operationId, sequence},
  ];
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      operationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  InvoiceItems createAlias(String alias) {
    return InvoiceItems(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(operation_id, sequence)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final String id;
  final String profileId;
  final String operationId;
  final String invoiceId;
  final int sequence;
  final int amountCents;
  const InvoiceItem({
    required this.id,
    required this.profileId,
    required this.operationId,
    required this.invoiceId,
    required this.sequence,
    required this.amountCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['operation_id'] = Variable<String>(operationId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['sequence'] = Variable<int>(sequence);
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      operationId: Value(operationId),
      invoiceId: Value(invoiceId),
      sequence: Value(sequence),
      amountCents: Value(amountCents),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      operationId: serializer.fromJson<String>(json['operation_id']),
      invoiceId: serializer.fromJson<String>(json['invoice_id']),
      sequence: serializer.fromJson<int>(json['sequence']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'operation_id': serializer.toJson<String>(operationId),
      'invoice_id': serializer.toJson<String>(invoiceId),
      'sequence': serializer.toJson<int>(sequence),
      'amount_cents': serializer.toJson<int>(amountCents),
    };
  }

  InvoiceItem copyWith({
    String? id,
    String? profileId,
    String? operationId,
    String? invoiceId,
    int? sequence,
    int? amountCents,
  }) => InvoiceItem(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    operationId: operationId ?? this.operationId,
    invoiceId: invoiceId ?? this.invoiceId,
    sequence: sequence ?? this.sequence,
    amountCents: amountCents ?? this.amountCents,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      operationId: data.operationId.present
          ? data.operationId.value
          : this.operationId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('operationId: $operationId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('sequence: $sequence, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, operationId, invoiceId, sequence, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.operationId == this.operationId &&
          other.invoiceId == this.invoiceId &&
          other.sequence == this.sequence &&
          other.amountCents == this.amountCents);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> operationId;
  final Value<String> invoiceId;
  final Value<int> sequence;
  final Value<int> amountCents;
  final Value<int> rowid;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.operationId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    required String id,
    required String profileId,
    required String operationId,
    required String invoiceId,
    required int sequence,
    required int amountCents,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       operationId = Value(operationId),
       invoiceId = Value(invoiceId),
       sequence = Value(sequence),
       amountCents = Value(amountCents);
  static Insertable<InvoiceItem> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? operationId,
    Expression<String>? invoiceId,
    Expression<int>? sequence,
    Expression<int>? amountCents,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (operationId != null) 'operation_id': operationId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (sequence != null) 'sequence': sequence,
      if (amountCents != null) 'amount_cents': amountCents,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? operationId,
    Value<String>? invoiceId,
    Value<int>? sequence,
    Value<int>? amountCents,
    Value<int>? rowid,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      operationId: operationId ?? this.operationId,
      invoiceId: invoiceId ?? this.invoiceId,
      sequence: sequence ?? this.sequence,
      amountCents: amountCents ?? this.amountCents,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (operationId.present) {
      map['operation_id'] = Variable<String>(operationId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('operationId: $operationId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('sequence: $sequence, ')
          ..write('amountCents: $amountCents, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class InvoicePayments extends Table
    with TableInfo<InvoicePayments, InvoicePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InvoicePayments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY REFERENCES financial_events(id)',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES credit_cards(id)',
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES accounts(id)',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents BETWEEN 1 AND 9007199254740991)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    cardId,
    accountId,
    amountCents,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicePayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicePayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  InvoicePayments createAlias(String alias) {
    return InvoicePayments(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class InvoicePayment extends DataClass implements Insertable<InvoicePayment> {
  final String id;
  final String profileId;
  final String cardId;
  final String accountId;
  final int amountCents;
  const InvoicePayment({
    required this.id,
    required this.profileId,
    required this.cardId,
    required this.accountId,
    required this.amountCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['card_id'] = Variable<String>(cardId);
    map['account_id'] = Variable<String>(accountId);
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  InvoicePaymentsCompanion toCompanion(bool nullToAbsent) {
    return InvoicePaymentsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      cardId: Value(cardId),
      accountId: Value(accountId),
      amountCents: Value(amountCents),
    );
  }

  factory InvoicePayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicePayment(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      cardId: serializer.fromJson<String>(json['card_id']),
      accountId: serializer.fromJson<String>(json['account_id']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'card_id': serializer.toJson<String>(cardId),
      'account_id': serializer.toJson<String>(accountId),
      'amount_cents': serializer.toJson<int>(amountCents),
    };
  }

  InvoicePayment copyWith({
    String? id,
    String? profileId,
    String? cardId,
    String? accountId,
    int? amountCents,
  }) => InvoicePayment(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    cardId: cardId ?? this.cardId,
    accountId: accountId ?? this.accountId,
    amountCents: amountCents ?? this.amountCents,
  );
  InvoicePayment copyWithCompanion(InvoicePaymentsCompanion data) {
    return InvoicePayment(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePayment(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('accountId: $accountId, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, cardId, accountId, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicePayment &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.cardId == this.cardId &&
          other.accountId == this.accountId &&
          other.amountCents == this.amountCents);
}

class InvoicePaymentsCompanion extends UpdateCompanion<InvoicePayment> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> cardId;
  final Value<String> accountId;
  final Value<int> amountCents;
  final Value<int> rowid;
  const InvoicePaymentsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicePaymentsCompanion.insert({
    required String id,
    required String profileId,
    required String cardId,
    required String accountId,
    required int amountCents,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       cardId = Value(cardId),
       accountId = Value(accountId),
       amountCents = Value(amountCents);
  static Insertable<InvoicePayment> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? cardId,
    Expression<String>? accountId,
    Expression<int>? amountCents,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (cardId != null) 'card_id': cardId,
      if (accountId != null) 'account_id': accountId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicePaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? cardId,
    Value<String>? accountId,
    Value<int>? amountCents,
    Value<int>? rowid,
  }) {
    return InvoicePaymentsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      cardId: cardId ?? this.cardId,
      accountId: accountId ?? this.accountId,
      amountCents: amountCents ?? this.amountCents,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('cardId: $cardId, ')
          ..write('accountId: $accountId, ')
          ..write('amountCents: $amountCents, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class InvoicePaymentAllocations extends Table
    with TableInfo<InvoicePaymentAllocations, InvoicePaymentAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InvoicePaymentAllocations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES invoice_payments(id)',
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES invoices(id)',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents BETWEEN 1 AND 9007199254740991)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    paymentId,
    invoiceId,
    amountCents,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_payment_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicePaymentAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {paymentId, invoiceId},
  ];
  @override
  InvoicePaymentAllocation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicePaymentAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
    );
  }

  @override
  InvoicePaymentAllocations createAlias(String alias) {
    return InvoicePaymentAllocations(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(payment_id, invoice_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class InvoicePaymentAllocation extends DataClass
    implements Insertable<InvoicePaymentAllocation> {
  final String id;
  final String profileId;
  final String paymentId;
  final String invoiceId;
  final int amountCents;
  const InvoicePaymentAllocation({
    required this.id,
    required this.profileId,
    required this.paymentId,
    required this.invoiceId,
    required this.amountCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['payment_id'] = Variable<String>(paymentId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount_cents'] = Variable<int>(amountCents);
    return map;
  }

  InvoicePaymentAllocationsCompanion toCompanion(bool nullToAbsent) {
    return InvoicePaymentAllocationsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      paymentId: Value(paymentId),
      invoiceId: Value(invoiceId),
      amountCents: Value(amountCents),
    );
  }

  factory InvoicePaymentAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicePaymentAllocation(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      paymentId: serializer.fromJson<String>(json['payment_id']),
      invoiceId: serializer.fromJson<String>(json['invoice_id']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'payment_id': serializer.toJson<String>(paymentId),
      'invoice_id': serializer.toJson<String>(invoiceId),
      'amount_cents': serializer.toJson<int>(amountCents),
    };
  }

  InvoicePaymentAllocation copyWith({
    String? id,
    String? profileId,
    String? paymentId,
    String? invoiceId,
    int? amountCents,
  }) => InvoicePaymentAllocation(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    paymentId: paymentId ?? this.paymentId,
    invoiceId: invoiceId ?? this.invoiceId,
    amountCents: amountCents ?? this.amountCents,
  );
  InvoicePaymentAllocation copyWithCompanion(
    InvoicePaymentAllocationsCompanion data,
  ) {
    return InvoicePaymentAllocation(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePaymentAllocation(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountCents: $amountCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, paymentId, invoiceId, amountCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicePaymentAllocation &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.paymentId == this.paymentId &&
          other.invoiceId == this.invoiceId &&
          other.amountCents == this.amountCents);
}

class InvoicePaymentAllocationsCompanion
    extends UpdateCompanion<InvoicePaymentAllocation> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> paymentId;
  final Value<String> invoiceId;
  final Value<int> amountCents;
  final Value<int> rowid;
  const InvoicePaymentAllocationsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicePaymentAllocationsCompanion.insert({
    required String id,
    required String profileId,
    required String paymentId,
    required String invoiceId,
    required int amountCents,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       paymentId = Value(paymentId),
       invoiceId = Value(invoiceId),
       amountCents = Value(amountCents);
  static Insertable<InvoicePaymentAllocation> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? paymentId,
    Expression<String>? invoiceId,
    Expression<int>? amountCents,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (paymentId != null) 'payment_id': paymentId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicePaymentAllocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? paymentId,
    Value<String>? invoiceId,
    Value<int>? amountCents,
    Value<int>? rowid,
  }) {
    return InvoicePaymentAllocationsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      paymentId: paymentId ?? this.paymentId,
      invoiceId: invoiceId ?? this.invoiceId,
      amountCents: amountCents ?? this.amountCents,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePaymentAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountCents: $amountCents, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class RecurrenceSeries extends Table
    with TableInfo<RecurrenceSeries, RecurrenceSery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RecurrenceSeries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) BETWEEN 1 AND 160)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'income\', \'expense\', \'transfer\', \'card_purchase\'))',
  );
  static const VerificationMeta _pausedOnMeta = const VerificationMeta(
    'pausedOn',
  );
  late final GeneratedColumn<String> pausedOn = GeneratedColumn<String>(
    'paused_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    kind,
    pausedOn,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurrence_series';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurrenceSery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
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
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('paused_on')) {
      context.handle(
        _pausedOnMeta,
        pausedOn.isAcceptableOrUnknown(data['paused_on']!, _pausedOnMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurrenceSery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurrenceSery(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      pausedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paused_on'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  RecurrenceSeries createAlias(String alias) {
    return RecurrenceSeries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RecurrenceSery extends DataClass implements Insertable<RecurrenceSery> {
  final String id;
  final String profileId;
  final String name;
  final String kind;
  final String? pausedOn;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const RecurrenceSery({
    required this.id,
    required this.profileId,
    required this.name,
    required this.kind,
    this.pausedOn,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || pausedOn != null) {
      map['paused_on'] = Variable<String>(pausedOn);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  RecurrenceSeriesCompanion toCompanion(bool nullToAbsent) {
    return RecurrenceSeriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      kind: Value(kind),
      pausedOn: pausedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedOn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory RecurrenceSery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurrenceSery(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      pausedOn: serializer.fromJson<String?>(json['paused_on']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'paused_on': serializer.toJson<String?>(pausedOn),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  RecurrenceSery copyWith({
    String? id,
    String? profileId,
    String? name,
    String? kind,
    Value<String?> pausedOn = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => RecurrenceSery(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    pausedOn: pausedOn.present ? pausedOn.value : this.pausedOn,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  RecurrenceSery copyWithCompanion(RecurrenceSeriesCompanion data) {
    return RecurrenceSery(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      pausedOn: data.pausedOn.present ? data.pausedOn.value : this.pausedOn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceSery(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('pausedOn: $pausedOn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    name,
    kind,
    pausedOn,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurrenceSery &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.pausedOn == this.pausedOn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class RecurrenceSeriesCompanion extends UpdateCompanion<RecurrenceSery> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<String> kind;
  final Value<String?> pausedOn;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const RecurrenceSeriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.pausedOn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurrenceSeriesCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    required String kind,
    this.pausedOn = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name),
       kind = Value(kind),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RecurrenceSery> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? pausedOn,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (pausedOn != null) 'paused_on': pausedOn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurrenceSeriesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<String>? kind,
    Value<String?>? pausedOn,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return RecurrenceSeriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      pausedOn: pausedOn ?? this.pausedOn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (pausedOn.present) {
      map['paused_on'] = Variable<String>(pausedOn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceSeriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('pausedOn: $pausedOn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class RecurrenceRuleVersions extends Table
    with TableInfo<RecurrenceRuleVersions, RecurrenceRuleVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RecurrenceRuleVersions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  late final GeneratedColumn<String> seriesId = GeneratedColumn<String>(
    'series_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES recurrence_series(id)',
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  late final GeneratedColumn<String> validFrom = GeneratedColumn<String>(
    'valid_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  late final GeneratedColumn<int> isCurrent = GeneratedColumn<int>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (is_current IN (0, 1))',
    defaultValue: const CustomExpression('1'),
  );
  static const VerificationMeta _validUntilMeta = const VerificationMeta(
    'validUntil',
  );
  late final GeneratedColumn<String> validUntil = GeneratedColumn<String>(
    'valid_until',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _anchorOnMeta = const VerificationMeta(
    'anchorOn',
  );
  late final GeneratedColumn<String> anchorOn = GeneratedColumn<String>(
    'anchor_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (frequency IN (\'daily\', \'weekly\', \'monthly\', \'yearly\'))',
  );
  static const VerificationMeta _intervalCountMeta = const VerificationMeta(
    'intervalCount',
  );
  late final GeneratedColumn<int> intervalCount = GeneratedColumn<int>(
    'interval_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (interval_count BETWEEN 1 AND 1200)',
  );
  static const VerificationMeta _lastDayMeta = const VerificationMeta(
    'lastDay',
  );
  late final GeneratedColumn<int> lastDay = GeneratedColumn<int>(
    'last_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (last_day IN (0, 1))',
  );
  static const VerificationMeta _endOnMeta = const VerificationMeta('endOn');
  late final GeneratedColumn<String> endOn = GeneratedColumn<String>(
    'end_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _maxOccurrencesMeta = const VerificationMeta(
    'maxOccurrences',
  );
  late final GeneratedColumn<int> maxOccurrences = GeneratedColumn<int>(
    'max_occurrences',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (max_occurrences BETWEEN 1 AND 1000000)',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (length(trim(description)) BETWEEN 1 AND 160)',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents BETWEEN 1 AND 9007199254740991)',
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES accounts(id)',
  );
  static const VerificationMeta _destinationIdMeta = const VerificationMeta(
    'destinationId',
  );
  late final GeneratedColumn<String> destinationId = GeneratedColumn<String>(
    'destination_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES accounts(id)',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES credit_cards(id)',
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES categories(id)',
  );
  static const VerificationMeta _costNatureMeta = const VerificationMeta(
    'costNature',
  );
  late final GeneratedColumn<String> costNature = GeneratedColumn<String>(
    'cost_nature',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (cost_nature IN (\'fixed\', \'variable\'))',
  );
  static const VerificationMeta _essentialMeta = const VerificationMeta(
    'essential',
  );
  late final GeneratedColumn<int> essential = GeneratedColumn<int>(
    'essential',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (essential IN (0, 1))',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    seriesId,
    validFrom,
    isCurrent,
    validUntil,
    anchorOn,
    frequency,
    intervalCount,
    lastDay,
    endOn,
    maxOccurrences,
    description,
    amountCents,
    accountId,
    destinationId,
    cardId,
    categoryId,
    costNature,
    essential,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurrence_rule_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurrenceRuleVersion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesIdMeta);
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    } else if (isInserting) {
      context.missing(_validFromMeta);
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    }
    if (data.containsKey('valid_until')) {
      context.handle(
        _validUntilMeta,
        validUntil.isAcceptableOrUnknown(data['valid_until']!, _validUntilMeta),
      );
    }
    if (data.containsKey('anchor_on')) {
      context.handle(
        _anchorOnMeta,
        anchorOn.isAcceptableOrUnknown(data['anchor_on']!, _anchorOnMeta),
      );
    } else if (isInserting) {
      context.missing(_anchorOnMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('interval_count')) {
      context.handle(
        _intervalCountMeta,
        intervalCount.isAcceptableOrUnknown(
          data['interval_count']!,
          _intervalCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalCountMeta);
    }
    if (data.containsKey('last_day')) {
      context.handle(
        _lastDayMeta,
        lastDay.isAcceptableOrUnknown(data['last_day']!, _lastDayMeta),
      );
    } else if (isInserting) {
      context.missing(_lastDayMeta);
    }
    if (data.containsKey('end_on')) {
      context.handle(
        _endOnMeta,
        endOn.isAcceptableOrUnknown(data['end_on']!, _endOnMeta),
      );
    }
    if (data.containsKey('max_occurrences')) {
      context.handle(
        _maxOccurrencesMeta,
        maxOccurrences.isAcceptableOrUnknown(
          data['max_occurrences']!,
          _maxOccurrencesMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('destination_id')) {
      context.handle(
        _destinationIdMeta,
        destinationId.isAcceptableOrUnknown(
          data['destination_id']!,
          _destinationIdMeta,
        ),
      );
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('cost_nature')) {
      context.handle(
        _costNatureMeta,
        costNature.isAcceptableOrUnknown(data['cost_nature']!, _costNatureMeta),
      );
    }
    if (data.containsKey('essential')) {
      context.handle(
        _essentialMeta,
        essential.isAcceptableOrUnknown(data['essential']!, _essentialMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurrenceRuleVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurrenceRuleVersion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series_id'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valid_from'],
      )!,
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_current'],
      )!,
      validUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valid_until'],
      ),
      anchorOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anchor_on'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      intervalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_count'],
      )!,
      lastDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_day'],
      )!,
      endOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_on'],
      ),
      maxOccurrences: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_occurrences'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      destinationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_id'],
      ),
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      costNature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_nature'],
      ),
      essential: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}essential'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  RecurrenceRuleVersions createAlias(String alias) {
    return RecurrenceRuleVersions(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RecurrenceRuleVersion extends DataClass
    implements Insertable<RecurrenceRuleVersion> {
  final String id;
  final String profileId;
  final String seriesId;
  final String validFrom;
  final int isCurrent;
  final String? validUntil;
  final String anchorOn;
  final String frequency;
  final int intervalCount;
  final int lastDay;
  final String? endOn;
  final int? maxOccurrences;
  final String description;
  final int amountCents;
  final String? accountId;
  final String? destinationId;
  final String? cardId;
  final String? categoryId;
  final String? costNature;
  final int? essential;
  final String createdAt;
  const RecurrenceRuleVersion({
    required this.id,
    required this.profileId,
    required this.seriesId,
    required this.validFrom,
    required this.isCurrent,
    this.validUntil,
    required this.anchorOn,
    required this.frequency,
    required this.intervalCount,
    required this.lastDay,
    this.endOn,
    this.maxOccurrences,
    required this.description,
    required this.amountCents,
    this.accountId,
    this.destinationId,
    this.cardId,
    this.categoryId,
    this.costNature,
    this.essential,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['series_id'] = Variable<String>(seriesId);
    map['valid_from'] = Variable<String>(validFrom);
    map['is_current'] = Variable<int>(isCurrent);
    if (!nullToAbsent || validUntil != null) {
      map['valid_until'] = Variable<String>(validUntil);
    }
    map['anchor_on'] = Variable<String>(anchorOn);
    map['frequency'] = Variable<String>(frequency);
    map['interval_count'] = Variable<int>(intervalCount);
    map['last_day'] = Variable<int>(lastDay);
    if (!nullToAbsent || endOn != null) {
      map['end_on'] = Variable<String>(endOn);
    }
    if (!nullToAbsent || maxOccurrences != null) {
      map['max_occurrences'] = Variable<int>(maxOccurrences);
    }
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || destinationId != null) {
      map['destination_id'] = Variable<String>(destinationId);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<String>(cardId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || costNature != null) {
      map['cost_nature'] = Variable<String>(costNature);
    }
    if (!nullToAbsent || essential != null) {
      map['essential'] = Variable<int>(essential);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  RecurrenceRuleVersionsCompanion toCompanion(bool nullToAbsent) {
    return RecurrenceRuleVersionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      seriesId: Value(seriesId),
      validFrom: Value(validFrom),
      isCurrent: Value(isCurrent),
      validUntil: validUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(validUntil),
      anchorOn: Value(anchorOn),
      frequency: Value(frequency),
      intervalCount: Value(intervalCount),
      lastDay: Value(lastDay),
      endOn: endOn == null && nullToAbsent
          ? const Value.absent()
          : Value(endOn),
      maxOccurrences: maxOccurrences == null && nullToAbsent
          ? const Value.absent()
          : Value(maxOccurrences),
      description: Value(description),
      amountCents: Value(amountCents),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      destinationId: destinationId == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationId),
      cardId: cardId == null && nullToAbsent
          ? const Value.absent()
          : Value(cardId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      costNature: costNature == null && nullToAbsent
          ? const Value.absent()
          : Value(costNature),
      essential: essential == null && nullToAbsent
          ? const Value.absent()
          : Value(essential),
      createdAt: Value(createdAt),
    );
  }

  factory RecurrenceRuleVersion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurrenceRuleVersion(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      seriesId: serializer.fromJson<String>(json['series_id']),
      validFrom: serializer.fromJson<String>(json['valid_from']),
      isCurrent: serializer.fromJson<int>(json['is_current']),
      validUntil: serializer.fromJson<String?>(json['valid_until']),
      anchorOn: serializer.fromJson<String>(json['anchor_on']),
      frequency: serializer.fromJson<String>(json['frequency']),
      intervalCount: serializer.fromJson<int>(json['interval_count']),
      lastDay: serializer.fromJson<int>(json['last_day']),
      endOn: serializer.fromJson<String?>(json['end_on']),
      maxOccurrences: serializer.fromJson<int?>(json['max_occurrences']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
      accountId: serializer.fromJson<String?>(json['account_id']),
      destinationId: serializer.fromJson<String?>(json['destination_id']),
      cardId: serializer.fromJson<String?>(json['card_id']),
      categoryId: serializer.fromJson<String?>(json['category_id']),
      costNature: serializer.fromJson<String?>(json['cost_nature']),
      essential: serializer.fromJson<int?>(json['essential']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'series_id': serializer.toJson<String>(seriesId),
      'valid_from': serializer.toJson<String>(validFrom),
      'is_current': serializer.toJson<int>(isCurrent),
      'valid_until': serializer.toJson<String?>(validUntil),
      'anchor_on': serializer.toJson<String>(anchorOn),
      'frequency': serializer.toJson<String>(frequency),
      'interval_count': serializer.toJson<int>(intervalCount),
      'last_day': serializer.toJson<int>(lastDay),
      'end_on': serializer.toJson<String?>(endOn),
      'max_occurrences': serializer.toJson<int?>(maxOccurrences),
      'description': serializer.toJson<String>(description),
      'amount_cents': serializer.toJson<int>(amountCents),
      'account_id': serializer.toJson<String?>(accountId),
      'destination_id': serializer.toJson<String?>(destinationId),
      'card_id': serializer.toJson<String?>(cardId),
      'category_id': serializer.toJson<String?>(categoryId),
      'cost_nature': serializer.toJson<String?>(costNature),
      'essential': serializer.toJson<int?>(essential),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  RecurrenceRuleVersion copyWith({
    String? id,
    String? profileId,
    String? seriesId,
    String? validFrom,
    int? isCurrent,
    Value<String?> validUntil = const Value.absent(),
    String? anchorOn,
    String? frequency,
    int? intervalCount,
    int? lastDay,
    Value<String?> endOn = const Value.absent(),
    Value<int?> maxOccurrences = const Value.absent(),
    String? description,
    int? amountCents,
    Value<String?> accountId = const Value.absent(),
    Value<String?> destinationId = const Value.absent(),
    Value<String?> cardId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> costNature = const Value.absent(),
    Value<int?> essential = const Value.absent(),
    String? createdAt,
  }) => RecurrenceRuleVersion(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    seriesId: seriesId ?? this.seriesId,
    validFrom: validFrom ?? this.validFrom,
    isCurrent: isCurrent ?? this.isCurrent,
    validUntil: validUntil.present ? validUntil.value : this.validUntil,
    anchorOn: anchorOn ?? this.anchorOn,
    frequency: frequency ?? this.frequency,
    intervalCount: intervalCount ?? this.intervalCount,
    lastDay: lastDay ?? this.lastDay,
    endOn: endOn.present ? endOn.value : this.endOn,
    maxOccurrences: maxOccurrences.present
        ? maxOccurrences.value
        : this.maxOccurrences,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    accountId: accountId.present ? accountId.value : this.accountId,
    destinationId: destinationId.present
        ? destinationId.value
        : this.destinationId,
    cardId: cardId.present ? cardId.value : this.cardId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    costNature: costNature.present ? costNature.value : this.costNature,
    essential: essential.present ? essential.value : this.essential,
    createdAt: createdAt ?? this.createdAt,
  );
  RecurrenceRuleVersion copyWithCompanion(
    RecurrenceRuleVersionsCompanion data,
  ) {
    return RecurrenceRuleVersion(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
      validUntil: data.validUntil.present
          ? data.validUntil.value
          : this.validUntil,
      anchorOn: data.anchorOn.present ? data.anchorOn.value : this.anchorOn,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      intervalCount: data.intervalCount.present
          ? data.intervalCount.value
          : this.intervalCount,
      lastDay: data.lastDay.present ? data.lastDay.value : this.lastDay,
      endOn: data.endOn.present ? data.endOn.value : this.endOn,
      maxOccurrences: data.maxOccurrences.present
          ? data.maxOccurrences.value
          : this.maxOccurrences,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      destinationId: data.destinationId.present
          ? data.destinationId.value
          : this.destinationId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      costNature: data.costNature.present
          ? data.costNature.value
          : this.costNature,
      essential: data.essential.present ? data.essential.value : this.essential,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceRuleVersion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('seriesId: $seriesId, ')
          ..write('validFrom: $validFrom, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('validUntil: $validUntil, ')
          ..write('anchorOn: $anchorOn, ')
          ..write('frequency: $frequency, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('lastDay: $lastDay, ')
          ..write('endOn: $endOn, ')
          ..write('maxOccurrences: $maxOccurrences, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('accountId: $accountId, ')
          ..write('destinationId: $destinationId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    profileId,
    seriesId,
    validFrom,
    isCurrent,
    validUntil,
    anchorOn,
    frequency,
    intervalCount,
    lastDay,
    endOn,
    maxOccurrences,
    description,
    amountCents,
    accountId,
    destinationId,
    cardId,
    categoryId,
    costNature,
    essential,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurrenceRuleVersion &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.seriesId == this.seriesId &&
          other.validFrom == this.validFrom &&
          other.isCurrent == this.isCurrent &&
          other.validUntil == this.validUntil &&
          other.anchorOn == this.anchorOn &&
          other.frequency == this.frequency &&
          other.intervalCount == this.intervalCount &&
          other.lastDay == this.lastDay &&
          other.endOn == this.endOn &&
          other.maxOccurrences == this.maxOccurrences &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.accountId == this.accountId &&
          other.destinationId == this.destinationId &&
          other.cardId == this.cardId &&
          other.categoryId == this.categoryId &&
          other.costNature == this.costNature &&
          other.essential == this.essential &&
          other.createdAt == this.createdAt);
}

class RecurrenceRuleVersionsCompanion
    extends UpdateCompanion<RecurrenceRuleVersion> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> seriesId;
  final Value<String> validFrom;
  final Value<int> isCurrent;
  final Value<String?> validUntil;
  final Value<String> anchorOn;
  final Value<String> frequency;
  final Value<int> intervalCount;
  final Value<int> lastDay;
  final Value<String?> endOn;
  final Value<int?> maxOccurrences;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<String?> accountId;
  final Value<String?> destinationId;
  final Value<String?> cardId;
  final Value<String?> categoryId;
  final Value<String?> costNature;
  final Value<int?> essential;
  final Value<String> createdAt;
  final Value<int> rowid;
  const RecurrenceRuleVersionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.validUntil = const Value.absent(),
    this.anchorOn = const Value.absent(),
    this.frequency = const Value.absent(),
    this.intervalCount = const Value.absent(),
    this.lastDay = const Value.absent(),
    this.endOn = const Value.absent(),
    this.maxOccurrences = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.accountId = const Value.absent(),
    this.destinationId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurrenceRuleVersionsCompanion.insert({
    required String id,
    required String profileId,
    required String seriesId,
    required String validFrom,
    this.isCurrent = const Value.absent(),
    this.validUntil = const Value.absent(),
    required String anchorOn,
    required String frequency,
    required int intervalCount,
    required int lastDay,
    this.endOn = const Value.absent(),
    this.maxOccurrences = const Value.absent(),
    required String description,
    required int amountCents,
    this.accountId = const Value.absent(),
    this.destinationId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       seriesId = Value(seriesId),
       validFrom = Value(validFrom),
       anchorOn = Value(anchorOn),
       frequency = Value(frequency),
       intervalCount = Value(intervalCount),
       lastDay = Value(lastDay),
       description = Value(description),
       amountCents = Value(amountCents),
       createdAt = Value(createdAt);
  static Insertable<RecurrenceRuleVersion> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? seriesId,
    Expression<String>? validFrom,
    Expression<int>? isCurrent,
    Expression<String>? validUntil,
    Expression<String>? anchorOn,
    Expression<String>? frequency,
    Expression<int>? intervalCount,
    Expression<int>? lastDay,
    Expression<String>? endOn,
    Expression<int>? maxOccurrences,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<String>? accountId,
    Expression<String>? destinationId,
    Expression<String>? cardId,
    Expression<String>? categoryId,
    Expression<String>? costNature,
    Expression<int>? essential,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (seriesId != null) 'series_id': seriesId,
      if (validFrom != null) 'valid_from': validFrom,
      if (isCurrent != null) 'is_current': isCurrent,
      if (validUntil != null) 'valid_until': validUntil,
      if (anchorOn != null) 'anchor_on': anchorOn,
      if (frequency != null) 'frequency': frequency,
      if (intervalCount != null) 'interval_count': intervalCount,
      if (lastDay != null) 'last_day': lastDay,
      if (endOn != null) 'end_on': endOn,
      if (maxOccurrences != null) 'max_occurrences': maxOccurrences,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (accountId != null) 'account_id': accountId,
      if (destinationId != null) 'destination_id': destinationId,
      if (cardId != null) 'card_id': cardId,
      if (categoryId != null) 'category_id': categoryId,
      if (costNature != null) 'cost_nature': costNature,
      if (essential != null) 'essential': essential,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurrenceRuleVersionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? seriesId,
    Value<String>? validFrom,
    Value<int>? isCurrent,
    Value<String?>? validUntil,
    Value<String>? anchorOn,
    Value<String>? frequency,
    Value<int>? intervalCount,
    Value<int>? lastDay,
    Value<String?>? endOn,
    Value<int?>? maxOccurrences,
    Value<String>? description,
    Value<int>? amountCents,
    Value<String?>? accountId,
    Value<String?>? destinationId,
    Value<String?>? cardId,
    Value<String?>? categoryId,
    Value<String?>? costNature,
    Value<int?>? essential,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return RecurrenceRuleVersionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      seriesId: seriesId ?? this.seriesId,
      validFrom: validFrom ?? this.validFrom,
      isCurrent: isCurrent ?? this.isCurrent,
      validUntil: validUntil ?? this.validUntil,
      anchorOn: anchorOn ?? this.anchorOn,
      frequency: frequency ?? this.frequency,
      intervalCount: intervalCount ?? this.intervalCount,
      lastDay: lastDay ?? this.lastDay,
      endOn: endOn ?? this.endOn,
      maxOccurrences: maxOccurrences ?? this.maxOccurrences,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      accountId: accountId ?? this.accountId,
      destinationId: destinationId ?? this.destinationId,
      cardId: cardId ?? this.cardId,
      categoryId: categoryId ?? this.categoryId,
      costNature: costNature ?? this.costNature,
      essential: essential ?? this.essential,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (seriesId.present) {
      map['series_id'] = Variable<String>(seriesId.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<String>(validFrom.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<int>(isCurrent.value);
    }
    if (validUntil.present) {
      map['valid_until'] = Variable<String>(validUntil.value);
    }
    if (anchorOn.present) {
      map['anchor_on'] = Variable<String>(anchorOn.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (intervalCount.present) {
      map['interval_count'] = Variable<int>(intervalCount.value);
    }
    if (lastDay.present) {
      map['last_day'] = Variable<int>(lastDay.value);
    }
    if (endOn.present) {
      map['end_on'] = Variable<String>(endOn.value);
    }
    if (maxOccurrences.present) {
      map['max_occurrences'] = Variable<int>(maxOccurrences.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (destinationId.present) {
      map['destination_id'] = Variable<String>(destinationId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (costNature.present) {
      map['cost_nature'] = Variable<String>(costNature.value);
    }
    if (essential.present) {
      map['essential'] = Variable<int>(essential.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceRuleVersionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('seriesId: $seriesId, ')
          ..write('validFrom: $validFrom, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('validUntil: $validUntil, ')
          ..write('anchorOn: $anchorOn, ')
          ..write('frequency: $frequency, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('lastDay: $lastDay, ')
          ..write('endOn: $endOn, ')
          ..write('maxOccurrences: $maxOccurrences, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('accountId: $accountId, ')
          ..write('destinationId: $destinationId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ScheduledOccurrences extends Table
    with TableInfo<ScheduledOccurrences, ScheduledOccurrence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScheduledOccurrences(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  late final GeneratedColumn<String> seriesId = GeneratedColumn<String>(
    'series_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES recurrence_series(id)',
  );
  static const VerificationMeta _ruleVersionIdMeta = const VerificationMeta(
    'ruleVersionId',
  );
  late final GeneratedColumn<String> ruleVersionId = GeneratedColumn<String>(
    'rule_version_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES recurrence_rule_versions(id)',
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (ordinal > 0)',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'income\', \'expense\', \'transfer\', \'card_purchase\'))',
  );
  static const VerificationMeta _scheduledOnMeta = const VerificationMeta(
    'scheduledOn',
  );
  late final GeneratedColumn<String> scheduledOn = GeneratedColumn<String>(
    'scheduled_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (length(trim(description)) BETWEEN 1 AND 160)',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents BETWEEN 1 AND 9007199254740991)',
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES accounts(id)',
  );
  static const VerificationMeta _destinationIdMeta = const VerificationMeta(
    'destinationId',
  );
  late final GeneratedColumn<String> destinationId = GeneratedColumn<String>(
    'destination_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES accounts(id)',
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES credit_cards(id)',
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES categories(id)',
  );
  static const VerificationMeta _costNatureMeta = const VerificationMeta(
    'costNature',
  );
  late final GeneratedColumn<String> costNature = GeneratedColumn<String>(
    'cost_nature',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (cost_nature IN (\'fixed\', \'variable\'))',
  );
  static const VerificationMeta _essentialMeta = const VerificationMeta(
    'essential',
  );
  late final GeneratedColumn<int> essential = GeneratedColumn<int>(
    'essential',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (essential IN (0, 1))',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (status IN (\'pending\', \'settled\', \'skipped\', \'cancelled\'))',
  );
  static const VerificationMeta _settledEventIdMeta = const VerificationMeta(
    'settledEventId',
  );
  late final GeneratedColumn<String> settledEventId = GeneratedColumn<String>(
    'settled_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'UNIQUE REFERENCES financial_events(id)',
  );
  static const VerificationMeta _isManualOverrideMeta = const VerificationMeta(
    'isManualOverride',
  );
  late final GeneratedColumn<int> isManualOverride = GeneratedColumn<int>(
    'is_manual_override',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (is_manual_override IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    seriesId,
    ruleVersionId,
    ordinal,
    kind,
    scheduledOn,
    description,
    amountCents,
    accountId,
    destinationId,
    cardId,
    categoryId,
    costNature,
    essential,
    status,
    settledEventId,
    isManualOverride,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduledOccurrence> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    }
    if (data.containsKey('rule_version_id')) {
      context.handle(
        _ruleVersionIdMeta,
        ruleVersionId.isAcceptableOrUnknown(
          data['rule_version_id']!,
          _ruleVersionIdMeta,
        ),
      );
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
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
    if (data.containsKey('scheduled_on')) {
      context.handle(
        _scheduledOnMeta,
        scheduledOn.isAcceptableOrUnknown(
          data['scheduled_on']!,
          _scheduledOnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledOnMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('destination_id')) {
      context.handle(
        _destinationIdMeta,
        destinationId.isAcceptableOrUnknown(
          data['destination_id']!,
          _destinationIdMeta,
        ),
      );
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('cost_nature')) {
      context.handle(
        _costNatureMeta,
        costNature.isAcceptableOrUnknown(data['cost_nature']!, _costNatureMeta),
      );
    }
    if (data.containsKey('essential')) {
      context.handle(
        _essentialMeta,
        essential.isAcceptableOrUnknown(data['essential']!, _essentialMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('settled_event_id')) {
      context.handle(
        _settledEventIdMeta,
        settledEventId.isAcceptableOrUnknown(
          data['settled_event_id']!,
          _settledEventIdMeta,
        ),
      );
    }
    if (data.containsKey('is_manual_override')) {
      context.handle(
        _isManualOverrideMeta,
        isManualOverride.isAcceptableOrUnknown(
          data['is_manual_override']!,
          _isManualOverrideMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {ruleVersionId, ordinal},
  ];
  @override
  ScheduledOccurrence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledOccurrence(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series_id'],
      ),
      ruleVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_version_id'],
      ),
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      scheduledOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_on'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      destinationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_id'],
      ),
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      costNature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_nature'],
      ),
      essential: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}essential'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      settledEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settled_event_id'],
      ),
      isManualOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_manual_override'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  ScheduledOccurrences createAlias(String alias) {
    return ScheduledOccurrences(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(rule_version_id, ordinal)',
    'CHECK((series_id IS NULL AND rule_version_id IS NULL AND ordinal IS NULL)OR(series_id IS NOT NULL AND rule_version_id IS NOT NULL AND ordinal IS NOT NULL))',
    'CHECK((status = \'settled\' AND settled_event_id IS NOT NULL)OR(status != \'settled\' AND settled_event_id IS NULL))',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScheduledOccurrence extends DataClass
    implements Insertable<ScheduledOccurrence> {
  final String id;
  final String profileId;
  final String? seriesId;
  final String? ruleVersionId;
  final int? ordinal;
  final String kind;
  final String scheduledOn;
  final String description;
  final int amountCents;
  final String? accountId;
  final String? destinationId;
  final String? cardId;
  final String? categoryId;
  final String? costNature;
  final int? essential;
  final String status;
  final String? settledEventId;
  final int isManualOverride;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const ScheduledOccurrence({
    required this.id,
    required this.profileId,
    this.seriesId,
    this.ruleVersionId,
    this.ordinal,
    required this.kind,
    required this.scheduledOn,
    required this.description,
    required this.amountCents,
    this.accountId,
    this.destinationId,
    this.cardId,
    this.categoryId,
    this.costNature,
    this.essential,
    required this.status,
    this.settledEventId,
    required this.isManualOverride,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || seriesId != null) {
      map['series_id'] = Variable<String>(seriesId);
    }
    if (!nullToAbsent || ruleVersionId != null) {
      map['rule_version_id'] = Variable<String>(ruleVersionId);
    }
    if (!nullToAbsent || ordinal != null) {
      map['ordinal'] = Variable<int>(ordinal);
    }
    map['kind'] = Variable<String>(kind);
    map['scheduled_on'] = Variable<String>(scheduledOn);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || destinationId != null) {
      map['destination_id'] = Variable<String>(destinationId);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<String>(cardId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || costNature != null) {
      map['cost_nature'] = Variable<String>(costNature);
    }
    if (!nullToAbsent || essential != null) {
      map['essential'] = Variable<int>(essential);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || settledEventId != null) {
      map['settled_event_id'] = Variable<String>(settledEventId);
    }
    map['is_manual_override'] = Variable<int>(isManualOverride);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  ScheduledOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return ScheduledOccurrencesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      seriesId: seriesId == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesId),
      ruleVersionId: ruleVersionId == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleVersionId),
      ordinal: ordinal == null && nullToAbsent
          ? const Value.absent()
          : Value(ordinal),
      kind: Value(kind),
      scheduledOn: Value(scheduledOn),
      description: Value(description),
      amountCents: Value(amountCents),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      destinationId: destinationId == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationId),
      cardId: cardId == null && nullToAbsent
          ? const Value.absent()
          : Value(cardId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      costNature: costNature == null && nullToAbsent
          ? const Value.absent()
          : Value(costNature),
      essential: essential == null && nullToAbsent
          ? const Value.absent()
          : Value(essential),
      status: Value(status),
      settledEventId: settledEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(settledEventId),
      isManualOverride: Value(isManualOverride),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory ScheduledOccurrence.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledOccurrence(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      seriesId: serializer.fromJson<String?>(json['series_id']),
      ruleVersionId: serializer.fromJson<String?>(json['rule_version_id']),
      ordinal: serializer.fromJson<int?>(json['ordinal']),
      kind: serializer.fromJson<String>(json['kind']),
      scheduledOn: serializer.fromJson<String>(json['scheduled_on']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
      accountId: serializer.fromJson<String?>(json['account_id']),
      destinationId: serializer.fromJson<String?>(json['destination_id']),
      cardId: serializer.fromJson<String?>(json['card_id']),
      categoryId: serializer.fromJson<String?>(json['category_id']),
      costNature: serializer.fromJson<String?>(json['cost_nature']),
      essential: serializer.fromJson<int?>(json['essential']),
      status: serializer.fromJson<String>(json['status']),
      settledEventId: serializer.fromJson<String?>(json['settled_event_id']),
      isManualOverride: serializer.fromJson<int>(json['is_manual_override']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'series_id': serializer.toJson<String?>(seriesId),
      'rule_version_id': serializer.toJson<String?>(ruleVersionId),
      'ordinal': serializer.toJson<int?>(ordinal),
      'kind': serializer.toJson<String>(kind),
      'scheduled_on': serializer.toJson<String>(scheduledOn),
      'description': serializer.toJson<String>(description),
      'amount_cents': serializer.toJson<int>(amountCents),
      'account_id': serializer.toJson<String?>(accountId),
      'destination_id': serializer.toJson<String?>(destinationId),
      'card_id': serializer.toJson<String?>(cardId),
      'category_id': serializer.toJson<String?>(categoryId),
      'cost_nature': serializer.toJson<String?>(costNature),
      'essential': serializer.toJson<int?>(essential),
      'status': serializer.toJson<String>(status),
      'settled_event_id': serializer.toJson<String?>(settledEventId),
      'is_manual_override': serializer.toJson<int>(isManualOverride),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  ScheduledOccurrence copyWith({
    String? id,
    String? profileId,
    Value<String?> seriesId = const Value.absent(),
    Value<String?> ruleVersionId = const Value.absent(),
    Value<int?> ordinal = const Value.absent(),
    String? kind,
    String? scheduledOn,
    String? description,
    int? amountCents,
    Value<String?> accountId = const Value.absent(),
    Value<String?> destinationId = const Value.absent(),
    Value<String?> cardId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> costNature = const Value.absent(),
    Value<int?> essential = const Value.absent(),
    String? status,
    Value<String?> settledEventId = const Value.absent(),
    int? isManualOverride,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => ScheduledOccurrence(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    seriesId: seriesId.present ? seriesId.value : this.seriesId,
    ruleVersionId: ruleVersionId.present
        ? ruleVersionId.value
        : this.ruleVersionId,
    ordinal: ordinal.present ? ordinal.value : this.ordinal,
    kind: kind ?? this.kind,
    scheduledOn: scheduledOn ?? this.scheduledOn,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    accountId: accountId.present ? accountId.value : this.accountId,
    destinationId: destinationId.present
        ? destinationId.value
        : this.destinationId,
    cardId: cardId.present ? cardId.value : this.cardId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    costNature: costNature.present ? costNature.value : this.costNature,
    essential: essential.present ? essential.value : this.essential,
    status: status ?? this.status,
    settledEventId: settledEventId.present
        ? settledEventId.value
        : this.settledEventId,
    isManualOverride: isManualOverride ?? this.isManualOverride,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  ScheduledOccurrence copyWithCompanion(ScheduledOccurrencesCompanion data) {
    return ScheduledOccurrence(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      ruleVersionId: data.ruleVersionId.present
          ? data.ruleVersionId.value
          : this.ruleVersionId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      kind: data.kind.present ? data.kind.value : this.kind,
      scheduledOn: data.scheduledOn.present
          ? data.scheduledOn.value
          : this.scheduledOn,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      destinationId: data.destinationId.present
          ? data.destinationId.value
          : this.destinationId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      costNature: data.costNature.present
          ? data.costNature.value
          : this.costNature,
      essential: data.essential.present ? data.essential.value : this.essential,
      status: data.status.present ? data.status.value : this.status,
      settledEventId: data.settledEventId.present
          ? data.settledEventId.value
          : this.settledEventId,
      isManualOverride: data.isManualOverride.present
          ? data.isManualOverride.value
          : this.isManualOverride,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledOccurrence(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('seriesId: $seriesId, ')
          ..write('ruleVersionId: $ruleVersionId, ')
          ..write('ordinal: $ordinal, ')
          ..write('kind: $kind, ')
          ..write('scheduledOn: $scheduledOn, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('accountId: $accountId, ')
          ..write('destinationId: $destinationId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('status: $status, ')
          ..write('settledEventId: $settledEventId, ')
          ..write('isManualOverride: $isManualOverride, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    profileId,
    seriesId,
    ruleVersionId,
    ordinal,
    kind,
    scheduledOn,
    description,
    amountCents,
    accountId,
    destinationId,
    cardId,
    categoryId,
    costNature,
    essential,
    status,
    settledEventId,
    isManualOverride,
    createdAt,
    updatedAt,
    revision,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledOccurrence &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.seriesId == this.seriesId &&
          other.ruleVersionId == this.ruleVersionId &&
          other.ordinal == this.ordinal &&
          other.kind == this.kind &&
          other.scheduledOn == this.scheduledOn &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.accountId == this.accountId &&
          other.destinationId == this.destinationId &&
          other.cardId == this.cardId &&
          other.categoryId == this.categoryId &&
          other.costNature == this.costNature &&
          other.essential == this.essential &&
          other.status == this.status &&
          other.settledEventId == this.settledEventId &&
          other.isManualOverride == this.isManualOverride &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class ScheduledOccurrencesCompanion
    extends UpdateCompanion<ScheduledOccurrence> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> seriesId;
  final Value<String?> ruleVersionId;
  final Value<int?> ordinal;
  final Value<String> kind;
  final Value<String> scheduledOn;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<String?> accountId;
  final Value<String?> destinationId;
  final Value<String?> cardId;
  final Value<String?> categoryId;
  final Value<String?> costNature;
  final Value<int?> essential;
  final Value<String> status;
  final Value<String?> settledEventId;
  final Value<int> isManualOverride;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const ScheduledOccurrencesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.ruleVersionId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.kind = const Value.absent(),
    this.scheduledOn = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.accountId = const Value.absent(),
    this.destinationId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    this.status = const Value.absent(),
    this.settledEventId = const Value.absent(),
    this.isManualOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduledOccurrencesCompanion.insert({
    required String id,
    required String profileId,
    this.seriesId = const Value.absent(),
    this.ruleVersionId = const Value.absent(),
    this.ordinal = const Value.absent(),
    required String kind,
    required String scheduledOn,
    required String description,
    required int amountCents,
    this.accountId = const Value.absent(),
    this.destinationId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.costNature = const Value.absent(),
    this.essential = const Value.absent(),
    required String status,
    this.settledEventId = const Value.absent(),
    this.isManualOverride = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       kind = Value(kind),
       scheduledOn = Value(scheduledOn),
       description = Value(description),
       amountCents = Value(amountCents),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduledOccurrence> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? seriesId,
    Expression<String>? ruleVersionId,
    Expression<int>? ordinal,
    Expression<String>? kind,
    Expression<String>? scheduledOn,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<String>? accountId,
    Expression<String>? destinationId,
    Expression<String>? cardId,
    Expression<String>? categoryId,
    Expression<String>? costNature,
    Expression<int>? essential,
    Expression<String>? status,
    Expression<String>? settledEventId,
    Expression<int>? isManualOverride,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (seriesId != null) 'series_id': seriesId,
      if (ruleVersionId != null) 'rule_version_id': ruleVersionId,
      if (ordinal != null) 'ordinal': ordinal,
      if (kind != null) 'kind': kind,
      if (scheduledOn != null) 'scheduled_on': scheduledOn,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (accountId != null) 'account_id': accountId,
      if (destinationId != null) 'destination_id': destinationId,
      if (cardId != null) 'card_id': cardId,
      if (categoryId != null) 'category_id': categoryId,
      if (costNature != null) 'cost_nature': costNature,
      if (essential != null) 'essential': essential,
      if (status != null) 'status': status,
      if (settledEventId != null) 'settled_event_id': settledEventId,
      if (isManualOverride != null) 'is_manual_override': isManualOverride,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduledOccurrencesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? seriesId,
    Value<String?>? ruleVersionId,
    Value<int?>? ordinal,
    Value<String>? kind,
    Value<String>? scheduledOn,
    Value<String>? description,
    Value<int>? amountCents,
    Value<String?>? accountId,
    Value<String?>? destinationId,
    Value<String?>? cardId,
    Value<String?>? categoryId,
    Value<String?>? costNature,
    Value<int?>? essential,
    Value<String>? status,
    Value<String?>? settledEventId,
    Value<int>? isManualOverride,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return ScheduledOccurrencesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      seriesId: seriesId ?? this.seriesId,
      ruleVersionId: ruleVersionId ?? this.ruleVersionId,
      ordinal: ordinal ?? this.ordinal,
      kind: kind ?? this.kind,
      scheduledOn: scheduledOn ?? this.scheduledOn,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      accountId: accountId ?? this.accountId,
      destinationId: destinationId ?? this.destinationId,
      cardId: cardId ?? this.cardId,
      categoryId: categoryId ?? this.categoryId,
      costNature: costNature ?? this.costNature,
      essential: essential ?? this.essential,
      status: status ?? this.status,
      settledEventId: settledEventId ?? this.settledEventId,
      isManualOverride: isManualOverride ?? this.isManualOverride,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (seriesId.present) {
      map['series_id'] = Variable<String>(seriesId.value);
    }
    if (ruleVersionId.present) {
      map['rule_version_id'] = Variable<String>(ruleVersionId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (scheduledOn.present) {
      map['scheduled_on'] = Variable<String>(scheduledOn.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (destinationId.present) {
      map['destination_id'] = Variable<String>(destinationId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (costNature.present) {
      map['cost_nature'] = Variable<String>(costNature.value);
    }
    if (essential.present) {
      map['essential'] = Variable<int>(essential.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (settledEventId.present) {
      map['settled_event_id'] = Variable<String>(settledEventId.value);
    }
    if (isManualOverride.present) {
      map['is_manual_override'] = Variable<int>(isManualOverride.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('seriesId: $seriesId, ')
          ..write('ruleVersionId: $ruleVersionId, ')
          ..write('ordinal: $ordinal, ')
          ..write('kind: $kind, ')
          ..write('scheduledOn: $scheduledOn, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('accountId: $accountId, ')
          ..write('destinationId: $destinationId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('costNature: $costNature, ')
          ..write('essential: $essential, ')
          ..write('status: $status, ')
          ..write('settledEventId: $settledEventId, ')
          ..write('isManualOverride: $isManualOverride, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Objectives extends Table with TableInfo<Objectives, Objective> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Objectives(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(title)) BETWEEN 1 AND 80)',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (status IN (\'active\', \'completed\', \'archived\'))',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    title,
    status,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'objectives';
  @override
  VerificationContext validateIntegrity(
    Insertable<Objective> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Objective map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Objective(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  Objectives createAlias(String alias) {
    return Objectives(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Objective extends DataClass implements Insertable<Objective> {
  final String id;
  final String profileId;
  final String title;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const Objective({
    required this.id,
    required this.profileId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['title'] = Variable<String>(title);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  ObjectivesCompanion toCompanion(bool nullToAbsent) {
    return ObjectivesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      title: Value(title),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory Objective.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Objective(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      title: serializer.fromJson<String>(json['title']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'title': serializer.toJson<String>(title),
      'status': serializer.toJson<String>(status),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  Objective copyWith({
    String? id,
    String? profileId,
    String? title,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => Objective(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    title: title ?? this.title,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  Objective copyWithCompanion(ObjectivesCompanion data) {
    return Objective(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      title: data.title.present ? data.title.value : this.title,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Objective(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, title, status, createdAt, updatedAt, revision);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Objective &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.title == this.title &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class ObjectivesCompanion extends UpdateCompanion<Objective> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> title;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const ObjectivesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.title = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObjectivesCompanion.insert({
    required String id,
    required String profileId,
    required String title,
    required String status,
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       title = Value(title),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Objective> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? title,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (title != null) 'title': title,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObjectivesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? title,
    Value<String>? status,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return ObjectivesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObjectivesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Goals extends Table with TableInfo<Goals, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Goals(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _objectiveIdMeta = const VerificationMeta(
    'objectiveId',
  );
  late final GeneratedColumn<String> objectiveId = GeneratedColumn<String>(
    'objective_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES objectives(id)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(title)) BETWEEN 1 AND 80)',
  );
  static const VerificationMeta _purposeMeta = const VerificationMeta(
    'purpose',
  );
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (purpose IN (\'emergency\', \'purchase\', \'general\'))',
  );
  static const VerificationMeta _targetCentsMeta = const VerificationMeta(
    'targetCents',
  );
  late final GeneratedColumn<int> targetCents = GeneratedColumn<int>(
    'target_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(target_cents) = \'integer\' AND target_cents > 0 AND target_cents <= 9007199254740991)',
  );
  static const VerificationMeta _targetOnMeta = const VerificationMeta(
    'targetOn',
  );
  late final GeneratedColumn<String> targetOn = GeneratedColumn<String>(
    'target_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (priority BETWEEN 1 AND 5)',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (status IN (\'active\', \'paused\', \'fulfilled\', \'archived\'))',
  );
  static const VerificationMeta _fulfilledOnMeta = const VerificationMeta(
    'fulfilledOn',
  );
  late final GeneratedColumn<String> fulfilledOn = GeneratedColumn<String>(
    'fulfilled_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _fulfilledCentsMeta = const VerificationMeta(
    'fulfilledCents',
  );
  late final GeneratedColumn<int> fulfilledCents = GeneratedColumn<int>(
    'fulfilled_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'CHECK (fulfilled_cents IS NULL OR fulfilled_cents >= 0)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 1 CHECK (revision > 0)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    objectiveId,
    title,
    purpose,
    targetCents,
    targetOn,
    priority,
    status,
    fulfilledOn,
    fulfilledCents,
    createdAt,
    updatedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('objective_id')) {
      context.handle(
        _objectiveIdMeta,
        objectiveId.isAcceptableOrUnknown(
          data['objective_id']!,
          _objectiveIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('purpose')) {
      context.handle(
        _purposeMeta,
        purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta),
      );
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('target_cents')) {
      context.handle(
        _targetCentsMeta,
        targetCents.isAcceptableOrUnknown(
          data['target_cents']!,
          _targetCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCentsMeta);
    }
    if (data.containsKey('target_on')) {
      context.handle(
        _targetOnMeta,
        targetOn.isAcceptableOrUnknown(data['target_on']!, _targetOnMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('fulfilled_on')) {
      context.handle(
        _fulfilledOnMeta,
        fulfilledOn.isAcceptableOrUnknown(
          data['fulfilled_on']!,
          _fulfilledOnMeta,
        ),
      );
    }
    if (data.containsKey('fulfilled_cents')) {
      context.handle(
        _fulfilledCentsMeta,
        fulfilledCents.isAcceptableOrUnknown(
          data['fulfilled_cents']!,
          _fulfilledCentsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      objectiveId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objective_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      purpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purpose'],
      )!,
      targetCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_cents'],
      )!,
      targetOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_on'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      fulfilledOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fulfilled_on'],
      ),
      fulfilledCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fulfilled_cents'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  Goals createAlias(String alias) {
    return Goals(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String profileId;
  final String? objectiveId;
  final String title;
  final String purpose;
  final int targetCents;
  final String? targetOn;
  final int priority;
  final String status;
  final String? fulfilledOn;
  final int? fulfilledCents;
  final String createdAt;
  final String updatedAt;
  final int revision;
  const Goal({
    required this.id,
    required this.profileId,
    this.objectiveId,
    required this.title,
    required this.purpose,
    required this.targetCents,
    this.targetOn,
    required this.priority,
    required this.status,
    this.fulfilledOn,
    this.fulfilledCents,
    required this.createdAt,
    required this.updatedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || objectiveId != null) {
      map['objective_id'] = Variable<String>(objectiveId);
    }
    map['title'] = Variable<String>(title);
    map['purpose'] = Variable<String>(purpose);
    map['target_cents'] = Variable<int>(targetCents);
    if (!nullToAbsent || targetOn != null) {
      map['target_on'] = Variable<String>(targetOn);
    }
    map['priority'] = Variable<int>(priority);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || fulfilledOn != null) {
      map['fulfilled_on'] = Variable<String>(fulfilledOn);
    }
    if (!nullToAbsent || fulfilledCents != null) {
      map['fulfilled_cents'] = Variable<int>(fulfilledCents);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      objectiveId: objectiveId == null && nullToAbsent
          ? const Value.absent()
          : Value(objectiveId),
      title: Value(title),
      purpose: Value(purpose),
      targetCents: Value(targetCents),
      targetOn: targetOn == null && nullToAbsent
          ? const Value.absent()
          : Value(targetOn),
      priority: Value(priority),
      status: Value(status),
      fulfilledOn: fulfilledOn == null && nullToAbsent
          ? const Value.absent()
          : Value(fulfilledOn),
      fulfilledCents: fulfilledCents == null && nullToAbsent
          ? const Value.absent()
          : Value(fulfilledCents),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      revision: Value(revision),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      objectiveId: serializer.fromJson<String?>(json['objective_id']),
      title: serializer.fromJson<String>(json['title']),
      purpose: serializer.fromJson<String>(json['purpose']),
      targetCents: serializer.fromJson<int>(json['target_cents']),
      targetOn: serializer.fromJson<String?>(json['target_on']),
      priority: serializer.fromJson<int>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      fulfilledOn: serializer.fromJson<String?>(json['fulfilled_on']),
      fulfilledCents: serializer.fromJson<int?>(json['fulfilled_cents']),
      createdAt: serializer.fromJson<String>(json['created_at']),
      updatedAt: serializer.fromJson<String>(json['updated_at']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'objective_id': serializer.toJson<String?>(objectiveId),
      'title': serializer.toJson<String>(title),
      'purpose': serializer.toJson<String>(purpose),
      'target_cents': serializer.toJson<int>(targetCents),
      'target_on': serializer.toJson<String?>(targetOn),
      'priority': serializer.toJson<int>(priority),
      'status': serializer.toJson<String>(status),
      'fulfilled_on': serializer.toJson<String?>(fulfilledOn),
      'fulfilled_cents': serializer.toJson<int?>(fulfilledCents),
      'created_at': serializer.toJson<String>(createdAt),
      'updated_at': serializer.toJson<String>(updatedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  Goal copyWith({
    String? id,
    String? profileId,
    Value<String?> objectiveId = const Value.absent(),
    String? title,
    String? purpose,
    int? targetCents,
    Value<String?> targetOn = const Value.absent(),
    int? priority,
    String? status,
    Value<String?> fulfilledOn = const Value.absent(),
    Value<int?> fulfilledCents = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    int? revision,
  }) => Goal(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    objectiveId: objectiveId.present ? objectiveId.value : this.objectiveId,
    title: title ?? this.title,
    purpose: purpose ?? this.purpose,
    targetCents: targetCents ?? this.targetCents,
    targetOn: targetOn.present ? targetOn.value : this.targetOn,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    fulfilledOn: fulfilledOn.present ? fulfilledOn.value : this.fulfilledOn,
    fulfilledCents: fulfilledCents.present
        ? fulfilledCents.value
        : this.fulfilledCents,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    revision: revision ?? this.revision,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      objectiveId: data.objectiveId.present
          ? data.objectiveId.value
          : this.objectiveId,
      title: data.title.present ? data.title.value : this.title,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      targetCents: data.targetCents.present
          ? data.targetCents.value
          : this.targetCents,
      targetOn: data.targetOn.present ? data.targetOn.value : this.targetOn,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      fulfilledOn: data.fulfilledOn.present
          ? data.fulfilledOn.value
          : this.fulfilledOn,
      fulfilledCents: data.fulfilledCents.present
          ? data.fulfilledCents.value
          : this.fulfilledCents,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('objectiveId: $objectiveId, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('targetCents: $targetCents, ')
          ..write('targetOn: $targetOn, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('fulfilledOn: $fulfilledOn, ')
          ..write('fulfilledCents: $fulfilledCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    objectiveId,
    title,
    purpose,
    targetCents,
    targetOn,
    priority,
    status,
    fulfilledOn,
    fulfilledCents,
    createdAt,
    updatedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.objectiveId == this.objectiveId &&
          other.title == this.title &&
          other.purpose == this.purpose &&
          other.targetCents == this.targetCents &&
          other.targetOn == this.targetOn &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.fulfilledOn == this.fulfilledOn &&
          other.fulfilledCents == this.fulfilledCents &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.revision == this.revision);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> objectiveId;
  final Value<String> title;
  final Value<String> purpose;
  final Value<int> targetCents;
  final Value<String?> targetOn;
  final Value<int> priority;
  final Value<String> status;
  final Value<String?> fulfilledOn;
  final Value<int?> fulfilledCents;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.objectiveId = const Value.absent(),
    this.title = const Value.absent(),
    this.purpose = const Value.absent(),
    this.targetCents = const Value.absent(),
    this.targetOn = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.fulfilledOn = const Value.absent(),
    this.fulfilledCents = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String profileId,
    this.objectiveId = const Value.absent(),
    required String title,
    required String purpose,
    required int targetCents,
    this.targetOn = const Value.absent(),
    required int priority,
    required String status,
    this.fulfilledOn = const Value.absent(),
    this.fulfilledCents = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       title = Value(title),
       purpose = Value(purpose),
       targetCents = Value(targetCents),
       priority = Value(priority),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? objectiveId,
    Expression<String>? title,
    Expression<String>? purpose,
    Expression<int>? targetCents,
    Expression<String>? targetOn,
    Expression<int>? priority,
    Expression<String>? status,
    Expression<String>? fulfilledOn,
    Expression<int>? fulfilledCents,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (objectiveId != null) 'objective_id': objectiveId,
      if (title != null) 'title': title,
      if (purpose != null) 'purpose': purpose,
      if (targetCents != null) 'target_cents': targetCents,
      if (targetOn != null) 'target_on': targetOn,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (fulfilledOn != null) 'fulfilled_on': fulfilledOn,
      if (fulfilledCents != null) 'fulfilled_cents': fulfilledCents,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? objectiveId,
    Value<String>? title,
    Value<String>? purpose,
    Value<int>? targetCents,
    Value<String?>? targetOn,
    Value<int>? priority,
    Value<String>? status,
    Value<String?>? fulfilledOn,
    Value<int?>? fulfilledCents,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      objectiveId: objectiveId ?? this.objectiveId,
      title: title ?? this.title,
      purpose: purpose ?? this.purpose,
      targetCents: targetCents ?? this.targetCents,
      targetOn: targetOn ?? this.targetOn,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      fulfilledOn: fulfilledOn ?? this.fulfilledOn,
      fulfilledCents: fulfilledCents ?? this.fulfilledCents,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (objectiveId.present) {
      map['objective_id'] = Variable<String>(objectiveId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (targetCents.present) {
      map['target_cents'] = Variable<int>(targetCents.value);
    }
    if (targetOn.present) {
      map['target_on'] = Variable<String>(targetOn.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (fulfilledOn.present) {
      map['fulfilled_on'] = Variable<String>(fulfilledOn.value);
    }
    if (fulfilledCents.present) {
      map['fulfilled_cents'] = Variable<int>(fulfilledCents.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('objectiveId: $objectiveId, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('targetCents: $targetCents, ')
          ..write('targetOn: $targetOn, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('fulfilledOn: $fulfilledOn, ')
          ..write('fulfilledCents: $fulfilledCents, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class GoalFundMovements extends Table
    with TableInfo<GoalFundMovements, GoalFundMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  GoalFundMovements(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES profiles(id)',
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES goals(id)',
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES accounts(id)',
  );
  static const VerificationMeta _effectiveOnMeta = const VerificationMeta(
    'effectiveOn',
  );
  late final GeneratedColumn<String> effectiveOn = GeneratedColumn<String>(
    'effective_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typeof(amount_cents) = \'integer\' AND amount_cents != 0 AND amount_cents BETWEEN -9007199254740991 AND 9007199254740991)',
  );
  static const VerificationMeta _sequenceNoMeta = const VerificationMeta(
    'sequenceNo',
  );
  late final GeneratedColumn<int> sequenceNo = GeneratedColumn<int>(
    'sequence_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (sequence_no > 0)',
  );
  static const VerificationMeta _requestIdMeta = const VerificationMeta(
    'requestId',
  );
  late final GeneratedColumn<String> requestId = GeneratedColumn<String>(
    'request_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    goalId,
    accountId,
    effectiveOn,
    amountCents,
    sequenceNo,
    requestId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_fund_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalFundMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('effective_on')) {
      context.handle(
        _effectiveOnMeta,
        effectiveOn.isAcceptableOrUnknown(
          data['effective_on']!,
          _effectiveOnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveOnMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('sequence_no')) {
      context.handle(
        _sequenceNoMeta,
        sequenceNo.isAcceptableOrUnknown(data['sequence_no']!, _sequenceNoMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceNoMeta);
    }
    if (data.containsKey('request_id')) {
      context.handle(
        _requestIdMeta,
        requestId.isAcceptableOrUnknown(data['request_id']!, _requestIdMeta),
      );
    } else if (isInserting) {
      context.missing(_requestIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {requestId},
    {goalId, accountId, sequenceNo},
  ];
  @override
  GoalFundMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalFundMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      effectiveOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_on'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      sequenceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_no'],
      )!,
      requestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}request_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  GoalFundMovements createAlias(String alias) {
    return GoalFundMovements(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'UNIQUE(request_id)',
    'UNIQUE(goal_id, account_id, sequence_no)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class GoalFundMovement extends DataClass
    implements Insertable<GoalFundMovement> {
  final String id;
  final String profileId;
  final String goalId;
  final String accountId;
  final String effectiveOn;
  final int amountCents;
  final int sequenceNo;
  final String requestId;
  final String createdAt;
  const GoalFundMovement({
    required this.id,
    required this.profileId,
    required this.goalId,
    required this.accountId,
    required this.effectiveOn,
    required this.amountCents,
    required this.sequenceNo,
    required this.requestId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['goal_id'] = Variable<String>(goalId);
    map['account_id'] = Variable<String>(accountId);
    map['effective_on'] = Variable<String>(effectiveOn);
    map['amount_cents'] = Variable<int>(amountCents);
    map['sequence_no'] = Variable<int>(sequenceNo);
    map['request_id'] = Variable<String>(requestId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  GoalFundMovementsCompanion toCompanion(bool nullToAbsent) {
    return GoalFundMovementsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      goalId: Value(goalId),
      accountId: Value(accountId),
      effectiveOn: Value(effectiveOn),
      amountCents: Value(amountCents),
      sequenceNo: Value(sequenceNo),
      requestId: Value(requestId),
      createdAt: Value(createdAt),
    );
  }

  factory GoalFundMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalFundMovement(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profile_id']),
      goalId: serializer.fromJson<String>(json['goal_id']),
      accountId: serializer.fromJson<String>(json['account_id']),
      effectiveOn: serializer.fromJson<String>(json['effective_on']),
      amountCents: serializer.fromJson<int>(json['amount_cents']),
      sequenceNo: serializer.fromJson<int>(json['sequence_no']),
      requestId: serializer.fromJson<String>(json['request_id']),
      createdAt: serializer.fromJson<String>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profile_id': serializer.toJson<String>(profileId),
      'goal_id': serializer.toJson<String>(goalId),
      'account_id': serializer.toJson<String>(accountId),
      'effective_on': serializer.toJson<String>(effectiveOn),
      'amount_cents': serializer.toJson<int>(amountCents),
      'sequence_no': serializer.toJson<int>(sequenceNo),
      'request_id': serializer.toJson<String>(requestId),
      'created_at': serializer.toJson<String>(createdAt),
    };
  }

  GoalFundMovement copyWith({
    String? id,
    String? profileId,
    String? goalId,
    String? accountId,
    String? effectiveOn,
    int? amountCents,
    int? sequenceNo,
    String? requestId,
    String? createdAt,
  }) => GoalFundMovement(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    goalId: goalId ?? this.goalId,
    accountId: accountId ?? this.accountId,
    effectiveOn: effectiveOn ?? this.effectiveOn,
    amountCents: amountCents ?? this.amountCents,
    sequenceNo: sequenceNo ?? this.sequenceNo,
    requestId: requestId ?? this.requestId,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalFundMovement copyWithCompanion(GoalFundMovementsCompanion data) {
    return GoalFundMovement(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      effectiveOn: data.effectiveOn.present
          ? data.effectiveOn.value
          : this.effectiveOn,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      sequenceNo: data.sequenceNo.present
          ? data.sequenceNo.value
          : this.sequenceNo,
      requestId: data.requestId.present ? data.requestId.value : this.requestId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalFundMovement(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('goalId: $goalId, ')
          ..write('accountId: $accountId, ')
          ..write('effectiveOn: $effectiveOn, ')
          ..write('amountCents: $amountCents, ')
          ..write('sequenceNo: $sequenceNo, ')
          ..write('requestId: $requestId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    goalId,
    accountId,
    effectiveOn,
    amountCents,
    sequenceNo,
    requestId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalFundMovement &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.goalId == this.goalId &&
          other.accountId == this.accountId &&
          other.effectiveOn == this.effectiveOn &&
          other.amountCents == this.amountCents &&
          other.sequenceNo == this.sequenceNo &&
          other.requestId == this.requestId &&
          other.createdAt == this.createdAt);
}

class GoalFundMovementsCompanion extends UpdateCompanion<GoalFundMovement> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> goalId;
  final Value<String> accountId;
  final Value<String> effectiveOn;
  final Value<int> amountCents;
  final Value<int> sequenceNo;
  final Value<String> requestId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const GoalFundMovementsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.effectiveOn = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.sequenceNo = const Value.absent(),
    this.requestId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalFundMovementsCompanion.insert({
    required String id,
    required String profileId,
    required String goalId,
    required String accountId,
    required String effectiveOn,
    required int amountCents,
    required int sequenceNo,
    required String requestId,
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       goalId = Value(goalId),
       accountId = Value(accountId),
       effectiveOn = Value(effectiveOn),
       amountCents = Value(amountCents),
       sequenceNo = Value(sequenceNo),
       requestId = Value(requestId),
       createdAt = Value(createdAt);
  static Insertable<GoalFundMovement> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? goalId,
    Expression<String>? accountId,
    Expression<String>? effectiveOn,
    Expression<int>? amountCents,
    Expression<int>? sequenceNo,
    Expression<String>? requestId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (goalId != null) 'goal_id': goalId,
      if (accountId != null) 'account_id': accountId,
      if (effectiveOn != null) 'effective_on': effectiveOn,
      if (amountCents != null) 'amount_cents': amountCents,
      if (sequenceNo != null) 'sequence_no': sequenceNo,
      if (requestId != null) 'request_id': requestId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalFundMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? goalId,
    Value<String>? accountId,
    Value<String>? effectiveOn,
    Value<int>? amountCents,
    Value<int>? sequenceNo,
    Value<String>? requestId,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalFundMovementsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      goalId: goalId ?? this.goalId,
      accountId: accountId ?? this.accountId,
      effectiveOn: effectiveOn ?? this.effectiveOn,
      amountCents: amountCents ?? this.amountCents,
      sequenceNo: sequenceNo ?? this.sequenceNo,
      requestId: requestId ?? this.requestId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (effectiveOn.present) {
      map['effective_on'] = Variable<String>(effectiveOn.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (sequenceNo.present) {
      map['sequence_no'] = Variable<int>(sequenceNo.value);
    }
    if (requestId.present) {
      map['request_id'] = Variable<String>(requestId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalFundMovementsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('goalId: $goalId, ')
          ..write('accountId: $accountId, ')
          ..write('effectiveOn: $effectiveOn, ')
          ..write('amountCents: $amountCents, ')
          ..write('sequenceNo: $sequenceNo, ')
          ..write('requestId: $requestId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CanguruuDatabase extends GeneratedDatabase {
  _$CanguruuDatabase(QueryExecutor e) : super(e);
  $CanguruuDatabaseManager get managers => $CanguruuDatabaseManager(this);
  late final Profiles profiles = Profiles(this);
  late final LedgerAccounts ledgerAccounts = LedgerAccounts(this);
  late final Accounts accounts = Accounts(this);
  late final Categories categories = Categories(this);
  late final FinancialEvents financialEvents = FinancialEvents(this);
  late final Postings postings = Postings(this);
  late final OperationReceipts operationReceipts = OperationReceipts(this);
  late final Index eventsByDate = Index(
    'events_by_date',
    'CREATE INDEX events_by_date ON financial_events (profile_id, effective_date, created_at)',
  );
  late final Index postingsByAccount = Index(
    'postings_by_account',
    'CREATE INDEX postings_by_account ON postings (ledger_account_id, event_id)',
  );
  late final Index postingsByCategory = Index(
    'postings_by_category',
    'CREATE INDEX postings_by_category ON postings (category_id, event_id)',
  );
  late final Index categoriesByParent = Index(
    'categories_by_parent',
    'CREATE INDEX categories_by_parent ON categories (parent_id)',
  );
  late final CreditCards creditCards = CreditCards(this);
  late final CardOperations cardOperations = CardOperations(this);
  late final Invoices invoices = Invoices(this);
  late final InvoiceItems invoiceItems = InvoiceItems(this);
  late final InvoicePayments invoicePayments = InvoicePayments(this);
  late final InvoicePaymentAllocations invoicePaymentAllocations =
      InvoicePaymentAllocations(this);
  late final Index invoicesByDue = Index(
    'invoices_by_due',
    'CREATE INDEX invoices_by_due ON invoices (due_on, card_id)',
  );
  late final Index itemsByInvoice = Index(
    'items_by_invoice',
    'CREATE INDEX items_by_invoice ON invoice_items (invoice_id)',
  );
  late final Index allocationsByInvoice = Index(
    'allocations_by_invoice',
    'CREATE INDEX allocations_by_invoice ON invoice_payment_allocations (invoice_id)',
  );
  late final RecurrenceSeries recurrenceSeries = RecurrenceSeries(this);
  late final RecurrenceRuleVersions recurrenceRuleVersions =
      RecurrenceRuleVersions(this);
  late final ScheduledOccurrences scheduledOccurrences = ScheduledOccurrences(
    this,
  );
  late final Index occurrenceBySeriesDate = Index(
    'occurrence_by_series_date',
    'CREATE UNIQUE INDEX occurrence_by_series_date ON scheduled_occurrences (series_id, scheduled_on) WHERE status != \'cancelled\'',
  );
  late final Index scheduledByDate = Index(
    'scheduled_by_date',
    'CREATE INDEX scheduled_by_date ON scheduled_occurrences (status, scheduled_on)',
  );
  late final Index rulesBySeries = Index(
    'rules_by_series',
    'CREATE INDEX rules_by_series ON recurrence_rule_versions (series_id, valid_from)',
  );
  late final Index currentRulePerSeries = Index(
    'current_rule_per_series',
    'CREATE UNIQUE INDEX current_rule_per_series ON recurrence_rule_versions (series_id) WHERE is_current = 1',
  );
  late final Objectives objectives = Objectives(this);
  late final Goals goals = Goals(this);
  late final GoalFundMovements goalFundMovements = GoalFundMovements(this);
  late final Index goalsByStatus = Index(
    'goals_by_status',
    'CREATE INDEX goals_by_status ON goals (profile_id, status, priority)',
  );
  late final Index goalMovementsByGoal = Index(
    'goal_movements_by_goal',
    'CREATE INDEX goal_movements_by_goal ON goal_fund_movements (goal_id, effective_on)',
  );
  late final Index goalMovementsByAccount = Index(
    'goal_movements_by_account',
    'CREATE INDEX goal_movements_by_account ON goal_fund_movements (account_id, effective_on)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    ledgerAccounts,
    accounts,
    categories,
    financialEvents,
    postings,
    operationReceipts,
    eventsByDate,
    postingsByAccount,
    postingsByCategory,
    categoriesByParent,
    creditCards,
    cardOperations,
    invoices,
    invoiceItems,
    invoicePayments,
    invoicePaymentAllocations,
    invoicesByDue,
    itemsByInvoice,
    allocationsByInvoice,
    recurrenceSeries,
    recurrenceRuleVersions,
    scheduledOccurrences,
    occurrenceBySeriesDate,
    scheduledByDate,
    rulesBySeries,
    currentRulePerSeries,
    objectives,
    goals,
    goalFundMovements,
    goalsByStatus,
    goalMovementsByGoal,
    goalMovementsByAccount,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $ProfilesCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      required String currency,
      required String locale,
      required String timezone,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $ProfilesUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<String> currency,
      Value<String> locale,
      Value<String> timezone,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $ProfilesReferences
    extends BaseReferences<_$CanguruuDatabase, Profiles, Profile> {
  $ProfilesReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<LedgerAccounts, List<LedgerAccount>>
  _ledgerAccountsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ledgerAccounts,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.ledgerAccounts.profileId,
        ),
      );

  $LedgerAccountsProcessedTableManager get ledgerAccountsRefs {
    final manager = $LedgerAccountsTableManager(
      $_db,
      $_db.ledgerAccounts,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ledgerAccountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Accounts, List<Account>> _accountsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.accounts.profileId),
  );

  $AccountsProcessedTableManager get accountsRefs {
    final manager = $AccountsTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Categories, List<Category>> _categoriesRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.categories,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.categories.profileId),
  );

  $CategoriesProcessedTableManager get categoriesRefs {
    final manager = $CategoriesTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<FinancialEvents, List<FinancialEvent>>
  _financialEventsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialEvents,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.financialEvents.profileId,
        ),
      );

  $FinancialEventsProcessedTableManager get financialEventsRefs {
    final manager = $FinancialEventsTableManager(
      $_db,
      $_db.financialEvents,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Postings, List<Posting>> _postingsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.postings,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.postings.profileId),
  );

  $PostingsProcessedTableManager get postingsRefs {
    final manager = $PostingsTableManager(
      $_db,
      $_db.postings,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<OperationReceipts, List<OperationReceipt>>
  _operationReceiptsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.operationReceipts,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.operationReceipts.profileId,
        ),
      );

  $OperationReceiptsProcessedTableManager get operationReceiptsRefs {
    final manager = $OperationReceiptsTableManager(
      $_db,
      $_db.operationReceipts,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _operationReceiptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<CreditCards, List<CreditCard>>
  _creditCardsRefsTable(_$CanguruuDatabase db) => MultiTypedResultKey.fromTable(
    db.creditCards,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.creditCards.profileId),
  );

  $CreditCardsProcessedTableManager get creditCardsRefs {
    final manager = $CreditCardsTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<CardOperations, List<CardOperation>>
  _cardOperationsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cardOperations,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.cardOperations.profileId,
        ),
      );

  $CardOperationsProcessedTableManager get cardOperationsRefs {
    final manager = $CardOperationsTableManager(
      $_db,
      $_db.cardOperations,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardOperationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Invoices, List<Invoice>> _invoicesRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.invoices.profileId),
  );

  $InvoicesProcessedTableManager get invoicesRefs {
    final manager = $InvoicesTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<InvoiceItems, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoiceItems,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.invoiceItems.profileId,
        ),
      );

  $InvoiceItemsProcessedTableManager get invoiceItemsRefs {
    final manager = $InvoiceItemsTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<InvoicePayments, List<InvoicePayment>>
  _invoicePaymentsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoicePayments,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.invoicePayments.profileId,
        ),
      );

  $InvoicePaymentsProcessedTableManager get invoicePaymentsRefs {
    final manager = $InvoicePaymentsTableManager(
      $_db,
      $_db.invoicePayments,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoicePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    InvoicePaymentAllocations,
    List<InvoicePaymentAllocation>
  >
  _invoicePaymentAllocationsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoicePaymentAllocations,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.invoicePaymentAllocations.profileId,
        ),
      );

  $InvoicePaymentAllocationsProcessedTableManager
  get invoicePaymentAllocationsRefs {
    final manager = $InvoicePaymentAllocationsTableManager(
      $_db,
      $_db.invoicePaymentAllocations,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoicePaymentAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<RecurrenceSeries, List<RecurrenceSery>>
  _recurrenceSeriesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurrenceSeries,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.recurrenceSeries.profileId,
        ),
      );

  $RecurrenceSeriesProcessedTableManager get recurrenceSeriesRefs {
    final manager = $RecurrenceSeriesTableManager(
      $_db,
      $_db.recurrenceSeries,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurrenceSeriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    RecurrenceRuleVersions,
    List<RecurrenceRuleVersion>
  >
  _recurrenceRuleVersionsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurrenceRuleVersions,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.recurrenceRuleVersions.profileId,
        ),
      );

  $RecurrenceRuleVersionsProcessedTableManager get recurrenceRuleVersionsRefs {
    final manager = $RecurrenceRuleVersionsTableManager(
      $_db,
      $_db.recurrenceRuleVersions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurrenceRuleVersionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScheduledOccurrences, List<ScheduledOccurrence>>
  _scheduledOccurrencesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduledOccurrences,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.scheduledOccurrences.profileId,
        ),
      );

  $ScheduledOccurrencesProcessedTableManager get scheduledOccurrencesRefs {
    final manager = $ScheduledOccurrencesTableManager(
      $_db,
      $_db.scheduledOccurrences,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduledOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Objectives, List<Objective>> _objectivesRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.objectives,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.objectives.profileId),
  );

  $ObjectivesProcessedTableManager get objectivesRefs {
    final manager = $ObjectivesTableManager(
      $_db,
      $_db.objectives,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_objectivesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Goals, List<Goal>> _goalsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goals,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.goals.profileId),
  );

  $GoalsProcessedTableManager get goalsRefs {
    final manager = $GoalsTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<GoalFundMovements, List<GoalFundMovement>>
  _goalFundMovementsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.goalFundMovements,
        aliasName: $_aliasNameGenerator(
          db.profiles.id,
          db.goalFundMovements.profileId,
        ),
      );

  $GoalFundMovementsProcessedTableManager get goalFundMovementsRefs {
    final manager = $GoalFundMovementsTableManager(
      $_db,
      $_db.goalFundMovements,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalFundMovementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ProfilesFilterComposer extends Composer<_$CanguruuDatabase, Profiles> {
  $ProfilesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ledgerAccountsRefs(
    Expression<bool> Function($LedgerAccountsFilterComposer f) f,
  ) {
    final $LedgerAccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsFilterComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($AccountsFilterComposer f) f,
  ) {
    final $AccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AccountsFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoriesRefs(
    Expression<bool> Function($CategoriesFilterComposer f) f,
  ) {
    final $CategoriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> financialEventsRefs(
    Expression<bool> Function($FinancialEventsFilterComposer f) f,
  ) {
    final $FinancialEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsFilterComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> postingsRefs(
    Expression<bool> Function($PostingsFilterComposer f) f,
  ) {
    final $PostingsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsFilterComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> operationReceiptsRefs(
    Expression<bool> Function($OperationReceiptsFilterComposer f) f,
  ) {
    final $OperationReceiptsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.operationReceipts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $OperationReceiptsFilterComposer(
            $db: $db,
            $table: $db.operationReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardsRefs(
    Expression<bool> Function($CreditCardsFilterComposer f) f,
  ) {
    final $CreditCardsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CreditCardsFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardOperationsRefs(
    Expression<bool> Function($CardOperationsFilterComposer f) f,
  ) {
    final $CardOperationsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardOperations,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardOperationsFilterComposer(
            $db: $db,
            $table: $db.cardOperations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($InvoicesFilterComposer f) f,
  ) {
    final $InvoicesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($InvoiceItemsFilterComposer f) f,
  ) {
    final $InvoiceItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoiceItemsFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePaymentsRefs(
    Expression<bool> Function($InvoicePaymentsFilterComposer f) f,
  ) {
    final $InvoicePaymentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentsFilterComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePaymentAllocationsRefs(
    Expression<bool> Function($InvoicePaymentAllocationsFilterComposer f) f,
  ) {
    final $InvoicePaymentAllocationsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePaymentAllocations,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentAllocationsFilterComposer(
            $db: $db,
            $table: $db.invoicePaymentAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurrenceSeriesRefs(
    Expression<bool> Function($RecurrenceSeriesFilterComposer f) f,
  ) {
    final $RecurrenceSeriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesFilterComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurrenceRuleVersionsRefs(
    Expression<bool> Function($RecurrenceRuleVersionsFilterComposer f) f,
  ) {
    final $RecurrenceRuleVersionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsFilterComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduledOccurrencesRefs(
    Expression<bool> Function($ScheduledOccurrencesFilterComposer f) f,
  ) {
    final $ScheduledOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> objectivesRefs(
    Expression<bool> Function($ObjectivesFilterComposer f) f,
  ) {
    final $ObjectivesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.objectives,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ObjectivesFilterComposer(
            $db: $db,
            $table: $db.objectives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalsRefs(
    Expression<bool> Function($GoalsFilterComposer f) f,
  ) {
    final $GoalsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalFundMovementsRefs(
    Expression<bool> Function($GoalFundMovementsFilterComposer f) f,
  ) {
    final $GoalFundMovementsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalFundMovements,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalFundMovementsFilterComposer(
            $db: $db,
            $table: $db.goalFundMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProfilesOrderingComposer extends Composer<_$CanguruuDatabase, Profiles> {
  $ProfilesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ProfilesAnnotationComposer
    extends Composer<_$CanguruuDatabase, Profiles> {
  $ProfilesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  Expression<T> ledgerAccountsRefs<T extends Object>(
    Expression<T> Function($LedgerAccountsAnnotationComposer a) f,
  ) {
    final $LedgerAccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsAnnotationComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($AccountsAnnotationComposer a) f,
  ) {
    final $AccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AccountsAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoriesRefs<T extends Object>(
    Expression<T> Function($CategoriesAnnotationComposer a) f,
  ) {
    final $CategoriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> financialEventsRefs<T extends Object>(
    Expression<T> Function($FinancialEventsAnnotationComposer a) f,
  ) {
    final $FinancialEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsAnnotationComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> postingsRefs<T extends Object>(
    Expression<T> Function($PostingsAnnotationComposer a) f,
  ) {
    final $PostingsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsAnnotationComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> operationReceiptsRefs<T extends Object>(
    Expression<T> Function($OperationReceiptsAnnotationComposer a) f,
  ) {
    final $OperationReceiptsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.operationReceipts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $OperationReceiptsAnnotationComposer(
            $db: $db,
            $table: $db.operationReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardsRefs<T extends Object>(
    Expression<T> Function($CreditCardsAnnotationComposer a) f,
  ) {
    final $CreditCardsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CreditCardsAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardOperationsRefs<T extends Object>(
    Expression<T> Function($CardOperationsAnnotationComposer a) f,
  ) {
    final $CardOperationsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardOperations,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardOperationsAnnotationComposer(
            $db: $db,
            $table: $db.cardOperations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($InvoicesAnnotationComposer a) f,
  ) {
    final $InvoicesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($InvoiceItemsAnnotationComposer a) f,
  ) {
    final $InvoiceItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoiceItemsAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePaymentsRefs<T extends Object>(
    Expression<T> Function($InvoicePaymentsAnnotationComposer a) f,
  ) {
    final $InvoicePaymentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentsAnnotationComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePaymentAllocationsRefs<T extends Object>(
    Expression<T> Function($InvoicePaymentAllocationsAnnotationComposer a) f,
  ) {
    final $InvoicePaymentAllocationsAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.invoicePaymentAllocations,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $InvoicePaymentAllocationsAnnotationComposer(
                $db: $db,
                $table: $db.invoicePaymentAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recurrenceSeriesRefs<T extends Object>(
    Expression<T> Function($RecurrenceSeriesAnnotationComposer a) f,
  ) {
    final $RecurrenceSeriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurrenceRuleVersionsRefs<T extends Object>(
    Expression<T> Function($RecurrenceRuleVersionsAnnotationComposer a) f,
  ) {
    final $RecurrenceRuleVersionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduledOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScheduledOccurrencesAnnotationComposer a) f,
  ) {
    final $ScheduledOccurrencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesAnnotationComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> objectivesRefs<T extends Object>(
    Expression<T> Function($ObjectivesAnnotationComposer a) f,
  ) {
    final $ObjectivesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.objectives,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ObjectivesAnnotationComposer(
            $db: $db,
            $table: $db.objectives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalsRefs<T extends Object>(
    Expression<T> Function($GoalsAnnotationComposer a) f,
  ) {
    final $GoalsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalFundMovementsRefs<T extends Object>(
    Expression<T> Function($GoalFundMovementsAnnotationComposer a) f,
  ) {
    final $GoalFundMovementsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalFundMovements,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalFundMovementsAnnotationComposer(
            $db: $db,
            $table: $db.goalFundMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProfilesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Profiles,
          Profile,
          $ProfilesFilterComposer,
          $ProfilesOrderingComposer,
          $ProfilesAnnotationComposer,
          $ProfilesCreateCompanionBuilder,
          $ProfilesUpdateCompanionBuilder,
          (Profile, $ProfilesReferences),
          Profile,
          PrefetchHooks Function({
            bool ledgerAccountsRefs,
            bool accountsRefs,
            bool categoriesRefs,
            bool financialEventsRefs,
            bool postingsRefs,
            bool operationReceiptsRefs,
            bool creditCardsRefs,
            bool cardOperationsRefs,
            bool invoicesRefs,
            bool invoiceItemsRefs,
            bool invoicePaymentsRefs,
            bool invoicePaymentAllocationsRefs,
            bool recurrenceSeriesRefs,
            bool recurrenceRuleVersionsRefs,
            bool scheduledOccurrencesRefs,
            bool objectivesRefs,
            bool goalsRefs,
            bool goalFundMovementsRefs,
          })
        > {
  $ProfilesTableManager(_$CanguruuDatabase db, Profiles table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProfilesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProfilesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProfilesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                currency: currency,
                locale: locale,
                timezone: timezone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String currency,
                required String locale,
                required String timezone,
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                currency: currency,
                locale: locale,
                timezone: timezone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $ProfilesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ledgerAccountsRefs = false,
                accountsRefs = false,
                categoriesRefs = false,
                financialEventsRefs = false,
                postingsRefs = false,
                operationReceiptsRefs = false,
                creditCardsRefs = false,
                cardOperationsRefs = false,
                invoicesRefs = false,
                invoiceItemsRefs = false,
                invoicePaymentsRefs = false,
                invoicePaymentAllocationsRefs = false,
                recurrenceSeriesRefs = false,
                recurrenceRuleVersionsRefs = false,
                scheduledOccurrencesRefs = false,
                objectivesRefs = false,
                goalsRefs = false,
                goalFundMovementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ledgerAccountsRefs) db.ledgerAccounts,
                    if (accountsRefs) db.accounts,
                    if (categoriesRefs) db.categories,
                    if (financialEventsRefs) db.financialEvents,
                    if (postingsRefs) db.postings,
                    if (operationReceiptsRefs) db.operationReceipts,
                    if (creditCardsRefs) db.creditCards,
                    if (cardOperationsRefs) db.cardOperations,
                    if (invoicesRefs) db.invoices,
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (invoicePaymentsRefs) db.invoicePayments,
                    if (invoicePaymentAllocationsRefs)
                      db.invoicePaymentAllocations,
                    if (recurrenceSeriesRefs) db.recurrenceSeries,
                    if (recurrenceRuleVersionsRefs) db.recurrenceRuleVersions,
                    if (scheduledOccurrencesRefs) db.scheduledOccurrences,
                    if (objectivesRefs) db.objectives,
                    if (goalsRefs) db.goals,
                    if (goalFundMovementsRefs) db.goalFundMovements,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ledgerAccountsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          LedgerAccount
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._ledgerAccountsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).ledgerAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedData<Profile, Profiles, Account>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).accountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoriesRefs)
                        await $_getPrefetchedData<Profile, Profiles, Category>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._categoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).categoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (financialEventsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          FinancialEvent
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._financialEventsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).financialEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (postingsRefs)
                        await $_getPrefetchedData<Profile, Profiles, Posting>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._postingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).postingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (operationReceiptsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          OperationReceipt
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._operationReceiptsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).operationReceiptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          CreditCard
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._creditCardsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).creditCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardOperationsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          CardOperation
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._cardOperationsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).cardOperationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<Profile, Profiles, Invoice>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicePaymentsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          InvoicePayment
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._invoicePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).invoicePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicePaymentAllocationsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          InvoicePaymentAllocation
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._invoicePaymentAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).invoicePaymentAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurrenceSeriesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          RecurrenceSery
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._recurrenceSeriesRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).recurrenceSeriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurrenceRuleVersionsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          RecurrenceRuleVersion
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._recurrenceRuleVersionsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).recurrenceRuleVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scheduledOccurrencesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          ScheduledOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._scheduledOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).scheduledOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (objectivesRefs)
                        await $_getPrefetchedData<Profile, Profiles, Objective>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._objectivesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).objectivesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalsRefs)
                        await $_getPrefetchedData<Profile, Profiles, Goal>(
                          currentTable: table,
                          referencedTable: $ProfilesReferences._goalsRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $ProfilesReferences(db, table, p0).goalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalFundMovementsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          Profiles,
                          GoalFundMovement
                        >(
                          currentTable: table,
                          referencedTable: $ProfilesReferences
                              ._goalFundMovementsRefsTable(db),
                          managerFromTypedResult: (p0) => $ProfilesReferences(
                            db,
                            table,
                            p0,
                          ).goalFundMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $ProfilesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Profiles,
      Profile,
      $ProfilesFilterComposer,
      $ProfilesOrderingComposer,
      $ProfilesAnnotationComposer,
      $ProfilesCreateCompanionBuilder,
      $ProfilesUpdateCompanionBuilder,
      (Profile, $ProfilesReferences),
      Profile,
      PrefetchHooks Function({
        bool ledgerAccountsRefs,
        bool accountsRefs,
        bool categoriesRefs,
        bool financialEventsRefs,
        bool postingsRefs,
        bool operationReceiptsRefs,
        bool creditCardsRefs,
        bool cardOperationsRefs,
        bool invoicesRefs,
        bool invoiceItemsRefs,
        bool invoicePaymentsRefs,
        bool invoicePaymentAllocationsRefs,
        bool recurrenceSeriesRefs,
        bool recurrenceRuleVersionsRefs,
        bool scheduledOccurrencesRefs,
        bool objectivesRefs,
        bool goalsRefs,
        bool goalFundMovementsRefs,
      })
    >;
typedef $LedgerAccountsCreateCompanionBuilder =
    LedgerAccountsCompanion Function({
      required String id,
      required String profileId,
      required String kind,
      required String createdAt,
      Value<int> rowid,
    });
typedef $LedgerAccountsUpdateCompanionBuilder =
    LedgerAccountsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> kind,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $LedgerAccountsReferences
    extends BaseReferences<_$CanguruuDatabase, LedgerAccounts, LedgerAccount> {
  $LedgerAccountsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.ledgerAccounts.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Accounts, List<Account>> _accountsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: $_aliasNameGenerator(db.ledgerAccounts.id, db.accounts.id),
  );

  $AccountsProcessedTableManager get accountsRefs {
    final manager = $AccountsTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Postings, List<Posting>> _postingsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.postings,
    aliasName: $_aliasNameGenerator(
      db.ledgerAccounts.id,
      db.postings.ledgerAccountId,
    ),
  );

  $PostingsProcessedTableManager get postingsRefs {
    final manager = $PostingsTableManager($_db, $_db.postings).filter(
      (f) => f.ledgerAccountId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_postingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<CreditCards, List<CreditCard>>
  _creditCardsRefsTable(_$CanguruuDatabase db) => MultiTypedResultKey.fromTable(
    db.creditCards,
    aliasName: $_aliasNameGenerator(db.ledgerAccounts.id, db.creditCards.id),
  );

  $CreditCardsProcessedTableManager get creditCardsRefs {
    final manager = $CreditCardsTableManager(
      $_db,
      $_db.creditCards,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $LedgerAccountsFilterComposer
    extends Composer<_$CanguruuDatabase, LedgerAccounts> {
  $LedgerAccountsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($AccountsFilterComposer f) f,
  ) {
    final $AccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AccountsFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> postingsRefs(
    Expression<bool> Function($PostingsFilterComposer f) f,
  ) {
    final $PostingsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.ledgerAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsFilterComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardsRefs(
    Expression<bool> Function($CreditCardsFilterComposer f) f,
  ) {
    final $CreditCardsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CreditCardsFilterComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $LedgerAccountsOrderingComposer
    extends Composer<_$CanguruuDatabase, LedgerAccounts> {
  $LedgerAccountsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $LedgerAccountsAnnotationComposer
    extends Composer<_$CanguruuDatabase, LedgerAccounts> {
  $LedgerAccountsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($AccountsAnnotationComposer a) f,
  ) {
    final $AccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AccountsAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> postingsRefs<T extends Object>(
    Expression<T> Function($PostingsAnnotationComposer a) f,
  ) {
    final $PostingsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.ledgerAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsAnnotationComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardsRefs<T extends Object>(
    Expression<T> Function($CreditCardsAnnotationComposer a) f,
  ) {
    final $CreditCardsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CreditCardsAnnotationComposer(
            $db: $db,
            $table: $db.creditCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $LedgerAccountsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          LedgerAccounts,
          LedgerAccount,
          $LedgerAccountsFilterComposer,
          $LedgerAccountsOrderingComposer,
          $LedgerAccountsAnnotationComposer,
          $LedgerAccountsCreateCompanionBuilder,
          $LedgerAccountsUpdateCompanionBuilder,
          (LedgerAccount, $LedgerAccountsReferences),
          LedgerAccount,
          PrefetchHooks Function({
            bool profileId,
            bool accountsRefs,
            bool postingsRefs,
            bool creditCardsRefs,
          })
        > {
  $LedgerAccountsTableManager(_$CanguruuDatabase db, LedgerAccounts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $LedgerAccountsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $LedgerAccountsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $LedgerAccountsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerAccountsCompanion(
                id: id,
                profileId: profileId,
                kind: kind,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String kind,
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LedgerAccountsCompanion.insert(
                id: id,
                profileId: profileId,
                kind: kind,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $LedgerAccountsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                accountsRefs = false,
                postingsRefs = false,
                creditCardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (accountsRefs) db.accounts,
                    if (postingsRefs) db.postings,
                    if (creditCardsRefs) db.creditCards,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $LedgerAccountsReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $LedgerAccountsReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (accountsRefs)
                        await $_getPrefetchedData<
                          LedgerAccount,
                          LedgerAccounts,
                          Account
                        >(
                          currentTable: table,
                          referencedTable: $LedgerAccountsReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $LedgerAccountsReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (postingsRefs)
                        await $_getPrefetchedData<
                          LedgerAccount,
                          LedgerAccounts,
                          Posting
                        >(
                          currentTable: table,
                          referencedTable: $LedgerAccountsReferences
                              ._postingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $LedgerAccountsReferences(
                                db,
                                table,
                                p0,
                              ).postingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ledgerAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardsRefs)
                        await $_getPrefetchedData<
                          LedgerAccount,
                          LedgerAccounts,
                          CreditCard
                        >(
                          currentTable: table,
                          referencedTable: $LedgerAccountsReferences
                              ._creditCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $LedgerAccountsReferences(
                                db,
                                table,
                                p0,
                              ).creditCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $LedgerAccountsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      LedgerAccounts,
      LedgerAccount,
      $LedgerAccountsFilterComposer,
      $LedgerAccountsOrderingComposer,
      $LedgerAccountsAnnotationComposer,
      $LedgerAccountsCreateCompanionBuilder,
      $LedgerAccountsUpdateCompanionBuilder,
      (LedgerAccount, $LedgerAccountsReferences),
      LedgerAccount,
      PrefetchHooks Function({
        bool profileId,
        bool accountsRefs,
        bool postingsRefs,
        bool creditCardsRefs,
      })
    >;
typedef $AccountsCreateCompanionBuilder =
    AccountsCompanion Function({
      required String id,
      required String profileId,
      required String name,
      required String kind,
      required String openedOn,
      Value<int> archived,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $AccountsUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> name,
      Value<String> kind,
      Value<String> openedOn,
      Value<int> archived,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $AccountsReferences
    extends BaseReferences<_$CanguruuDatabase, Accounts, Account> {
  $AccountsReferences(super.$_db, super.$_table, super.$_typedResult);

  static LedgerAccounts _idTable(_$CanguruuDatabase db) => db.ledgerAccounts
      .createAlias($_aliasNameGenerator(db.accounts.id, db.ledgerAccounts.id));

  $LedgerAccountsProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $LedgerAccountsTableManager(
      $_db,
      $_db.ledgerAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Profiles _profileIdTable(_$CanguruuDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.accounts.profileId, db.profiles.id));

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $AccountsFilterComposer extends Composer<_$CanguruuDatabase, Accounts> {
  $AccountsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $LedgerAccountsFilterComposer get id {
    final $LedgerAccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsFilterComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AccountsOrderingComposer extends Composer<_$CanguruuDatabase, Accounts> {
  $AccountsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $LedgerAccountsOrderingComposer get id {
    final $LedgerAccountsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsOrderingComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AccountsAnnotationComposer
    extends Composer<_$CanguruuDatabase, Accounts> {
  $AccountsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get openedOn =>
      $composableBuilder(column: $table.openedOn, builder: (column) => column);

  GeneratedColumn<int> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $LedgerAccountsAnnotationComposer get id {
    final $LedgerAccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsAnnotationComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AccountsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Accounts,
          Account,
          $AccountsFilterComposer,
          $AccountsOrderingComposer,
          $AccountsAnnotationComposer,
          $AccountsCreateCompanionBuilder,
          $AccountsUpdateCompanionBuilder,
          (Account, $AccountsReferences),
          Account,
          PrefetchHooks Function({bool id, bool profileId})
        > {
  $AccountsTableManager(_$CanguruuDatabase db, Accounts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AccountsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AccountsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AccountsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> openedOn = const Value.absent(),
                Value<int> archived = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                openedOn: openedOn,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                required String kind,
                required String openedOn,
                Value<int> archived = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                openedOn: openedOn,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $AccountsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, profileId = false}) {
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
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $AccountsReferences._idTable(
                                  db,
                                ),
                                referencedColumn: $AccountsReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $AccountsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $AccountsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $AccountsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Accounts,
      Account,
      $AccountsFilterComposer,
      $AccountsOrderingComposer,
      $AccountsAnnotationComposer,
      $AccountsCreateCompanionBuilder,
      $AccountsUpdateCompanionBuilder,
      (Account, $AccountsReferences),
      Account,
      PrefetchHooks Function({bool id, bool profileId})
    >;
typedef $CategoriesCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String profileId,
      required String name,
      required String kind,
      Value<String?> parentId,
      required String costNature,
      required int essential,
      Value<int> archived,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $CategoriesUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> name,
      Value<String> kind,
      Value<String?> parentId,
      Value<String> costNature,
      Value<int> essential,
      Value<int> archived,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $CategoriesReferences
    extends BaseReferences<_$CanguruuDatabase, Categories, Category> {
  $CategoriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.categories.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Postings, List<Posting>> _postingsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.postings,
    aliasName: $_aliasNameGenerator(db.categories.id, db.postings.categoryId),
  );

  $PostingsProcessedTableManager get postingsRefs {
    final manager = $PostingsTableManager(
      $_db,
      $_db.postings,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    RecurrenceRuleVersions,
    List<RecurrenceRuleVersion>
  >
  _recurrenceRuleVersionsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurrenceRuleVersions,
        aliasName: $_aliasNameGenerator(
          db.categories.id,
          db.recurrenceRuleVersions.categoryId,
        ),
      );

  $RecurrenceRuleVersionsProcessedTableManager get recurrenceRuleVersionsRefs {
    final manager = $RecurrenceRuleVersionsTableManager(
      $_db,
      $_db.recurrenceRuleVersions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurrenceRuleVersionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScheduledOccurrences, List<ScheduledOccurrence>>
  _scheduledOccurrencesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduledOccurrences,
        aliasName: $_aliasNameGenerator(
          db.categories.id,
          db.scheduledOccurrences.categoryId,
        ),
      );

  $ScheduledOccurrencesProcessedTableManager get scheduledOccurrencesRefs {
    final manager = $ScheduledOccurrencesTableManager(
      $_db,
      $_db.scheduledOccurrences,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduledOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $CategoriesFilterComposer
    extends Composer<_$CanguruuDatabase, Categories> {
  $CategoriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> postingsRefs(
    Expression<bool> Function($PostingsFilterComposer f) f,
  ) {
    final $PostingsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsFilterComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurrenceRuleVersionsRefs(
    Expression<bool> Function($RecurrenceRuleVersionsFilterComposer f) f,
  ) {
    final $RecurrenceRuleVersionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsFilterComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduledOccurrencesRefs(
    Expression<bool> Function($ScheduledOccurrencesFilterComposer f) f,
  ) {
    final $ScheduledOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $CategoriesOrderingComposer
    extends Composer<_$CanguruuDatabase, Categories> {
  $CategoriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CategoriesAnnotationComposer
    extends Composer<_$CanguruuDatabase, Categories> {
  $CategoriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get essential =>
      $composableBuilder(column: $table.essential, builder: (column) => column);

  GeneratedColumn<int> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> postingsRefs<T extends Object>(
    Expression<T> Function($PostingsAnnotationComposer a) f,
  ) {
    final $PostingsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsAnnotationComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurrenceRuleVersionsRefs<T extends Object>(
    Expression<T> Function($RecurrenceRuleVersionsAnnotationComposer a) f,
  ) {
    final $RecurrenceRuleVersionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduledOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScheduledOccurrencesAnnotationComposer a) f,
  ) {
    final $ScheduledOccurrencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesAnnotationComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $CategoriesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Categories,
          Category,
          $CategoriesFilterComposer,
          $CategoriesOrderingComposer,
          $CategoriesAnnotationComposer,
          $CategoriesCreateCompanionBuilder,
          $CategoriesUpdateCompanionBuilder,
          (Category, $CategoriesReferences),
          Category,
          PrefetchHooks Function({
            bool profileId,
            bool postingsRefs,
            bool recurrenceRuleVersionsRefs,
            bool scheduledOccurrencesRefs,
          })
        > {
  $CategoriesTableManager(_$CanguruuDatabase db, Categories table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CategoriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CategoriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CategoriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> costNature = const Value.absent(),
                Value<int> essential = const Value.absent(),
                Value<int> archived = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                parentId: parentId,
                costNature: costNature,
                essential: essential,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                required String kind,
                Value<String?> parentId = const Value.absent(),
                required String costNature,
                required int essential,
                Value<int> archived = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                parentId: parentId,
                costNature: costNature,
                essential: essential,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $CategoriesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                postingsRefs = false,
                recurrenceRuleVersionsRefs = false,
                scheduledOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (postingsRefs) db.postings,
                    if (recurrenceRuleVersionsRefs) db.recurrenceRuleVersions,
                    if (scheduledOccurrencesRefs) db.scheduledOccurrences,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $CategoriesReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $CategoriesReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (postingsRefs)
                        await $_getPrefetchedData<
                          Category,
                          Categories,
                          Posting
                        >(
                          currentTable: table,
                          referencedTable: $CategoriesReferences
                              ._postingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $CategoriesReferences(db, table, p0).postingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurrenceRuleVersionsRefs)
                        await $_getPrefetchedData<
                          Category,
                          Categories,
                          RecurrenceRuleVersion
                        >(
                          currentTable: table,
                          referencedTable: $CategoriesReferences
                              ._recurrenceRuleVersionsRefsTable(db),
                          managerFromTypedResult: (p0) => $CategoriesReferences(
                            db,
                            table,
                            p0,
                          ).recurrenceRuleVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scheduledOccurrencesRefs)
                        await $_getPrefetchedData<
                          Category,
                          Categories,
                          ScheduledOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $CategoriesReferences
                              ._scheduledOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) => $CategoriesReferences(
                            db,
                            table,
                            p0,
                          ).scheduledOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $CategoriesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Categories,
      Category,
      $CategoriesFilterComposer,
      $CategoriesOrderingComposer,
      $CategoriesAnnotationComposer,
      $CategoriesCreateCompanionBuilder,
      $CategoriesUpdateCompanionBuilder,
      (Category, $CategoriesReferences),
      Category,
      PrefetchHooks Function({
        bool profileId,
        bool postingsRefs,
        bool recurrenceRuleVersionsRefs,
        bool scheduledOccurrencesRefs,
      })
    >;
typedef $FinancialEventsCreateCompanionBuilder =
    FinancialEventsCompanion Function({
      required String id,
      required String profileId,
      required String kind,
      required String effectiveDate,
      required String description,
      required String idempotencyKey,
      Value<String?> reversalOf,
      required String createdAt,
      Value<int> rowid,
    });
typedef $FinancialEventsUpdateCompanionBuilder =
    FinancialEventsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> kind,
      Value<String> effectiveDate,
      Value<String> description,
      Value<String> idempotencyKey,
      Value<String?> reversalOf,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $FinancialEventsReferences
    extends
        BaseReferences<_$CanguruuDatabase, FinancialEvents, FinancialEvent> {
  $FinancialEventsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.financialEvents.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Postings, List<Posting>> _postingsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.postings,
    aliasName: $_aliasNameGenerator(db.financialEvents.id, db.postings.eventId),
  );

  $PostingsProcessedTableManager get postingsRefs {
    final manager = $PostingsTableManager(
      $_db,
      $_db.postings,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<CardOperations, List<CardOperation>>
  _cardOperationsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cardOperations,
        aliasName: $_aliasNameGenerator(
          db.financialEvents.id,
          db.cardOperations.id,
        ),
      );

  $CardOperationsProcessedTableManager get cardOperationsRefs {
    final manager = $CardOperationsTableManager(
      $_db,
      $_db.cardOperations,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardOperationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<InvoicePayments, List<InvoicePayment>>
  _invoicePaymentsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoicePayments,
        aliasName: $_aliasNameGenerator(
          db.financialEvents.id,
          db.invoicePayments.id,
        ),
      );

  $InvoicePaymentsProcessedTableManager get invoicePaymentsRefs {
    final manager = $InvoicePaymentsTableManager(
      $_db,
      $_db.invoicePayments,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoicePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScheduledOccurrences, List<ScheduledOccurrence>>
  _scheduledOccurrencesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduledOccurrences,
        aliasName: $_aliasNameGenerator(
          db.financialEvents.id,
          db.scheduledOccurrences.settledEventId,
        ),
      );

  $ScheduledOccurrencesProcessedTableManager get scheduledOccurrencesRefs {
    final manager = $ScheduledOccurrencesTableManager(
      $_db,
      $_db.scheduledOccurrences,
    ).filter((f) => f.settledEventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduledOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $FinancialEventsFilterComposer
    extends Composer<_$CanguruuDatabase, FinancialEvents> {
  $FinancialEventsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reversalOf => $composableBuilder(
    column: $table.reversalOf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> postingsRefs(
    Expression<bool> Function($PostingsFilterComposer f) f,
  ) {
    final $PostingsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsFilterComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardOperationsRefs(
    Expression<bool> Function($CardOperationsFilterComposer f) f,
  ) {
    final $CardOperationsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardOperations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardOperationsFilterComposer(
            $db: $db,
            $table: $db.cardOperations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePaymentsRefs(
    Expression<bool> Function($InvoicePaymentsFilterComposer f) f,
  ) {
    final $InvoicePaymentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentsFilterComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduledOccurrencesRefs(
    Expression<bool> Function($ScheduledOccurrencesFilterComposer f) f,
  ) {
    final $ScheduledOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.settledEventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $FinancialEventsOrderingComposer
    extends Composer<_$CanguruuDatabase, FinancialEvents> {
  $FinancialEventsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reversalOf => $composableBuilder(
    column: $table.reversalOf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $FinancialEventsAnnotationComposer
    extends Composer<_$CanguruuDatabase, FinancialEvents> {
  $FinancialEventsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get effectiveDate => $composableBuilder(
    column: $table.effectiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reversalOf => $composableBuilder(
    column: $table.reversalOf,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> postingsRefs<T extends Object>(
    Expression<T> Function($PostingsAnnotationComposer a) f,
  ) {
    final $PostingsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postings,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $PostingsAnnotationComposer(
            $db: $db,
            $table: $db.postings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardOperationsRefs<T extends Object>(
    Expression<T> Function($CardOperationsAnnotationComposer a) f,
  ) {
    final $CardOperationsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardOperations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardOperationsAnnotationComposer(
            $db: $db,
            $table: $db.cardOperations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePaymentsRefs<T extends Object>(
    Expression<T> Function($InvoicePaymentsAnnotationComposer a) f,
  ) {
    final $InvoicePaymentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentsAnnotationComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduledOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScheduledOccurrencesAnnotationComposer a) f,
  ) {
    final $ScheduledOccurrencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.settledEventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesAnnotationComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $FinancialEventsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          FinancialEvents,
          FinancialEvent,
          $FinancialEventsFilterComposer,
          $FinancialEventsOrderingComposer,
          $FinancialEventsAnnotationComposer,
          $FinancialEventsCreateCompanionBuilder,
          $FinancialEventsUpdateCompanionBuilder,
          (FinancialEvent, $FinancialEventsReferences),
          FinancialEvent,
          PrefetchHooks Function({
            bool profileId,
            bool postingsRefs,
            bool cardOperationsRefs,
            bool invoicePaymentsRefs,
            bool scheduledOccurrencesRefs,
          })
        > {
  $FinancialEventsTableManager(_$CanguruuDatabase db, FinancialEvents table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $FinancialEventsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $FinancialEventsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $FinancialEventsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> effectiveDate = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String?> reversalOf = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialEventsCompanion(
                id: id,
                profileId: profileId,
                kind: kind,
                effectiveDate: effectiveDate,
                description: description,
                idempotencyKey: idempotencyKey,
                reversalOf: reversalOf,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String kind,
                required String effectiveDate,
                required String description,
                required String idempotencyKey,
                Value<String?> reversalOf = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FinancialEventsCompanion.insert(
                id: id,
                profileId: profileId,
                kind: kind,
                effectiveDate: effectiveDate,
                description: description,
                idempotencyKey: idempotencyKey,
                reversalOf: reversalOf,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $FinancialEventsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                postingsRefs = false,
                cardOperationsRefs = false,
                invoicePaymentsRefs = false,
                scheduledOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (postingsRefs) db.postings,
                    if (cardOperationsRefs) db.cardOperations,
                    if (invoicePaymentsRefs) db.invoicePayments,
                    if (scheduledOccurrencesRefs) db.scheduledOccurrences,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $FinancialEventsReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $FinancialEventsReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (postingsRefs)
                        await $_getPrefetchedData<
                          FinancialEvent,
                          FinancialEvents,
                          Posting
                        >(
                          currentTable: table,
                          referencedTable: $FinancialEventsReferences
                              ._postingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $FinancialEventsReferences(
                                db,
                                table,
                                p0,
                              ).postingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardOperationsRefs)
                        await $_getPrefetchedData<
                          FinancialEvent,
                          FinancialEvents,
                          CardOperation
                        >(
                          currentTable: table,
                          referencedTable: $FinancialEventsReferences
                              ._cardOperationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $FinancialEventsReferences(
                                db,
                                table,
                                p0,
                              ).cardOperationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (invoicePaymentsRefs)
                        await $_getPrefetchedData<
                          FinancialEvent,
                          FinancialEvents,
                          InvoicePayment
                        >(
                          currentTable: table,
                          referencedTable: $FinancialEventsReferences
                              ._invoicePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $FinancialEventsReferences(
                                db,
                                table,
                                p0,
                              ).invoicePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) =>
                                  referencedItems.where((e) => e.id == item.id),
                          typedResults: items,
                        ),
                      if (scheduledOccurrencesRefs)
                        await $_getPrefetchedData<
                          FinancialEvent,
                          FinancialEvents,
                          ScheduledOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $FinancialEventsReferences
                              ._scheduledOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $FinancialEventsReferences(
                                db,
                                table,
                                p0,
                              ).scheduledOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.settledEventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $FinancialEventsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      FinancialEvents,
      FinancialEvent,
      $FinancialEventsFilterComposer,
      $FinancialEventsOrderingComposer,
      $FinancialEventsAnnotationComposer,
      $FinancialEventsCreateCompanionBuilder,
      $FinancialEventsUpdateCompanionBuilder,
      (FinancialEvent, $FinancialEventsReferences),
      FinancialEvent,
      PrefetchHooks Function({
        bool profileId,
        bool postingsRefs,
        bool cardOperationsRefs,
        bool invoicePaymentsRefs,
        bool scheduledOccurrencesRefs,
      })
    >;
typedef $PostingsCreateCompanionBuilder =
    PostingsCompanion Function({
      required String id,
      required String profileId,
      required String eventId,
      required String ledgerAccountId,
      required int sequence,
      required int amountCents,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      Value<int> rowid,
    });
typedef $PostingsUpdateCompanionBuilder =
    PostingsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> eventId,
      Value<String> ledgerAccountId,
      Value<int> sequence,
      Value<int> amountCents,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      Value<int> rowid,
    });

final class $PostingsReferences
    extends BaseReferences<_$CanguruuDatabase, Postings, Posting> {
  $PostingsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.postings.profileId, db.profiles.id));

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static FinancialEvents _eventIdTable(_$CanguruuDatabase db) =>
      db.financialEvents.createAlias(
        $_aliasNameGenerator(db.postings.eventId, db.financialEvents.id),
      );

  $FinancialEventsProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $FinancialEventsTableManager(
      $_db,
      $_db.financialEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static LedgerAccounts _ledgerAccountIdTable(_$CanguruuDatabase db) =>
      db.ledgerAccounts.createAlias(
        $_aliasNameGenerator(db.postings.ledgerAccountId, db.ledgerAccounts.id),
      );

  $LedgerAccountsProcessedTableManager get ledgerAccountId {
    final $_column = $_itemColumn<String>('ledger_account_id')!;

    final manager = $LedgerAccountsTableManager(
      $_db,
      $_db.ledgerAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ledgerAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Categories _categoryIdTable(_$CanguruuDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.postings.categoryId, db.categories.id),
      );

  $CategoriesProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $CategoriesTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $PostingsFilterComposer extends Composer<_$CanguruuDatabase, Postings> {
  $PostingsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsFilterComposer get eventId {
    final $FinancialEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsFilterComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $LedgerAccountsFilterComposer get ledgerAccountId {
    final $LedgerAccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerAccountId,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsFilterComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesFilterComposer get categoryId {
    final $CategoriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $PostingsOrderingComposer extends Composer<_$CanguruuDatabase, Postings> {
  $PostingsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsOrderingComposer get eventId {
    final $FinancialEventsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsOrderingComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $LedgerAccountsOrderingComposer get ledgerAccountId {
    final $LedgerAccountsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerAccountId,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsOrderingComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesOrderingComposer get categoryId {
    final $CategoriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $PostingsAnnotationComposer
    extends Composer<_$CanguruuDatabase, Postings> {
  $PostingsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get essential =>
      $composableBuilder(column: $table.essential, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsAnnotationComposer get eventId {
    final $FinancialEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsAnnotationComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $LedgerAccountsAnnotationComposer get ledgerAccountId {
    final $LedgerAccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerAccountId,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsAnnotationComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesAnnotationComposer get categoryId {
    final $CategoriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $PostingsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Postings,
          Posting,
          $PostingsFilterComposer,
          $PostingsOrderingComposer,
          $PostingsAnnotationComposer,
          $PostingsCreateCompanionBuilder,
          $PostingsUpdateCompanionBuilder,
          (Posting, $PostingsReferences),
          Posting,
          PrefetchHooks Function({
            bool profileId,
            bool eventId,
            bool ledgerAccountId,
            bool categoryId,
          })
        > {
  $PostingsTableManager(_$CanguruuDatabase db, Postings table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $PostingsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $PostingsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $PostingsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> ledgerAccountId = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostingsCompanion(
                id: id,
                profileId: profileId,
                eventId: eventId,
                ledgerAccountId: ledgerAccountId,
                sequence: sequence,
                amountCents: amountCents,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String eventId,
                required String ledgerAccountId,
                required int sequence,
                required int amountCents,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostingsCompanion.insert(
                id: id,
                profileId: profileId,
                eventId: eventId,
                ledgerAccountId: ledgerAccountId,
                sequence: sequence,
                amountCents: amountCents,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $PostingsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                eventId = false,
                ledgerAccountId = false,
                categoryId = false,
              }) {
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $PostingsReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $PostingsReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (eventId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventId,
                                    referencedTable: $PostingsReferences
                                        ._eventIdTable(db),
                                    referencedColumn: $PostingsReferences
                                        ._eventIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (ledgerAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ledgerAccountId,
                                    referencedTable: $PostingsReferences
                                        ._ledgerAccountIdTable(db),
                                    referencedColumn: $PostingsReferences
                                        ._ledgerAccountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $PostingsReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $PostingsReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
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

typedef $PostingsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Postings,
      Posting,
      $PostingsFilterComposer,
      $PostingsOrderingComposer,
      $PostingsAnnotationComposer,
      $PostingsCreateCompanionBuilder,
      $PostingsUpdateCompanionBuilder,
      (Posting, $PostingsReferences),
      Posting,
      PrefetchHooks Function({
        bool profileId,
        bool eventId,
        bool ledgerAccountId,
        bool categoryId,
      })
    >;
typedef $OperationReceiptsCreateCompanionBuilder =
    OperationReceiptsCompanion Function({
      required String id,
      required String profileId,
      required String command,
      required String fingerprint,
      required String resultId,
      required String createdAt,
      Value<int> rowid,
    });
typedef $OperationReceiptsUpdateCompanionBuilder =
    OperationReceiptsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> command,
      Value<String> fingerprint,
      Value<String> resultId,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $OperationReceiptsReferences
    extends
        BaseReferences<
          _$CanguruuDatabase,
          OperationReceipts,
          OperationReceipt
        > {
  $OperationReceiptsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.operationReceipts.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $OperationReceiptsFilterComposer
    extends Composer<_$CanguruuDatabase, OperationReceipts> {
  $OperationReceiptsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get command => $composableBuilder(
    column: $table.command,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultId => $composableBuilder(
    column: $table.resultId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $OperationReceiptsOrderingComposer
    extends Composer<_$CanguruuDatabase, OperationReceipts> {
  $OperationReceiptsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get command => $composableBuilder(
    column: $table.command,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultId => $composableBuilder(
    column: $table.resultId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $OperationReceiptsAnnotationComposer
    extends Composer<_$CanguruuDatabase, OperationReceipts> {
  $OperationReceiptsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get command =>
      $composableBuilder(column: $table.command, builder: (column) => column);

  GeneratedColumn<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultId =>
      $composableBuilder(column: $table.resultId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $OperationReceiptsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          OperationReceipts,
          OperationReceipt,
          $OperationReceiptsFilterComposer,
          $OperationReceiptsOrderingComposer,
          $OperationReceiptsAnnotationComposer,
          $OperationReceiptsCreateCompanionBuilder,
          $OperationReceiptsUpdateCompanionBuilder,
          (OperationReceipt, $OperationReceiptsReferences),
          OperationReceipt,
          PrefetchHooks Function({bool profileId})
        > {
  $OperationReceiptsTableManager(_$CanguruuDatabase db, OperationReceipts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $OperationReceiptsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $OperationReceiptsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $OperationReceiptsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> command = const Value.absent(),
                Value<String> fingerprint = const Value.absent(),
                Value<String> resultId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OperationReceiptsCompanion(
                id: id,
                profileId: profileId,
                command: command,
                fingerprint: fingerprint,
                resultId: resultId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String command,
                required String fingerprint,
                required String resultId,
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => OperationReceiptsCompanion.insert(
                id: id,
                profileId: profileId,
                command: command,
                fingerprint: fingerprint,
                resultId: resultId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $OperationReceiptsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $OperationReceiptsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $OperationReceiptsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $OperationReceiptsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      OperationReceipts,
      OperationReceipt,
      $OperationReceiptsFilterComposer,
      $OperationReceiptsOrderingComposer,
      $OperationReceiptsAnnotationComposer,
      $OperationReceiptsCreateCompanionBuilder,
      $OperationReceiptsUpdateCompanionBuilder,
      (OperationReceipt, $OperationReceiptsReferences),
      OperationReceipt,
      PrefetchHooks Function({bool profileId})
    >;
typedef $CreditCardsCreateCompanionBuilder =
    CreditCardsCompanion Function({
      required String id,
      required String profileId,
      required String name,
      required String openedOn,
      required int limitCents,
      required int closingDay,
      required int dueDay,
      required String closingPolicy,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $CreditCardsUpdateCompanionBuilder =
    CreditCardsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> name,
      Value<String> openedOn,
      Value<int> limitCents,
      Value<int> closingDay,
      Value<int> dueDay,
      Value<String> closingPolicy,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $CreditCardsReferences
    extends BaseReferences<_$CanguruuDatabase, CreditCards, CreditCard> {
  $CreditCardsReferences(super.$_db, super.$_table, super.$_typedResult);

  static LedgerAccounts _idTable(_$CanguruuDatabase db) =>
      db.ledgerAccounts.createAlias(
        $_aliasNameGenerator(db.creditCards.id, db.ledgerAccounts.id),
      );

  $LedgerAccountsProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $LedgerAccountsTableManager(
      $_db,
      $_db.ledgerAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.creditCards.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CreditCardsFilterComposer
    extends Composer<_$CanguruuDatabase, CreditCards> {
  $CreditCardsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get limitCents => $composableBuilder(
    column: $table.limitCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closingPolicy => $composableBuilder(
    column: $table.closingPolicy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $LedgerAccountsFilterComposer get id {
    final $LedgerAccountsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsFilterComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CreditCardsOrderingComposer
    extends Composer<_$CanguruuDatabase, CreditCards> {
  $CreditCardsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openedOn => $composableBuilder(
    column: $table.openedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get limitCents => $composableBuilder(
    column: $table.limitCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closingPolicy => $composableBuilder(
    column: $table.closingPolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $LedgerAccountsOrderingComposer get id {
    final $LedgerAccountsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsOrderingComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CreditCardsAnnotationComposer
    extends Composer<_$CanguruuDatabase, CreditCards> {
  $CreditCardsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get openedOn =>
      $composableBuilder(column: $table.openedOn, builder: (column) => column);

  GeneratedColumn<int> get limitCents => $composableBuilder(
    column: $table.limitCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get closingDay => $composableBuilder(
    column: $table.closingDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<String> get closingPolicy => $composableBuilder(
    column: $table.closingPolicy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $LedgerAccountsAnnotationComposer get id {
    final $LedgerAccountsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ledgerAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LedgerAccountsAnnotationComposer(
            $db: $db,
            $table: $db.ledgerAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CreditCardsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          CreditCards,
          CreditCard,
          $CreditCardsFilterComposer,
          $CreditCardsOrderingComposer,
          $CreditCardsAnnotationComposer,
          $CreditCardsCreateCompanionBuilder,
          $CreditCardsUpdateCompanionBuilder,
          (CreditCard, $CreditCardsReferences),
          CreditCard,
          PrefetchHooks Function({bool id, bool profileId})
        > {
  $CreditCardsTableManager(_$CanguruuDatabase db, CreditCards table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CreditCardsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CreditCardsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CreditCardsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> openedOn = const Value.absent(),
                Value<int> limitCents = const Value.absent(),
                Value<int> closingDay = const Value.absent(),
                Value<int> dueDay = const Value.absent(),
                Value<String> closingPolicy = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCompanion(
                id: id,
                profileId: profileId,
                name: name,
                openedOn: openedOn,
                limitCents: limitCents,
                closingDay: closingDay,
                dueDay: dueDay,
                closingPolicy: closingPolicy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                required String openedOn,
                required int limitCents,
                required int closingDay,
                required int dueDay,
                required String closingPolicy,
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                openedOn: openedOn,
                limitCents: limitCents,
                closingDay: closingDay,
                dueDay: dueDay,
                closingPolicy: closingPolicy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $CreditCardsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, profileId = false}) {
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
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $CreditCardsReferences
                                    ._idTable(db),
                                referencedColumn: $CreditCardsReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $CreditCardsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $CreditCardsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $CreditCardsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      CreditCards,
      CreditCard,
      $CreditCardsFilterComposer,
      $CreditCardsOrderingComposer,
      $CreditCardsAnnotationComposer,
      $CreditCardsCreateCompanionBuilder,
      $CreditCardsUpdateCompanionBuilder,
      (CreditCard, $CreditCardsReferences),
      CreditCard,
      PrefetchHooks Function({bool id, bool profileId})
    >;
typedef $CardOperationsCreateCompanionBuilder =
    CardOperationsCompanion Function({
      required String id,
      required String profileId,
      required String cardId,
      required String kind,
      required String billingOn,
      required int installmentCount,
      required int totalCents,
      required int reconciled,
      Value<int> rowid,
    });
typedef $CardOperationsUpdateCompanionBuilder =
    CardOperationsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> cardId,
      Value<String> kind,
      Value<String> billingOn,
      Value<int> installmentCount,
      Value<int> totalCents,
      Value<int> reconciled,
      Value<int> rowid,
    });

final class $CardOperationsReferences
    extends BaseReferences<_$CanguruuDatabase, CardOperations, CardOperation> {
  $CardOperationsReferences(super.$_db, super.$_table, super.$_typedResult);

  static FinancialEvents _idTable(_$CanguruuDatabase db) =>
      db.financialEvents.createAlias(
        $_aliasNameGenerator(db.cardOperations.id, db.financialEvents.id),
      );

  $FinancialEventsProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $FinancialEventsTableManager(
      $_db,
      $_db.financialEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.cardOperations.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CardOperationsFilterComposer
    extends Composer<_$CanguruuDatabase, CardOperations> {
  $CardOperationsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingOn => $composableBuilder(
    column: $table.billingOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => ColumnFilters(column),
  );

  $FinancialEventsFilterComposer get id {
    final $FinancialEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsFilterComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardOperationsOrderingComposer
    extends Composer<_$CanguruuDatabase, CardOperations> {
  $CardOperationsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingOn => $composableBuilder(
    column: $table.billingOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => ColumnOrderings(column),
  );

  $FinancialEventsOrderingComposer get id {
    final $FinancialEventsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsOrderingComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardOperationsAnnotationComposer
    extends Composer<_$CanguruuDatabase, CardOperations> {
  $CardOperationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get billingOn =>
      $composableBuilder(column: $table.billingOn, builder: (column) => column);

  GeneratedColumn<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reconciled => $composableBuilder(
    column: $table.reconciled,
    builder: (column) => column,
  );

  $FinancialEventsAnnotationComposer get id {
    final $FinancialEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsAnnotationComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardOperationsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          CardOperations,
          CardOperation,
          $CardOperationsFilterComposer,
          $CardOperationsOrderingComposer,
          $CardOperationsAnnotationComposer,
          $CardOperationsCreateCompanionBuilder,
          $CardOperationsUpdateCompanionBuilder,
          (CardOperation, $CardOperationsReferences),
          CardOperation,
          PrefetchHooks Function({bool id, bool profileId})
        > {
  $CardOperationsTableManager(_$CanguruuDatabase db, CardOperations table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CardOperationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CardOperationsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CardOperationsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> billingOn = const Value.absent(),
                Value<int> installmentCount = const Value.absent(),
                Value<int> totalCents = const Value.absent(),
                Value<int> reconciled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardOperationsCompanion(
                id: id,
                profileId: profileId,
                cardId: cardId,
                kind: kind,
                billingOn: billingOn,
                installmentCount: installmentCount,
                totalCents: totalCents,
                reconciled: reconciled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String cardId,
                required String kind,
                required String billingOn,
                required int installmentCount,
                required int totalCents,
                required int reconciled,
                Value<int> rowid = const Value.absent(),
              }) => CardOperationsCompanion.insert(
                id: id,
                profileId: profileId,
                cardId: cardId,
                kind: kind,
                billingOn: billingOn,
                installmentCount: installmentCount,
                totalCents: totalCents,
                reconciled: reconciled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $CardOperationsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, profileId = false}) {
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
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $CardOperationsReferences
                                    ._idTable(db),
                                referencedColumn: $CardOperationsReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $CardOperationsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $CardOperationsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $CardOperationsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      CardOperations,
      CardOperation,
      $CardOperationsFilterComposer,
      $CardOperationsOrderingComposer,
      $CardOperationsAnnotationComposer,
      $CardOperationsCreateCompanionBuilder,
      $CardOperationsUpdateCompanionBuilder,
      (CardOperation, $CardOperationsReferences),
      CardOperation,
      PrefetchHooks Function({bool id, bool profileId})
    >;
typedef $InvoicesCreateCompanionBuilder =
    InvoicesCompanion Function({
      required String id,
      required String profileId,
      required String cardId,
      required String closingOn,
      required String dueOn,
      Value<int> rowid,
    });
typedef $InvoicesUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> cardId,
      Value<String> closingOn,
      Value<String> dueOn,
      Value<int> rowid,
    });

final class $InvoicesReferences
    extends BaseReferences<_$CanguruuDatabase, Invoices, Invoice> {
  $InvoicesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.invoices.profileId, db.profiles.id));

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<InvoiceItems, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoiceItems,
        aliasName: $_aliasNameGenerator(
          db.invoices.id,
          db.invoiceItems.invoiceId,
        ),
      );

  $InvoiceItemsProcessedTableManager get invoiceItemsRefs {
    final manager = $InvoiceItemsTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    InvoicePaymentAllocations,
    List<InvoicePaymentAllocation>
  >
  _invoicePaymentAllocationsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.invoicePaymentAllocations,
        aliasName: $_aliasNameGenerator(
          db.invoices.id,
          db.invoicePaymentAllocations.invoiceId,
        ),
      );

  $InvoicePaymentAllocationsProcessedTableManager
  get invoicePaymentAllocationsRefs {
    final manager = $InvoicePaymentAllocationsTableManager(
      $_db,
      $_db.invoicePaymentAllocations,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoicePaymentAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $InvoicesFilterComposer extends Composer<_$CanguruuDatabase, Invoices> {
  $InvoicesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closingOn => $composableBuilder(
    column: $table.closingOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($InvoiceItemsFilterComposer f) f,
  ) {
    final $InvoiceItemsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoiceItemsFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePaymentAllocationsRefs(
    Expression<bool> Function($InvoicePaymentAllocationsFilterComposer f) f,
  ) {
    final $InvoicePaymentAllocationsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePaymentAllocations,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicePaymentAllocationsFilterComposer(
            $db: $db,
            $table: $db.invoicePaymentAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $InvoicesOrderingComposer extends Composer<_$CanguruuDatabase, Invoices> {
  $InvoicesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closingOn => $composableBuilder(
    column: $table.closingOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicesAnnotationComposer
    extends Composer<_$CanguruuDatabase, Invoices> {
  $InvoicesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get closingOn =>
      $composableBuilder(column: $table.closingOn, builder: (column) => column);

  GeneratedColumn<String> get dueOn =>
      $composableBuilder(column: $table.dueOn, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($InvoiceItemsAnnotationComposer a) f,
  ) {
    final $InvoiceItemsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoiceItemsAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePaymentAllocationsRefs<T extends Object>(
    Expression<T> Function($InvoicePaymentAllocationsAnnotationComposer a) f,
  ) {
    final $InvoicePaymentAllocationsAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.invoicePaymentAllocations,
          getReferencedColumn: (t) => t.invoiceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $InvoicePaymentAllocationsAnnotationComposer(
                $db: $db,
                $table: $db.invoicePaymentAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $InvoicesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Invoices,
          Invoice,
          $InvoicesFilterComposer,
          $InvoicesOrderingComposer,
          $InvoicesAnnotationComposer,
          $InvoicesCreateCompanionBuilder,
          $InvoicesUpdateCompanionBuilder,
          (Invoice, $InvoicesReferences),
          Invoice,
          PrefetchHooks Function({
            bool profileId,
            bool invoiceItemsRefs,
            bool invoicePaymentAllocationsRefs,
          })
        > {
  $InvoicesTableManager(_$CanguruuDatabase db, Invoices table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InvoicesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InvoicesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $InvoicesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> closingOn = const Value.absent(),
                Value<String> dueOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                profileId: profileId,
                cardId: cardId,
                closingOn: closingOn,
                dueOn: dueOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String cardId,
                required String closingOn,
                required String dueOn,
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                profileId: profileId,
                cardId: cardId,
                closingOn: closingOn,
                dueOn: dueOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $InvoicesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                invoiceItemsRefs = false,
                invoicePaymentAllocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (invoicePaymentAllocationsRefs)
                      db.invoicePaymentAllocations,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $InvoicesReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $InvoicesReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          Invoices,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $InvoicesReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $InvoicesReferences(
                            db,
                            table,
                            p0,
                          ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicePaymentAllocationsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          Invoices,
                          InvoicePaymentAllocation
                        >(
                          currentTable: table,
                          referencedTable: $InvoicesReferences
                              ._invoicePaymentAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) => $InvoicesReferences(
                            db,
                            table,
                            p0,
                          ).invoicePaymentAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $InvoicesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Invoices,
      Invoice,
      $InvoicesFilterComposer,
      $InvoicesOrderingComposer,
      $InvoicesAnnotationComposer,
      $InvoicesCreateCompanionBuilder,
      $InvoicesUpdateCompanionBuilder,
      (Invoice, $InvoicesReferences),
      Invoice,
      PrefetchHooks Function({
        bool profileId,
        bool invoiceItemsRefs,
        bool invoicePaymentAllocationsRefs,
      })
    >;
typedef $InvoiceItemsCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      required String id,
      required String profileId,
      required String operationId,
      required String invoiceId,
      required int sequence,
      required int amountCents,
      Value<int> rowid,
    });
typedef $InvoiceItemsUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> operationId,
      Value<String> invoiceId,
      Value<int> sequence,
      Value<int> amountCents,
      Value<int> rowid,
    });

final class $InvoiceItemsReferences
    extends BaseReferences<_$CanguruuDatabase, InvoiceItems, InvoiceItem> {
  $InvoiceItemsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.invoiceItems.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Invoices _invoiceIdTable(_$CanguruuDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.invoiceItems.invoiceId, db.invoices.id),
      );

  $InvoicesProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $InvoicesTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $InvoiceItemsFilterComposer
    extends Composer<_$CanguruuDatabase, InvoiceItems> {
  $InvoiceItemsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesFilterComposer get invoiceId {
    final $InvoicesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoiceItemsOrderingComposer
    extends Composer<_$CanguruuDatabase, InvoiceItems> {
  $InvoiceItemsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesOrderingComposer get invoiceId {
    final $InvoicesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoiceItemsAnnotationComposer
    extends Composer<_$CanguruuDatabase, InvoiceItems> {
  $InvoiceItemsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesAnnotationComposer get invoiceId {
    final $InvoicesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoiceItemsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          InvoiceItems,
          InvoiceItem,
          $InvoiceItemsFilterComposer,
          $InvoiceItemsOrderingComposer,
          $InvoiceItemsAnnotationComposer,
          $InvoiceItemsCreateCompanionBuilder,
          $InvoiceItemsUpdateCompanionBuilder,
          (InvoiceItem, $InvoiceItemsReferences),
          InvoiceItem,
          PrefetchHooks Function({bool profileId, bool invoiceId})
        > {
  $InvoiceItemsTableManager(_$CanguruuDatabase db, InvoiceItems table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InvoiceItemsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InvoiceItemsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $InvoiceItemsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> operationId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                profileId: profileId,
                operationId: operationId,
                invoiceId: invoiceId,
                sequence: sequence,
                amountCents: amountCents,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String operationId,
                required String invoiceId,
                required int sequence,
                required int amountCents,
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                profileId: profileId,
                operationId: operationId,
                invoiceId: invoiceId,
                sequence: sequence,
                amountCents: amountCents,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $InvoiceItemsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, invoiceId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $InvoiceItemsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $InvoiceItemsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $InvoiceItemsReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $InvoiceItemsReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $InvoiceItemsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      InvoiceItems,
      InvoiceItem,
      $InvoiceItemsFilterComposer,
      $InvoiceItemsOrderingComposer,
      $InvoiceItemsAnnotationComposer,
      $InvoiceItemsCreateCompanionBuilder,
      $InvoiceItemsUpdateCompanionBuilder,
      (InvoiceItem, $InvoiceItemsReferences),
      InvoiceItem,
      PrefetchHooks Function({bool profileId, bool invoiceId})
    >;
typedef $InvoicePaymentsCreateCompanionBuilder =
    InvoicePaymentsCompanion Function({
      required String id,
      required String profileId,
      required String cardId,
      required String accountId,
      required int amountCents,
      Value<int> rowid,
    });
typedef $InvoicePaymentsUpdateCompanionBuilder =
    InvoicePaymentsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> cardId,
      Value<String> accountId,
      Value<int> amountCents,
      Value<int> rowid,
    });

final class $InvoicePaymentsReferences
    extends
        BaseReferences<_$CanguruuDatabase, InvoicePayments, InvoicePayment> {
  $InvoicePaymentsReferences(super.$_db, super.$_table, super.$_typedResult);

  static FinancialEvents _idTable(_$CanguruuDatabase db) =>
      db.financialEvents.createAlias(
        $_aliasNameGenerator(db.invoicePayments.id, db.financialEvents.id),
      );

  $FinancialEventsProcessedTableManager get id {
    final $_column = $_itemColumn<String>('id')!;

    final manager = $FinancialEventsTableManager(
      $_db,
      $_db.financialEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.invoicePayments.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $InvoicePaymentsFilterComposer
    extends Composer<_$CanguruuDatabase, InvoicePayments> {
  $InvoicePaymentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  $FinancialEventsFilterComposer get id {
    final $FinancialEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsFilterComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentsOrderingComposer
    extends Composer<_$CanguruuDatabase, InvoicePayments> {
  $InvoicePaymentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  $FinancialEventsOrderingComposer get id {
    final $FinancialEventsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsOrderingComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentsAnnotationComposer
    extends Composer<_$CanguruuDatabase, InvoicePayments> {
  $InvoicePaymentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  $FinancialEventsAnnotationComposer get id {
    final $FinancialEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsAnnotationComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          InvoicePayments,
          InvoicePayment,
          $InvoicePaymentsFilterComposer,
          $InvoicePaymentsOrderingComposer,
          $InvoicePaymentsAnnotationComposer,
          $InvoicePaymentsCreateCompanionBuilder,
          $InvoicePaymentsUpdateCompanionBuilder,
          (InvoicePayment, $InvoicePaymentsReferences),
          InvoicePayment,
          PrefetchHooks Function({bool id, bool profileId})
        > {
  $InvoicePaymentsTableManager(_$CanguruuDatabase db, InvoicePayments table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InvoicePaymentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InvoicePaymentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $InvoicePaymentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentsCompanion(
                id: id,
                profileId: profileId,
                cardId: cardId,
                accountId: accountId,
                amountCents: amountCents,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String cardId,
                required String accountId,
                required int amountCents,
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentsCompanion.insert(
                id: id,
                profileId: profileId,
                cardId: cardId,
                accountId: accountId,
                amountCents: amountCents,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $InvoicePaymentsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({id = false, profileId = false}) {
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
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $InvoicePaymentsReferences
                                    ._idTable(db),
                                referencedColumn: $InvoicePaymentsReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $InvoicePaymentsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $InvoicePaymentsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $InvoicePaymentsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      InvoicePayments,
      InvoicePayment,
      $InvoicePaymentsFilterComposer,
      $InvoicePaymentsOrderingComposer,
      $InvoicePaymentsAnnotationComposer,
      $InvoicePaymentsCreateCompanionBuilder,
      $InvoicePaymentsUpdateCompanionBuilder,
      (InvoicePayment, $InvoicePaymentsReferences),
      InvoicePayment,
      PrefetchHooks Function({bool id, bool profileId})
    >;
typedef $InvoicePaymentAllocationsCreateCompanionBuilder =
    InvoicePaymentAllocationsCompanion Function({
      required String id,
      required String profileId,
      required String paymentId,
      required String invoiceId,
      required int amountCents,
      Value<int> rowid,
    });
typedef $InvoicePaymentAllocationsUpdateCompanionBuilder =
    InvoicePaymentAllocationsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> paymentId,
      Value<String> invoiceId,
      Value<int> amountCents,
      Value<int> rowid,
    });

final class $InvoicePaymentAllocationsReferences
    extends
        BaseReferences<
          _$CanguruuDatabase,
          InvoicePaymentAllocations,
          InvoicePaymentAllocation
        > {
  $InvoicePaymentAllocationsReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(
          db.invoicePaymentAllocations.profileId,
          db.profiles.id,
        ),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Invoices _invoiceIdTable(_$CanguruuDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(
          db.invoicePaymentAllocations.invoiceId,
          db.invoices.id,
        ),
      );

  $InvoicesProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $InvoicesTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $InvoicePaymentAllocationsFilterComposer
    extends Composer<_$CanguruuDatabase, InvoicePaymentAllocations> {
  $InvoicePaymentAllocationsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesFilterComposer get invoiceId {
    final $InvoicesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentAllocationsOrderingComposer
    extends Composer<_$CanguruuDatabase, InvoicePaymentAllocations> {
  $InvoicePaymentAllocationsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesOrderingComposer get invoiceId {
    final $InvoicesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentAllocationsAnnotationComposer
    extends Composer<_$CanguruuDatabase, InvoicePaymentAllocations> {
  $InvoicePaymentAllocationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $InvoicesAnnotationComposer get invoiceId {
    final $InvoicesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $InvoicesAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $InvoicePaymentAllocationsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          InvoicePaymentAllocations,
          InvoicePaymentAllocation,
          $InvoicePaymentAllocationsFilterComposer,
          $InvoicePaymentAllocationsOrderingComposer,
          $InvoicePaymentAllocationsAnnotationComposer,
          $InvoicePaymentAllocationsCreateCompanionBuilder,
          $InvoicePaymentAllocationsUpdateCompanionBuilder,
          (InvoicePaymentAllocation, $InvoicePaymentAllocationsReferences),
          InvoicePaymentAllocation,
          PrefetchHooks Function({bool profileId, bool invoiceId})
        > {
  $InvoicePaymentAllocationsTableManager(
    _$CanguruuDatabase db,
    InvoicePaymentAllocations table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InvoicePaymentAllocationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InvoicePaymentAllocationsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $InvoicePaymentAllocationsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentAllocationsCompanion(
                id: id,
                profileId: profileId,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountCents: amountCents,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String paymentId,
                required String invoiceId,
                required int amountCents,
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentAllocationsCompanion.insert(
                id: id,
                profileId: profileId,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountCents: amountCents,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $InvoicePaymentAllocationsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, invoiceId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable:
                                    $InvoicePaymentAllocationsReferences
                                        ._profileIdTable(db),
                                referencedColumn:
                                    $InvoicePaymentAllocationsReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable:
                                    $InvoicePaymentAllocationsReferences
                                        ._invoiceIdTable(db),
                                referencedColumn:
                                    $InvoicePaymentAllocationsReferences
                                        ._invoiceIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $InvoicePaymentAllocationsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      InvoicePaymentAllocations,
      InvoicePaymentAllocation,
      $InvoicePaymentAllocationsFilterComposer,
      $InvoicePaymentAllocationsOrderingComposer,
      $InvoicePaymentAllocationsAnnotationComposer,
      $InvoicePaymentAllocationsCreateCompanionBuilder,
      $InvoicePaymentAllocationsUpdateCompanionBuilder,
      (InvoicePaymentAllocation, $InvoicePaymentAllocationsReferences),
      InvoicePaymentAllocation,
      PrefetchHooks Function({bool profileId, bool invoiceId})
    >;
typedef $RecurrenceSeriesCreateCompanionBuilder =
    RecurrenceSeriesCompanion Function({
      required String id,
      required String profileId,
      required String name,
      required String kind,
      Value<String?> pausedOn,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $RecurrenceSeriesUpdateCompanionBuilder =
    RecurrenceSeriesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> name,
      Value<String> kind,
      Value<String?> pausedOn,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $RecurrenceSeriesReferences
    extends
        BaseReferences<_$CanguruuDatabase, RecurrenceSeries, RecurrenceSery> {
  $RecurrenceSeriesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.recurrenceSeries.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    RecurrenceRuleVersions,
    List<RecurrenceRuleVersion>
  >
  _recurrenceRuleVersionsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurrenceRuleVersions,
        aliasName: $_aliasNameGenerator(
          db.recurrenceSeries.id,
          db.recurrenceRuleVersions.seriesId,
        ),
      );

  $RecurrenceRuleVersionsProcessedTableManager get recurrenceRuleVersionsRefs {
    final manager = $RecurrenceRuleVersionsTableManager(
      $_db,
      $_db.recurrenceRuleVersions,
    ).filter((f) => f.seriesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurrenceRuleVersionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<ScheduledOccurrences, List<ScheduledOccurrence>>
  _scheduledOccurrencesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduledOccurrences,
        aliasName: $_aliasNameGenerator(
          db.recurrenceSeries.id,
          db.scheduledOccurrences.seriesId,
        ),
      );

  $ScheduledOccurrencesProcessedTableManager get scheduledOccurrencesRefs {
    final manager = $ScheduledOccurrencesTableManager(
      $_db,
      $_db.scheduledOccurrences,
    ).filter((f) => f.seriesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduledOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $RecurrenceSeriesFilterComposer
    extends Composer<_$CanguruuDatabase, RecurrenceSeries> {
  $RecurrenceSeriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<String> get pausedOn => $composableBuilder(
    column: $table.pausedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recurrenceRuleVersionsRefs(
    Expression<bool> Function($RecurrenceRuleVersionsFilterComposer f) f,
  ) {
    final $RecurrenceRuleVersionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsFilterComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduledOccurrencesRefs(
    Expression<bool> Function($ScheduledOccurrencesFilterComposer f) f,
  ) {
    final $ScheduledOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RecurrenceSeriesOrderingComposer
    extends Composer<_$CanguruuDatabase, RecurrenceSeries> {
  $RecurrenceSeriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<String> get pausedOn => $composableBuilder(
    column: $table.pausedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecurrenceSeriesAnnotationComposer
    extends Composer<_$CanguruuDatabase, RecurrenceSeries> {
  $RecurrenceSeriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get pausedOn =>
      $composableBuilder(column: $table.pausedOn, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recurrenceRuleVersionsRefs<T extends Object>(
    Expression<T> Function($RecurrenceRuleVersionsAnnotationComposer a) f,
  ) {
    final $RecurrenceRuleVersionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduledOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScheduledOccurrencesAnnotationComposer a) f,
  ) {
    final $ScheduledOccurrencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.seriesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesAnnotationComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RecurrenceSeriesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          RecurrenceSeries,
          RecurrenceSery,
          $RecurrenceSeriesFilterComposer,
          $RecurrenceSeriesOrderingComposer,
          $RecurrenceSeriesAnnotationComposer,
          $RecurrenceSeriesCreateCompanionBuilder,
          $RecurrenceSeriesUpdateCompanionBuilder,
          (RecurrenceSery, $RecurrenceSeriesReferences),
          RecurrenceSery,
          PrefetchHooks Function({
            bool profileId,
            bool recurrenceRuleVersionsRefs,
            bool scheduledOccurrencesRefs,
          })
        > {
  $RecurrenceSeriesTableManager(_$CanguruuDatabase db, RecurrenceSeries table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RecurrenceSeriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RecurrenceSeriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RecurrenceSeriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> pausedOn = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceSeriesCompanion(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                pausedOn: pausedOn,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                required String kind,
                Value<String?> pausedOn = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceSeriesCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                kind: kind,
                pausedOn: pausedOn,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $RecurrenceSeriesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                recurrenceRuleVersionsRefs = false,
                scheduledOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurrenceRuleVersionsRefs) db.recurrenceRuleVersions,
                    if (scheduledOccurrencesRefs) db.scheduledOccurrences,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $RecurrenceSeriesReferences
                                        ._profileIdTable(db),
                                    referencedColumn:
                                        $RecurrenceSeriesReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurrenceRuleVersionsRefs)
                        await $_getPrefetchedData<
                          RecurrenceSery,
                          RecurrenceSeries,
                          RecurrenceRuleVersion
                        >(
                          currentTable: table,
                          referencedTable: $RecurrenceSeriesReferences
                              ._recurrenceRuleVersionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $RecurrenceSeriesReferences(
                                db,
                                table,
                                p0,
                              ).recurrenceRuleVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.seriesId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scheduledOccurrencesRefs)
                        await $_getPrefetchedData<
                          RecurrenceSery,
                          RecurrenceSeries,
                          ScheduledOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $RecurrenceSeriesReferences
                              ._scheduledOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $RecurrenceSeriesReferences(
                                db,
                                table,
                                p0,
                              ).scheduledOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.seriesId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $RecurrenceSeriesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      RecurrenceSeries,
      RecurrenceSery,
      $RecurrenceSeriesFilterComposer,
      $RecurrenceSeriesOrderingComposer,
      $RecurrenceSeriesAnnotationComposer,
      $RecurrenceSeriesCreateCompanionBuilder,
      $RecurrenceSeriesUpdateCompanionBuilder,
      (RecurrenceSery, $RecurrenceSeriesReferences),
      RecurrenceSery,
      PrefetchHooks Function({
        bool profileId,
        bool recurrenceRuleVersionsRefs,
        bool scheduledOccurrencesRefs,
      })
    >;
typedef $RecurrenceRuleVersionsCreateCompanionBuilder =
    RecurrenceRuleVersionsCompanion Function({
      required String id,
      required String profileId,
      required String seriesId,
      required String validFrom,
      Value<int> isCurrent,
      Value<String?> validUntil,
      required String anchorOn,
      required String frequency,
      required int intervalCount,
      required int lastDay,
      Value<String?> endOn,
      Value<int?> maxOccurrences,
      required String description,
      required int amountCents,
      Value<String?> accountId,
      Value<String?> destinationId,
      Value<String?> cardId,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      required String createdAt,
      Value<int> rowid,
    });
typedef $RecurrenceRuleVersionsUpdateCompanionBuilder =
    RecurrenceRuleVersionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> seriesId,
      Value<String> validFrom,
      Value<int> isCurrent,
      Value<String?> validUntil,
      Value<String> anchorOn,
      Value<String> frequency,
      Value<int> intervalCount,
      Value<int> lastDay,
      Value<String?> endOn,
      Value<int?> maxOccurrences,
      Value<String> description,
      Value<int> amountCents,
      Value<String?> accountId,
      Value<String?> destinationId,
      Value<String?> cardId,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $RecurrenceRuleVersionsReferences
    extends
        BaseReferences<
          _$CanguruuDatabase,
          RecurrenceRuleVersions,
          RecurrenceRuleVersion
        > {
  $RecurrenceRuleVersionsReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(
          db.recurrenceRuleVersions.profileId,
          db.profiles.id,
        ),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static RecurrenceSeries _seriesIdTable(_$CanguruuDatabase db) =>
      db.recurrenceSeries.createAlias(
        $_aliasNameGenerator(
          db.recurrenceRuleVersions.seriesId,
          db.recurrenceSeries.id,
        ),
      );

  $RecurrenceSeriesProcessedTableManager get seriesId {
    final $_column = $_itemColumn<String>('series_id')!;

    final manager = $RecurrenceSeriesTableManager(
      $_db,
      $_db.recurrenceSeries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_seriesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Categories _categoryIdTable(_$CanguruuDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(
          db.recurrenceRuleVersions.categoryId,
          db.categories.id,
        ),
      );

  $CategoriesProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $CategoriesTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<ScheduledOccurrences, List<ScheduledOccurrence>>
  _scheduledOccurrencesRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduledOccurrences,
        aliasName: $_aliasNameGenerator(
          db.recurrenceRuleVersions.id,
          db.scheduledOccurrences.ruleVersionId,
        ),
      );

  $ScheduledOccurrencesProcessedTableManager get scheduledOccurrencesRefs {
    final manager = $ScheduledOccurrencesTableManager(
      $_db,
      $_db.scheduledOccurrences,
    ).filter((f) => f.ruleVersionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduledOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $RecurrenceRuleVersionsFilterComposer
    extends Composer<_$CanguruuDatabase, RecurrenceRuleVersions> {
  $RecurrenceRuleVersionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anchorOn => $composableBuilder(
    column: $table.anchorOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastDay => $composableBuilder(
    column: $table.lastDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endOn => $composableBuilder(
    column: $table.endOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxOccurrences => $composableBuilder(
    column: $table.maxOccurrences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesFilterComposer get seriesId {
    final $RecurrenceSeriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesFilterComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesFilterComposer get categoryId {
    final $CategoriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scheduledOccurrencesRefs(
    Expression<bool> Function($ScheduledOccurrencesFilterComposer f) f,
  ) {
    final $ScheduledOccurrencesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.ruleVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesFilterComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RecurrenceRuleVersionsOrderingComposer
    extends Composer<_$CanguruuDatabase, RecurrenceRuleVersions> {
  $RecurrenceRuleVersionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anchorOn => $composableBuilder(
    column: $table.anchorOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastDay => $composableBuilder(
    column: $table.lastDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endOn => $composableBuilder(
    column: $table.endOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxOccurrences => $composableBuilder(
    column: $table.maxOccurrences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesOrderingComposer get seriesId {
    final $RecurrenceSeriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesOrderingComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesOrderingComposer get categoryId {
    final $CategoriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $RecurrenceRuleVersionsAnnotationComposer
    extends Composer<_$CanguruuDatabase, RecurrenceRuleVersions> {
  $RecurrenceRuleVersionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<int> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  GeneratedColumn<String> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get anchorOn =>
      $composableBuilder(column: $table.anchorOn, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastDay =>
      $composableBuilder(column: $table.lastDay, builder: (column) => column);

  GeneratedColumn<String> get endOn =>
      $composableBuilder(column: $table.endOn, builder: (column) => column);

  GeneratedColumn<int> get maxOccurrences => $composableBuilder(
    column: $table.maxOccurrences,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get essential =>
      $composableBuilder(column: $table.essential, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesAnnotationComposer get seriesId {
    final $RecurrenceSeriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesAnnotationComposer get categoryId {
    final $CategoriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> scheduledOccurrencesRefs<T extends Object>(
    Expression<T> Function($ScheduledOccurrencesAnnotationComposer a) f,
  ) {
    final $ScheduledOccurrencesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduledOccurrences,
      getReferencedColumn: (t) => t.ruleVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ScheduledOccurrencesAnnotationComposer(
            $db: $db,
            $table: $db.scheduledOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $RecurrenceRuleVersionsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          RecurrenceRuleVersions,
          RecurrenceRuleVersion,
          $RecurrenceRuleVersionsFilterComposer,
          $RecurrenceRuleVersionsOrderingComposer,
          $RecurrenceRuleVersionsAnnotationComposer,
          $RecurrenceRuleVersionsCreateCompanionBuilder,
          $RecurrenceRuleVersionsUpdateCompanionBuilder,
          (RecurrenceRuleVersion, $RecurrenceRuleVersionsReferences),
          RecurrenceRuleVersion,
          PrefetchHooks Function({
            bool profileId,
            bool seriesId,
            bool categoryId,
            bool scheduledOccurrencesRefs,
          })
        > {
  $RecurrenceRuleVersionsTableManager(
    _$CanguruuDatabase db,
    RecurrenceRuleVersions table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RecurrenceRuleVersionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RecurrenceRuleVersionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RecurrenceRuleVersionsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> seriesId = const Value.absent(),
                Value<String> validFrom = const Value.absent(),
                Value<int> isCurrent = const Value.absent(),
                Value<String?> validUntil = const Value.absent(),
                Value<String> anchorOn = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int> intervalCount = const Value.absent(),
                Value<int> lastDay = const Value.absent(),
                Value<String?> endOn = const Value.absent(),
                Value<int?> maxOccurrences = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> destinationId = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceRuleVersionsCompanion(
                id: id,
                profileId: profileId,
                seriesId: seriesId,
                validFrom: validFrom,
                isCurrent: isCurrent,
                validUntil: validUntil,
                anchorOn: anchorOn,
                frequency: frequency,
                intervalCount: intervalCount,
                lastDay: lastDay,
                endOn: endOn,
                maxOccurrences: maxOccurrences,
                description: description,
                amountCents: amountCents,
                accountId: accountId,
                destinationId: destinationId,
                cardId: cardId,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String seriesId,
                required String validFrom,
                Value<int> isCurrent = const Value.absent(),
                Value<String?> validUntil = const Value.absent(),
                required String anchorOn,
                required String frequency,
                required int intervalCount,
                required int lastDay,
                Value<String?> endOn = const Value.absent(),
                Value<int?> maxOccurrences = const Value.absent(),
                required String description,
                required int amountCents,
                Value<String?> accountId = const Value.absent(),
                Value<String?> destinationId = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceRuleVersionsCompanion.insert(
                id: id,
                profileId: profileId,
                seriesId: seriesId,
                validFrom: validFrom,
                isCurrent: isCurrent,
                validUntil: validUntil,
                anchorOn: anchorOn,
                frequency: frequency,
                intervalCount: intervalCount,
                lastDay: lastDay,
                endOn: endOn,
                maxOccurrences: maxOccurrences,
                description: description,
                amountCents: amountCents,
                accountId: accountId,
                destinationId: destinationId,
                cardId: cardId,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $RecurrenceRuleVersionsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                seriesId = false,
                categoryId = false,
                scheduledOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scheduledOccurrencesRefs) db.scheduledOccurrences,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $RecurrenceRuleVersionsReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $RecurrenceRuleVersionsReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (seriesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.seriesId,
                                    referencedTable:
                                        $RecurrenceRuleVersionsReferences
                                            ._seriesIdTable(db),
                                    referencedColumn:
                                        $RecurrenceRuleVersionsReferences
                                            ._seriesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $RecurrenceRuleVersionsReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $RecurrenceRuleVersionsReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scheduledOccurrencesRefs)
                        await $_getPrefetchedData<
                          RecurrenceRuleVersion,
                          RecurrenceRuleVersions,
                          ScheduledOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $RecurrenceRuleVersionsReferences
                              ._scheduledOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $RecurrenceRuleVersionsReferences(
                                db,
                                table,
                                p0,
                              ).scheduledOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $RecurrenceRuleVersionsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      RecurrenceRuleVersions,
      RecurrenceRuleVersion,
      $RecurrenceRuleVersionsFilterComposer,
      $RecurrenceRuleVersionsOrderingComposer,
      $RecurrenceRuleVersionsAnnotationComposer,
      $RecurrenceRuleVersionsCreateCompanionBuilder,
      $RecurrenceRuleVersionsUpdateCompanionBuilder,
      (RecurrenceRuleVersion, $RecurrenceRuleVersionsReferences),
      RecurrenceRuleVersion,
      PrefetchHooks Function({
        bool profileId,
        bool seriesId,
        bool categoryId,
        bool scheduledOccurrencesRefs,
      })
    >;
typedef $ScheduledOccurrencesCreateCompanionBuilder =
    ScheduledOccurrencesCompanion Function({
      required String id,
      required String profileId,
      Value<String?> seriesId,
      Value<String?> ruleVersionId,
      Value<int?> ordinal,
      required String kind,
      required String scheduledOn,
      required String description,
      required int amountCents,
      Value<String?> accountId,
      Value<String?> destinationId,
      Value<String?> cardId,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      required String status,
      Value<String?> settledEventId,
      Value<int> isManualOverride,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $ScheduledOccurrencesUpdateCompanionBuilder =
    ScheduledOccurrencesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String?> seriesId,
      Value<String?> ruleVersionId,
      Value<int?> ordinal,
      Value<String> kind,
      Value<String> scheduledOn,
      Value<String> description,
      Value<int> amountCents,
      Value<String?> accountId,
      Value<String?> destinationId,
      Value<String?> cardId,
      Value<String?> categoryId,
      Value<String?> costNature,
      Value<int?> essential,
      Value<String> status,
      Value<String?> settledEventId,
      Value<int> isManualOverride,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $ScheduledOccurrencesReferences
    extends
        BaseReferences<
          _$CanguruuDatabase,
          ScheduledOccurrences,
          ScheduledOccurrence
        > {
  $ScheduledOccurrencesReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.scheduledOccurrences.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static RecurrenceSeries _seriesIdTable(_$CanguruuDatabase db) =>
      db.recurrenceSeries.createAlias(
        $_aliasNameGenerator(
          db.scheduledOccurrences.seriesId,
          db.recurrenceSeries.id,
        ),
      );

  $RecurrenceSeriesProcessedTableManager? get seriesId {
    final $_column = $_itemColumn<String>('series_id');
    if ($_column == null) return null;
    final manager = $RecurrenceSeriesTableManager(
      $_db,
      $_db.recurrenceSeries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_seriesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static RecurrenceRuleVersions _ruleVersionIdTable(_$CanguruuDatabase db) =>
      db.recurrenceRuleVersions.createAlias(
        $_aliasNameGenerator(
          db.scheduledOccurrences.ruleVersionId,
          db.recurrenceRuleVersions.id,
        ),
      );

  $RecurrenceRuleVersionsProcessedTableManager? get ruleVersionId {
    final $_column = $_itemColumn<String>('rule_version_id');
    if ($_column == null) return null;
    final manager = $RecurrenceRuleVersionsTableManager(
      $_db,
      $_db.recurrenceRuleVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Categories _categoryIdTable(_$CanguruuDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(
          db.scheduledOccurrences.categoryId,
          db.categories.id,
        ),
      );

  $CategoriesProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $CategoriesTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static FinancialEvents _settledEventIdTable(_$CanguruuDatabase db) =>
      db.financialEvents.createAlias(
        $_aliasNameGenerator(
          db.scheduledOccurrences.settledEventId,
          db.financialEvents.id,
        ),
      );

  $FinancialEventsProcessedTableManager? get settledEventId {
    final $_column = $_itemColumn<String>('settled_event_id');
    if ($_column == null) return null;
    final manager = $FinancialEventsTableManager(
      $_db,
      $_db.financialEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_settledEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ScheduledOccurrencesFilterComposer
    extends Composer<_$CanguruuDatabase, ScheduledOccurrences> {
  $ScheduledOccurrencesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledOn => $composableBuilder(
    column: $table.scheduledOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isManualOverride => $composableBuilder(
    column: $table.isManualOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesFilterComposer get seriesId {
    final $RecurrenceSeriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesFilterComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceRuleVersionsFilterComposer get ruleVersionId {
    final $RecurrenceRuleVersionsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleVersionId,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsFilterComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesFilterComposer get categoryId {
    final $CategoriesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsFilterComposer get settledEventId {
    final $FinancialEventsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settledEventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsFilterComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScheduledOccurrencesOrderingComposer
    extends Composer<_$CanguruuDatabase, ScheduledOccurrences> {
  $ScheduledOccurrencesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledOn => $composableBuilder(
    column: $table.scheduledOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get essential => $composableBuilder(
    column: $table.essential,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isManualOverride => $composableBuilder(
    column: $table.isManualOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesOrderingComposer get seriesId {
    final $RecurrenceSeriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesOrderingComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceRuleVersionsOrderingComposer get ruleVersionId {
    final $RecurrenceRuleVersionsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleVersionId,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsOrderingComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesOrderingComposer get categoryId {
    final $CategoriesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsOrderingComposer get settledEventId {
    final $FinancialEventsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settledEventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsOrderingComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScheduledOccurrencesAnnotationComposer
    extends Composer<_$CanguruuDatabase, ScheduledOccurrences> {
  $ScheduledOccurrencesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get scheduledOn => $composableBuilder(
    column: $table.scheduledOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get costNature => $composableBuilder(
    column: $table.costNature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get essential =>
      $composableBuilder(column: $table.essential, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get isManualOverride => $composableBuilder(
    column: $table.isManualOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceSeriesAnnotationComposer get seriesId {
    final $RecurrenceSeriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seriesId,
      referencedTable: $db.recurrenceSeries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceSeriesAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceSeries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $RecurrenceRuleVersionsAnnotationComposer get ruleVersionId {
    final $RecurrenceRuleVersionsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleVersionId,
      referencedTable: $db.recurrenceRuleVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $RecurrenceRuleVersionsAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceRuleVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $CategoriesAnnotationComposer get categoryId {
    final $CategoriesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CategoriesAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $FinancialEventsAnnotationComposer get settledEventId {
    final $FinancialEventsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settledEventId,
      referencedTable: $db.financialEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $FinancialEventsAnnotationComposer(
            $db: $db,
            $table: $db.financialEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ScheduledOccurrencesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          ScheduledOccurrences,
          ScheduledOccurrence,
          $ScheduledOccurrencesFilterComposer,
          $ScheduledOccurrencesOrderingComposer,
          $ScheduledOccurrencesAnnotationComposer,
          $ScheduledOccurrencesCreateCompanionBuilder,
          $ScheduledOccurrencesUpdateCompanionBuilder,
          (ScheduledOccurrence, $ScheduledOccurrencesReferences),
          ScheduledOccurrence,
          PrefetchHooks Function({
            bool profileId,
            bool seriesId,
            bool ruleVersionId,
            bool categoryId,
            bool settledEventId,
          })
        > {
  $ScheduledOccurrencesTableManager(
    _$CanguruuDatabase db,
    ScheduledOccurrences table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ScheduledOccurrencesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ScheduledOccurrencesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ScheduledOccurrencesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> seriesId = const Value.absent(),
                Value<String?> ruleVersionId = const Value.absent(),
                Value<int?> ordinal = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> scheduledOn = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> destinationId = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> settledEventId = const Value.absent(),
                Value<int> isManualOverride = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduledOccurrencesCompanion(
                id: id,
                profileId: profileId,
                seriesId: seriesId,
                ruleVersionId: ruleVersionId,
                ordinal: ordinal,
                kind: kind,
                scheduledOn: scheduledOn,
                description: description,
                amountCents: amountCents,
                accountId: accountId,
                destinationId: destinationId,
                cardId: cardId,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                status: status,
                settledEventId: settledEventId,
                isManualOverride: isManualOverride,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> seriesId = const Value.absent(),
                Value<String?> ruleVersionId = const Value.absent(),
                Value<int?> ordinal = const Value.absent(),
                required String kind,
                required String scheduledOn,
                required String description,
                required int amountCents,
                Value<String?> accountId = const Value.absent(),
                Value<String?> destinationId = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> costNature = const Value.absent(),
                Value<int?> essential = const Value.absent(),
                required String status,
                Value<String?> settledEventId = const Value.absent(),
                Value<int> isManualOverride = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduledOccurrencesCompanion.insert(
                id: id,
                profileId: profileId,
                seriesId: seriesId,
                ruleVersionId: ruleVersionId,
                ordinal: ordinal,
                kind: kind,
                scheduledOn: scheduledOn,
                description: description,
                amountCents: amountCents,
                accountId: accountId,
                destinationId: destinationId,
                cardId: cardId,
                categoryId: categoryId,
                costNature: costNature,
                essential: essential,
                status: status,
                settledEventId: settledEventId,
                isManualOverride: isManualOverride,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ScheduledOccurrencesReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                seriesId = false,
                ruleVersionId = false,
                categoryId = false,
                settledEventId = false,
              }) {
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $ScheduledOccurrencesReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $ScheduledOccurrencesReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (seriesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.seriesId,
                                    referencedTable:
                                        $ScheduledOccurrencesReferences
                                            ._seriesIdTable(db),
                                    referencedColumn:
                                        $ScheduledOccurrencesReferences
                                            ._seriesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (ruleVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ruleVersionId,
                                    referencedTable:
                                        $ScheduledOccurrencesReferences
                                            ._ruleVersionIdTable(db),
                                    referencedColumn:
                                        $ScheduledOccurrencesReferences
                                            ._ruleVersionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $ScheduledOccurrencesReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $ScheduledOccurrencesReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (settledEventId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.settledEventId,
                                    referencedTable:
                                        $ScheduledOccurrencesReferences
                                            ._settledEventIdTable(db),
                                    referencedColumn:
                                        $ScheduledOccurrencesReferences
                                            ._settledEventIdTable(db)
                                            .id,
                                  )
                                  as T;
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

typedef $ScheduledOccurrencesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      ScheduledOccurrences,
      ScheduledOccurrence,
      $ScheduledOccurrencesFilterComposer,
      $ScheduledOccurrencesOrderingComposer,
      $ScheduledOccurrencesAnnotationComposer,
      $ScheduledOccurrencesCreateCompanionBuilder,
      $ScheduledOccurrencesUpdateCompanionBuilder,
      (ScheduledOccurrence, $ScheduledOccurrencesReferences),
      ScheduledOccurrence,
      PrefetchHooks Function({
        bool profileId,
        bool seriesId,
        bool ruleVersionId,
        bool categoryId,
        bool settledEventId,
      })
    >;
typedef $ObjectivesCreateCompanionBuilder =
    ObjectivesCompanion Function({
      required String id,
      required String profileId,
      required String title,
      required String status,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $ObjectivesUpdateCompanionBuilder =
    ObjectivesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> title,
      Value<String> status,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $ObjectivesReferences
    extends BaseReferences<_$CanguruuDatabase, Objectives, Objective> {
  $ObjectivesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.objectives.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Goals, List<Goal>> _goalsRefsTable(
    _$CanguruuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goals,
    aliasName: $_aliasNameGenerator(db.objectives.id, db.goals.objectiveId),
  );

  $GoalsProcessedTableManager get goalsRefs {
    final manager = $GoalsTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.objectiveId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ObjectivesFilterComposer
    extends Composer<_$CanguruuDatabase, Objectives> {
  $ObjectivesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> goalsRefs(
    Expression<bool> Function($GoalsFilterComposer f) f,
  ) {
    final $GoalsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.objectiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ObjectivesOrderingComposer
    extends Composer<_$CanguruuDatabase, Objectives> {
  $ObjectivesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ObjectivesAnnotationComposer
    extends Composer<_$CanguruuDatabase, Objectives> {
  $ObjectivesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> goalsRefs<T extends Object>(
    Expression<T> Function($GoalsAnnotationComposer a) f,
  ) {
    final $GoalsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.objectiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ObjectivesTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Objectives,
          Objective,
          $ObjectivesFilterComposer,
          $ObjectivesOrderingComposer,
          $ObjectivesAnnotationComposer,
          $ObjectivesCreateCompanionBuilder,
          $ObjectivesUpdateCompanionBuilder,
          (Objective, $ObjectivesReferences),
          Objective,
          PrefetchHooks Function({bool profileId, bool goalsRefs})
        > {
  $ObjectivesTableManager(_$CanguruuDatabase db, Objectives table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ObjectivesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ObjectivesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ObjectivesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObjectivesCompanion(
                id: id,
                profileId: profileId,
                title: title,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String title,
                required String status,
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObjectivesCompanion.insert(
                id: id,
                profileId: profileId,
                title: title,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $ObjectivesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, goalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (goalsRefs) db.goals],
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $ObjectivesReferences
                                    ._profileIdTable(db),
                                referencedColumn: $ObjectivesReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goalsRefs)
                    await $_getPrefetchedData<Objective, Objectives, Goal>(
                      currentTable: table,
                      referencedTable: $ObjectivesReferences._goalsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $ObjectivesReferences(db, table, p0).goalsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.objectiveId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $ObjectivesProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Objectives,
      Objective,
      $ObjectivesFilterComposer,
      $ObjectivesOrderingComposer,
      $ObjectivesAnnotationComposer,
      $ObjectivesCreateCompanionBuilder,
      $ObjectivesUpdateCompanionBuilder,
      (Objective, $ObjectivesReferences),
      Objective,
      PrefetchHooks Function({bool profileId, bool goalsRefs})
    >;
typedef $GoalsCreateCompanionBuilder =
    GoalsCompanion Function({
      required String id,
      required String profileId,
      Value<String?> objectiveId,
      required String title,
      required String purpose,
      required int targetCents,
      Value<String?> targetOn,
      required int priority,
      required String status,
      Value<String?> fulfilledOn,
      Value<int?> fulfilledCents,
      required String createdAt,
      required String updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $GoalsUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String?> objectiveId,
      Value<String> title,
      Value<String> purpose,
      Value<int> targetCents,
      Value<String?> targetOn,
      Value<int> priority,
      Value<String> status,
      Value<String?> fulfilledOn,
      Value<int?> fulfilledCents,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> revision,
      Value<int> rowid,
    });

final class $GoalsReferences
    extends BaseReferences<_$CanguruuDatabase, Goals, Goal> {
  $GoalsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.goals.profileId, db.profiles.id));

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Objectives _objectiveIdTable(_$CanguruuDatabase db) =>
      db.objectives.createAlias(
        $_aliasNameGenerator(db.goals.objectiveId, db.objectives.id),
      );

  $ObjectivesProcessedTableManager? get objectiveId {
    final $_column = $_itemColumn<String>('objective_id');
    if ($_column == null) return null;
    final manager = $ObjectivesTableManager(
      $_db,
      $_db.objectives,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_objectiveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<GoalFundMovements, List<GoalFundMovement>>
  _goalFundMovementsRefsTable(_$CanguruuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.goalFundMovements,
        aliasName: $_aliasNameGenerator(
          db.goals.id,
          db.goalFundMovements.goalId,
        ),
      );

  $GoalFundMovementsProcessedTableManager get goalFundMovementsRefs {
    final manager = $GoalFundMovementsTableManager(
      $_db,
      $_db.goalFundMovements,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalFundMovementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $GoalsFilterComposer extends Composer<_$CanguruuDatabase, Goals> {
  $GoalsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetOn => $composableBuilder(
    column: $table.targetOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fulfilledOn => $composableBuilder(
    column: $table.fulfilledOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fulfilledCents => $composableBuilder(
    column: $table.fulfilledCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ObjectivesFilterComposer get objectiveId {
    final $ObjectivesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.objectiveId,
      referencedTable: $db.objectives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ObjectivesFilterComposer(
            $db: $db,
            $table: $db.objectives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> goalFundMovementsRefs(
    Expression<bool> Function($GoalFundMovementsFilterComposer f) f,
  ) {
    final $GoalFundMovementsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalFundMovements,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalFundMovementsFilterComposer(
            $db: $db,
            $table: $db.goalFundMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $GoalsOrderingComposer extends Composer<_$CanguruuDatabase, Goals> {
  $GoalsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetOn => $composableBuilder(
    column: $table.targetOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fulfilledOn => $composableBuilder(
    column: $table.fulfilledOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fulfilledCents => $composableBuilder(
    column: $table.fulfilledCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ObjectivesOrderingComposer get objectiveId {
    final $ObjectivesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.objectiveId,
      referencedTable: $db.objectives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ObjectivesOrderingComposer(
            $db: $db,
            $table: $db.objectives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $GoalsAnnotationComposer extends Composer<_$CanguruuDatabase, Goals> {
  $GoalsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetOn =>
      $composableBuilder(column: $table.targetOn, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get fulfilledOn => $composableBuilder(
    column: $table.fulfilledOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fulfilledCents => $composableBuilder(
    column: $table.fulfilledCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $ObjectivesAnnotationComposer get objectiveId {
    final $ObjectivesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.objectiveId,
      referencedTable: $db.objectives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ObjectivesAnnotationComposer(
            $db: $db,
            $table: $db.objectives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> goalFundMovementsRefs<T extends Object>(
    Expression<T> Function($GoalFundMovementsAnnotationComposer a) f,
  ) {
    final $GoalFundMovementsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalFundMovements,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalFundMovementsAnnotationComposer(
            $db: $db,
            $table: $db.goalFundMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $GoalsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          Goals,
          Goal,
          $GoalsFilterComposer,
          $GoalsOrderingComposer,
          $GoalsAnnotationComposer,
          $GoalsCreateCompanionBuilder,
          $GoalsUpdateCompanionBuilder,
          (Goal, $GoalsReferences),
          Goal,
          PrefetchHooks Function({
            bool profileId,
            bool objectiveId,
            bool goalFundMovementsRefs,
          })
        > {
  $GoalsTableManager(_$CanguruuDatabase db, Goals table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $GoalsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $GoalsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $GoalsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> objectiveId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> purpose = const Value.absent(),
                Value<int> targetCents = const Value.absent(),
                Value<String?> targetOn = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> fulfilledOn = const Value.absent(),
                Value<int?> fulfilledCents = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                profileId: profileId,
                objectiveId: objectiveId,
                title: title,
                purpose: purpose,
                targetCents: targetCents,
                targetOn: targetOn,
                priority: priority,
                status: status,
                fulfilledOn: fulfilledOn,
                fulfilledCents: fulfilledCents,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> objectiveId = const Value.absent(),
                required String title,
                required String purpose,
                required int targetCents,
                Value<String?> targetOn = const Value.absent(),
                required int priority,
                required String status,
                Value<String?> fulfilledOn = const Value.absent(),
                Value<int?> fulfilledCents = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                profileId: profileId,
                objectiveId: objectiveId,
                title: title,
                purpose: purpose,
                targetCents: targetCents,
                targetOn: targetOn,
                priority: priority,
                status: status,
                fulfilledOn: fulfilledOn,
                fulfilledCents: fulfilledCents,
                createdAt: createdAt,
                updatedAt: updatedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $GoalsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                objectiveId = false,
                goalFundMovementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (goalFundMovementsRefs) db.goalFundMovements,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $GoalsReferences
                                        ._profileIdTable(db),
                                    referencedColumn: $GoalsReferences
                                        ._profileIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (objectiveId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.objectiveId,
                                    referencedTable: $GoalsReferences
                                        ._objectiveIdTable(db),
                                    referencedColumn: $GoalsReferences
                                        ._objectiveIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (goalFundMovementsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          Goals,
                          GoalFundMovement
                        >(
                          currentTable: table,
                          referencedTable: $GoalsReferences
                              ._goalFundMovementsRefsTable(db),
                          managerFromTypedResult: (p0) => $GoalsReferences(
                            db,
                            table,
                            p0,
                          ).goalFundMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $GoalsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      Goals,
      Goal,
      $GoalsFilterComposer,
      $GoalsOrderingComposer,
      $GoalsAnnotationComposer,
      $GoalsCreateCompanionBuilder,
      $GoalsUpdateCompanionBuilder,
      (Goal, $GoalsReferences),
      Goal,
      PrefetchHooks Function({
        bool profileId,
        bool objectiveId,
        bool goalFundMovementsRefs,
      })
    >;
typedef $GoalFundMovementsCreateCompanionBuilder =
    GoalFundMovementsCompanion Function({
      required String id,
      required String profileId,
      required String goalId,
      required String accountId,
      required String effectiveOn,
      required int amountCents,
      required int sequenceNo,
      required String requestId,
      required String createdAt,
      Value<int> rowid,
    });
typedef $GoalFundMovementsUpdateCompanionBuilder =
    GoalFundMovementsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> goalId,
      Value<String> accountId,
      Value<String> effectiveOn,
      Value<int> amountCents,
      Value<int> sequenceNo,
      Value<String> requestId,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $GoalFundMovementsReferences
    extends
        BaseReferences<
          _$CanguruuDatabase,
          GoalFundMovements,
          GoalFundMovement
        > {
  $GoalFundMovementsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Profiles _profileIdTable(_$CanguruuDatabase db) =>
      db.profiles.createAlias(
        $_aliasNameGenerator(db.goalFundMovements.profileId, db.profiles.id),
      );

  $ProfilesProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $ProfilesTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Goals _goalIdTable(_$CanguruuDatabase db) => db.goals.createAlias(
    $_aliasNameGenerator(db.goalFundMovements.goalId, db.goals.id),
  );

  $GoalsProcessedTableManager get goalId {
    final $_column = $_itemColumn<String>('goal_id')!;

    final manager = $GoalsTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $GoalFundMovementsFilterComposer
    extends Composer<_$CanguruuDatabase, GoalFundMovements> {
  $GoalFundMovementsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveOn => $composableBuilder(
    column: $table.effectiveOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceNo => $composableBuilder(
    column: $table.sequenceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestId => $composableBuilder(
    column: $table.requestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $ProfilesFilterComposer get profileId {
    final $ProfilesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $GoalsFilterComposer get goalId {
    final $GoalsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $GoalFundMovementsOrderingComposer
    extends Composer<_$CanguruuDatabase, GoalFundMovements> {
  $GoalFundMovementsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveOn => $composableBuilder(
    column: $table.effectiveOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceNo => $composableBuilder(
    column: $table.sequenceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestId => $composableBuilder(
    column: $table.requestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ProfilesOrderingComposer get profileId {
    final $ProfilesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $GoalsOrderingComposer get goalId {
    final $GoalsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $GoalFundMovementsAnnotationComposer
    extends Composer<_$CanguruuDatabase, GoalFundMovements> {
  $GoalFundMovementsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get effectiveOn => $composableBuilder(
    column: $table.effectiveOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequenceNo => $composableBuilder(
    column: $table.sequenceNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requestId =>
      $composableBuilder(column: $table.requestId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $ProfilesAnnotationComposer get profileId {
    final $ProfilesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProfilesAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $GoalsAnnotationComposer get goalId {
    final $GoalsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $GoalsAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $GoalFundMovementsTableManager
    extends
        RootTableManager<
          _$CanguruuDatabase,
          GoalFundMovements,
          GoalFundMovement,
          $GoalFundMovementsFilterComposer,
          $GoalFundMovementsOrderingComposer,
          $GoalFundMovementsAnnotationComposer,
          $GoalFundMovementsCreateCompanionBuilder,
          $GoalFundMovementsUpdateCompanionBuilder,
          (GoalFundMovement, $GoalFundMovementsReferences),
          GoalFundMovement,
          PrefetchHooks Function({bool profileId, bool goalId})
        > {
  $GoalFundMovementsTableManager(_$CanguruuDatabase db, GoalFundMovements table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $GoalFundMovementsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $GoalFundMovementsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $GoalFundMovementsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> effectiveOn = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> sequenceNo = const Value.absent(),
                Value<String> requestId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalFundMovementsCompanion(
                id: id,
                profileId: profileId,
                goalId: goalId,
                accountId: accountId,
                effectiveOn: effectiveOn,
                amountCents: amountCents,
                sequenceNo: sequenceNo,
                requestId: requestId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String goalId,
                required String accountId,
                required String effectiveOn,
                required int amountCents,
                required int sequenceNo,
                required String requestId,
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalFundMovementsCompanion.insert(
                id: id,
                profileId: profileId,
                goalId: goalId,
                accountId: accountId,
                effectiveOn: effectiveOn,
                amountCents: amountCents,
                sequenceNo: sequenceNo,
                requestId: requestId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $GoalFundMovementsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, goalId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $GoalFundMovementsReferences
                                    ._profileIdTable(db),
                                referencedColumn: $GoalFundMovementsReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (goalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.goalId,
                                referencedTable: $GoalFundMovementsReferences
                                    ._goalIdTable(db),
                                referencedColumn: $GoalFundMovementsReferences
                                    ._goalIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $GoalFundMovementsProcessedTableManager =
    ProcessedTableManager<
      _$CanguruuDatabase,
      GoalFundMovements,
      GoalFundMovement,
      $GoalFundMovementsFilterComposer,
      $GoalFundMovementsOrderingComposer,
      $GoalFundMovementsAnnotationComposer,
      $GoalFundMovementsCreateCompanionBuilder,
      $GoalFundMovementsUpdateCompanionBuilder,
      (GoalFundMovement, $GoalFundMovementsReferences),
      GoalFundMovement,
      PrefetchHooks Function({bool profileId, bool goalId})
    >;

class $CanguruuDatabaseManager {
  final _$CanguruuDatabase _db;
  $CanguruuDatabaseManager(this._db);
  $ProfilesTableManager get profiles =>
      $ProfilesTableManager(_db, _db.profiles);
  $LedgerAccountsTableManager get ledgerAccounts =>
      $LedgerAccountsTableManager(_db, _db.ledgerAccounts);
  $AccountsTableManager get accounts =>
      $AccountsTableManager(_db, _db.accounts);
  $CategoriesTableManager get categories =>
      $CategoriesTableManager(_db, _db.categories);
  $FinancialEventsTableManager get financialEvents =>
      $FinancialEventsTableManager(_db, _db.financialEvents);
  $PostingsTableManager get postings =>
      $PostingsTableManager(_db, _db.postings);
  $OperationReceiptsTableManager get operationReceipts =>
      $OperationReceiptsTableManager(_db, _db.operationReceipts);
  $CreditCardsTableManager get creditCards =>
      $CreditCardsTableManager(_db, _db.creditCards);
  $CardOperationsTableManager get cardOperations =>
      $CardOperationsTableManager(_db, _db.cardOperations);
  $InvoicesTableManager get invoices =>
      $InvoicesTableManager(_db, _db.invoices);
  $InvoiceItemsTableManager get invoiceItems =>
      $InvoiceItemsTableManager(_db, _db.invoiceItems);
  $InvoicePaymentsTableManager get invoicePayments =>
      $InvoicePaymentsTableManager(_db, _db.invoicePayments);
  $InvoicePaymentAllocationsTableManager get invoicePaymentAllocations =>
      $InvoicePaymentAllocationsTableManager(
        _db,
        _db.invoicePaymentAllocations,
      );
  $RecurrenceSeriesTableManager get recurrenceSeries =>
      $RecurrenceSeriesTableManager(_db, _db.recurrenceSeries);
  $RecurrenceRuleVersionsTableManager get recurrenceRuleVersions =>
      $RecurrenceRuleVersionsTableManager(_db, _db.recurrenceRuleVersions);
  $ScheduledOccurrencesTableManager get scheduledOccurrences =>
      $ScheduledOccurrencesTableManager(_db, _db.scheduledOccurrences);
  $ObjectivesTableManager get objectives =>
      $ObjectivesTableManager(_db, _db.objectives);
  $GoalsTableManager get goals => $GoalsTableManager(_db, _db.goals);
  $GoalFundMovementsTableManager get goalFundMovements =>
      $GoalFundMovementsTableManager(_db, _db.goalFundMovements);
}
