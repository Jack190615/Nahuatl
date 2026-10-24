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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, title, orderIndex, isUnlocked];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
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
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      isUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unlocked'])!,
    );
  }

  @override
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class LessonRow extends DataClass implements Insertable<LessonRow> {
  final int id;
  final String title;
  final int orderIndex;
  final bool isUnlocked;
  const LessonRow(
      {required this.id,
      required this.title,
      required this.orderIndex,
      required this.isUnlocked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['order_index'] = Variable<int>(orderIndex);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      title: Value(title),
      orderIndex: Value(orderIndex),
      isUnlocked: Value(isUnlocked),
    );
  }

  factory LessonRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
    };
  }

  LessonRow copyWith(
          {int? id, String? title, int? orderIndex, bool? isUnlocked}) =>
      LessonRow(
        id: id ?? this.id,
        title: title ?? this.title,
        orderIndex: orderIndex ?? this.orderIndex,
        isUnlocked: isUnlocked ?? this.isUnlocked,
      );
  LessonRow copyWithCompanion(LessonsCompanion data) {
    return LessonRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, orderIndex, isUnlocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.orderIndex == this.orderIndex &&
          other.isUnlocked == this.isUnlocked);
}

class LessonsCompanion extends UpdateCompanion<LessonRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> orderIndex;
  final Value<bool> isUnlocked;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.isUnlocked = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int orderIndex,
    this.isUnlocked = const Value.absent(),
  })  : title = Value(title),
        orderIndex = Value(orderIndex);
  static Insertable<LessonRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? orderIndex,
    Expression<bool>? isUnlocked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (orderIndex != null) 'order_index': orderIndex,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? orderIndex,
      Value<bool>? isUnlocked}) {
    return LessonsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('isUnlocked: $isUnlocked')
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
      [id, nahuatlWord, spanishTranslation, wordType, audioPath];
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
  final String nahuatlWord;
  final String spanishTranslation;

  /// Tipo gramatical: 'sustantivo', 'verbo', 'partícula', 'adjetivo', 'pronombre', etc.
  final String wordType;

  /// Ruta relativa del asset de audio (ej. `assets/audio/atl.mp3`). Nullable para UI Defensiva.
  final String? audioPath;
  const DictionaryRow(
      {required this.id,
      required this.nahuatlWord,
      required this.spanishTranslation,
      required this.wordType,
      this.audioPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
      'nahuatlWord': serializer.toJson<String>(nahuatlWord),
      'spanishTranslation': serializer.toJson<String>(spanishTranslation),
      'wordType': serializer.toJson<String>(wordType),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  DictionaryRow copyWith(
          {int? id,
          String? nahuatlWord,
          String? spanishTranslation,
          String? wordType,
          Value<String?> audioPath = const Value.absent()}) =>
      DictionaryRow(
        id: id ?? this.id,
        nahuatlWord: nahuatlWord ?? this.nahuatlWord,
        spanishTranslation: spanishTranslation ?? this.spanishTranslation,
        wordType: wordType ?? this.wordType,
        audioPath: audioPath.present ? audioPath.value : this.audioPath,
      );
  DictionaryRow copyWithCompanion(DictionaryCompanion data) {
    return DictionaryRow(
      id: data.id.present ? data.id.value : this.id,
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
          ..write('nahuatlWord: $nahuatlWord, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('wordType: $wordType, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nahuatlWord, spanishTranslation, wordType, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryRow &&
          other.id == this.id &&
          other.nahuatlWord == this.nahuatlWord &&
          other.spanishTranslation == this.spanishTranslation &&
          other.wordType == this.wordType &&
          other.audioPath == this.audioPath);
}

class DictionaryCompanion extends UpdateCompanion<DictionaryRow> {
  final Value<int> id;
  final Value<String> nahuatlWord;
  final Value<String> spanishTranslation;
  final Value<String> wordType;
  final Value<String?> audioPath;
  const DictionaryCompanion({
    this.id = const Value.absent(),
    this.nahuatlWord = const Value.absent(),
    this.spanishTranslation = const Value.absent(),
    this.wordType = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  DictionaryCompanion.insert({
    this.id = const Value.absent(),
    required String nahuatlWord,
    required String spanishTranslation,
    required String wordType,
    this.audioPath = const Value.absent(),
  })  : nahuatlWord = Value(nahuatlWord),
        spanishTranslation = Value(spanishTranslation),
        wordType = Value(wordType);
  static Insertable<DictionaryRow> custom({
    Expression<int>? id,
    Expression<String>? nahuatlWord,
    Expression<String>? spanishTranslation,
    Expression<String>? wordType,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nahuatlWord != null) 'nahuatl_word': nahuatlWord,
      if (spanishTranslation != null) 'spanish_translation': spanishTranslation,
      if (wordType != null) 'word_type': wordType,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  DictionaryCompanion copyWith(
      {Value<int>? id,
      Value<String>? nahuatlWord,
      Value<String>? spanishTranslation,
      Value<String>? wordType,
      Value<String?>? audioPath}) {
    return DictionaryCompanion(
      id: id ?? this.id,
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
      'lesson_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES lessons (id) ON DELETE CASCADE'));
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
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_id'])!,
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
  final int lessonId;
  final int? grammarRuleId;
  final String nahuatlSentence;
  final String spanishTranslation;

  /// Ruta relativa del asset de audio (ej. `assets/audio/cualli_tonalli.mp3`). Nullable para UI Defensiva.
  final String? audioPath;
  const PhraseRow(
      {required this.id,
      required this.lessonId,
      this.grammarRuleId,
      required this.nahuatlSentence,
      required this.spanishTranslation,
      this.audioPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
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
      lessonId: Value(lessonId),
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
      lessonId: serializer.fromJson<int>(json['lessonId']),
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
      'lessonId': serializer.toJson<int>(lessonId),
      'grammarRuleId': serializer.toJson<int?>(grammarRuleId),
      'nahuatlSentence': serializer.toJson<String>(nahuatlSentence),
      'spanishTranslation': serializer.toJson<String>(spanishTranslation),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  PhraseRow copyWith(
          {int? id,
          int? lessonId,
          Value<int?> grammarRuleId = const Value.absent(),
          String? nahuatlSentence,
          String? spanishTranslation,
          Value<String?> audioPath = const Value.absent()}) =>
      PhraseRow(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
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
          ..write('grammarRuleId: $grammarRuleId, ')
          ..write('nahuatlSentence: $nahuatlSentence, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, grammarRuleId, nahuatlSentence,
      spanishTranslation, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhraseRow &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.grammarRuleId == this.grammarRuleId &&
          other.nahuatlSentence == this.nahuatlSentence &&
          other.spanishTranslation == this.spanishTranslation &&
          other.audioPath == this.audioPath);
}

class PhrasesCompanion extends UpdateCompanion<PhraseRow> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<int?> grammarRuleId;
  final Value<String> nahuatlSentence;
  final Value<String> spanishTranslation;
  final Value<String?> audioPath;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.grammarRuleId = const Value.absent(),
    this.nahuatlSentence = const Value.absent(),
    this.spanishTranslation = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    this.grammarRuleId = const Value.absent(),
    required String nahuatlSentence,
    required String spanishTranslation,
    this.audioPath = const Value.absent(),
  })  : lessonId = Value(lessonId),
        nahuatlSentence = Value(nahuatlSentence),
        spanishTranslation = Value(spanishTranslation);
  static Insertable<PhraseRow> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<int>? grammarRuleId,
    Expression<String>? nahuatlSentence,
    Expression<String>? spanishTranslation,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (grammarRuleId != null) 'grammar_rule_id': grammarRuleId,
      if (nahuatlSentence != null) 'nahuatl_sentence': nahuatlSentence,
      if (spanishTranslation != null) 'spanish_translation': spanishTranslation,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  PhrasesCompanion copyWith(
      {Value<int>? id,
      Value<int>? lessonId,
      Value<int?>? grammarRuleId,
      Value<String>? nahuatlSentence,
      Value<String>? spanishTranslation,
      Value<String?>? audioPath}) {
    return PhrasesCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
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
          ..write('grammarRuleId: $grammarRuleId, ')
          ..write('nahuatlSentence: $nahuatlSentence, ')
          ..write('spanishTranslation: $spanishTranslation, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $GrammarRulesTable grammarRules = $GrammarRulesTable(this);
  late final $DictionaryTable dictionary = $DictionaryTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [lessons, grammarRules, dictionary, phrases];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('lessons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('grammar_rules', kind: UpdateKind.delete),
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
            on: TableUpdateQuery.onTableName('grammar_rules',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('phrases', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$LessonsTableCreateCompanionBuilder = LessonsCompanion Function({
  Value<int> id,
  required String title,
  required int orderIndex,
  Value<bool> isUnlocked,
});
typedef $$LessonsTableUpdateCompanionBuilder = LessonsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> orderIndex,
  Value<bool> isUnlocked,
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
            Value<String> title = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
          }) =>
              LessonsCompanion(
            id: id,
            title: title,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int orderIndex,
            Value<bool> isUnlocked = const Value.absent(),
          }) =>
              LessonsCompanion.insert(
            id: id,
            title: title,
            orderIndex: orderIndex,
            isUnlocked: isUnlocked,
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

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
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

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
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
  required String nahuatlWord,
  required String spanishTranslation,
  required String wordType,
  Value<String?> audioPath,
});
typedef $$DictionaryTableUpdateCompanionBuilder = DictionaryCompanion Function({
  Value<int> id,
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
            Value<String> nahuatlWord = const Value.absent(),
            Value<String> spanishTranslation = const Value.absent(),
            Value<String> wordType = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              DictionaryCompanion(
            id: id,
            nahuatlWord: nahuatlWord,
            spanishTranslation: spanishTranslation,
            wordType: wordType,
            audioPath: audioPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nahuatlWord,
            required String spanishTranslation,
            required String wordType,
            Value<String?> audioPath = const Value.absent(),
          }) =>
              DictionaryCompanion.insert(
            id: id,
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
}

typedef $$PhrasesTableCreateCompanionBuilder = PhrasesCompanion Function({
  Value<int> id,
  required int lessonId,
  Value<int?> grammarRuleId,
  required String nahuatlSentence,
  required String spanishTranslation,
  Value<String?> audioPath,
});
typedef $$PhrasesTableUpdateCompanionBuilder = PhrasesCompanion Function({
  Value<int> id,
  Value<int> lessonId,
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
            Value<int> lessonId = const Value.absent(),
            Value<int?> grammarRuleId = const Value.absent(),
            Value<String> nahuatlSentence = const Value.absent(),
            Value<String> spanishTranslation = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
          }) =>
              PhrasesCompanion(
            id: id,
            lessonId: lessonId,
            grammarRuleId: grammarRuleId,
            nahuatlSentence: nahuatlSentence,
            spanishTranslation: spanishTranslation,
            audioPath: audioPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int lessonId,
            Value<int?> grammarRuleId = const Value.absent(),
            required String nahuatlSentence,
            required String spanishTranslation,
            Value<String?> audioPath = const Value.absent(),
          }) =>
              PhrasesCompanion.insert(
            id: id,
            lessonId: lessonId,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LessonsTableTableManager get lessons =>
      $$LessonsTableTableManager(_db, _db.lessons);
  $$GrammarRulesTableTableManager get grammarRules =>
      $$GrammarRulesTableTableManager(_db, _db.grammarRules);
  $$DictionaryTableTableManager get dictionary =>
      $$DictionaryTableTableManager(_db, _db.dictionary);
  $$PhrasesTableTableManager get phrases =>
      $$PhrasesTableTableManager(_db, _db.phrases);
}
