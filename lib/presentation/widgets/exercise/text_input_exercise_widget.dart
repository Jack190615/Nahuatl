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
    final isComprehension =
        widget.exercise.direction == TranslationDirection.spanishToNahuatl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                isComprehension
                    ? 'Responde la pregunta en náhuatl'
                    : 'Escribe la traducción al español',
                style: TextStyle(
                  fontSize: info.scaleFont(20),
                  fontWeight: FontWeight.w800,
                  color: AppColors.obsidianText,
                ),
              ),
            ),
            if (widget.exercise.readingPassage != null)
              TextButton.icon(
                icon: const Icon(Icons.menu_book_rounded, size: 18),
                label: const Text('Ver lectura'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.jadePrimary,
                ),
                onPressed: () => _showReadingDialog(context, info),
              ),
          ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              if (widget.exercise.secondaryPrompt != null) ...[
                const SizedBox(height: 6),
                Text(
                  widget.exercise.secondaryPrompt!,
                  style: TextStyle(
                    fontSize: info.scaleFont(14),
                    fontStyle: FontStyle.italic,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: info.verticalSpacing),
        Actions(
          actions: widget.exercise.allowPaste
              ? const {}
              : {
                  PasteTextIntent: DoNothingAction(),
                },
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            onSubmitted: (_) => widget.onSubmitted(),
            textInputAction: TextInputAction.done,
            maxLines: info.isTablet ? 4 : 3,
            contextMenuBuilder: widget.exercise.allowPaste
                ? null
                : (context, editableTextState) {
                    final items = editableTextState.contextMenuButtonItems;
                    items.removeWhere(
                      (item) => item.type == ContextMenuButtonType.paste,
                    );
                    return AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: items,
                    );
                  },
            style: TextStyle(
              fontSize: info.scaleFont(16),
              color: AppColors.obsidianText,
            ),
            decoration: InputDecoration(
              hintText: isComprehension
                  ? 'Escribe tu respuesta en náhuatl...'
                  : 'Escribe aquí tu traducción (sin importar mayúsculas o signos)...',
            ),
          ),
        ),
        if (!widget.exercise.allowPaste) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.edit_note_rounded,
                size: 16,
                color: AppColors.slateMuted,
              ),
              const SizedBox(width: 6),
              Text(
                'Escritura manual requerida (pegado deshabilitado)',
                style: TextStyle(
                  fontSize: info.scaleFont(12),
                  fontWeight: FontWeight.w600,
                  color: AppColors.slateMuted,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showReadingDialog(BuildContext context, ResponsiveInfo info) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.borderOutline,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        color: AppColors.jadePrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Texto de Lectura',
                        style: TextStyle(
                          fontSize: info.scaleFont(18),
                          fontWeight: FontWeight.w800,
                          color: AppColors.obsidianText,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        widget.exercise.readingPassage ?? '',
                        style: TextStyle(
                          fontSize: info.scaleFont(16),
                          height: 1.6,
                          color: AppColors.obsidianText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
