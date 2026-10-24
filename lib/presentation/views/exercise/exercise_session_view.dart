import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/exercise.dart';
import '../../controllers/exercise_engine_controller.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/app_action_button.dart';
import '../../widgets/common/responsive_scaffold.dart';
import '../../widgets/exercise/exercise_feedback_banner.dart';
import '../../widgets/exercise/exercise_progress_header.dart';
import '../../widgets/exercise/matching_exercise_widget.dart';
import '../../widgets/exercise/text_input_exercise_widget.dart';
import '../../widgets/exercise/word_bank_exercise_widget.dart';

/// Vista responsiva que ejecuta el bucle de 10 ejercicios de una lección activa.
@RoutePage()
class ExerciseSessionView extends ConsumerWidget {
  final int lessonId;
  final String lessonTitle;

  const ExerciseSessionView({
    super.key,
    @PathParam('lessonId') required this.lessonId,
    this.lessonTitle = 'Práctica de Lección',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(exerciseEngineControllerProvider(lessonId));
    final controller =
        ref.read(exerciseEngineControllerProvider(lessonId).notifier);

    if (sessionState.isLoading) {
      return const ResponsiveScaffold(
        bodyBuilder: _buildLoading,
      );
    }

    if (sessionState.isLessonCompleted) {
      return ResponsiveScaffold(
        bodyBuilder: (context, info) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: info.verticalSpacing * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 88,
                  color: AppColors.goldHighlight,
                ),
                const SizedBox(height: 16),
                Text(
                  '¡Lección Completada!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: info.scaleFont(26),
                    fontWeight: FontWeight.w900,
                    color: AppColors.obsidianText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aciertos en la sesión: ${sessionState.correctAnswersCount} / ${sessionState.exercises.length}',
                  style: TextStyle(
                    fontSize: info.scaleFont(16),
                    color: AppColors.slateMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                AppActionButton(
                  label: 'Volver a las lecciones',
                  icon: Icons.check_rounded,
                  onPressed: () => context.router.maybePop(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentExercise = sessionState.currentExercise;
    if (currentExercise == null) {
      return ResponsiveScaffold(
        bodyBuilder: (context, _) => Center(
          child: Text(
            sessionState.errorMessage ?? 'No hay ejercicios disponibles.',
          ),
        ),
      );
    }

    return ResponsiveScaffold(
      bottomNavigationBar: _buildBottomBanner(
        sessionState: sessionState,
        currentExercise: currentExercise,
        controller: controller,
      ),
      bodyBuilder: (context, info) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExerciseProgressHeader(
              currentStep: sessionState.currentExerciseIndex,
              totalSteps: sessionState.exercises.length,
              onClose: () => context.router.maybePop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: MobilePlatformConfig.adaptiveScrollPhysics,
                padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
                child: _buildExerciseBody(
                  exercise: currentExercise,
                  state: sessionState,
                  controller: controller,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildLoading(BuildContext context, dynamic _) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildExerciseBody({
    required Exercise exercise,
    required ExerciseSessionState state,
    required ExerciseEngineController controller,
  }) {
    return switch (exercise) {
      MatchingExercise() => MatchingExerciseWidget(
          exercise: exercise,
          matchedIds: state.matchedDictionaryIds,
          selectedNahuatlId: state.selectedNahuatlDictionaryId,
          selectedSpanishId: state.selectedSpanishDictionaryId,
          onSelectNahuatl: (id) =>
              controller.selectMatchingItem(nahuatlDictionaryId: id),
          onSelectSpanish: (id) =>
              controller.selectMatchingItem(spanishDictionaryId: id),
        ),
      WordBankExercise() => WordBankExerciseWidget(
          exercise: exercise,
          selectedChips: state.selectedWordChips,
          onSelectChip: controller.selectWordChip,
          onRemoveChip: controller.removeWordChip,
        ),
      TextInputExercise() => TextInputExerciseWidget(
          exercise: exercise,
          currentInput: state.currentTextInput,
          onChanged: controller.updateTextInput,
          onSubmitted: controller.validateTextInput,
        ),
    };
  }

  Widget _buildBottomBanner({
    required ExerciseSessionState sessionState,
    required Exercise currentExercise,
    required ExerciseEngineController controller,
  }) {
    final bool canSubmit = switch (currentExercise) {
      MatchingExercise() =>
        sessionState.matchedDictionaryIds.length >= currentExercise.totalPairs,
      WordBankExercise() => sessionState.selectedWordChips.isNotEmpty,
      TextInputExercise() => sessionState.currentTextInput.trim().isNotEmpty,
    };

    final String? solutionHint = switch (currentExercise) {
      MatchingExercise() => null,
      WordBankExercise() => currentExercise.targetNahuatlTokens.join(' '),
      TextInputExercise() => currentExercise.expectedAnswer,
    };

    return ExerciseFeedbackBanner(
      status: sessionState.evaluationStatus,
      correctSolutionHint: solutionHint,
      canSubmit: canSubmit,
      onSubmit: () {
        switch (currentExercise) {
          case MatchingExercise():
            controller.nextExercise();
            break;
          case WordBankExercise():
            controller.validateWordBank();
            break;
          case TextInputExercise():
            controller.validateTextInput();
            break;
        }
      },
      onNext: controller.nextExercise,
    );
  }
}
