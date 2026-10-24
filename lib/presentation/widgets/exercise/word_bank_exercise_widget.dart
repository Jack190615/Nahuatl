import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/exercise.dart';
import '../common/defensive_audio_button.dart';

/// Widget reutilizable para el Ejercicio 2: Word Bank (Constructor de Oraciones).
/// Muestra la oración en español y permite ordenar las fichas en Náhuatl (con 2 palabras trampa).
class WordBankExerciseWidget extends StatelessWidget {
  final WordBankExercise exercise;
  final List<WordChip> selectedChips;
  final ValueChanged<WordChip> onSelectChip;
  final ValueChanged<WordChip> onRemoveChip;

  const WordBankExerciseWidget({
    super.key,
    required this.exercise,
    required this.selectedChips,
    required this.onSelectChip,
    required this.onRemoveChip,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final selectedIds = selectedChips.map((c) => c.instanceId).toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Construye la oración en Náhuatl',
          style: TextStyle(
            fontSize: info.scaleFont(20),
            fontWeight: FontWeight.w800,
            color: AppColors.obsidianText,
          ),
        ),
        SizedBox(height: info.verticalSpacing),

        // Tarjeta de la oración estímulo en español + botón de audio defensivo
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderOutline, width: 1.5),
          ),
          child: Row(
            children: [
              DefensiveAudioButton(audioPath: exercise.audioPath),
              if (exercise.hasAudio) const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.spanishPrompt,
                  style: TextStyle(
                    fontSize: info.scaleFont(18),
                    fontWeight: FontWeight.w700,
                    color: AppColors.obsidianText,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: info.verticalSpacing),

        // Área de respuesta donde se apilan las fichas seleccionadas en orden
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: info.isTablet ? 110 : 90),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.jadeLight.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.jadePrimary, width: 1.5),
          ),
          child: selectedChips.isEmpty
              ? Center(
                  child: Text(
                    'Toca las fichas inferiores para formar la traducción...',
                    style: TextStyle(
                      fontSize: info.scaleFont(14),
                      color: AppColors.slateMuted,
                    ),
                  ),
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedChips
                      .map(
                        (chip) => _WordTokenChip(
                          label: chip.word,
                          isSelectedInAnswer: true,
                          onTap: () => onRemoveChip(chip),
                        ),
                      )
                      .toList(),
                ),
        ),
        SizedBox(height: info.verticalSpacing * 1.25),

        // Banco de fichas mezcladas (incluye las 2 palabras trampa)
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: exercise.shuffledBankChips.map((chip) {
            final isUsed = selectedIds.contains(chip.instanceId);
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: isUsed ? 0.3 : 1.0,
              child: IgnorePointer(
                ignoring: isUsed,
                child: _WordTokenChip(
                  label: chip.word,
                  isSelectedInAnswer: false,
                  onTap: () => onSelectChip(chip),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _WordTokenChip extends StatelessWidget {
  final String label;
  final bool isSelectedInAnswer;
  final VoidCallback onTap;

  const _WordTokenChip({
    required this.label,
    required this.isSelectedInAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Material(
      color: isSelectedInAnswer ? AppColors.jadePrimary : AppColors.cardSurface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: info.isTablet ? 18 : 14,
            vertical: info.isTablet ? 12 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelectedInAnswer
                  ? AppColors.jadeDark
                  : AppColors.borderOutline,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: info.scaleFont(16),
              fontWeight: FontWeight.w700,
              color: isSelectedInAnswer ? Colors.white : AppColors.obsidianText,
            ),
          ),
        ),
      ),
    );
  }
}
