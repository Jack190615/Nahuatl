import 'dart:math';

import 'package:drift/drift.dart';

import '../../domain/entities/dictionary_entry.dart';
import '../../domain/entities/grammar_rule.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/phrase.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';
import '../datasources/local/app_database.dart';

/// Implementación local de [INahuatlRepository] respaldada por Drift (SQLite + FTS5).
class DriftNahuatlRepository implements INahuatlRepository {
  final AppDatabase _db;
  final Random _random;

  DriftNahuatlRepository({
    required AppDatabase db,
    Random? random,
  })  : _db = db,
        _random = random ?? Random();

  // ---------------------------------------------------------------------------
  // LECCIONES Y REGLAS GRAMATICALES
  // ---------------------------------------------------------------------------

  @override
  Future<List<LessonEntity>> getLessons() async {
    final query = _db.select(_db.lessons)
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    final rows = await query.get();
    return rows.map(_mapLessonRowToEntity).toList(growable: false);
  }

  @override
  Future<LessonEntity?> getLessonById(int lessonId) async {
    final query = _db.select(_db.lessons)..where((t) => t.id.equals(lessonId));
    final row = await query.getSingleOrNull();
    return row != null ? _mapLessonRowToEntity(row) : null;
  }

  @override
  Future<void> unlockLesson(int lessonId) async {
    await (_db.update(_db.lessons)..where((t) => t.id.equals(lessonId))).write(
      const LessonsCompanion(isUnlocked: Value(true)),
    );
  }

  @override
  Future<List<GrammarRuleEntity>> getGrammarRulesByLesson(int lessonId) async {
    final query = _db.select(_db.grammarRules)
      ..where((t) => t.lessonId.equals(lessonId));
    final rows = await query.get();
    return rows
        .map(
          (row) => GrammarRuleEntity(
            id: row.id,
            lessonId: row.lessonId,
            explanationText: row.explanationText,
          ),
        )
        .toList(growable: false);
  }

  // ---------------------------------------------------------------------------
  // DICCIONARIO Y BÚSQUEDA FULL-TEXT SEARCH (FTS5)
  // ---------------------------------------------------------------------------

  @override
  Future<List<DictionaryEntryEntity>> searchDictionary(String query) async {
    final rows = await _db.searchDictionaryFts(query);
    return rows.map(_mapDictionaryRowToEntity).toList(growable: false);
  }

  @override
  Future<List<DictionaryEntryEntity>> getRandomDictionaryEntries({
    required int limit,
    List<int> excludeIds = const [],
  }) async {
    final query = _db.select(_db.dictionary);
    if (excludeIds.isNotEmpty) {
      query.where((t) => t.id.isNotIn(excludeIds));
    }
    query
      ..orderBy([(t) => OrderingTerm.random()])
      ..limit(limit);

    final rows = await query.get();
    return rows.map(_mapDictionaryRowToEntity).toList(growable: false);
  }

  // ---------------------------------------------------------------------------
  // FRASES Y PALABRAS TRAMPA (WORD BANK)
  // ---------------------------------------------------------------------------

  @override
  Future<List<PhraseEntity>> getPhrasesByLesson(int lessonId) async {
    final query = _db.select(_db.phrases)
      ..where((t) => t.lessonId.equals(lessonId));
    final rows = await query.get();
    return rows.map(_mapPhraseRowToEntity).toList(growable: false);
  }

  @override
  Future<List<String>> getRandomDistractorNahuatlWords({
    required int count,
    required Set<String> excludedWords,
  }) async {
    final normalizedExcluded =
        excludedWords.map((w) => w.trim().toLowerCase()).toSet();

    // 1. Extraer oraciones aleatorias de la misma tabla `phrases`
    final phraseRows = await (_db.select(_db.phrases)
          ..orderBy([(t) => OrderingTerm.random()])
          ..limit(25))
        .get();

    final Set<String> candidatePool = {};

    for (final row in phraseRows) {
      final tokens = row.nahuatlSentence
          .split(' ')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty);
      for (final token in tokens) {
        if (!normalizedExcluded.contains(token.toLowerCase())) {
          candidatePool.add(token);
        }
      }
    }

    // 2. Respaldo defensivo desde `dictionary` si la tabla `phrases` tiene pocos tokens únicos
    if (candidatePool.length < count) {
      final dictRows = await (_db.select(_db.dictionary)
            ..orderBy([(t) => OrderingTerm.random()])
            ..limit(20))
          .get();
      for (final row in dictRows) {
        final word = row.nahuatlWord.trim();
        if (word.isNotEmpty &&
            !normalizedExcluded.contains(word.toLowerCase())) {
          candidatePool.add(word);
        }
      }
    }

    final candidatesList = candidatePool.toList()..shuffle(_random);
    return candidatesList.take(count).toList(growable: false);
  }

  // ---------------------------------------------------------------------------
  // MAPPERS PRIVADOS (FILA DRIFT -> ENTIDAD DE DOMINIO)
  // ---------------------------------------------------------------------------

  LessonEntity _mapLessonRowToEntity(LessonRow row) {
    return LessonEntity(
      id: row.id,
      title: row.title,
      orderIndex: row.orderIndex,
      isUnlocked: row.isUnlocked,
    );
  }

  DictionaryEntryEntity _mapDictionaryRowToEntity(DictionaryRow row) {
    return DictionaryEntryEntity(
      id: row.id,
      nahuatlWord: row.nahuatlWord,
      spanishTranslation: row.spanishTranslation,
      wordType: WordType.fromString(row.wordType),
      audioPath: row.audioPath,
    );
  }

  PhraseEntity _mapPhraseRowToEntity(PhraseRow row) {
    return PhraseEntity(
      id: row.id,
      lessonId: row.lessonId,
      grammarRuleId: row.grammarRuleId,
      nahuatlSentence: row.nahuatlSentence,
      spanishTranslation: row.spanishTranslation,
      audioPath: row.audioPath,
    );
  }
}
