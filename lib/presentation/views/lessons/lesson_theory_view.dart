import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/sublesson.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/app_action_button.dart';
import '../../widgets/common/responsive_scaffold.dart';

/// Provider familiar para consultar las reglas gramaticales de una lección específica.
final lessonGrammarRulesProvider =
    FutureProvider.autoDispose.family<List<GrammarRuleEntity>, int>((ref, lessonId) async {
  final grammarRepo = ref.watch(grammarRepositoryProvider);
  return grammarRepo.getGrammarRulesByLesson(lessonId);
});

/// Provider familiar para consultar el detalle de una sublección específica.
final sublessonDetailProvider =
    FutureProvider.autoDispose.family<SublessonEntity?, int>((ref, sublessonId) async {
  final sublessonRepo = ref.watch(sublessonRepositoryProvider);
  return sublessonRepo.getSublessonById(sublessonId);
});

/// Vista responsiva para estudiar lecciones o puntos de carácter teórico, ortográfico o explicativo.
@RoutePage()
class LessonTheoryView extends ConsumerWidget {
  final int lessonId;
  final int? sublessonId;
  final String lessonTitle;

  const LessonTheoryView({
    super.key,
    @PathParam('lessonId') required this.lessonId,
    @queryParam this.sublessonId,
    this.lessonTitle = 'Teoría de la Lección',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(lessonGrammarRulesProvider(lessonId));
    final sublessonAsync = sublessonId != null
        ? ref.watch(sublessonDetailProvider(sublessonId!))
        : null;

    final lessonMapState = ref.watch(lessonMapControllerProvider);
    final currentLesson =
        lessonMapState.lessons.where((l) => l.id == lessonId).firstOrNull;

    final isAlreadyCompleted = sublessonId != null
        ? (sublessonAsync?.value?.isCompleted ?? false)
        : (currentLesson?.isCompleted ?? false);

    return ResponsiveScaffold(
      appBar: AppBar(
        title: Text(
          lessonTitle,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColors.cardSurface,
          border: Border(
            top: BorderSide(color: AppColors.borderOutline, width: 1.5),
          ),
        ),
        child: SafeArea(
          top: false,
          child: isAlreadyCompleted
              ? AppActionButton(
                  label: sublessonId != null
                      ? 'Punto ya completado'
                      : 'Lección ya completada',
                  icon: Icons.check_circle_outline_rounded,
                  variant: AppButtonVariant.secondary,
                  onPressed: () {
                    context.router.maybePop();
                  },
                )
              : AppActionButton(
                  label: sublessonId != null
                      ? 'Entendido, completar punto'
                      : 'Entendido, completar lección',
                  icon: Icons.check_circle_rounded,
                  onPressed: () async {
                    await _completeAndUnlockNext(context, ref);
                  },
                ),
        ),
      ),
      bodyBuilder: (context, info) {
        return rulesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Text(
              'No se pudo cargar la teoría: $err',
              style: const TextStyle(color: AppColors.errorRed),
            ),
          ),
          data: (rules) {
            final specificTheory = sublessonAsync?.value?.theoryContent?.trim();
            final hasSpecificTheory =
                specificTheory != null && specificTheory.isNotEmpty;

            return SingleChildScrollView(
              physics: MobilePlatformConfig.adaptiveScrollPhysics,
              padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TheoryHeaderCard(
                    lessonId: lessonId,
                    lessonTitle: lessonTitle,
                    info: info,
                  ),
                  SizedBox(height: info.verticalSpacing),
                  if (hasSpecificTheory)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: _GrammarSectionCard(
                        explanationText: specificTheory,
                        info: info,
                      ),
                    ),
                  if (rules.isEmpty && !hasSpecificTheory)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderOutline),
                      ),
                      child: Text(
                        'Esta lección introductoria te prepara para los siguientes temas del curso.',
                        style: TextStyle(
                          fontSize: info.scaleFont(15),
                          color: AppColors.slateMuted,
                        ),
                      ),
                    )
                  else
                    ...rules.map(
                      (rule) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: _GrammarSectionCard(
                          explanationText: rule.explanationText,
                          info: info,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _completeAndUnlockNext(BuildContext context, WidgetRef ref) async {
    final lessonRepo = ref.read(lessonRepositoryProvider);
    final sublessonRepo = ref.read(sublessonRepositoryProvider);

    if (sublessonId != null) {
      await sublessonRepo.completeSublesson(sublessonId!);
      final sublessons = await sublessonRepo.getSublessonsByLesson(lessonId);
      final currentIdx = sublessons.indexWhere((s) => s.id == sublessonId);
      if (currentIdx != -1 && currentIdx + 1 < sublessons.length) {
        final nextSub = sublessons[currentIdx + 1];
        if (!nextSub.isUnlocked) {
          await sublessonRepo.unlockSublesson(nextSub.id);
        }
      }
      final allCompleted = sublessons.every(
        (s) => s.id == sublessonId ? true : s.isCompleted,
      );
      if (allCompleted) {
        await lessonRepo.completeLesson(lessonId);
        final allLessons = await lessonRepo.getLessons();
        final currentLessonIdx = allLessons.indexWhere((l) => l.id == lessonId);
        if (currentLessonIdx != -1 && currentLessonIdx + 1 < allLessons.length) {
          final nextLesson = allLessons[currentLessonIdx + 1];
          if (!nextLesson.isUnlocked) {
            await lessonRepo.unlockLesson(nextLesson.id);
          }
        }
      }
    } else {
      await lessonRepo.completeLesson(lessonId);
      final allLessons = await lessonRepo.getLessons();
      final currentIndex = allLessons.indexWhere((l) => l.id == lessonId);
      if (currentIndex != -1 && currentIndex + 1 < allLessons.length) {
        final nextLesson = allLessons[currentIndex + 1];
        if (!nextLesson.isUnlocked) {
          await lessonRepo.unlockLesson(nextLesson.id);
        }
      }
    }

    // Refrescar mapa de lecciones para actualizar estado visual y candados
    ref.read(lessonMapControllerProvider.notifier).loadLessons();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Contenido completado! Has desbloqueado el siguiente paso.'),
          backgroundColor: AppColors.successGreen,
          duration: Duration(seconds: 2),
        ),
      );
      try {
        await context.router.maybePop(true);
      } catch (_) {
        if (context.mounted) {
          Navigator.of(context).maybePop(true);
        }
      }
    }
  }
}

