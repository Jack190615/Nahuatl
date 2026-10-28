import 'package:drift/drift.dart';

/// Tabla de Lecciones (`lessons`).
/// Representa los grandes capítulos del curso (ej. Lección I, Lección II, Lección III).
@DataClassName('LessonRow')
class Lessons extends Table {
  @override
  String get tableName => 'lessons';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get romanNumber =>
      text().named('roman_number').nullable()();

  TextColumn get title => text().withLength(min: 1, max: 160)();

  TextColumn get description =>
      text().named('description').nullable()();

  IntColumn get orderIndex => integer().named('order_index')();

  BoolColumn get isUnlocked =>
      boolean().named('is_unlocked').withDefault(const Constant(false))();

  BoolColumn get isCompleted =>
      boolean().named('is_completed').withDefault(const Constant(false))();
}

/// Tabla de Sublecciones / Puntos del Libro (`sublessons`).
/// Representa cada punto o subdivisión pedagógica (ej. Punto 4, Punto 5, Punto 6, Puntos 7-9...).
@DataClassName('SublessonRow')
class Sublessons extends Table {
  @override
  String get tableName => 'sublessons';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get lessonId => integer()
      .named('lesson_id')
      .references(Lessons, #id, onDelete: KeyAction.cascade)();

  /// Número o rango de punto en el libro (ej. "4", "5", "6", "7-9", "10", "11").
  TextColumn get pointNumber => text().named('point_number')();

  TextColumn get title => text().withLength(min: 1, max: 180)();

  /// Tipo de contenido: 'teoria', 'vocabulario', 'frases'.
  TextColumn get type => text().withLength(min: 1, max: 40)();

  /// Contenido explicativo en caso de ser punto teórico.
  TextColumn get theoryContent =>
      text().named('theory_content').nullable()();

  IntColumn get orderIndex => integer().named('order_index')();

  BoolColumn get isUnlocked =>
      boolean().named('is_unlocked').withDefault(const Constant(false))();

  BoolColumn get isCompleted =>
      boolean().named('is_completed').withDefault(const Constant(false))();
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

  /// Referencia opcional a la sublección donde se introduce por primera vez este vocablo.
  IntColumn get sublessonId => integer()
      .named('sublesson_id')
      .nullable()
      .references(Sublessons, #id, onDelete: KeyAction.setNull)();

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
      .nullable()
      .references(Lessons, #id, onDelete: KeyAction.cascade)();

  /// Referencia opcional a la sublección (punto de ejercicios) correspondiente.
  IntColumn get sublessonId => integer()
      .named('sublesson_id')
      .nullable()
      .references(Sublessons, #id, onDelete: KeyAction.cascade)();

  IntColumn get grammarRuleId => integer()
      .named('grammar_rule_id')
      .nullable()
      .references(GrammarRules, #id, onDelete: KeyAction.setNull)();

  TextColumn get nahuatlSentence => text().named('nahuatl_sentence')();

  TextColumn get spanishTranslation => text().named('spanish_translation')();

  /// Ruta relativa del asset de audio (ej. `assets/audio/cualli_tonalli.mp3`). Nullable para UI Defensiva.
  TextColumn get audioPath => text().named('audio_path').nullable()();
}

/// Tabla de Preguntas de Comprensión de Lectura (`reading_questions`).
@DataClassName('ReadingQuestionRow')
class ReadingQuestions extends Table {
  @override
  String get tableName => 'reading_questions';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get sublessonId => integer()
      .named('sublesson_id')
      .references(Sublessons, #id, onDelete: KeyAction.cascade)();

  IntColumn get questionNumber =>
      integer().named('question_number').nullable()();

  TextColumn get questionNahuatl => text().named('question_nahuatl')();

  TextColumn get correctAnswer => text().named('correct_answer')();

  TextColumn get questionTranslationSpanish =>
      text().named('question_translation_spanish').nullable()();

  TextColumn get audioPath => text().named('audio_path').nullable()();
}
