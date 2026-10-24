import '../entities/dictionary_entry.dart';
import '../entities/grammar_rule.dart';
import '../entities/lesson.dart';
import '../entities/phrase.dart';

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para operaciones de Lecciones.
abstract interface class ILessonRepository {
  Future<List<LessonEntity>> getLessons();
  Future<LessonEntity?> getLessonById(int lessonId);
  Future<void> unlockLesson(int lessonId);
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
}

/// Principio de Segregación de Interfaces (ISP - SOLID):
/// Contrato exclusivo para Frases y extracción de palabras trampa.
abstract interface class IPhraseRepository {
  Future<List<PhraseEntity>> getPhrasesByLesson(int lessonId);
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
        IGrammarRepository,
        IDictionaryRepository,
        IPhraseRepository {}
