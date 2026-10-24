import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/lesson.dart';
import '../common/app_action_button.dart';

/// Tarjeta reutilizable y responsiva adaptada a las diferentes modalidades de lección:
/// 1. Práctica interactiva (con frases).
/// 2. Teoría / Ortografía / Introducción (sin frases).
/// 3. Próximamente (en desarrollo).
class LessonCardWidget extends StatelessWidget {
  final LessonEntity lesson;
  final List<GrammarRuleEntity> grammarRules;
  final LessonType lessonType;
  final VoidCallback onStartLesson;

  const LessonCardWidget({
    super.key,
    required this.lesson,
    required this.grammarRules,
    required this.lessonType,
    required this.onStartLesson,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final isUnlocked = lesson.isUnlocked;

    // Configuración visual según modalidad
    final (IconData avatarIcon, Color avatarBg, Color avatarColor, String tagLabel) = switch (lessonType) {
      LessonType.practice => (
          Icons.play_circle_fill_rounded,
          AppColors.jadeLight,
          AppColors.jadePrimary,
          'Práctica (Frases)',
        ),
      LessonType.theory => (
          Icons.menu_book_rounded,
          AppColors.jadeLight,
          AppColors.jadeDark,
          lesson.id == 1 ? 'Introducción' : 'Reglas y Ortografía',
        ),
      LessonType.comingSoon => (
          Icons.hourglass_top_rounded,
          AppColors.borderOutline.withValues(alpha: 0.5),
          AppColors.slateMuted,
          'Próximamente',
        ),
    };

    final String buttonLabel = switch (lessonType) {
      _ when !isUnlocked => 'Bloqueada',
      LessonType.theory => lesson.id == 1 ? 'Ver introducción' : 'Estudiar lección',
      LessonType.practice => 'Practicar (10 ejercicios)',
      LessonType.comingSoon => 'Más lecciones próximamente',
    };

    final IconData buttonIcon = switch (lessonType) {
      _ when !isUnlocked => Icons.lock_outline,
      LessonType.theory => Icons.auto_stories_rounded,
      LessonType.practice => Icons.play_arrow_rounded,
      LessonType.comingSoon => Icons.schedule_rounded,
    };

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
                  backgroundColor: isUnlocked ? avatarBg : AppColors.borderOutline,
                  child: Icon(
                    isUnlocked ? avatarIcon : Icons.lock_rounded,
                    color: isUnlocked ? avatarColor : AppColors.slateMuted,
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
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: isUnlocked
                                  ? AppColors.jadeLight
                                  : AppColors.borderOutline.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tagLabel,
                              style: TextStyle(
                                fontSize: info.scaleFont(10.5),
                                fontWeight: FontWeight.w700,
                                color: isUnlocked ? AppColors.jadeDark : AppColors.slateMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
              label: buttonLabel,
              icon: buttonIcon,
              variant: lessonType == LessonType.comingSoon || !isUnlocked
                  ? AppButtonVariant.secondary
                  : AppButtonVariant.primary,
              onPressed: (isUnlocked && lessonType != LessonType.comingSoon)
                  ? onStartLesson
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
