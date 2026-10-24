import 'package:flutter/foundation.dart';

import '../../core/utils/text_normalizer.dart';
import '../entities/exercise.dart';

/// Principio Abierto/Cerrado (OCP) y Responsabilidad Única (SRP):
/// Cada evaluador encapsula la regla de validación de un único tipo de ejercicio.

/// Evaluador para ejercicios de tipo [MatchingExercise].
class MatchingExerciseEvaluator {
  const MatchingExerciseEvaluator();

  /// Valida la coincidencia mediante el `id` relacional de `Dictionary`.
  bool isPairMatch({
    required int nahuatlDictionaryId,
    required int spanishDictionaryId,
  }) {
    return nahuatlDictionaryId == spanishDictionaryId;
  }

  /// Determina si todos los pares del ejercicio han sido emparejados.
  bool isExerciseComplete({
    required MatchingExercise exercise,
    required Set<int> matchedIds,
  }) {
    return matchedIds.length >= exercise.totalPairs;
  }
}

/// Evaluador para ejercicios de tipo [WordBankExercise].
class WordBankExerciseEvaluator {
  const WordBankExerciseEvaluator();

  /// Valida la reconstrucción exacta del array ordenado de tokens en Náhuatl.
  bool evaluate({
    required WordBankExercise exercise,
    required List<String> userOrderedWords,
  }) {
    return listEquals(userOrderedWords, exercise.targetNahuatlTokens);
  }
}

/// Evaluador para ejercicios de tipo [TextInputExercise].
class TextInputExerciseEvaluator {
  const TextInputExerciseEvaluator();

  /// Aplica el normalizador estricto (`trim()`, minúsculas, sin signos de puntuación
  /// ni dobles espacios) tanto al input del usuario como al string de la base de datos
  /// antes de realizar la comparación booleana.
  bool evaluate({
    required TextInputExercise exercise,
    required String rawUserInput,
  }) {
    return TextNormalizer.areEquivalent(rawUserInput, exercise.expectedAnswer);
  }
}
