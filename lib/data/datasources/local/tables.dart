import 'package:drift/drift.dart';

/// Tabla de Lecciones (`lessons`).
@DataClassName('LessonRow')
class Lessons extends Table {
  @override
  String get tableName => 'lessons';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 160)();

  IntColumn get orderIndex => integer().named('order_index')();

  BoolColumn get isUnlocked =>
      boolean().named('is_unlocked').withDefault(const Constant(false))();
}

/// Tabla de Reglas Gramaticales (`grammar_rules`).
@DataClassName('GrammarRuleRow')
class GrammarRules extends Table {
  @override
  String get tableName => 'grammar_rules';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get lessonId => integer()
      .named('lesson_id')
      .references(Lessons, #id, onDelete: KeyAction.cascade)();

  TextColumn get explanationText => text().named('explanation_text')();
}

/// Tabla de Diccionario (`dictionary`).
/// Cuenta con soporte de índice FTS5 nativo de SQLite mediante la tabla virtual `dictionary_fts`
/// sincronizada por triggers (`AFTER INSERT`, `AFTER DELETE`, `AFTER UPDATE`).
@DataClassName('DictionaryRow')
class Dictionary extends Table {
  @override
  String get tableName => 'dictionary';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get nahuatlWord => text().named('nahuatl_word')();

  TextColumn get spanishTranslation => text().named('spanish_translation')();

  /// Tipo gramatical: 'sustantivo', 'verbo', 'partícula', 'adjetivo', 'pronombre', etc.
  TextColumn get wordType => text().named('word_type')();

  /// Ruta relativa del asset de audio (ej. `assets/audio/atl.mp3`). Nullable para UI Defensiva.
  TextColumn get audioPath => text().named('audio_path').nullable()();
}

/// Tabla de Frases / Oraciones (`phrases`).
@DataClassName('PhraseRow')
class Phrases extends Table {
  @override
  String get tableName => 'phrases';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get lessonId => integer()
      .named('lesson_id')
      .references(Lessons, #id, onDelete: KeyAction.cascade)();

  IntColumn get grammarRuleId => integer()
      .named('grammar_rule_id')
      .nullable()
      .references(GrammarRules, #id, onDelete: KeyAction.setNull)();

  TextColumn get nahuatlSentence => text().named('nahuatl_sentence')();

  TextColumn get spanishTranslation => text().named('spanish_translation')();

  /// Ruta relativa del asset de audio (ej. `assets/audio/cualli_tonalli.mp3`). Nullable para UI Defensiva.
  TextColumn get audioPath => text().named('audio_path').nullable()();
}
