import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/env_config.dart';
import '../../core/services/asset_audio_service.dart';
import '../../core/services/i_audio_service.dart';
import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/local/database_seeder_service.dart';
import '../../data/repositories/drift_nahuatl_repository.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';
import '../../domain/usecases/generate_lesson_exercises_usecase.dart';
import '../controllers/dictionary_search_controller.dart';
import '../controllers/exercise_engine_controller.dart';
import '../controllers/lesson_map_controller.dart';

// =============================================================================
// INFRAESTRUCTURA & SERVICIOS CORE (DIP)
// =============================================================================

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final databaseSeederServiceProvider = Provider<DatabaseSeederService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DatabaseSeederService(db: db);
});

final audioServiceProvider = Provider<IAudioService>((ref) {
  return AssetAudioService();
});

/// Bootstrap inicial: carga `/.env` desde la raíz del proyecto y ejecuta el
/// Batch Insert transaccional únicamente en la primera instalación.
final appBootstrapProvider = FutureProvider<bool>((ref) async {
  await EnvConfig.init();
  final seeder = ref.watch(databaseSeederServiceProvider);
  return seeder.seedIfNeeded();
});

// =============================================================================
// REPOSITORIOS SEGREGADOS (ISP & DIP - SOLID)
// =============================================================================

final nahuatlRepositoryProvider = Provider<INahuatlRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftNahuatlRepository(db: db);
});

final lessonRepositoryProvider = Provider<ILessonRepository>((ref) {
  return ref.watch(nahuatlRepositoryProvider);
});

final grammarRepositoryProvider = Provider<IGrammarRepository>((ref) {
  return ref.watch(nahuatlRepositoryProvider);
});

final dictionaryRepositoryProvider = Provider<IDictionaryRepository>((ref) {
  return ref.watch(nahuatlRepositoryProvider);
});

final phraseRepositoryProvider = Provider<IPhraseRepository>((ref) {
  return ref.watch(nahuatlRepositoryProvider);
});

// =============================================================================
// CASOS DE USO (SRP & DIP)
// =============================================================================

final generateLessonExercisesUseCaseProvider =
    Provider<IGenerateLessonExercisesUseCase>((ref) {
  return GenerateLessonExercisesUseCase(
    dictionaryRepository: ref.watch(dictionaryRepositoryProvider),
    phraseRepository: ref.watch(phraseRepositoryProvider),
  );
});

// =============================================================================
// CONTROLADORES DE PRESENTACIÓN
// =============================================================================

final lessonMapControllerProvider =
    StateNotifierProvider<LessonMapController, LessonMapState>((ref) {
  return LessonMapController(
    lessonRepository: ref.watch(lessonRepositoryProvider),
    grammarRepository: ref.watch(grammarRepositoryProvider),
  );
});

final dictionarySearchControllerProvider = StateNotifierProvider.autoDispose<
    DictionarySearchController, DictionarySearchState>((ref) {
  return DictionarySearchController(
    dictionaryRepository: ref.watch(dictionaryRepositoryProvider),
  );
});

final exerciseEngineControllerProvider = StateNotifierProvider.autoDispose
    .family<ExerciseEngineController, ExerciseSessionState, int>(
  (ref, lessonId) {
    return ExerciseEngineController(
      lessonId: lessonId,
      generateExercisesUseCase:
          ref.watch(generateLessonExercisesUseCaseProvider),
      lessonRepository: ref.watch(lessonRepositoryProvider),
    );
  },
);
