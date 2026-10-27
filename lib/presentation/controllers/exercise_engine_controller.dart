import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/text_normalizer.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/evaluators/exercise_evaluators.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';
import '../../domain/usecases/generate_lesson_exercises_usecase.dart';

/// Estado de evaluación del ejercicio actual dentro del bucle de la lección.
enum ExerciseEvaluationStatus {
  idle,
  inProgress,
  correct,
  incorrect,
}

/// Estado inmutable de la sesión de una lección activa (10 ejercicios).
@immutable
class ExerciseSessionState {
  final int lessonId;
  final bool isLoading;
  final String? errorMessage;

  /// Lista de los 10 ejercicios dinámicos generados para la lección.
  final List<Exercise> exercises;

  /// Índice del ejercicio actual (0 .. 9).
  final int currentExerciseIndex;

  /// Estado de validación del ejercicio en curso.
  final ExerciseEvaluationStatus evaluationStatus;

  /// Pares ya resueltos en un ejercicio de tipo [MatchingExercise] (almacena los `dictionaryId`).
  final Set<int> matchedDictionaryIds;

  /// Selección temporal de la columna Náhuatl en [MatchingExercise].
  final int? selectedNahuatlDictionaryId;

  /// Selección temporal de la columna Español en [MatchingExercise].
  final int? selectedSpanishDictionaryId;

  /// Fichas seleccionadas en orden por el usuario en un [WordBankExercise].
  final List<WordChip> selectedWordChips;

  /// Texto ingresado por el usuario en un [TextInputExercise].
  final String currentTextInput;

  /// Conteo de aciertos acumulados en la sesión inicial.
  final int correctAnswersCount;

  /// Indica si el usuario ha completado el bucle de los 10 ejercicios (incluyendo revisión).
  final bool isLessonCompleted;

  /// Índices de los ejercicios en los que el usuario cometió algún error en la ronda inicial.
  final List<int> failedExerciseIndices;

  /// Indica si nos encontramos en la fase interactiva de repaso de errores al final de la lección.
  final bool isReviewMode;

  /// Índice dentro de la lista de errores [failedExerciseIndices].
  final int reviewCurrentIndex;

  /// Cantidad de errores corregidos exitosamente durante la fase de repaso.
  final int correctedCount;

  /// Indica si el usuario superó la lección alcanzando al menos el 50% de aciertos.
  final bool isLessonPassed;

  const ExerciseSessionState({
    required this.lessonId,
    this.isLoading = true,
    this.errorMessage,
    this.exercises = const [],
    this.currentExerciseIndex = 0,
    this.evaluationStatus = ExerciseEvaluationStatus.idle,
    this.matchedDictionaryIds = const {},
    this.selectedNahuatlDictionaryId,
    this.selectedSpanishDictionaryId,
    this.selectedWordChips = const [],
    this.currentTextInput = '',
    this.correctAnswersCount = 0,
    this.isLessonCompleted = false,
    this.failedExerciseIndices = const [],
    this.isReviewMode = false,
    this.reviewCurrentIndex = 0,
    this.correctedCount = 0,
    this.isLessonPassed = false,
  });

  /// Obtiene el ejercicio activo actual o `null` si aún está cargando / terminó.
  Exercise? get currentExercise {
    if (exercises.isEmpty ||
        currentExerciseIndex < 0 ||
        currentExerciseIndex >= exercises.length) {
      return null;
    }
    return exercises[currentExerciseIndex];
  }

  /// UI Defensiva: Indica si el ejercicio activo tiene un archivo de audio válido en `assets/audio/`.
  bool get currentExerciseHasAudio => currentExercise?.hasAudio ?? false;

  /// Progreso de la lección de 0.0 a 1.0.
  double get progress {
    if (isReviewMode) {
      return failedExerciseIndices.isEmpty
          ? 1.0
          : (reviewCurrentIndex / failedExerciseIndices.length).clamp(0.0, 1.0);
    }
    return exercises.isEmpty
        ? 0.0
        : (currentExerciseIndex / exercises.length).clamp(0.0, 1.0);
  }

