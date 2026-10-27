import '../entities/dictionary_entry.dart';
import '../entities/grammar_rule.dart';
import '../entities/lesson.dart';
import '../entities/phrase.dart';
import '../entities/sublesson.dart';

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para operaciones de Lecciones (Capítulos).
abstract interface class ILessonRepository {
  Future<List<LessonEntity>> getLessons();
  Future<LessonEntity?> getLessonById(int lessonId);
  Future<void> unlockLesson(int lessonId);
  Future<void> completeLesson(int lessonId);
}

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para operaciones de Sublecciones / Puntos del Libro.
abstract interface class ISublessonRepository {
  Future<List<SublessonEntity>> getSublessonsByLesson(int lessonId);
  Future<SublessonEntity?> getSublessonById(int sublessonId);
  Future<void> unlockSublesson(int sublessonId);
  Future<void> completeSublesson(int sublessonId);
  Future<List<DictionaryEntryEntity>> getVocabularyBySublesson(int sublessonId);
  Future<List<PhraseEntity>> getPhrasesBySublesson(int sublessonId);
}

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para consulta de Reglas Gramaticales.
abstract interface class IGrammarRepository {
  Future<List<GrammarRuleEntity>> getGrammarRulesByLesson(int lessonId);
}

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para operaciones de Diccionario y Full-Text Search (FTS5).
abstract interface class IDictionaryRepository {
  Future<List<DictionaryEntryEntity>> searchDictionary(String query);
  Future<List<DictionaryEntryEntity>> getRandomDictionaryEntries({
    required int limit,
    List<int> excludeIds = const [],
  });
  Future<List<DictionaryEntryEntity>> getVocabularyBySublesson(int sublessonId);
  Future<List<DictionaryEntryEntity>> getVocabularyByLesson(int lessonId);
}

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para Frases y extracción de palabras trampa.
abstract interface class IPhraseRepository {
  Future<List<PhraseEntity>> getPhrasesByLesson(int lessonId);
  Future<List<PhraseEntity>> getPhrasesBySublesson(int sublessonId);
  Future<List<String>> getRandomDistractorNahuatlWords({
    required int count,
    required Set<String> excludedWords,
  });
}

/// Contrato unificado que agrupa los repositorios de dominio para inyección global
/// manteniendo compatibilidad con clientes específicos (LSP & ISP).
abstract interface class INahuatlRepository
    implements
        ILessonRepository,
        ISublessonRepository,
        IGrammarRepository,
        IDictionaryRepository,
        IPhraseRepository {}
