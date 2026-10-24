import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';

/// Widget Reutilizable de UI Defensiva para reproducción de audio (`assets/audio/`).
/// Si [audioPath] es `null` o vacío, devuelve `SizedBox.shrink()` y no ocupa espacio en el árbol visual.
class DefensiveAudioButton extends ConsumerWidget {
  final String? audioPath;
  final String tooltip;
  final double iconSize;

  const DefensiveAudioButton({
    super.key,
    required this.audioPath,
    this.tooltip = 'Escuchar pronunciación en Náhuatl',
    this.iconSize = 22.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioService = ref.watch(audioServiceProvider);

    // Validación estricta de UI Defensiva
    if (!audioService.canPlay(audioPath)) {
      return const SizedBox.shrink();
    }

    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.jadeLight,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => audioService.playAsset(audioPath),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.volume_up_rounded,
              size: iconSize,
              color: AppColors.jadePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
