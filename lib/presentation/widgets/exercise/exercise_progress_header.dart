import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Cabecera reutilizable de progreso para el bucle de ejercicios.
/// Soporta tanto el progreso regular de la lección como la fase interactiva de repaso de errores.
class ExerciseProgressHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isReviewMode;
  final VoidCallback onClose;

  const ExerciseProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.isReviewMode = false,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        totalSteps > 0 ? ((currentStep + 1) / totalSteps).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded, color: AppColors.slateMuted),
                tooltip: 'Salir de la lección',
              ),
              const SizedBox(width: 4),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    tween: Tween<double>(begin: 0, end: progress),
                    builder: (context, animatedValue, _) {
                      return LinearProgressIndicator(
                        value: animatedValue,
                        minHeight: 12,
                        backgroundColor: AppColors.borderOutline,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isReviewMode
                              ? AppColors.terracottaAccent
                              : AppColors.jadePrimary,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${currentStep + 1}/$totalSteps',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slateMuted,
                ),
              ),
            ],
          ),
          if (isReviewMode) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 48), // Alineado con el inicio de la barra
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.errorSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.terracottaAccent.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.replay_rounded,
                        size: 13,
                        color: AppColors.terracottaAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Ronda de corrección: repasa tus errores',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.terracottaAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
