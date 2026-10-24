import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Cabecera reutilizable de progreso para el bucle de 10 ejercicios.
class ExerciseProgressHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onClose;

  const ExerciseProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        totalSteps > 0 ? ((currentStep + 1) / totalSteps).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded, color: AppColors.slateMuted),
            tooltip: 'Salir de la lección',
          ),
          const SizedBox(width: 8),
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
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.jadePrimary,
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
    );
  }
}