  /// Total acumulado de respuestas correctas (iniciales + corregidas en repaso).
  int get totalAcquiredCorrect =>
      (correctAnswersCount + correctedCount).clamp(0, exercises.length);

  /// Porcentaje de acierto obtenido en la sesión (0.0 a 100.0).
  double get scorePercentage => exercises.isEmpty
      ? 0.0
      : ((totalAcquiredCorrect / exercises.length) * 100).clamp(0.0, 100.0);

  ExerciseSessionState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<Exercise>? exercises,
    int? currentExerciseIndex,
    ExerciseEvaluationStatus? evaluationStatus,
    Set<int>? matchedDictionaryIds,
    int? selectedNahuatlDictionaryId,
    bool clearSelectedNahuatl = false,
    int? selectedSpanishDictionaryId,
    bool clearSelectedSpanish = false,
    List<WordChip>? selectedWordChips,
    String? currentTextInput,
    int? correctAnswersCount,
    bool? isLessonCompleted,
    List<int>? failedExerciseIndices,
    bool? isReviewMode,
    int? reviewCurrentIndex,
    int? correctedCount,
    bool? isLessonPassed,
  }) {
    return ExerciseSessionState(
      lessonId: lessonId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      exercises: exercises ?? this.exercises,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      evaluationStatus: evaluationStatus ?? this.evaluationStatus,
      matchedDictionaryIds: matchedDictionaryIds ?? this.matchedDictionaryIds,
      selectedNahuatlDictionaryId: clearSelectedNahuatl
          ? null
          : (selectedNahuatlDictionaryId ?? this.selectedNahuatlDictionaryId),
      selectedSpanishDictionaryId: clearSelectedSpanish
          ? null
          : (selectedSpanishDictionaryId ?? this.selectedSpanishDictionaryId),
      selectedWordChips: selectedWordChips ?? this.selectedWordChips,
      currentTextInput: currentTextInput ?? this.currentTextInput,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      isLessonCompleted: isLessonCompleted ?? this.isLessonCompleted,
      failedExerciseIndices: failedExerciseIndices ?? this.failedExerciseIndices,
      isReviewMode: isReviewMode ?? this.isReviewMode,
      reviewCurrentIndex: reviewCurrentIndex ?? this.reviewCurrentIndex,
      correctedCount: correctedCount ?? this.correctedCount,
      isLessonPassed: isLessonPassed ?? this.isLessonPassed,
    );
  }
}

/// Controlador del Motor de Ejercicios (`ExerciseEngineController`) refactorizado bajo SOLID:
/// - **SRP**: Solo coordina la transición de estados del bucle de la lección.
/// - **OCP / DIP**: Delega la creación de los 10 ejercicios a [IGenerateLessonExercisesUseCase]
///   y la evaluación a [MatchingExerciseEvaluator], [WordBankExerciseEvaluator] y [TextInputExerciseEvaluator].
class ExerciseEngineController extends StateNotifier<ExerciseSessionState> {
  static const int totalExercisesPerLesson = 10;

  final IGenerateLessonExercisesUseCase _generateExercisesUseCase;
  final ILessonRepository _lessonRepository;
  final MatchingExerciseEvaluator _matchingEvaluator;
  final WordBankExerciseEvaluator _wordBankEvaluator;
  final TextInputExerciseEvaluator _textInputEvaluator;

