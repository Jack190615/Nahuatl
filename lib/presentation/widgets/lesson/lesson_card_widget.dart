import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/lesson.dart';
import '../common/app_action_button.dart';

/// Tarjeta reutilizable y responsiva para mostrar una lección y sus reglas gramaticales.
/// Soporta estado de "Más lecciones próximamente" cuando no hay frases registradas aún para su id.
class LessonCardWidget extends StatelessWidget {
  final LessonEntity lesson;
  final List<GrammarRuleEntity> grammarRules;
  final bool hasPhrases;
  final VoidCallback onStartLesson;

  const LessonCardWidget({
    super.key,
    required this.lesson,
    required this.grammarRules,
    this.hasPhrases = true,
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
                      ? (hasPhrases ? AppColors.jadeLight : AppColors.goldHighlight.withValues(alpha: 0.18))
                      : AppColors.borderOutline,
                  child: Icon(
                    isUnlocked
                        ? (hasPhrases ? Icons.menu_book_rounded : Icons.hourglass_top_rounded)
                        : Icons.lock_rounded,
                    color: isUnlocked
                        ? (hasPhrases ? AppColors.jadePrimary : AppColors.goldHighlight)
                        : AppColors.slateMuted,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                          if (isUnlocked && !hasPhrases) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.goldHighlight.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Próximamente',
                                style: TextStyle(
                                  fontSize: info.scaleFont(10.5),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.goldHighlight,
                                ),
                              ),
                            ),
                          ],
                        ],
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
              label: !isUnlocked
                  ? 'Bloqueada'
                  : (!hasPhrases
                      ? 'Más lecciones próximamente'
                      : 'Practicar (10 ejercicios)'),
              icon: !isUnlocked
                  ? Icons.lock_outline
                  : (!hasPhrases
                      ? Icons.hourglass_top_rounded
                      : Icons.play_arrow_rounded),
              variant: !hasPhrases && isUnlocked
                  ? AppButtonVariant.secondary
                  : AppButtonVariant.primary,
              onPressed: isUnlocked ? onStartLesson : null,
            ),
          ],
        ),
      ),
    );
  }
}
