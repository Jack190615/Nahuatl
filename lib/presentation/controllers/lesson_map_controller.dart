import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/grammar_rule.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';

@immutable
class LessonMapState {
  final bool isLoading;
  final List<LessonEntity> lessons;
  final Map<int, List<GrammarRuleEntity>> grammarRulesByLesson;
  final String? errorMessage;

  const LessonMapState({
    this.isLoading = true,
    this.lessons = const [],
    this.grammarRulesByLesson = const {},
    this.errorMessage,
  });

  LessonMapState copyWith({
    bool? isLoading,
    List<LessonEntity>? lessons,
    Map<int, List<GrammarRuleEntity>>? grammarRulesByLesson,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LessonMapState(
      isLoading: isLoading ?? this.isLoading,
      lessons: lessons ?? this.lessons,
      grammarRulesByLesson: grammarRulesByLesson ?? this.grammarRulesByLesson,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Controlador con Responsabilidad Única (SRP) e Interfaces Segregadas (ISP):
/// Depende exclusivamente de [ILessonRepository] e [IGrammarRepository].
class LessonMapController extends StateNotifier<LessonMapState> {
  final ILessonRepository _lessonRepository;
  final IGrammarRepository _grammarRepository;

  LessonMapController({
    required ILessonRepository lessonRepository,
    required IGrammarRepository grammarRepository,
  })  : _lessonRepository = lessonRepository,
        _grammarRepository = grammarRepository,
        super(const LessonMapState()) {
    loadLessons();
  }

  Future<void> loadLessons() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final lessons = await _lessonRepository.getLessons();
      final Map<int, List<GrammarRuleEntity>> rulesMap = {};

      for (final lesson in lessons) {
        rulesMap[lesson.id] =
            await _grammarRepository.getGrammarRulesByLesson(lesson.id);
      }

      state = state.copyWith(
        isLoading: false,
        lessons: lessons,
        grammarRulesByLesson: rulesMap,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No se pudieron cargar las lecciones: $e',
      );
    }
  }
}
