import '../../domain/entities/dictionary_entry.dart';
import '../../domain/entities/grammar_rule.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/phrase.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';

/// Implementación futura de [INahuatlRepository] conectada a un backend REST/GraphQL.
/// Gracias a Clean Architecture y la inyección por Riverpod, cuando el backend esté listo
/// basta con conmutar el provider `nahuatlRepositoryProvider` o implementar una estrategia
/// Offline-First sin alterar ningún controlador de presentación.
class ApiNahuatlRepository implements INahuatlRepository {
  final String baseUrl;

  const ApiNahuatlRepository({required this.baseUrl});

  @override
  Future<List<LessonEntity>> getLessons() =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<LessonEntity?> getLessonById(int lessonId) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<void> unlockLesson(int lessonId) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<List<GrammarRuleEntity>> getGrammarRulesByLesson(int lessonId) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<List<DictionaryEntryEntity>> searchDictionary(String query) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<List<DictionaryEntryEntity>> getRandomDictionaryEntries({
    required int limit,
    List<int> excludeIds = const [],
  }) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<List<PhraseEntity>> getPhrasesByLesson(int lessonId) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');

  @override
  Future<List<String>> getRandomDistractorNahuatlWords({
    required int count,
    required Set<String> excludedWords,
  }) =>
      throw UnimplementedError('Pendiente de integración con API remota ($baseUrl)');
}
