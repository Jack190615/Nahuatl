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
/// Si la lección aún no cuenta con frases registradas, muestra el estado
/// "Más lecciones próximamente".
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

    // Estado cuando la lección no contiene frases disponibles aún
    if (sessionState.exercises.isEmpty) {
      return ResponsiveScaffold(
        appBar: AppBar(
          title: Text(
            lessonTitle,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.router.maybePop(),
          ),
        ),
        bodyBuilder: (context, info) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: info.verticalSpacing * 2,
              horizontal: info.horizontalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    color: AppColors.jadeLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_top_rounded,
                    size: 64,
                    color: AppColors.jadePrimary,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Más lecciones próximamente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: info.scaleFont(24),
                    fontWeight: FontWeight.w900,
                    color: AppColors.obsidianText,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Actualmente no hay frases registradas para esta lección. Estamos preparando nuevo contenido y ejercicios interactivos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: info.scaleFont(15),
                    color: AppColors.slateMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: AppActionButton(
                    label: 'Volver a las lecciones',
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => context.router.maybePop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (sessionState.isLessonCompleted) {
      final isPassed = sessionState.isLessonPassed;
      final scorePct = sessionState.scorePercentage.toStringAsFixed(0);

      return ResponsiveScaffold(
        bodyBuilder: (context, info) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: info.verticalSpacing * 2,
              horizontal: info.horizontalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPassed
                      ? Icons.emoji_events_rounded
                      : Icons.replay_circle_filled_rounded,
                  size: 88,
                  color: isPassed ? AppColors.goldHighlight : AppColors.terracottaAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  isPassed ? '¡Lección Superada!' : 'Casi lo logras',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: info.scaleFont(26),
                    fontWeight: FontWeight.w900,
                    color: AppColors.obsidianText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aciertos obtenidos: ${sessionState.totalAcquiredCorrect} / ${sessionState.exercises.length} ($scorePct%)',
                  style: TextStyle(
                    fontSize: info.scaleFont(16),
                    color: AppColors.slateMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isPassed ? AppColors.successSurface : AppColors.errorSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPassed
                          ? AppColors.successGreen.withValues(alpha: 0.6)
                          : AppColors.errorRed.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    isPassed
                        ? '¡Excelente trabajo! Has alcanzado el mínimo requerido (50%) y desbloqueado la siguiente lección.'
                        : 'Se requiere al menos un 50% de aciertos para desbloquear la siguiente lección. ¡Repasa y vuelve a intentarlo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: info.scaleFont(13.5),
                      fontWeight: FontWeight.w600,
                      color: isPassed ? AppColors.successGreen : AppColors.errorRed,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                if (isPassed) ...[
                  AppActionButton(
                    label: 'Volver a las lecciones',
                    icon: Icons.check_rounded,
                    onPressed: () => context.router.maybePop(),
                  ),
                ] else ...[
                  AppActionButton(
                    label: 'Reintentar lección',
                    icon: Icons.refresh_rounded,
                    onPressed: () => controller.retryLesson(),
                  ),
                  const SizedBox(height: 12),
                  AppActionButton(
                    label: 'Volver al mapa',
                    icon: Icons.arrow_back_rounded,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => context.router.maybePop(),
                  ),
                ],
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
              currentStep: sessionState.isReviewMode
                  ? sessionState.reviewCurrentIndex
                  : sessionState.currentExerciseIndex,
              totalSteps: sessionState.isReviewMode
                  ? sessionState.failedExerciseIndices.length
                  : sessionState.exercises.length,
              isReviewMode: sessionState.isReviewMode,
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
