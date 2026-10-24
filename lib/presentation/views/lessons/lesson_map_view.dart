import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/responsive/responsive_info.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/grammar_rule.dart';
import '../../../domain/entities/lesson.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/responsive_scaffold.dart';
import '../../widgets/lesson/lesson_card_widget.dart';

/// Vista principal del Mapa de Lecciones.
/// Clasifica inteligentemente cada lección en:
/// 1. Práctica (cuando cuenta con oraciones interactivas).
/// 2. Teoría / Ortografía / Introducción (cuando es de lectura o reglas fonéticas).
/// 3. Próximamente (cuando está en desarrollo).
@RoutePage()
class LessonMapView extends ConsumerWidget {
  const LessonMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonMapControllerProvider);

    return ResponsiveScaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Volver a Inicio',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.router.canPop()) {
              context.router.maybePop();
            } else {
              try {
                final tabsRouter = AutoTabsRouter.of(context, watch: false);
                tabsRouter.setActiveIndex(0);
              } catch (_) {
                context.router.maybePop();
              }
            }
          },
        ),
        title: const Text(
          'Ruta de Aprendizaje',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Diccionario FTS5',
            icon: const Icon(Icons.translate_rounded),
            onPressed: () {
              try {
                final tabsRouter = AutoTabsRouter.of(context, watch: false);
                tabsRouter.setActiveIndex(2);
              } catch (_) {
                context.router.push(const DictionarySearchRoute());
              }
            },
          ),
        ],
      ),
      bodyBuilder: (context, info) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(color: AppColors.errorRed),
            ),
          );
        }

        final lessons = state.lessons;

        if (info.gridColumns > 1) {
          return SingleChildScrollView(
            physics: MobilePlatformConfig.adaptiveScrollPhysics,
            padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 290,
                  ),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index];
                    final rules = state.grammarRulesByLesson[lesson.id] ?? const [];
                    final phrasesCount = state.phrasesCountByLesson[lesson.id] ?? 0;
                    final type = _resolveLessonType(
                      lesson: lesson,
                      phrasesCount: phrasesCount,
                      rules: rules,
                    );

                    return LessonCardWidget(
                      lesson: lesson,
                      grammarRules: rules,
                      lessonType: type,
                      onStartLesson: () => _handleLessonNavigation(
                        context: context,
                        ref: ref,
                        lesson: lesson,
                        lessonType: type,
                      ),
                    );
                  },
                ),
                SizedBox(height: info.verticalSpacing),
                _ComingSoonRoadmapFooter(info: info),
              ],
            ),
          );
        }

        return ListView.builder(
          physics: MobilePlatformConfig.adaptiveScrollPhysics,
          padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
          itemCount: lessons.length + 1,
          itemBuilder: (context, index) {
            if (index == lessons.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: _ComingSoonRoadmapFooter(info: info),
              );
            }

            final lesson = lessons[index];
            final rules = state.grammarRulesByLesson[lesson.id] ?? const [];
            final phrasesCount = state.phrasesCountByLesson[lesson.id] ?? 0;
            final type = _resolveLessonType(
              lesson: lesson,
              phrasesCount: phrasesCount,
              rules: rules,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: LessonCardWidget(
                lesson: lesson,
                grammarRules: rules,
                lessonType: type,
                onStartLesson: () => _handleLessonNavigation(
                  context: context,
                  ref: ref,
                  lesson: lesson,
                  lessonType: type,
                ),
              ),
            );
          },
        );
      },
    );
  }

  LessonType _resolveLessonType({
    required LessonEntity lesson,
    required int phrasesCount,
    required List<GrammarRuleEntity> rules,
  }) {
    // Si tiene frases, es interactiva práctica
    if (phrasesCount > 0) {
      return LessonType.practice;
    }
    // Si tiene reglas gramaticales, ortografía o es introductoria
    if (rules.isNotEmpty || lesson.id <= 2) {
      return LessonType.theory;
    }
    // Si no tiene contenido todavía cargado
    return LessonType.comingSoon;
  }

  Future<void> _handleLessonNavigation({
    required BuildContext context,
    required WidgetRef ref,
    required LessonEntity lesson,
    required LessonType lessonType,
  }) async {
    if (lessonType == LessonType.theory) {
      await context.router.push(
        LessonTheoryRoute(
          lessonId: lesson.id,
          lessonTitle: lesson.title,
        ),
      );
    } else if (lessonType == LessonType.practice) {
      await context.router.push(
        ExerciseSessionRoute(
          lessonId: lesson.id,
          lessonTitle: lesson.title,
        ),
      );
    }
    ref.read(lessonMapControllerProvider.notifier).loadLessons();
  }
}

class _ComingSoonRoadmapFooter extends StatelessWidget {
  final ResponsiveInfo info;

  const _ComingSoonRoadmapFooter({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderOutline,
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.jadeLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.goldHighlight,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Más lecciones próximamente',
                  style: TextStyle(
                    fontSize: info.scaleFont(15.5),
                    fontWeight: FontWeight.w800,
                    color: AppColors.obsidianText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Estamos expandiendo la ruta con nuevas lecciones teóricas y oraciones interactivas.',
                  style: TextStyle(
                    fontSize: info.scaleFont(13),
                    color: AppColors.slateMuted,
                    height: 1.35,
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
