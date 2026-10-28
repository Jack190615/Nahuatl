// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LessonsTable extends Lessons with TableInfo<$LessonsTable, LessonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _romanNumberMeta =
      const VerificationMeta('romanNumber');
  @override
  late final GeneratedColumn<String> romanNumber = GeneratedColumn<String>(
      'roman_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isUnlockedMeta =
      const VerificationMeta('isUnlocked');
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
      'is_unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        romanNumber,
        title,
        description,
        orderIndex,
        isUnlocked,
        isCompleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lessons';
  @override
  VerificationContext validateIntegrity(Insertable<LessonRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('roman_number')) {
      context.handle(
          _romanNumberMeta,
          romanNumber.isAcceptableOrUnknown(
              data['roman_number']!, _romanNumberMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
          _isUnlockedMeta,
          isUnlocked.isAcceptableOrUnknown(
              data['is_unlocked']!, _isUnlockedMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      romanNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}roman_number']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      isUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unlocked'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class LessonRow extends DataClass implements Insertable<LessonRow> {
  final int id;
  final String? romanNumber;
  final String title;
  final String? description;
  final int orderIndex;
  final bool isUnlocked;
  final bool isCompleted;
  const LessonRow(
      {required this.id,
      this.romanNumber,
      required this.title,
      this.description,
      required this.orderIndex,
      required this.isUnlocked,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || romanNumber != null) {
      map['roman_number'] = Variable<String>(romanNumber);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['order_index'] = Variable<int>(orderIndex);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      romanNumber: romanNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(romanNumber),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      orderIndex: Value(orderIndex),
      isUnlocked: Value(isUnlocked),
      isCompleted: Value(isCompleted),
    );
  }

  factory LessonRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonRow(
      id: serializer.fromJson<int>(json['id']),
      romanNumber: serializer.fromJson<String?>(json['romanNumber']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'romanNumber': serializer.toJson<String?>(romanNumber),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  LessonRow copyWith(
          {int? id,
          Value<String?> romanNumber = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          int? orderIndex,
          bool? isUnlocked,
          bool? isCompleted}) =>
      LessonRow(
        id: id ?? this.id,
        romanNumber: romanNumber.present ? romanNumber.value : this.romanNumber,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        orderIndex: orderIndex ?? this.orderIndex,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  LessonRow copyWithCompanion(LessonsCompanion data) {
    return LessonRow(
      id: data.id.present ? data.id.value : this.id,
      romanNumber:
          data.romanNumber.present ? data.romanNumber.value : this.romanNumber,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonRow(')
          ..write('id: $id, ')
          ..write('romanNumber: $romanNumber, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, romanNumber, title, description, orderIndex, isUnlocked, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonRow &&
          other.id == this.id &&
          other.romanNumber == this.romanNumber &&
          other.title == this.title &&
          other.description == this.description &&
          other.orderIndex == this.orderIndex &&
          other.isUnlocked == this.isUnlocked &&
          other.isCompleted == this.isCompleted);
}

class LessonsCompanion extends UpdateCompanion<LessonRow> {
  final Value<int> id;
  final Value<String?> romanNumber;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> orderIndex;
  final Value<bool> isUnlocked;
  final Value<bool> isCompleted;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.romanNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    this.romanNumber = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required int orderIndex,
    this.isUnlocked = const Value.absent(),
    this.isCompleted = const Value.absent(),
  })  : title = Value(title),
        orderIndex = Value(orderIndex);
  static Insertable<LessonRow> custom({
    Expression<int>? id,
    Expression<String>? romanNumber,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? orderIndex,
    Expression<bool>? isUnlocked,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (romanNumber != null) 'roman_number': romanNumber,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (orderIndex != null) 'order_index': orderIndex,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? romanNumber,
      Value<String>? title,
      Value<String?>? description,
      Value<int>? orderIndex,
      Value<bool>? isUnlocked,
      Value<bool>? isCompleted}) {
    return LessonsCompanion(
      id: id ?? this.id,
      romanNumber: romanNumber ?? this.romanNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (romanNumber.present) {
      map['roman_number'] = Variable<String>(romanNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('romanNumber: $romanNumber, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $SublessonsTable extends Sublessons
    with TableInfo<$SublessonsTable, SublessonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SublessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES lessons (id) ON DELETE CASCADE'));
  static const VerificationMeta _pointNumberMeta =
      const VerificationMeta('pointNumber');
  @override
  late final GeneratedColumn<String> pointNumber = GeneratedColumn<String>(
      'point_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 180),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 40),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _theoryContentMeta =
      const VerificationMeta('theoryContent');
  @override
  late final GeneratedColumn<String> theoryContent = GeneratedColumn<String>(
      'theory_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isUnlockedMeta =
      const VerificationMeta('isUnlocked');
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
      'is_unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lessonId,
        pointNumber,
        title,
        type,
        theoryContent,
        orderIndex,
        isUnlocked,
        isCompleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sublessons';
  @override
  VerificationContext validateIntegrity(Insertable<SublessonRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('point_number')) {
      context.handle(
          _pointNumberMeta,
          pointNumber.isAcceptableOrUnknown(
              data['point_number']!, _pointNumberMeta));
    } else if (isInserting) {
      context.missing(_pointNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('theory_content')) {
      context.handle(
          _theoryContentMeta,
          theoryContent.isAcceptableOrUnknown(
              data['theory_content']!, _theoryContentMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
          _isUnlockedMeta,
          isUnlocked.isAcceptableOrUnknown(
              data['is_unlocked']!, _isUnlockedMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SublessonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SublessonRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_id'])!,
      pointNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}point_number'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      theoryContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theory_content']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      isUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unlocked'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $SublessonsTable createAlias(String alias) {
    return $SublessonsTable(attachedDatabase, alias);
  }
}

class SublessonRow extends DataClass implements Insertable<SublessonRow> {
  final int id;
  final int lessonId;

  /// Número o rango de punto en el libro (ej. "4", "5", "6", "7-9", "10", "11").
  final String pointNumber;
  final String title;

  /// Tipo de contenido: 'teoria', 'vocabulario', 'frases'.
  final String type;

  /// Contenido explicativo en caso de ser punto teórico.
  final String? theoryContent;
  final int orderIndex;
  final bool isUnlocked;
  final bool isCompleted;
  const SublessonRow(
      {required this.id,
      required this.lessonId,
      required this.pointNumber,
      required this.title,
      required this.type,
      this.theoryContent,
      required this.orderIndex,
      required this.isUnlocked,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['point_number'] = Variable<String>(pointNumber);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || theoryContent != null) {
      map['theory_content'] = Variable<String>(theoryContent);
    }
    map['order_index'] = Variable<int>(orderIndex);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  SublessonsCompanion toCompanion(bool nullToAbsent) {
    return SublessonsCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      pointNumber: Value(pointNumber),
      title: Value(title),
      type: Value(type),
      theoryContent: theoryContent == null && nullToAbsent
          ? const Value.absent()
          : Value(theoryContent),
      orderIndex: Value(orderIndex),
      isUnlocked: Value(isUnlocked),
      isCompleted: Value(isCompleted),
    );
  }

  factory SublessonRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SublessonRow(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      pointNumber: serializer.fromJson<String>(json['pointNumber']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      theoryContent: serializer.fromJson<String?>(json['theoryContent']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'pointNumber': serializer.toJson<String>(pointNumber),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'theoryContent': serializer.toJson<String?>(theoryContent),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  SublessonRow copyWith(
          {int? id,
          int? lessonId,
          String? pointNumber,
          String? title,
          String? type,
          Value<String?> theoryContent = const Value.absent(),
          int? orderIndex,
          bool? isUnlocked,
          bool? isCompleted}) =>
      SublessonRow(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
        pointNumber: pointNumber ?? this.pointNumber,
        title: title ?? this.title,
        type: type ?? this.type,
        theoryContent:
            theoryContent.present ? theoryContent.value : this.theoryContent,
        orderIndex: orderIndex ?? this.orderIndex,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  SublessonRow copyWithCompanion(SublessonsCompanion data) {
    return SublessonRow(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      pointNumber:
          data.pointNumber.present ? data.pointNumber.value : this.pointNumber,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      theoryContent: data.theoryContent.present
          ? data.theoryContent.value
          : this.theoryContent,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SublessonRow(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('pointNumber: $pointNumber, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('theoryContent: $theoryContent, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, pointNumber, title, type,
      theoryContent, orderIndex, isUnlocked, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SublessonRow &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.pointNumber == this.pointNumber &&
          other.title == this.title &&
          other.type == this.type &&
          other.theoryContent == this.theoryContent &&
          other.orderIndex == this.orderIndex &&
          other.isUnlocked == this.isUnlocked &&
          other.isCompleted == this.isCompleted);
}

class SublessonsCompanion extends UpdateCompanion<SublessonRow> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<String> pointNumber;
  final Value<String> title;
  final Value<String> type;
  final Value<String?> theoryContent;
  final Value<int> orderIndex;
  final Value<bool> isUnlocked;
  final Value<bool> isCompleted;
  const SublessonsCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.pointNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.theoryContent = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  SublessonsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    required String pointNumber,
    required String title,
    required String type,
    this.theoryContent = const Value.absent(),
    required int orderIndex,
    this.isUnlocked = const Value.absent(),
    this.isCompleted = const Value.absent(),
  })  : lessonId = Value(lessonId),
        pointNumber = Value(pointNumber),
        title = Value(title),
        type = Value(type),
        orderIndex = Value(orderIndex);
  static Insertable<SublessonRow> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<String>? pointNumber,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? theoryContent,
    Expression<int>? orderIndex,
    Expression<bool>? isUnlocked,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (pointNumber != null) 'point_number': pointNumber,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (theoryContent != null) 'theory_content': theoryContent,
      if (orderIndex != null) 'order_index': orderIndex,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  SublessonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? lessonId,
      Value<String>? pointNumber,
      Value<String>? title,
      Value<String>? type,
      Value<String?>? theoryContent,
      Value<int>? orderIndex,
      Value<bool>? isUnlocked,
      Value<bool>? isCompleted}) {
    return SublessonsCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      pointNumber: pointNumber ?? this.pointNumber,
      title: title ?? this.title,
      type: type ?? this.type,
      theoryContent: theoryContent ?? this.theoryContent,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (pointNumber.present) {
      map['point_number'] = Variable<String>(pointNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (theoryContent.present) {
      map['theory_content'] = Variable<String>(theoryContent.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SublessonsCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('pointNumber: $pointNumber, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('theoryContent: $theoryContent, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $GrammarRulesTable extends GrammarRules
    with TableInfo<$GrammarRulesTable, GrammarRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrammarRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES lessons (id) ON DELETE CASCADE'));
  static const VerificationMeta _explanationTextMeta =
      const VerificationMeta('explanationText');
  @override
  late final GeneratedColumn<String> explanationText = GeneratedColumn<String>(
      'explanation_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, lessonId, explanationText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grammar_rules';
  @override
  VerificationContext validateIntegrity(Insertable<GrammarRuleRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('explanation_text')) {
      context.handle(
          _explanationTextMeta,
          explanationText.isAcceptableOrUnknown(
              data['explanation_text']!, _explanationTextMeta));
    } else if (isInserting) {
      context.missing(_explanationTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrammarRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrammarRuleRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_id'])!,
      explanationText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}explanation_text'])!,
    );
  }

  @override
  $GrammarRulesTable createAlias(String alias) {
    return $GrammarRulesTable(attachedDatabase, alias);
  }
}

class GrammarRuleRow extends DataClass implements Insertable<GrammarRuleRow> {
  final int id;
  final int lessonId;
  final String explanationText;
  const GrammarRuleRow(
      {required this.id,
      required this.lessonId,
      required this.explanationText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['explanation_text'] = Variable<String>(explanationText);
    return map;
  }

  GrammarRulesCompanion toCompanion(bool nullToAbsent) {
    return GrammarRulesCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      explanationText: Value(explanationText),
    );
  }

  factory GrammarRuleRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrammarRuleRow(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      explanationText: serializer.fromJson<String>(json['explanationText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'explanationText': serializer.toJson<String>(explanationText),
    };
  }

  GrammarRuleRow copyWith({int? id, int? lessonId, String? explanationText}) =>
      GrammarRuleRow(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
        explanationText: explanationText ?? this.explanationText,
      );
  GrammarRuleRow copyWithCompanion(GrammarRulesCompanion data) {
    return GrammarRuleRow(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      explanationText: data.explanationText.present
          ? data.explanationText.value
          : this.explanationText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrammarRuleRow(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('explanationText: $explanationText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, explanationText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarRuleRow &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.explanationText == this.explanationText);
}

class GrammarRulesCompanion extends UpdateCompanion<GrammarRuleRow> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<String> explanationText;
  const GrammarRulesCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.explanationText = const Value.absent(),
  });
  GrammarRulesCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    required String explanationText,
  })  : lessonId = Value(lessonId),
        explanationText = Value(explanationText);
  static Insertable<GrammarRuleRow> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<String>? explanationText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (explanationText != null) 'explanation_text': explanationText,
    });
  }

  GrammarRulesCompanion copyWith(
      {Value<int>? id, Value<int>? lessonId, Value<String>? explanationText}) {
    return GrammarRulesCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      explanationText: explanationText ?? this.explanationText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (explanationText.present) {
      map['explanation_text'] = Variable<String>(explanationText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrammarRulesCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('explanationText: $explanationText')
          ..write(')'))
        .toString();
  }
}

class $DictionaryTable extends Dictionary
    with TableInfo<$DictionaryTable, DictionaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sublessonIdMeta =
      const VerificationMeta('sublessonId');
  @override
  late final GeneratedColumn<int> sublessonId = GeneratedColumn<int>(
      'sublesson_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES sublessons (id) ON DELETE SET NULL'));
  static const VerificationMeta _nahuatlWordMeta =
      const VerificationMeta('nahuatlWord');
  @override
  late final GeneratedColumn<String> nahuatlWord = GeneratedColumn<String>(
      'nahuatl_word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spanishTranslationMeta =
      const VerificationMeta('spanishTranslation');
  @override
  late final GeneratedColumn<String> spanishTranslation =
      GeneratedColumn<String>('spanish_translation', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordTypeMeta =
      const VerificationMeta('wordType');
  @override
  late final GeneratedColumn<String> wordType = GeneratedColumn<String>(
      'word_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sublessonId, nahuatlWord, spanishTranslation, wordType, audioPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictionary';
  @override
  VerificationContext validateIntegrity(Insertable<DictionaryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sublesson_id')) {
      context.handle(
          _sublessonIdMeta,
          sublessonId.isAcceptableOrUnknown(
              data['sublesson_id']!, _sublessonIdMeta));
    }
    if (data.containsKey('nahuatl_word')) {
      context.handle(
          _nahuatlWordMeta,
          nahuatlWord.isAcceptableOrUnknown(
              data['nahuatl_word']!, _nahuatlWordMeta));
    } else if (isInserting) {
      context.missing(_nahuatlWordMeta);
    }
    if (data.containsKey('spanish_translation')) {
      context.handle(
          _spanishTranslationMeta,
          spanishTranslation.isAcceptableOrUnknown(
              data['spanish_translation']!, _spanishTranslationMeta));
    } else if (isInserting) {
      context.missing(_spanishTranslationMeta);
    }
    if (data.containsKey('word_type')) {
      context.handle(_wordTypeMeta,
          wordType.isAcceptableOrUnknown(data['word_type']!, _wordTypeMeta));
    } else if (isInserting) {
      context.missing(_wordTypeMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DictionaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictionaryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sublessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sublesson_id']),
      nahuatlWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nahuatl_word'])!,
      spanishTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}spanish_translation'])!,
      wordType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word_type'])!,
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path']),
    );
  }

  @override
  $DictionaryTable createAlias(String alias) {
    return $DictionaryTable(attachedDatabase, alias);
  }
}

class DictionaryRow extends DataClass implements Insertable<DictionaryRow> {
  final int id;

  /// Referencia opcional a la sublección donde se introduce por primera vez este vocablo.
  final int? sublessonId;
  final String nahuatlWord;
  final String spanishTranslation;

  /// Tipo gramatical: 'sustantivo', 'verbo', 'partícula', 'adjetivo', 'pronombre', etc.
  final String wordType;

  /// Ruta relativa del asset de audio (ej. `assets/audio/atl.mp3`). Nullable para UI Defensiva.
  final String? audioPath;
  const DictionaryRow(
      {required this.id,
      this.sublessonId,
      required this.nahuatlWord,
      required this.spanishTranslation,
      required this.wordType,
      this.audioPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sublessonId != null) {
      map['sublesson_id'] = Variable<int>(sublessonId);
    }
    map['nahuatl_word'] = Variable<String>(nahuatlWord);
    map['spanish_translation'] = Variable<String>(spanishTranslation);
    map['word_type'] = Variable<String>(wordType);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    return map;
  }

  DictionaryCompanion toCompanion(bool nullToAbsent) {
    return DictionaryCompanion(
      id: Value(id),
      sublessonId: sublessonId == null && nullToAbsent
          ? const Value.absent()
          : Value(sublessonId),
      nahuatlWord: Value(nahuatlWord),
      spanishTranslation: Value(spanishTranslation),
      wordType: Value(wordType),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
    );
  }

  factory DictionaryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictionaryRow(
      id: serializer.fromJson<int>(json['id']),
      sublessonId: serializer.fromJson<int?>(json['sublessonId']),
      nahuatlWord: serializer.fromJson<String>(json['nahuatlWord']),
      spanishTranslation:
          serializer.fromJson<String>(json['spanishTranslation']),
      wordType: serializer.fromJson<String>(json['wordType']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sublessonId': serializer.toJson<int?>(sublessonId),
      'nahuatlWord': serializer.toJson<String>(nahuatlWord),
      'spanishTranslation': serializer.toJson<String>(spanishTranslation),
      'wordType': serializer.toJson<String>(wordType),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  DictionaryRow copyWith(
          {int? id,
          Value<int?> sublessonId = const Value.absent(),
          String? nahuatlWord,
          String? spanishTranslation,
          String? wordType,
          Value<String?> audioPath = const Value.absent()}) =>
      DictionaryRow(
        id: id ?? this.id,
        sublessonId: sublessonId.present ? sublessonId.value : this.sublessonId,
        nahuatlWord: nahuatlWord ?? this.nahuatlWord,
        spanishTranslation: spanishTranslation ?? this.spanishTranslation,
        wordType: wordType ?? this.wordType,
        audioPath: audioPath.present ? audioPath.value : this.audioPath,
      );
  DictionaryRow copyWithCompanion(DictionaryCompanion data) {
    return DictionaryRow(
      id: data.id.present ? data.id.value : this.id,
      sublessonId:
          data.sublessonId.present ? data.sublessonId.value : this.sublessonId,
      nahuatlWord:
          data.nahuatlWord.present ? data.nahuatlWord.value : this.nahuatlWord,
      spanishTranslation: data.spanishTranslation.present
          ? data.spanishTranslation.value
          : this.spanishTranslation,
      wordType: data.wordType.present ? data.wordType.value : this.wordType,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryRow(')
          ..write('id: $id, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('nahuatlWord: $nahuatlWord, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('wordType: $wordType, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, sublessonId, nahuatlWord, spanishTranslation, wordType, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryRow &&
          other.id == this.id &&
          other.sublessonId == this.sublessonId &&
          other.nahuatlWord == this.nahuatlWord &&
          other.spanishTranslation == this.spanishTranslation &&
          other.wordType == this.wordType &&
          other.audioPath == this.audioPath);
}

class DictionaryCompanion extends UpdateCompanion<DictionaryRow> {
  final Value<int> id;
  final Value<int?> sublessonId;
  final Value<String> nahuatlWord;
  final Value<String> spanishTranslation;
  final Value<String> wordType;
  final Value<String?> audioPath;
  const DictionaryCompanion({
    this.id = const Value.absent(),
    this.sublessonId = const Value.absent(),
    this.nahuatlWord = const Value.absent(),
    this.spanishTranslation = const Value.absent(),
    this.wordType = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  DictionaryCompanion.insert({
    this.id = const Value.absent(),
    this.sublessonId = const Value.absent(),
    required String nahuatlWord,
    required String spanishTranslation,
    required String wordType,
    this.audioPath = const Value.absent(),
  })  : nahuatlWord = Value(nahuatlWord),
        spanishTranslation = Value(spanishTranslation),
        wordType = Value(wordType);
  static Insertable<DictionaryRow> custom({
    Expression<int>? id,
    Expression<int>? sublessonId,
    Expression<String>? nahuatlWord,
    Expression<String>? spanishTranslation,
    Expression<String>? wordType,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sublessonId != null) 'sublesson_id': sublessonId,
      if (nahuatlWord != null) 'nahuatl_word': nahuatlWord,
      if (spanishTranslation != null) 'spanish_translation': spanishTranslation,
      if (wordType != null) 'word_type': wordType,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  DictionaryCompanion copyWith(
      {Value<int>? id,
      Value<int?>? sublessonId,
      Value<String>? nahuatlWord,
      Value<String>? spanishTranslation,
      Value<String>? wordType,
      Value<String?>? audioPath}) {
    return DictionaryCompanion(
      id: id ?? this.id,
      sublessonId: sublessonId ?? this.sublessonId,
      nahuatlWord: nahuatlWord ?? this.nahuatlWord,
      spanishTranslation: spanishTranslation ?? this.spanishTranslation,
      wordType: wordType ?? this.wordType,
      audioPath: audioPath ?? this.audioPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sublessonId.present) {
      map['sublesson_id'] = Variable<int>(sublessonId.value);
    }
    if (nahuatlWord.present) {
      map['nahuatl_word'] = Variable<String>(nahuatlWord.value);
    }
    if (spanishTranslation.present) {
      map['spanish_translation'] = Variable<String>(spanishTranslation.value);
    }
    if (wordType.present) {
      map['word_type'] = Variable<String>(wordType.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryCompanion(')
          ..write('id: $id, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('nahuatlWord: $nahuatlWord, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('wordType: $wordType, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }
}

class $PhrasesTable extends Phrases with TableInfo<$PhrasesTable, PhraseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhrasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
      'lesson_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES lessons (id) ON DELETE CASCADE'));
  static const VerificationMeta _sublessonIdMeta =
      const VerificationMeta('sublessonId');
  @override
  late final GeneratedColumn<int> sublessonId = GeneratedColumn<int>(
      'sublesson_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES sublessons (id) ON DELETE CASCADE'));
  static const VerificationMeta _grammarRuleIdMeta =
      const VerificationMeta('grammarRuleId');
  @override
  late final GeneratedColumn<int> grammarRuleId = GeneratedColumn<int>(
      'grammar_rule_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES grammar_rules (id) ON DELETE SET NULL'));
  static const VerificationMeta _nahuatlSentenceMeta =
      const VerificationMeta('nahuatlSentence');
  @override
  late final GeneratedColumn<String> nahuatlSentence = GeneratedColumn<String>(
      'nahuatl_sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _spanishTranslationMeta =
      const VerificationMeta('spanishTranslation');
  @override
  late final GeneratedColumn<String> spanishTranslation =
      GeneratedColumn<String>('spanish_translation', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lessonId,
        sublessonId,
        grammarRuleId,
        nahuatlSentence,
        spanishTranslation,
        audioPath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phrases';
  @override
  VerificationContext validateIntegrity(Insertable<PhraseRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    }
    if (data.containsKey('sublesson_id')) {
      context.handle(
          _sublessonIdMeta,
          sublessonId.isAcceptableOrUnknown(
              data['sublesson_id']!, _sublessonIdMeta));
    }
    if (data.containsKey('grammar_rule_id')) {
      context.handle(
          _grammarRuleIdMeta,
          grammarRuleId.isAcceptableOrUnknown(
              data['grammar_rule_id']!, _grammarRuleIdMeta));
    }
    if (data.containsKey('nahuatl_sentence')) {
      context.handle(
          _nahuatlSentenceMeta,
          nahuatlSentence.isAcceptableOrUnknown(
              data['nahuatl_sentence']!, _nahuatlSentenceMeta));
    } else if (isInserting) {
      context.missing(_nahuatlSentenceMeta);
    }
    if (data.containsKey('spanish_translation')) {
      context.handle(
          _spanishTranslationMeta,
          spanishTranslation.isAcceptableOrUnknown(
              data['spanish_translation']!, _spanishTranslationMeta));
    } else if (isInserting) {
      context.missing(_spanishTranslationMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhraseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhraseRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_id']),
      sublessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sublesson_id']),
      grammarRuleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grammar_rule_id']),
      nahuatlSentence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nahuatl_sentence'])!,
      spanishTranslation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}spanish_translation'])!,
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path']),
    );
  }

  @override
  $PhrasesTable createAlias(String alias) {
    return $PhrasesTable(attachedDatabase, alias);
  }
}

class PhraseRow extends DataClass implements Insertable<PhraseRow> {
  final int id;
  final int? lessonId;

  /// Referencia opcional a la sublección (punto de ejercicios) correspondiente.
  final int? sublessonId;
  final int? grammarRuleId;
  final String nahuatlSentence;
  final String spanishTranslation;

  /// Ruta relativa del asset de audio (ej. `assets/audio/cualli_tonalli.mp3`). Nullable para UI Defensiva.
  final String? audioPath;
  const PhraseRow(
      {required this.id,
      this.lessonId,
      this.sublessonId,
      this.grammarRuleId,
      required this.nahuatlSentence,
      required this.spanishTranslation,
      this.audioPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lessonId != null) {
      map['lesson_id'] = Variable<int>(lessonId);
    }
    if (!nullToAbsent || sublessonId != null) {
      map['sublesson_id'] = Variable<int>(sublessonId);
    }
    if (!nullToAbsent || grammarRuleId != null) {
      map['grammar_rule_id'] = Variable<int>(grammarRuleId);
    }
    map['nahuatl_sentence'] = Variable<String>(nahuatlSentence);
    map['spanish_translation'] = Variable<String>(spanishTranslation);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      lessonId: lessonId == null && nullToAbsent
          ? const Value.absent()
          : Value(lessonId),
      sublessonId: sublessonId == null && nullToAbsent
          ? const Value.absent()
          : Value(sublessonId),
      grammarRuleId: grammarRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarRuleId),
      nahuatlSentence: Value(nahuatlSentence),
      spanishTranslation: Value(spanishTranslation),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
    );
  }

  factory PhraseRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhraseRow(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int?>(json['lessonId']),
      sublessonId: serializer.fromJson<int?>(json['sublessonId']),
      grammarRuleId: serializer.fromJson<int?>(json['grammarRuleId']),
      nahuatlSentence: serializer.fromJson<String>(json['nahuatlSentence']),
      spanishTranslation:
          serializer.fromJson<String>(json['spanishTranslation']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int?>(lessonId),
      'sublessonId': serializer.toJson<int?>(sublessonId),
      'grammarRuleId': serializer.toJson<int?>(grammarRuleId),
      'nahuatlSentence': serializer.toJson<String>(nahuatlSentence),
      'spanishTranslation': serializer.toJson<String>(spanishTranslation),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  PhraseRow copyWith(
          {int? id,
          Value<int?> lessonId = const Value.absent(),
          Value<int?> sublessonId = const Value.absent(),
          Value<int?> grammarRuleId = const Value.absent(),
          String? nahuatlSentence,
          String? spanishTranslation,
          Value<String?> audioPath = const Value.absent()}) =>
      PhraseRow(
        id: id ?? this.id,
        lessonId: lessonId.present ? lessonId.value : this.lessonId,
        sublessonId: sublessonId.present ? sublessonId.value : this.sublessonId,
        grammarRuleId:
            grammarRuleId.present ? grammarRuleId.value : this.grammarRuleId,
        nahuatlSentence: nahuatlSentence ?? this.nahuatlSentence,
        spanishTranslation: spanishTranslation ?? this.spanishTranslation,
        audioPath: audioPath.present ? audioPath.value : this.audioPath,
      );
  PhraseRow copyWithCompanion(PhrasesCompanion data) {
    return PhraseRow(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      sublessonId:
          data.sublessonId.present ? data.sublessonId.value : this.sublessonId,
      grammarRuleId: data.grammarRuleId.present
          ? data.grammarRuleId.value
          : this.grammarRuleId,
      nahuatlSentence: data.nahuatlSentence.present
          ? data.nahuatlSentence.value
          : this.nahuatlSentence,
      spanishTranslation: data.spanishTranslation.present
          ? data.spanishTranslation.value
          : this.spanishTranslation,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhraseRow(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('grammarRuleId: $grammarRuleId, ')
          ..write('nahuatlSentence: $nahuatlSentence, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, sublessonId, grammarRuleId,
      nahuatlSentence, spanishTranslation, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhraseRow &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.sublessonId == this.sublessonId &&
          other.grammarRuleId == this.grammarRuleId &&
          other.nahuatlSentence == this.nahuatlSentence &&
          other.spanishTranslation == this.spanishTranslation &&
          other.audioPath == this.audioPath);
}

class PhrasesCompanion extends UpdateCompanion<PhraseRow> {
  final Value<int> id;
  final Value<int?> lessonId;
  final Value<int?> sublessonId;
  final Value<int?> grammarRuleId;
  final Value<String> nahuatlSentence;
  final Value<String> spanishTranslation;
  final Value<String?> audioPath;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.sublessonId = const Value.absent(),
    this.grammarRuleId = const Value.absent(),
    this.nahuatlSentence = const Value.absent(),
    this.spanishTranslation = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.sublessonId = const Value.absent(),
    this.grammarRuleId = const Value.absent(),
    required String nahuatlSentence,
    required String spanishTranslation,
    this.audioPath = const Value.absent(),
  })  : nahuatlSentence = Value(nahuatlSentence),
        spanishTranslation = Value(spanishTranslation);
  static Insertable<PhraseRow> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<int>? sublessonId,
    Expression<int>? grammarRuleId,
    Expression<String>? nahuatlSentence,
    Expression<String>? spanishTranslation,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (sublessonId != null) 'sublesson_id': sublessonId,
      if (grammarRuleId != null) 'grammar_rule_id': grammarRuleId,
      if (nahuatlSentence != null) 'nahuatl_sentence': nahuatlSentence,
      if (spanishTranslation != null) 'spanish_translation': spanishTranslation,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  PhrasesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? lessonId,
      Value<int?>? sublessonId,
      Value<int?>? grammarRuleId,
      Value<String>? nahuatlSentence,
      Value<String>? spanishTranslation,
      Value<String?>? audioPath}) {
    return PhrasesCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      sublessonId: sublessonId ?? this.sublessonId,
      grammarRuleId: grammarRuleId ?? this.grammarRuleId,
      nahuatlSentence: nahuatlSentence ?? this.nahuatlSentence,
      spanishTranslation: spanishTranslation ?? this.spanishTranslation,
      audioPath: audioPath ?? this.audioPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (sublessonId.present) {
      map['sublesson_id'] = Variable<int>(sublessonId.value);
    }
    if (grammarRuleId.present) {
      map['grammar_rule_id'] = Variable<int>(grammarRuleId.value);
    }
    if (nahuatlSentence.present) {
      map['nahuatl_sentence'] = Variable<String>(nahuatlSentence.value);
    }
    if (spanishTranslation.present) {
      map['spanish_translation'] = Variable<String>(spanishTranslation.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('grammarRuleId: $grammarRuleId, ')
          ..write('nahuatlSentence: $nahuatlSentence, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }
}

class $ReadingQuestionsTable extends ReadingQuestions
    with TableInfo<$ReadingQuestionsTable, ReadingQuestionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sublessonIdMeta =
      const VerificationMeta('sublessonId');
  @override
  late final GeneratedColumn<int> sublessonId = GeneratedColumn<int>(
      'sublesson_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES sublessons (id) ON DELETE CASCADE'));
  static const VerificationMeta _questionNumberMeta =
      const VerificationMeta('questionNumber');
  @override
  late final GeneratedColumn<int> questionNumber = GeneratedColumn<int>(
      'question_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _questionNahuatlMeta =
      const VerificationMeta('questionNahuatl');
  @override
  late final GeneratedColumn<String> questionNahuatl = GeneratedColumn<String>(
      'question_nahuatl', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionTranslationSpanishMeta =
      const VerificationMeta('questionTranslationSpanish');
  @override
  late final GeneratedColumn<String> questionTranslationSpanish =
      GeneratedColumn<String>('question_translation_spanish', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sublessonId,
        questionNumber,
        questionNahuatl,
        correctAnswer,
        questionTranslationSpanish,
        audioPath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_questions';
  @override
  VerificationContext validateIntegrity(Insertable<ReadingQuestionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sublesson_id')) {
      context.handle(
          _sublessonIdMeta,
          sublessonId.isAcceptableOrUnknown(
              data['sublesson_id']!, _sublessonIdMeta));
    } else if (isInserting) {
      context.missing(_sublessonIdMeta);
    }
    if (data.containsKey('question_number')) {
      context.handle(
          _questionNumberMeta,
          questionNumber.isAcceptableOrUnknown(
              data['question_number']!, _questionNumberMeta));
    }
    if (data.containsKey('question_nahuatl')) {
      context.handle(
          _questionNahuatlMeta,
          questionNahuatl.isAcceptableOrUnknown(
              data['question_nahuatl']!, _questionNahuatlMeta));
    } else if (isInserting) {
      context.missing(_questionNahuatlMeta);
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    } else if (isInserting) {
      context.missing(_correctAnswerMeta);
    }
    if (data.containsKey('question_translation_spanish')) {
      context.handle(
          _questionTranslationSpanishMeta,
          questionTranslationSpanish.isAcceptableOrUnknown(
              data['question_translation_spanish']!,
              _questionTranslationSpanishMeta));
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingQuestionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingQuestionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sublessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sublesson_id'])!,
      questionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_number']),
      questionNahuatl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_nahuatl'])!,
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer'])!,
      questionTranslationSpanish: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}question_translation_spanish']),
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path']),
    );
  }

  @override
  $ReadingQuestionsTable createAlias(String alias) {
    return $ReadingQuestionsTable(attachedDatabase, alias);
  }
}

class ReadingQuestionRow extends DataClass
    implements Insertable<ReadingQuestionRow> {
  final int id;
  final int sublessonId;
  final int? questionNumber;
  final String questionNahuatl;
  final String correctAnswer;
  final String? questionTranslationSpanish;
  final String? audioPath;
  const ReadingQuestionRow(
      {required this.id,
      required this.sublessonId,
      this.questionNumber,
      required this.questionNahuatl,
      required this.correctAnswer,
      this.questionTranslationSpanish,
      this.audioPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sublesson_id'] = Variable<int>(sublessonId);
    if (!nullToAbsent || questionNumber != null) {
      map['question_number'] = Variable<int>(questionNumber);
    }
    map['question_nahuatl'] = Variable<String>(questionNahuatl);
    map['correct_answer'] = Variable<String>(correctAnswer);
    if (!nullToAbsent || questionTranslationSpanish != null) {
      map['question_translation_spanish'] =
          Variable<String>(questionTranslationSpanish);
    }
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    return map;
  }

  ReadingQuestionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingQuestionsCompanion(
      id: Value(id),
      sublessonId: Value(sublessonId),
      questionNumber: questionNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(questionNumber),
      questionNahuatl: Value(questionNahuatl),
      correctAnswer: Value(correctAnswer),
      questionTranslationSpanish:
          questionTranslationSpanish == null && nullToAbsent
              ? const Value.absent()
              : Value(questionTranslationSpanish),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
    );
  }

  factory ReadingQuestionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingQuestionRow(
      id: serializer.fromJson<int>(json['id']),
      sublessonId: serializer.fromJson<int>(json['sublessonId']),
      questionNumber: serializer.fromJson<int?>(json['questionNumber']),
      questionNahuatl: serializer.fromJson<String>(json['questionNahuatl']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      questionTranslationSpanish:
          serializer.fromJson<String?>(json['questionTranslationSpanish']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sublessonId': serializer.toJson<int>(sublessonId),
      'questionNumber': serializer.toJson<int?>(questionNumber),
      'questionNahuatl': serializer.toJson<String>(questionNahuatl),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'questionTranslationSpanish':
          serializer.toJson<String?>(questionTranslationSpanish),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  ReadingQuestionRow copyWith(
          {int? id,
          int? sublessonId,
          Value<int?> questionNumber = const Value.absent(),
          String? questionNahuatl,
          String? correctAnswer,
          Value<String?> questionTranslationSpanish = const Value.absent(),
          Value<String?> audioPath = const Value.absent()}) =>
      ReadingQuestionRow(
        id: id ?? this.id,
        sublessonId: sublessonId ?? this.sublessonId,
        questionNumber:
            questionNumber.present ? questionNumber.value : this.questionNumber,
        questionNahuatl: questionNahuatl ?? this.questionNahuatl,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        questionTranslationSpanish: questionTranslationSpanish.present
            ? questionTranslationSpanish.value
            : this.questionTranslationSpanish,
        audioPath: audioPath.present ? audioPath.value : this.audioPath,
      );
  ReadingQuestionRow copyWithCompanion(ReadingQuestionsCompanion data) {
    return ReadingQuestionRow(
      id: data.id.present ? data.id.value : this.id,
      sublessonId:
          data.sublessonId.present ? data.sublessonId.value : this.sublessonId,
      questionNumber: data.questionNumber.present
          ? data.questionNumber.value
          : this.questionNumber,
      questionNahuatl: data.questionNahuatl.present
          ? data.questionNahuatl.value
          : this.questionNahuatl,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      questionTranslationSpanish: data.questionTranslationSpanish.present
          ? data.questionTranslationSpanish.value
          : this.questionTranslationSpanish,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingQuestionRow(')
          ..write('id: $id, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('questionNahuatl: $questionNahuatl, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('questionTranslationSpanish: $questionTranslationSpanish, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sublessonId, questionNumber,
      questionNahuatl, correctAnswer, questionTranslationSpanish, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingQuestionRow &&
          other.id == this.id &&
          other.sublessonId == this.sublessonId &&
          other.questionNumber == this.questionNumber &&
          other.questionNahuatl == this.questionNahuatl &&
          other.correctAnswer == this.correctAnswer &&
          other.questionTranslationSpanish == this.questionTranslationSpanish &&
          other.audioPath == this.audioPath);
}

class ReadingQuestionsCompanion extends UpdateCompanion<ReadingQuestionRow> {
  final Value<int> id;
  final Value<int> sublessonId;
  final Value<int?> questionNumber;
  final Value<String> questionNahuatl;
  final Value<String> correctAnswer;
  final Value<String?> questionTranslationSpanish;
  final Value<String?> audioPath;
  const ReadingQuestionsCompanion({
    this.id = const Value.absent(),
    this.sublessonId = const Value.absent(),
    this.questionNumber = const Value.absent(),
    this.questionNahuatl = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.questionTranslationSpanish = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  ReadingQuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int sublessonId,
    this.questionNumber = const Value.absent(),
    required String questionNahuatl,
    required String correctAnswer,
    this.questionTranslationSpanish = const Value.absent(),
    this.audioPath = const Value.absent(),
  })  : sublessonId = Value(sublessonId),
        questionNahuatl = Value(questionNahuatl),
        correctAnswer = Value(correctAnswer);
  static Insertable<ReadingQuestionRow> custom({
    Expression<int>? id,
    Expression<int>? sublessonId,
    Expression<int>? questionNumber,
    Expression<String>? questionNahuatl,
    Expression<String>? correctAnswer,
    Expression<String>? questionTranslationSpanish,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sublessonId != null) 'sublesson_id': sublessonId,
      if (questionNumber != null) 'question_number': questionNumber,
      if (questionNahuatl != null) 'question_nahuatl': questionNahuatl,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (questionTranslationSpanish != null)
        'question_translation_spanish': questionTranslationSpanish,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  ReadingQuestionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sublessonId,
      Value<int?>? questionNumber,
      Value<String>? questionNahuatl,
      Value<String>? correctAnswer,
      Value<String?>? questionTranslationSpanish,
      Value<String?>? audioPath}) {
    return ReadingQuestionsCompanion(
      id: id ?? this.id,
      sublessonId: sublessonId ?? this.sublessonId,
      questionNumber: questionNumber ?? this.questionNumber,
      questionNahuatl: questionNahuatl ?? this.questionNahuatl,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      questionTranslationSpanish:
          questionTranslationSpanish ?? this.questionTranslationSpanish,
      audioPath: audioPath ?? this.audioPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sublessonId.present) {
      map['sublesson_id'] = Variable<int>(sublessonId.value);
    }
    if (questionNumber.present) {
      map['question_number'] = Variable<int>(questionNumber.value);
    }
    if (questionNahuatl.present) {
      map['question_nahuatl'] = Variable<String>(questionNahuatl.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (questionTranslationSpanish.present) {
      map['question_translation_spanish'] =
          Variable<String>(questionTranslationSpanish.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('sublessonId: $sublessonId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('questionNahuatl: $questionNahuatl, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('questionTranslationSpanish: $questionTranslationSpanish, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $SublessonsTable sublessons = $SublessonsTable(this);
  late final $GrammarRulesTable grammarRules = $GrammarRulesTable(this);
  late final $DictionaryTable dictionary = $DictionaryTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  late final $ReadingQuestionsTable readingQuestions =
      $ReadingQuestionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        lessons,
        sublessons,
        grammarRules,
        dictionary,
        phrases,
        readingQuestions
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('lessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sublessons', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('lessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('grammar_rules', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sublessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('dictionary', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('lessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('phrases', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sublessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('phrases', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('grammar_rules',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('phrases', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('sublessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reading_questions', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$LessonsTableCreateCompanionBuilder = LessonsCompanion Function({
  Value<int> id,
  Value<String?> romanNumber,
  required String title,
  Value<String?> description,
  required int orderIndex,
  Value<bool> isUnlocked,
  Value<bool> isCompleted,
});
typedef $$LessonsTableUpdateCompanionBuilder = LessonsCompanion Function({
  Value<int> id,
  Value<String?> romanNumber,
  Value<String> title,
  Value<String?> description,
  Value<int> orderIndex,
  Value<bool> isUnlocked,
  Value<bool> isCompleted,
});

class $$LessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonsTable,
    LessonRow,
    $$LessonsTableFilterComposer,
    $$LessonsTableOrderingComposer,
    $$LessonsTableCreateCompanionBuilder,
    $$LessonsTableUpdateCompanionBuilder> {
  $$LessonsTableTableManager(_$AppDatabase db, $LessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LessonsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LessonsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> romanNumber = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              LessonsCompanion(
            id: id,
            romanNumber: romanNumber,
            title: title,
            description: description,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
            isCompleted: isCompleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> romanNumber = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required int orderIndex,
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              LessonsCompanion.insert(
            id: id,
            romanNumber: romanNumber,
            title: title,
            description: description,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
            isCompleted: isCompleted,
          ),
        ));
}

class $$LessonsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get romanNumber => $state.composableBuilder(
      column: $state.table.romanNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isUnlocked => $state.composableBuilder(
      column: $state.table.isUnlocked,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter sublessonsRefs(
      ComposableFilter Function($$SublessonsTableFilterComposer f) f) {
    final $$SublessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.lessonId,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableFilterComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter grammarRulesRefs(
      ComposableFilter Function($$GrammarRulesTableFilterComposer f) f) {
    final $$GrammarRulesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.grammarRules,
        getReferencedColumn: (t) => t.lessonId,
        builder: (joinBuilder, parentComposers) =>
            $$GrammarRulesTableFilterComposer(ComposerState($state.db,
                $state.db.grammarRules, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter phrasesRefs(
      ComposableFilter Function($$PhrasesTableFilterComposer f) f) {
    final $$PhrasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.phrases,
        getReferencedColumn: (t) => t.lessonId,
        builder: (joinBuilder, parentComposers) => $$PhrasesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.phrases, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$LessonsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get romanNumber => $state.composableBuilder(
      column: $state.table.romanNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isUnlocked => $state.composableBuilder(
      column: $state.table.isUnlocked,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SublessonsTableCreateCompanionBuilder = SublessonsCompanion Function({
  Value<int> id,
  required int lessonId,
  required String pointNumber,
  required String title,
  required String type,
  Value<String?> theoryContent,
  required int orderIndex,
  Value<bool> isUnlocked,
  Value<bool> isCompleted,
});
typedef $$SublessonsTableUpdateCompanionBuilder = SublessonsCompanion Function({
  Value<int> id,
  Value<int> lessonId,
  Value<String> pointNumber,
  Value<String> title,
  Value<String> type,
  Value<String?> theoryContent,
  Value<int> orderIndex,
  Value<bool> isUnlocked,
  Value<bool> isCompleted,
});

class $$SublessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SublessonsTable,
    SublessonRow,
    $$SublessonsTableFilterComposer,
    $$SublessonsTableOrderingComposer,
    $$SublessonsTableCreateCompanionBuilder,
    $$SublessonsTableUpdateCompanionBuilder> {
  $$SublessonsTableTableManager(_$AppDatabase db, $SublessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SublessonsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SublessonsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> lessonId = const Value.absent(),
            Value<String> pointNumber = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> theoryContent = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              SublessonsCompanion(
            id: id,
            lessonId: lessonId,
            pointNumber: pointNumber,
            title: title,
            type: type,
            theoryContent: theoryContent,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
            isCompleted: isCompleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int lessonId,
            required String pointNumber,
            required String title,
            required String type,
            Value<String?> theoryContent = const Value.absent(),
            required int orderIndex,
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              SublessonsCompanion.insert(
            id: id,
            lessonId: lessonId,
            pointNumber: pointNumber,
            title: title,
            type: type,
            theoryContent: theoryContent,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
            isCompleted: isCompleted,
          ),
        ));
}

class $$SublessonsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SublessonsTable> {
  $$SublessonsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pointNumber => $state.composableBuilder(
      column: $state.table.pointNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get theoryContent => $state.composableBuilder(
      column: $state.table.theoryContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isUnlocked => $state.composableBuilder(
      column: $state.table.isUnlocked,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$LessonsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter dictionaryRefs(
      ComposableFilter Function($$DictionaryTableFilterComposer f) f) {
    final $$DictionaryTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.dictionary,
        getReferencedColumn: (t) => t.sublessonId,
        builder: (joinBuilder, parentComposers) =>
            $$DictionaryTableFilterComposer(ComposerState($state.db,
                $state.db.dictionary, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter phrasesRefs(
      ComposableFilter Function($$PhrasesTableFilterComposer f) f) {
    final $$PhrasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.phrases,
        getReferencedColumn: (t) => t.sublessonId,
        builder: (joinBuilder, parentComposers) => $$PhrasesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.phrases, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter readingQuestionsRefs(
      ComposableFilter Function($$ReadingQuestionsTableFilterComposer f) f) {
    final $$ReadingQuestionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.readingQuestions,
            getReferencedColumn: (t) => t.sublessonId,
            builder: (joinBuilder, parentComposers) =>
                $$ReadingQuestionsTableFilterComposer(ComposerState($state.db,
                    $state.db.readingQuestions, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SublessonsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SublessonsTable> {
  $$SublessonsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pointNumber => $state.composableBuilder(
      column: $state.table.pointNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get theoryContent => $state.composableBuilder(
      column: $state.table.theoryContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isUnlocked => $state.composableBuilder(
      column: $state.table.isUnlocked,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$LessonsTableOrderingComposer(ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$GrammarRulesTableCreateCompanionBuilder = GrammarRulesCompanion
    Function({
  Value<int> id,
  required int lessonId,
  required String explanationText,
});
typedef $$GrammarRulesTableUpdateCompanionBuilder = GrammarRulesCompanion
    Function({
  Value<int> id,
  Value<int> lessonId,
  Value<String> explanationText,
});

class $$GrammarRulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrammarRulesTable,
    GrammarRuleRow,
    $$GrammarRulesTableFilterComposer,
    $$GrammarRulesTableOrderingComposer,
    $$GrammarRulesTableCreateCompanionBuilder,
    $$GrammarRulesTableUpdateCompanionBuilder> {
  $$GrammarRulesTableTableManager(_$AppDatabase db, $GrammarRulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GrammarRulesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GrammarRulesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> lessonId = const Value.absent(),
            Value<String> explanationText = const Value.absent(),
          }) =>
              GrammarRulesCompanion(
            id: id,
            lessonId: lessonId,
            explanationText: explanationText,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int lessonId,
            required String explanationText,
          }) =>
              GrammarRulesCompanion.insert(
            id: id,
            lessonId: lessonId,
            explanationText: explanationText,
          ),
        ));
}

class $$GrammarRulesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $GrammarRulesTable> {
  $$GrammarRulesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get explanationText => $state.composableBuilder(
      column: $state.table.explanationText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$LessonsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter phrasesRefs(
      ComposableFilter Function($$PhrasesTableFilterComposer f) f) {
    final $$PhrasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.phrases,
        getReferencedColumn: (t) => t.grammarRuleId,
        builder: (joinBuilder, parentComposers) => $$PhrasesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.phrases, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$GrammarRulesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $GrammarRulesTable> {
  $$GrammarRulesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get explanationText => $state.composableBuilder(
      column: $state.table.explanationText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$LessonsTableOrderingComposer(ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$DictionaryTableCreateCompanionBuilder = DictionaryCompanion Function({
  Value<int> id,
  Value<int?> sublessonId,
  required String nahuatlWord,
  required String spanishTranslation,
  required String wordType,
  Value<String?> audioPath,
});
typedef $$DictionaryTableUpdateCompanionBuilder = DictionaryCompanion Function({
  Value<int> id,
  Value<int?> sublessonId,
  Value<String> nahuatlWord,
  Value<String> spanishTranslation,
  Value<String> wordType,
  Value<String?> audioPath,
});

class $$DictionaryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DictionaryTable,
    DictionaryRow,
    $$DictionaryTableFilterComposer,
    $$DictionaryTableOrderingComposer,
    $$DictionaryTableCreateCompanionBuilder,
    $$DictionaryTableUpdateCompanionBuilder> {
  $$DictionaryTableTableManager(_$AppDatabase db, $DictionaryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DictionaryTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DictionaryTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> sublessonId = const Value.absent(),
            Value<String> nahuatlWord = const Value.absent(),
            Value<String> spanishTranslation = const Value.absent(),
            Value<String> wordType = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              DictionaryCompanion(
            id: id,
            sublessonId: sublessonId,
            nahuatlWord: nahuatlWord,
            spanishTranslation: spanishTranslation,
            wordType: wordType,
            audioPath: audioPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> sublessonId = const Value.absent(),
            required String nahuatlWord,
            required String spanishTranslation,
            required String wordType,
            Value<String?> audioPath = const Value.absent(),
          }) =>
              DictionaryCompanion.insert(
            id: id,
            sublessonId: sublessonId,
            nahuatlWord: nahuatlWord,
            spanishTranslation: spanishTranslation,
            wordType: wordType,
            audioPath: audioPath,
          ),
        ));
}

class $$DictionaryTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DictionaryTable> {
  $$DictionaryTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nahuatlWord => $state.composableBuilder(
      column: $state.table.nahuatlWord,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get spanishTranslation => $state.composableBuilder(
      column: $state.table.spanishTranslation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get wordType => $state.composableBuilder(
      column: $state.table.wordType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SublessonsTableFilterComposer get sublessonId {
    final $$SublessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableFilterComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$DictionaryTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DictionaryTable> {
  $$DictionaryTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nahuatlWord => $state.composableBuilder(
      column: $state.table.nahuatlWord,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get spanishTranslation => $state.composableBuilder(
      column: $state.table.spanishTranslation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get wordType => $state.composableBuilder(
      column: $state.table.wordType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SublessonsTableOrderingComposer get sublessonId {
    final $$SublessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableOrderingComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PhrasesTableCreateCompanionBuilder = PhrasesCompanion Function({
  Value<int> id,
  Value<int?> lessonId,
  Value<int?> sublessonId,
  Value<int?> grammarRuleId,
  required String nahuatlSentence,
  required String spanishTranslation,
  Value<String?> audioPath,
});
typedef $$PhrasesTableUpdateCompanionBuilder = PhrasesCompanion Function({
  Value<int> id,
  Value<int?> lessonId,
  Value<int?> sublessonId,
  Value<int?> grammarRuleId,
  Value<String> nahuatlSentence,
  Value<String> spanishTranslation,
  Value<String?> audioPath,
});

class $$PhrasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhrasesTable,
    PhraseRow,
    $$PhrasesTableFilterComposer,
    $$PhrasesTableOrderingComposer,
    $$PhrasesTableCreateCompanionBuilder,
    $$PhrasesTableUpdateCompanionBuilder> {
  $$PhrasesTableTableManager(_$AppDatabase db, $PhrasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhrasesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PhrasesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> lessonId = const Value.absent(),
            Value<int?> sublessonId = const Value.absent(),
            Value<int?> grammarRuleId = const Value.absent(),
            Value<String> nahuatlSentence = const Value.absent(),
            Value<String> spanishTranslation = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              PhrasesCompanion(
            id: id,
            lessonId: lessonId,
            sublessonId: sublessonId,
            grammarRuleId: grammarRuleId,
            nahuatlSentence: nahuatlSentence,
            spanishTranslation: spanishTranslation,
            audioPath: audioPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> lessonId = const Value.absent(),
            Value<int?> sublessonId = const Value.absent(),
            Value<int?> grammarRuleId = const Value.absent(),
            required String nahuatlSentence,
            required String spanishTranslation,
            Value<String?> audioPath = const Value.absent(),
          }) =>
              PhrasesCompanion.insert(
            id: id,
            lessonId: lessonId,
            sublessonId: sublessonId,
            grammarRuleId: grammarRuleId,
            nahuatlSentence: nahuatlSentence,
            spanishTranslation: spanishTranslation,
            audioPath: audioPath,
          ),
        ));
}

class $$PhrasesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nahuatlSentence => $state.composableBuilder(
      column: $state.table.nahuatlSentence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get spanishTranslation => $state.composableBuilder(
      column: $state.table.spanishTranslation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$LessonsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }

  $$SublessonsTableFilterComposer get sublessonId {
    final $$SublessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableFilterComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }

  $$GrammarRulesTableFilterComposer get grammarRuleId {
    final $$GrammarRulesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.grammarRuleId,
        referencedTable: $state.db.grammarRules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$GrammarRulesTableFilterComposer(ComposerState($state.db,
                $state.db.grammarRules, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PhrasesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhrasesTable> {
  $$PhrasesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nahuatlSentence => $state.composableBuilder(
      column: $state.table.nahuatlSentence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get spanishTranslation => $state.composableBuilder(
      column: $state.table.spanishTranslation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonId,
        referencedTable: $state.db.lessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$LessonsTableOrderingComposer(ComposerState(
                $state.db, $state.db.lessons, joinBuilder, parentComposers)));
    return composer;
  }

  $$SublessonsTableOrderingComposer get sublessonId {
    final $$SublessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableOrderingComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }

  $$GrammarRulesTableOrderingComposer get grammarRuleId {
    final $$GrammarRulesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.grammarRuleId,
        referencedTable: $state.db.grammarRules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$GrammarRulesTableOrderingComposer(ComposerState($state.db,
                $state.db.grammarRules, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ReadingQuestionsTableCreateCompanionBuilder
    = ReadingQuestionsCompanion Function({
  Value<int> id,
  required int sublessonId,
  Value<int?> questionNumber,
  required String questionNahuatl,
  required String correctAnswer,
  Value<String?> questionTranslationSpanish,
  Value<String?> audioPath,
});
typedef $$ReadingQuestionsTableUpdateCompanionBuilder
    = ReadingQuestionsCompanion Function({
  Value<int> id,
  Value<int> sublessonId,
  Value<int?> questionNumber,
  Value<String> questionNahuatl,
  Value<String> correctAnswer,
  Value<String?> questionTranslationSpanish,
  Value<String?> audioPath,
});

class $$ReadingQuestionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingQuestionsTable,
    ReadingQuestionRow,
    $$ReadingQuestionsTableFilterComposer,
    $$ReadingQuestionsTableOrderingComposer,
    $$ReadingQuestionsTableCreateCompanionBuilder,
    $$ReadingQuestionsTableUpdateCompanionBuilder> {
  $$ReadingQuestionsTableTableManager(
      _$AppDatabase db, $ReadingQuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReadingQuestionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReadingQuestionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sublessonId = const Value.absent(),
            Value<int?> questionNumber = const Value.absent(),
            Value<String> questionNahuatl = const Value.absent(),
            Value<String> correctAnswer = const Value.absent(),
            Value<String?> questionTranslationSpanish = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              ReadingQuestionsCompanion(
            id: id,
            sublessonId: sublessonId,
            questionNumber: questionNumber,
            questionNahuatl: questionNahuatl,
            correctAnswer: correctAnswer,
            questionTranslationSpanish: questionTranslationSpanish,
            audioPath: audioPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sublessonId,
            Value<int?> questionNumber = const Value.absent(),
            required String questionNahuatl,
            required String correctAnswer,
            Value<String?> questionTranslationSpanish = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              ReadingQuestionsCompanion.insert(
            id: id,
            sublessonId: sublessonId,
            questionNumber: questionNumber,
            questionNahuatl: questionNahuatl,
            correctAnswer: correctAnswer,
            questionTranslationSpanish: questionTranslationSpanish,
            audioPath: audioPath,
          ),
        ));
}

class $$ReadingQuestionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReadingQuestionsTable> {
  $$ReadingQuestionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get questionNumber => $state.composableBuilder(
      column: $state.table.questionNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionNahuatl => $state.composableBuilder(
      column: $state.table.questionNahuatl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get correctAnswer => $state.composableBuilder(
      column: $state.table.correctAnswer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionTranslationSpanish =>
      $state.composableBuilder(
          column: $state.table.questionTranslationSpanish,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SublessonsTableFilterComposer get sublessonId {
    final $$SublessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableFilterComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ReadingQuestionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReadingQuestionsTable> {
  $$ReadingQuestionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get questionNumber => $state.composableBuilder(
      column: $state.table.questionNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionNahuatl => $state.composableBuilder(
      column: $state.table.questionNahuatl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get correctAnswer => $state.composableBuilder(
      column: $state.table.correctAnswer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionTranslationSpanish =>
      $state.composableBuilder(
          column: $state.table.questionTranslationSpanish,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SublessonsTableOrderingComposer get sublessonId {
    final $$SublessonsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sublessonId,
        referencedTable: $state.db.sublessons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SublessonsTableOrderingComposer(ComposerState($state.db,
                $state.db.sublessons, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LessonsTableTableManager get lessons =>
      $$LessonsTableTableManager(_db, _db.lessons);
  $$SublessonsTableTableManager get sublessons =>
      $$SublessonsTableTableManager(_db, _db.sublessons);
  $$GrammarRulesTableTableManager get grammarRules =>
      $$GrammarRulesTableTableManager(_db, _db.grammarRules);
  $$DictionaryTableTableManager get dictionary =>
      $$DictionaryTableTableManager(_db, _db.dictionary);
  $$PhrasesTableTableManager get phrases =>
      $$PhrasesTableTableManager(_db, _db.phrases);
  $$ReadingQuestionsTableTableManager get readingQuestions =>
      $$ReadingQuestionsTableTableManager(_db, _db.readingQuestions);
}
