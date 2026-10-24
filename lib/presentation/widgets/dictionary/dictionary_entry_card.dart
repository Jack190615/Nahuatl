import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/dictionary_entry.dart';
import '../common/defensive_audio_button.dart';

/// Tarjeta reutilizable para mostrar una entrada del Diccionario FTS5
/// integrando el botón de audio defensivo [DefensiveAudioButton].
class DictionaryEntryCard extends StatelessWidget {
  final DictionaryEntryEntity entry;

  const DictionaryEntryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: info.isTablet ? 20 : 16,
          vertical: info.isTablet ? 16 : 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          entry.nahuatlWord,
                          style: TextStyle(
                            fontSize: info.scaleFont(18),
                            fontWeight: FontWeight.w800,
                            color: AppColors.jadeDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.jadeLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry.wordType.value,
                          style: TextStyle(
                            fontSize: info.scaleFont(11.5),
                            fontWeight: FontWeight.w700,
                            color: AppColors.jadePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.spanishTranslation,
                    style: TextStyle(
                      fontSize: info.scaleFont(15),
                      color: AppColors.obsidianText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // UI Defensiva: solo se renderiza si `entry.hasAudio` es verdadero
            DefensiveAudioButton(
              audioPath: entry.resolvedAssetAudioPath,
            ),
          ],
        ),
      ),
    );
  }
}
