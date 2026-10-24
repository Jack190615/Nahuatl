import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/exercise.dart';
import '../common/defensive_audio_button.dart';

/// Widget reutilizable para el Ejercicio 3: Text Input (Traducción Libre).
class TextInputExerciseWidget extends StatefulWidget {
  final TextInputExercise exercise;
  final String currentInput;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;

  const TextInputExerciseWidget({
    super.key,
    required this.exercise,
    required this.currentInput,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<TextInputExerciseWidget> createState() =>
      _TextInputExerciseWidgetState();
}

class _TextInputExerciseWidgetState extends State<TextInputExerciseWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentInput);
  }

  @override
  void didUpdateWidget(covariant TextInputExerciseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.exerciseId != widget.exercise.exerciseId) {
      _controller.text = widget.currentInput;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escribe la traducción al español',
          style: TextStyle(
            fontSize: info.scaleFont(20),
            fontWeight: FontWeight.w800,
            color: AppColors.obsidianText,
          ),
        ),
        SizedBox(height: info.verticalSpacing),
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
              // UI Defensiva: solo aparece si `audioPath` no es nulo
              DefensiveAudioButton(audioPath: widget.exercise.audioPath),
              if (widget.exercise.hasAudio) const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.exercise.promptSentence,
                  style: TextStyle(
                    fontSize: info.scaleFont(19),
                    fontWeight: FontWeight.w800,
                    color: AppColors.jadeDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: info.verticalSpacing),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          onSubmitted: (_) => widget.onSubmitted(),
          textInputAction: TextInputAction.done,
          maxLines: info.isTablet ? 4 : 3,
          style: TextStyle(
            fontSize: info.scaleFont(16),
            color: AppColors.obsidianText,
          ),
          decoration: const InputDecoration(
            hintText: 'Escribe aquí tu traducción (sin importar mayúsculas o signos)...',
          ),
        ),
      ],
    );
  }
}