class _TheoryHeaderCard extends StatelessWidget {
  final int lessonId;
  final String lessonTitle;
  final ResponsiveInfo info;

  const _TheoryHeaderCard({
    required this.lessonId,
    required this.lessonTitle,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final isIntro = lessonId == 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.jadeLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.jadePrimary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.jadePrimary, width: 1.5),
            ),
            child: Icon(
              isIntro ? Icons.lightbulb_rounded : Icons.auto_stories_rounded,
              color: AppColors.jadePrimary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isIntro ? 'LECCIÓN INTRODUCTORIA' : 'TEORÍA Y REGLAS CLÁSICAS',
                  style: TextStyle(
                    fontSize: info.scaleFont(11.5),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.jadeDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  lessonTitle,
                  style: TextStyle(
                    fontSize: info.scaleFont(19),
                    fontWeight: FontWeight.w900,
                    color: AppColors.obsidianText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrammarSectionCard extends StatelessWidget {
  final String explanationText;
  final ResponsiveInfo info;

  const _GrammarSectionCard({
    required this.explanationText,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
              const Icon(
                Icons.bookmark_added_rounded,
                size: 20,
                color: AppColors.goldHighlight,
              ),
              const SizedBox(width: 8),
              Text(
                'Contenido de estudio',
                style: TextStyle(
                  fontSize: info.scaleFont(13.5),
                  fontWeight: FontWeight.w700,
                  color: AppColors.slateMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            explanationText,
            style: TextStyle(
              fontSize: info.scaleFont(15.5),
              color: AppColors.obsidianText,
              height: 1.55,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
