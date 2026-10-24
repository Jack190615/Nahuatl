/// Tipos de ejercicios interactivos soportados por el motor de lecciones.
enum ExerciseType {
  matching,
  wordBank,
  textInput,
}

/// Clase base sellada para los ejercicios dinámicos de una lección.
sealed class Exercise {
  final String exerciseId;
  final ExerciseType type;

  /// Ruta de audio opcional (UI Defensiva).
  final String? audioPath;

  const Exercise({
    required this.exerciseId,
    required this.type,
    this.audioPath,
  });

  /// UI Defensiva: La UI solo renderiza el botón de audio cuando [hasAudio] es `true`.
  bool get hasAudio => audioPath != null && audioPath!.trim().isNotEmpty;
}

/// Elemento individual dentro de las columnas de un ejercicio Matching (Pares).
class MatchingOptionItem {
  /// ID relacional de la tabla `Dictionary` usado para validar el par.
  final int dictionaryId;
  final String text;
  final String? audioPath;

  const MatchingOptionItem({
    required this.dictionaryId,
    required this.text,
    this.audioPath,
  });

  bool get hasAudio => audioPath != null && audioPath!.trim().isNotEmpty;
}

/// 1. Ejercicio de Pares (Matching):
/// Contiene 4 pares extraídos de `Dictionary`, separados en dos listas independientes
/// y aleatorizadas (`nahuatlColumn` y `spanishColumn`).
class MatchingExercise extends Exercise {
  final List<MatchingOptionItem> nahuatlColumn;
  final List<MatchingOptionItem> spanishColumn;

  const MatchingExercise({
    required super.exerciseId,
    required this.nahuatlColumn,
    required this.spanishColumn,
  }) : super(type: ExerciseType.matching, audioPath: null);

  int get totalPairs => nahuatlColumn.length;
}

/// Representa una ficha (chip) individual en el ejercicio Word Bank.
/// Posee un [instanceId] único para permitir palabras repetidas dentro de una misma oración.
class WordChip {
  final String instanceId;
  final String word;
  final bool isDistractor;

  const WordChip({
    required this.instanceId,
    required this.word,
    required this.isDistractor,
  });
}

/// 2. Ejercicio Constructor de Palabras (Word Bank):
/// Muestra la oración en español y ofrece fichas mezcladas en náhuatl (incluyendo 2 palabras trampa).
class WordBankExercise extends Exercise {
  final int phraseId;
  final String spanishPrompt;
  final List<String> targetNahuatlTokens;
  final List<WordChip> shuffledBankChips;

  const WordBankExercise({
    required super.exerciseId,
    required this.phraseId,
    required this.spanishPrompt,
    required this.targetNahuatlTokens,
    required this.shuffledBankChips,
    super.audioPath,
  }) : super(type: ExerciseType.wordBank);
}

/// Dirección de traducción para el ejercicio de texto libre.
enum TranslationDirection {
  nahuatlToSpanish,
  spanishToNahuatl,
}

/// 3. Ejercicio de Traducción Libre (Text Input):
/// Evalúa el input del usuario contra la traducción esperada tras pasar por el normalizador estricto.
class TextInputExercise extends Exercise {
  final int phraseId;
  final TranslationDirection direction;
  final String promptSentence;
  final String expectedAnswer;

  const TextInputExercise({
    required super.exerciseId,
    required this.phraseId,
    required this.direction,
    required this.promptSentence,
    required this.expectedAnswer,
    super.audioPath,
  }) : super(type: ExerciseType.textInput);
}
