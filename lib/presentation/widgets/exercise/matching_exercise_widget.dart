import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/exercise.dart';
import '../common/defensive_audio_button.dart';

/// Widget reutilizable para el Ejercicio 1: Matching (Pares de Diccionario).
/// Muestra las dos listas aleatorizadas (`nahuatlColumn` y `spanishColumn`) y valida por `dictionaryId`.
class MatchingExerciseWidget extends StatelessWidget {
  final MatchingExercise exercise;
  final Set<int> matchedIds;
  final int? selectedNahuatlId;
  final int? selectedSpanishId;
  final ValueChanged<int> onSelectNahuatl;
  final ValueChanged<int> onSelectSpanish;

  const MatchingExerciseWidget({
    super.key,
    required this.exercise,
    required this.matchedIds,
    required this.selectedNahuatlId,
    required this.selectedSpanishId,
    required this.onSelectNahuatl,
    required this.onSelectSpanish,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona los pares correspondientes',
          style: TextStyle(
            fontSize: info.scaleFont(20),
            fontWeight: FontWeight.w800,
            color: AppColors.obsidianText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Une cada vocablo en Náhuatl Clásico con su traducción en español.',
          style: TextStyle(
            fontSize: info.scaleFont(14),
            color: AppColors.slateMuted,
          ),
        ),
        SizedBox(height: info.verticalSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Columna Izquierda: Náhuatl Clásico
            Expanded(
              child: Column(
                children: exercise.nahuatlColumn.map((item) {
                  final isMatched = matchedIds.contains(item.dictionaryId);
                  final isSelected = selectedNahuatlId == item.dictionaryId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _MatchingTile(
                      text: item.text,
                      audioPath: item.audioPath,
                      isMatched: isMatched,
                      isSelected: isSelected,
                      onTap: () => onSelectNahuatl(item.dictionaryId),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: info.isTablet ? 24 : 12),
            // Columna Derecha: Español
            Expanded(
              child: Column(
                children: exercise.spanishColumn.map((item) {
                  final isMatched = matchedIds.contains(item.dictionaryId);
                  final isSelected = selectedSpanishId == item.dictionaryId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _MatchingTile(
                      text: item.text,
                      audioPath: null,
                      isMatched: isMatched,
                      isSelected: isSelected,
                      onTap: () => onSelectSpanish(item.dictionaryId),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MatchingTile extends StatelessWidget {
  final String text;
  final String? audioPath;
  final bool isMatched;
  final bool isSelected;
  final VoidCallback onTap;

  const _MatchingTile({
    required this.text,
    required this.audioPath,
    required this.isMatched,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    final Color bgColor;
    final Color borderColor;
    final Color textColor;

    if (isMatched) {
      bgColor = AppColors.successSurface;
      borderColor = AppColors.successGreen;
      textColor = AppColors.successGreen;
    } else if (isSelected) {
      bgColor = AppColors.jadeLight;
      borderColor = AppColors.jadePrimary;
      textColor = AppColors.jadeDark;
    } else {
      bgColor = AppColors.cardSurface;
      borderColor = AppColors.borderOutline;
      textColor = AppColors.obsidianText;
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isMatched ? 0.55 : 1.0,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isMatched ? null : onTap,
          child: Container(
            constraints: BoxConstraints(minHeight: info.isTablet ? 64 : 56),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
                width: isSelected ? 2.2 : 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: info.scaleFont(16),
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                // UI Defensiva: solo muestra el icono si el vocablo tiene audio_path
                DefensiveAudioButton(
                  audioPath: audioPath,
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
