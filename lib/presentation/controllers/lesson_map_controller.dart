import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/grammar_rule.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/sublesson.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';

@immutable
class LessonMapState {
  final bool isLoading;
  final List<LessonEntity> lessons;
  final Map<int, List<SublessonEntity>> sublessonsByLesson;
  final Map<int, List<GrammarRuleEntity>> grammarRulesByLesson;
  final Map<int, int> phrasesCountByLesson;
  final String? errorMessage;

  const LessonMapState({
    this.isLoading = true,
    this.lessons = const [],
    this.sublessonsByLesson = const {},
    this.grammarRulesByLesson = const {},
    this.phrasesCountByLesson = const {},
    this.errorMessage,
  });

  LessonMapState copyWith({
    bool? isLoading,
    List<LessonEntity>? lessons,
    Map<int, List<SublessonEntity>>? sublessonsByLesson,
    Map<int, List<GrammarRuleEntity>>? grammarRulesByLesson,
    Map<int, int>? phrasesCountByLesson,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LessonMapState(
      isLoading: isLoading ?? this.isLoading,
      lessons: lessons ?? this.lessons,
      sublessonsByLesson: sublessonsByLesson ?? this.sublessonsByLesson,
      grammarRulesByLesson: grammarRulesByLesson ?? this.grammarRulesByLesson,
      phrasesCountByLesson: phrasesCountByLesson ?? this.phrasesCountByLesson,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Controlador con Responsabilidad Única (SRP) e Interfaces Segregadas (ISP):
/// Consulta [ILessonRepository], [ISublessonRepository], [IGrammarRepository] e [IPhraseRepository]
/// para determinar el estado de desbloqueo, puntos del libro y contenido disponible por lección.
class LessonMapController extends StateNotifier<LessonMapState> {
  final ILessonRepository _lessonRepository;
  final ISublessonRepository? _sublessonRepository;
  final IGrammarRepository _grammarRepository;
  final IPhraseRepository _phraseRepository;

  LessonMapController({
    required ILessonRepository lessonRepository,
    ISublessonRepository? sublessonRepository,
    required IGrammarRepository grammarRepository,
    required IPhraseRepository phraseRepository,
  })  : _lessonRepository = lessonRepository,
        _sublessonRepository = sublessonRepository,
        _grammarRepository = grammarRepository,
        _phraseRepository = phraseRepository,
        super(const LessonMapState()) {
    loadLessons();
  }

  Future<void> loadLessons() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final lessons = await _lessonRepository.getLessons();
      final Map<int, List<SublessonEntity>> sublessonsMap = {};
      final Map<int, List<GrammarRuleEntity>> rulesMap = {};
      final Map<int, int> phraseCountsMap = {};

      for (final lesson in lessons) {
        if (_sublessonRepository != null) {
          sublessonsMap[lesson.id] =
              await _sublessonRepository.getSublessonsByLesson(lesson.id);
        }

        rulesMap[lesson.id] =
            await _grammarRepository.getGrammarRulesByLesson(lesson.id);

        final phrases = await _phraseRepository.getPhrasesByLesson(lesson.id);
        phraseCountsMap[lesson.id] = phrases.length;
      }

      state = state.copyWith(
        isLoading: false,
        lessons: lessons,
        sublessonsByLesson: sublessonsMap,
        grammarRulesByLesson: rulesMap,
        phrasesCountByLesson: phraseCountsMap,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No se pudieron cargar las lecciones: $e',
      );
    }
  }
}
