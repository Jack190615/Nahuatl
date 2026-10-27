import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/lesson.dart';
import '../../../domain/entities/sublesson.dart';
import '../common/app_action_button.dart';

/// Tarjeta reutilizable y responsiva adaptada a las diferentes modalidades de lección
/// y con soporte para subdivisión de puntos pedagógicos (Sublecciones):
/// 1. Práctica interactiva (con frases).
/// 2. Teoría / Ortografía / Introducción (sin frases).
/// 3. Modular con Sublecciones (Puntos 4, 5, 6, 7-9, etc.).
/// 4. Próximamente (en desarrollo).
class LessonCardWidget extends StatelessWidget {
  final LessonEntity lesson;
  final List<SublessonEntity> sublessons;
  final List<GrammarRuleEntity> grammarRules;
  final LessonType lessonType;
  final VoidCallback onStartLesson;
  final void Function(SublessonEntity sublesson)? onStartSublesson;

  const LessonCardWidget({
    super.key,
    required this.lesson,
    this.sublessons = const [],
    required this.grammarRules,
    required this.lessonType,
    required this.onStartLesson,
    this.onStartSublesson,
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
      _ when sublessons.isNotEmpty => 'Explorar subtemas (${sublessons.length})',
      LessonType.theory => lesson.isCompleted
          ? 'Repasar teoría'
          : (lesson.id == 1 ? 'Ver introducción' : 'Estudiar lección'),
      LessonType.practice => lesson.isCompleted
          ? 'Volver a practicar'
          : 'Practicar (10 ejercicios)',
      LessonType.comingSoon => 'Más lecciones próximamente',
    };

    final IconData buttonIcon = switch (lessonType) {
      _ when !isUnlocked => Icons.lock_outline,
      _ when sublessons.isNotEmpty => Icons.format_list_bulleted_rounded,
      _ when lesson.isCompleted => Icons.refresh_rounded,
      LessonType.theory => Icons.auto_stories_rounded,
      LessonType.practice => Icons.play_arrow_rounded,
      LessonType.comingSoon => Icons.schedule_rounded,
    };

    final lessonNumberText = lesson.romanNumber != null && lesson.romanNumber!.trim().isNotEmpty
        ? 'Lección ${lesson.romanNumber}'
        : 'Lección ${lesson.orderIndex}';

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
                            lessonNumberText,
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
                              sublessons.isNotEmpty ? '${sublessons.length} subpuntos' : tagLabel,
                              style: TextStyle(
                                fontSize: info.scaleFont(10.5),
                                fontWeight: FontWeight.w700,
                                color: isUnlocked ? AppColors.jadeDark : AppColors.slateMuted,
                              ),
                            ),
                          ),
                          if (lesson.isCompleted) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.successSurface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.successGreen.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 11,
                                    color: AppColors.successGreen,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    'Completada',
                                    style: TextStyle(
                                      fontSize: info.scaleFont(10),
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.successGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                      if (lesson.description != null && lesson.description!.trim().isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          lesson.description!,
                          style: TextStyle(
                            fontSize: info.scaleFont(13),
                            color: AppColors.slateMuted,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Si la lección cuenta con sublecciones (puntos del libro), mostrarlos como pasos interactivos
            if (sublessons.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(color: AppColors.borderOutline),
              const SizedBox(height: 6),
              ...sublessons.map(
                (sublesson) => _SublessonItemTile(
                  sublesson: sublesson,
                  info: info,
                  isParentUnlocked: isUnlocked,
                  onTap: () {
                    if (isUnlocked && onStartSublesson != null) {
                      onStartSublesson!(sublesson);
                    }
                  },
                ),
              ),
            ] else if (grammarRules.isNotEmpty) ...[
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

class _SublessonItemTile extends StatelessWidget {
  final SublessonEntity sublesson;
  final ResponsiveInfo info;
  final bool isParentUnlocked;
  final VoidCallback onTap;

  const _SublessonItemTile({
    required this.sublesson,
    required this.info,
    required this.isParentUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (IconData typeIcon, Color typeColor, String typeTag) = switch (sublesson.type) {
      SublessonType.theory => (
          Icons.auto_stories_rounded,
          AppColors.jadeDark,
          'Teoría',
        ),
      SublessonType.vocabulary => (
          Icons.translate_rounded,
          AppColors.terracottaAccent,
          'Vocabulario',
        ),
      SublessonType.phrases => (
          Icons.play_circle_outline_rounded,
          AppColors.jadePrimary,
          'Práctica',
        ),
    };

    return InkWell(
      onTap: isParentUnlocked ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(typeIcon, size: 16, color: typeColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punto ${sublesson.pointNumber}: ${sublesson.title}',
                    style: TextStyle(
                      fontSize: info.scaleFont(13.5),
                      fontWeight: FontWeight.w700,
                      color: isParentUnlocked ? AppColors.obsidianText : AppColors.slateMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            if (sublesson.isCompleted) ...[
              const Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: AppColors.successGreen,
              ),
              const SizedBox(width: 4),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                typeTag,
                style: TextStyle(
                  fontSize: info.scaleFont(10),
                  fontWeight: FontWeight.w700,
                  color: typeColor,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: isParentUnlocked ? AppColors.slateMuted : AppColors.borderOutline,
            ),
          ],
        ),
      ),
    );
  }
}
