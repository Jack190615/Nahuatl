import 'dart:math';

import '../entities/exercise.dart';
import '../entities/phrase.dart';
import '../repositories/i_nahuatl_repository.dart';

/// Principio de Inversión de Dependencias (DIP) y Responsabilidad Única (SRP):
/// Caso de uso dedicado exclusivamente a construir el lote de 10 ejercicios dinámicos de una lección.
abstract interface class IGenerateLessonExercisesUseCase {
  Future<List<Exercise>> execute({
    required int lessonId,
    int totalExercises = 10,
  });
}

class GenerateLessonExercisesUseCase implements IGenerateLessonExercisesUseCase {
  static const int matchingPairsCount = 4;
  static const int wordBankDistractorsCount = 2;

  final IDictionaryRepository _dictionaryRepository;
  final IPhraseRepository _phraseRepository;
  final Random _random;

  GenerateLessonExercisesUseCase({
    required IDictionaryRepository dictionaryRepository,
    required IPhraseRepository phraseRepository,
    Random? random,
  })  : _dictionaryRepository = dictionaryRepository,
        _phraseRepository = phraseRepository,
        _random = random ?? Random();

  @override
  Future<List<Exercise>> execute({
    required int lessonId,
    int totalExercises = 10,
  }) async {
    final phrases = await _phraseRepository.getPhrasesByLesson(lessonId);
    // Si no existen frases para esta lección, devuelve una lista vacía para mostrar
    // la pantalla de "Más lecciones próximamente"
    if (phrases.isEmpty) {
      return const [];
    }

    final List<Exercise> generated = [];

    for (int i = 0; i < totalExercises; i++) {
      final mod = phrases.isEmpty ? 0 : (i % 3);

      if (mod == 0) {
        generated.add(await _buildMatchingExercise(lessonId: lessonId, index: i));
      } else if (mod == 1) {
        final phrase = phrases[i % phrases.length];
        generated.add(
          await _buildWordBankExercise(
            lessonId: lessonId,
            index: i,
            phrase: phrase,
          ),
        );
      } else {
        final phrase = phrases[i % phrases.length];
        generated.add(
          _buildTextInputExercise(
            lessonId: lessonId,
            index: i,
            phrase: phrase,
          ),
        );
      }
    }

    return generated;
  }

  /// 1. Matching (Pares): Extrae 4 pares de `Dictionary`, los separa en dos listas
  /// independientes y las aleatoriza conservando su `dictionaryId` relacional.
  Future<MatchingExercise> _buildMatchingExercise({
    required int lessonId,
    required int index,
  }) async {
    final entries = await _dictionaryRepository.getRandomDictionaryEntries(
      limit: matchingPairsCount,
    );

    final nahuatlColumn = entries
        .map(
          (entry) => MatchingOptionItem(
            dictionaryId: entry.id,
            text: entry.nahuatlWord,
            audioPath: entry.resolvedAssetAudioPath,
          ),
        )
        .toList()
      ..shuffle(_random);

    final spanishColumn = entries
        .map(
          (entry) => MatchingOptionItem(
            dictionaryId: entry.id,
            text: entry.spanishTranslation,
            audioPath: null,
          ),
        )
        .toList()
      ..shuffle(_random);

    return MatchingExercise(
      exerciseId: 'matching_${lessonId}_$index',
      nahuatlColumn: nahuatlColumn,
      spanishColumn: spanishColumn,
    );
  }

  /// 2. Word Bank (Constructor): Aplica `split(' ')` al string en náhuatl,
  /// inyecta 2 palabras "trampa" aleatorias de la misma tabla y mezcla las fichas.
  Future<WordBankExercise> _buildWordBankExercise({
    required int lessonId,
    required int index,
    required PhraseEntity phrase,
  }) async {
    final targetTokens = phrase.nahuatlSentence
        .trim()
        .split(' ')
        .where((token) => token.trim().isNotEmpty)
        .toList(growable: false);

    final distractors = await _phraseRepository.getRandomDistractorNahuatlWords(
      count: wordBankDistractorsCount,
      excludedWords: targetTokens.toSet(),
    );

    final List<WordChip> chips = [
      for (int i = 0; i < targetTokens.length; i++)
        WordChip(
          instanceId: 'target_${index}_$i',
          word: targetTokens[i],
          isDistractor: false,
        ),
      for (int j = 0; j < distractors.length; j++)
        WordChip(
          instanceId: 'trap_${index}_$j',
          word: distractors[j],
          isDistractor: true,
        ),
    ]..shuffle(_random);

    return WordBankExercise(
      exerciseId: 'word_bank_${lessonId}_$index',
      phraseId: phrase.id,
      spanishPrompt: phrase.spanishTranslation,
      targetNahuatlTokens: targetTokens,
      shuffledBankChips: chips,
      audioPath: phrase.resolvedAssetAudioPath,
    );
  }

  /// 3. Text Input (Traducción Libre):
  TextInputExercise _buildTextInputExercise({
    required int lessonId,
    required int index,
    required PhraseEntity phrase,
  }) {
    return TextInputExercise(
      exerciseId: 'text_input_${lessonId}_$index',
      phraseId: phrase.id,
      direction: TranslationDirection.nahuatlToSpanish,
      promptSentence: phrase.nahuatlSentence,
      expectedAnswer: phrase.spanishTranslation,
      audioPath: phrase.resolvedAssetAudioPath,
    );
  }
}
