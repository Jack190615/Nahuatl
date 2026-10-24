import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/lesson.dart';
import '../common/app_action_button.dart';

/// Tarjeta reutilizable y responsiva para mostrar una lección y sus reglas gramaticales.
class LessonCardWidget extends StatelessWidget {
  final LessonEntity lesson;
  final List<GrammarRuleEntity> grammarRules;
  final VoidCallback onStartLesson;

  const LessonCardWidget({
    super.key,
    required this.lesson,
    required this.grammarRules,
    required this.onStartLesson,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final isUnlocked = lesson.isUnlocked;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(info.isTablet ? 22.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: info.isTablet ? 24 : 20,
                  backgroundColor: isUnlocked
                      ? AppColors.jadeLight
                      : AppColors.borderOutline,
                  child: Icon(
                    isUnlocked ? Icons.menu_book_rounded : Icons.lock_rounded,
                    color: isUnlocked
                        ? AppColors.jadePrimary
                        : AppColors.slateMuted,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lección ${lesson.orderIndex}',
                        style: TextStyle(
                          fontSize: info.scaleFont(12),
                          fontWeight: FontWeight.w700,
                          color: isUnlocked
                              ? AppColors.jadePrimary
                              : AppColors.slateMuted,
                        ),
                      ),
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: info.scaleFont(18),
                          fontWeight: FontWeight.w800,
                          color: isUnlocked
                              ? AppColors.obsidianText
                              : AppColors.slateMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (grammarRules.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(color: AppColors.borderOutline),
              const SizedBox(height: 8),
              ...grammarRules.map(
                (rule) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 16,
                        color: AppColors.goldHighlight,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          rule.explanationText,
                          style: TextStyle(
                            fontSize: info.scaleFont(13.5),
                            color: AppColors.slateMuted,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 14),
            AppActionButton(
              label: isUnlocked ? 'Practicar (10 ejercicios)' : 'Bloqueada',
              icon: isUnlocked ? Icons.play_arrow_rounded : Icons.lock_outline,
              onPressed: isUnlocked ? onStartLesson : null,
            ),
          ],
        ),
      ),
    );
  }
}
