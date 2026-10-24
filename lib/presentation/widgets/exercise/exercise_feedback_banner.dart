import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../controllers/exercise_engine_controller.dart';
import '../common/app_action_button.dart';

/// Banner inferior reutilizable que muestra el resultado de validación del ejercicio
/// y permite comprobar o avanzar al siguiente paso del bucle.
class ExerciseFeedbackBanner extends StatelessWidget {
  final ExerciseEvaluationStatus status;
  final String? correctSolutionHint;
  final bool canSubmit;
  final VoidCallback onSubmit;
  final VoidCallback onNext;

  const ExerciseFeedbackBanner({
    super.key,
    required this.status,
    this.correctSolutionHint,
    required this.canSubmit,
    required this.onSubmit,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final isResolved = status == ExerciseEvaluationStatus.correct ||
        status == ExerciseEvaluationStatus.incorrect;

    final isCorrect = status == ExerciseEvaluationStatus.correct;

    final Color bgColor = !isResolved
        ? Colors.transparent
        : (isCorrect ? AppColors.successSurface : AppColors.errorSurface);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(
        horizontal: info.horizontalPadding,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            color: isResolved
                ? (isCorrect ? AppColors.successGreen : AppColors.errorRed)
                : AppColors.borderOutline,
            width: 1.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: info.maxContentWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isResolved) ...[
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.error_rounded,
                      color: isCorrect
                          ? AppColors.successGreen
                          : AppColors.errorRed,
                      size: info.scaleFont(24),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isCorrect
                            ? '¡Cenca cualli! (¡Muy bien!)'
                            : 'Respuesta incorrecta',
                        style: TextStyle(
                          fontSize: info.scaleFont(17),
                          fontWeight: FontWeight.w800,
                          color: isCorrect
                              ? AppColors.successGreen
                              : AppColors.errorRed,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isCorrect &&
                    correctSolutionHint != null &&
                    correctSolutionHint!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Solución correcta: $correctSolutionHint',
                    style: TextStyle(
                      fontSize: info.scaleFont(14),
                      color: AppColors.obsidianText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                AppActionButton(
                  label: 'Continuar',
                  onPressed: onNext,
                  variant: isCorrect
                      ? AppButtonVariant.primary
                      : AppButtonVariant.danger,
                ),
              ] else ...[
                AppActionButton(
                  label: 'Comprobar',
                  onPressed: canSubmit ? onSubmit : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