  ExerciseEngineController({
    required int lessonId,
    required IGenerateLessonExercisesUseCase generateExercisesUseCase,
    required ILessonRepository lessonRepository,
    MatchingExerciseEvaluator matchingEvaluator =
        const MatchingExerciseEvaluator(),
    WordBankExerciseEvaluator wordBankEvaluator =
        const WordBankExerciseEvaluator(),
    TextInputExerciseEvaluator textInputEvaluator =
        const TextInputExerciseEvaluator(),
  })  : _generateExercisesUseCase = generateExercisesUseCase,
        _lessonRepository = lessonRepository,
        _matchingEvaluator = matchingEvaluator,
        _wordBankEvaluator = wordBankEvaluator,
        _textInputEvaluator = textInputEvaluator,
        super(ExerciseSessionState(lessonId: lessonId)) {
    loadLessonExercises();
  }

  /// Solicita al caso de uso los 10 ejercicios dinámicos para la lección activa.
  Future<void> loadLessonExercises() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final generatedExercises = await _generateExercisesUseCase.execute(
        lessonId: state.lessonId,
        totalExercises: totalExercisesPerLesson,
      );

      state = ExerciseSessionState(
        lessonId: state.lessonId,
        isLoading: false,
        exercises: generatedExercises,
        currentExerciseIndex: 0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al generar los ejercicios de la lección: $e',
      );
    }
  }

  // ===========================================================================
  // 1. INTERACCIÓN Y VALIDACIÓN: MATCHING (PARES)
  // ===========================================================================

  void selectMatchingItem({
    int? nahuatlDictionaryId,
    int? spanishDictionaryId,
  }) {
    final current = state.currentExercise;
    if (current is! MatchingExercise) return;

    final nextNahuatlId =
        nahuatlDictionaryId ?? state.selectedNahuatlDictionaryId;
    final nextSpanishId =
        spanishDictionaryId ?? state.selectedSpanishDictionaryId;

    if (nextNahuatlId != null &&
        state.matchedDictionaryIds.contains(nextNahuatlId)) {
      return;
    }
    if (nextSpanishId != null &&
        state.matchedDictionaryIds.contains(nextSpanishId)) {
      return;
    }

    state = state.copyWith(
      selectedNahuatlDictionaryId: nextNahuatlId,
      selectedSpanishDictionaryId: nextSpanishId,
      evaluationStatus: ExerciseEvaluationStatus.inProgress,
    );

    if (nextNahuatlId != null && nextSpanishId != null) {
      validateMatchingPair(
        nahuatlDictionaryId: nextNahuatlId,
        spanishDictionaryId: nextSpanishId,
      );
    }
  }

  bool validateMatchingPair({
    required int nahuatlDictionaryId,
    required int spanishDictionaryId,
  }) {
    final current = state.currentExercise;
    if (current is! MatchingExercise) return false;

    final isMatch = _matchingEvaluator.isPairMatch(
      nahuatlDictionaryId: nahuatlDictionaryId,
      spanishDictionaryId: spanishDictionaryId,
    );

    if (isMatch) {
      final updatedMatches = {
        ...state.matchedDictionaryIds,
        nahuatlDictionaryId,
      };
      final allPairsCompleted = _matchingEvaluator.isExerciseComplete(
        exercise: current,
        matchedIds: updatedMatches,
      );

      final isReview = state.isReviewMode;
      final updatedCorrect = !isReview && allPairsCompleted
          ? state.correctAnswersCount + 1
          : state.correctAnswersCount;
      final updatedCorrected = isReview && allPairsCompleted
          ? state.correctedCount + 1
          : state.correctedCount;

      state = state.copyWith(
        matchedDictionaryIds: updatedMatches,
        clearSelectedNahuatl: true,
        clearSelectedSpanish: true,
        evaluationStatus: allPairsCompleted
            ? ExerciseEvaluationStatus.correct
            : ExerciseEvaluationStatus.inProgress,
        correctAnswersCount: updatedCorrect,
        correctedCount: updatedCorrected,
      );
      return true;
    } else {
      final updatedFailed = (!state.isReviewMode &&
              !state.failedExerciseIndices.contains(state.currentExerciseIndex))
          ? [...state.failedExerciseIndices, state.currentExerciseIndex]
          : state.failedExerciseIndices;

      state = state.copyWith(
        clearSelectedNahuatl: true,
        clearSelectedSpanish: true,
        evaluationStatus: ExerciseEvaluationStatus.incorrect,
        failedExerciseIndices: updatedFailed,
      );
      return false;
    }
  }

  // ===========================================================================
  // 2. INTERACCIÓN Y VALIDACIÓN: WORD BANK (CONSTRUCTOR DE FICHAS)
  // ===========================================================================

  void selectWordChip(WordChip chip) {
    if (state.currentExercise is! WordBankExercise) return;
    final alreadySelected =
        state.selectedWordChips.any((c) => c.instanceId == chip.instanceId);
    if (alreadySelected) return;

    state = state.copyWith(
      selectedWordChips: [...state.selectedWordChips, chip],
      evaluationStatus: ExerciseEvaluationStatus.inProgress,
    );
  }

  void removeWordChip(WordChip chip) {
    if (state.currentExercise is! WordBankExercise) return;
    state = state.copyWith(
      selectedWordChips: state.selectedWordChips
          .where((c) => c.instanceId != chip.instanceId)
          .toList(growable: false),
      evaluationStatus: ExerciseEvaluationStatus.inProgress,
    );
  }

  bool validateWordBank([List<String>? candidateWords]) {
    final current = state.currentExercise;
    if (current is! WordBankExercise) return false;

    final reconstructedArray = candidateWords ??
        state.selectedWordChips.map((chip) => chip.word).toList(growable: false);

    final isSuccess = _wordBankEvaluator.evaluate(
      exercise: current,
      userOrderedWords: reconstructedArray,
    );

    final isReview = state.isReviewMode;
    final updatedCorrect = !isReview && isSuccess
        ? state.correctAnswersCount + 1
        : state.correctAnswersCount;
    final updatedCorrected = isReview && isSuccess
        ? state.correctedCount + 1
        : state.correctedCount;
    final updatedFailed = (!isSuccess &&
            !isReview &&
            !state.failedExerciseIndices.contains(state.currentExerciseIndex))
        ? [...state.failedExerciseIndices, state.currentExerciseIndex]
        : state.failedExerciseIndices;

    state = state.copyWith(
      evaluationStatus: isSuccess
          ? ExerciseEvaluationStatus.correct
          : ExerciseEvaluationStatus.incorrect,
      correctAnswersCount: updatedCorrect,
      correctedCount: updatedCorrected,
      failedExerciseIndices: updatedFailed,
    );

    return isSuccess;
  }

  // ===========================================================================
  // 3. INTERACCIÓN Y VALIDACIÓN: TEXT INPUT (TRADUCCIÓN LIBRE)
  // ===========================================================================

  String normalizeStrictInput(String rawText) {
    return TextNormalizer.normalizeStrict(rawText);
  }

  void updateTextInput(String value) {
    if (state.currentExercise is! TextInputExercise) return;
    state = state.copyWith(
      currentTextInput: value,
      evaluationStatus: ExerciseEvaluationStatus.inProgress,
    );
  }

  bool validateTextInput([String? rawUserInput]) {
    final current = state.currentExercise;
    if (current is! TextInputExercise) return false;

    final inputToEvaluate = rawUserInput ?? state.currentTextInput;
    final isSuccess = _textInputEvaluator.evaluate(
      exercise: current,
      rawUserInput: inputToEvaluate,
    );

    final isReview = state.isReviewMode;
    final updatedCorrect = !isReview && isSuccess
        ? state.correctAnswersCount + 1
        : state.correctAnswersCount;
    final updatedCorrected = isReview && isSuccess
        ? state.correctedCount + 1
        : state.correctedCount;
    final updatedFailed = (!isSuccess &&
            !isReview &&
            !state.failedExerciseIndices.contains(state.currentExerciseIndex))
        ? [...state.failedExerciseIndices, state.currentExerciseIndex]
        : state.failedExerciseIndices;

    state = state.copyWith(
      currentTextInput: inputToEvaluate,
      evaluationStatus: isSuccess
          ? ExerciseEvaluationStatus.correct
          : ExerciseEvaluationStatus.incorrect,
      correctAnswersCount: updatedCorrect,
      correctedCount: updatedCorrected,
      failedExerciseIndices: updatedFailed,
    );

    return isSuccess;
  }

  // ===========================================================================
  // AVANCE DEL BUCLE DE 10 EJERCICIOS, REPASO DE ERRORES Y CONDICIÓN DE 50%
  // ===========================================================================

  Future<void> nextExercise() async {
    if (!state.isReviewMode) {
      final nextIndex = state.currentExerciseIndex + 1;

      if (nextIndex < state.exercises.length) {
        state = state.copyWith(
          currentExerciseIndex: nextIndex,
          evaluationStatus: ExerciseEvaluationStatus.idle,
          matchedDictionaryIds: const {},
          clearSelectedNahuatl: true,
          clearSelectedSpanish: true,
          selectedWordChips: const [],
          currentTextInput: '',
        );
        return;
      }

      // Fin de la ronda principal de la lección
      // Si el usuario tuvo errores, iniciar ronda interactiva de corrección
      if (state.failedExerciseIndices.isNotEmpty) {
        final firstFailedIndex = state.failedExerciseIndices.first;
        state = state.copyWith(
          isReviewMode: true,
          reviewCurrentIndex: 0,
          currentExerciseIndex: firstFailedIndex,
          evaluationStatus: ExerciseEvaluationStatus.idle,
          matchedDictionaryIds: const {},
          clearSelectedNahuatl: true,
          clearSelectedSpanish: true,
          selectedWordChips: const [],
          currentTextInput: '',
        );
        return;
      }

      // No hubo ningún error (100% de aciertos directos)
      await _finalizeSession();
    } else {
      // En fase interactiva de repaso de errores
      final nextReview = state.reviewCurrentIndex + 1;

      if (nextReview < state.failedExerciseIndices.length) {
        final nextExerciseIdx = state.failedExerciseIndices[nextReview];
        state = state.copyWith(
          reviewCurrentIndex: nextReview,
          currentExerciseIndex: nextExerciseIdx,
          evaluationStatus: ExerciseEvaluationStatus.idle,
          matchedDictionaryIds: const {},
          clearSelectedNahuatl: true,
          clearSelectedSpanish: true,
          selectedWordChips: const [],
          currentTextInput: '',
        );
        return;
      }

      // Concluyó la revisión de todos los ejercicios con error
      await _finalizeSession();
    }
  }

  Future<void> _finalizeSession() async {
    final passed = state.scorePercentage >= 50.0;

    if (passed) {
      // Desbloquea la siguiente lección al alcanzar el mínimo de 50%
      await _unlockNextLessonIfAvailable();
      // Registra la lección como completada en SQLite
      await _lessonRepository.completeLesson(state.lessonId);
    }

    state = state.copyWith(
      isLessonCompleted: true,
      isLessonPassed: passed,
      evaluationStatus: ExerciseEvaluationStatus.correct,
    );
  }

  Future<void> retryLesson() async {
    state = ExerciseSessionState(lessonId: state.lessonId);
    await loadLessonExercises();
  }

  Future<void> _unlockNextLessonIfAvailable() async {
    final allLessons = await _lessonRepository.getLessons();
    final currentIndex =
        allLessons.indexWhere((lesson) => lesson.id == state.lessonId);
    if (currentIndex != -1 && currentIndex + 1 < allLessons.length) {
      final nextLesson = allLessons[currentIndex + 1];
      if (!nextLesson.isUnlocked) {
        await _lessonRepository.unlockLesson(nextLesson.id);
      }
    }
  }
}
