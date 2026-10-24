import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/responsive/responsive_info.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/responsive_scaffold.dart';
import '../../widgets/lesson/lesson_card_widget.dart';

/// Vista principal del Mapa de Lecciones.
/// Adapta automáticamente el listado a 1 columna en celulares o 2 columnas en tabletas,
/// e incluye estados de "Más lecciones próximamente" para lecciones aún sin frases.
@RoutePage()
class LessonMapView extends ConsumerWidget {
  const LessonMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonMapControllerProvider);

    return ResponsiveScaffold(
      appBar: AppBar(
        title: const Text(
          'Ruta de Aprendizaje',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Diccionario FTS5',
            icon: const Icon(Icons.translate_rounded),
            onPressed: () {
              context.router.push(const DictionarySearchRoute());
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

        // En tabletas grandes o modo horizontal se organiza en grilla de 2 columnas
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
                    final hasPhrases = (state.phrasesCountByLesson[lesson.id] ?? 0) > 0;

                    return LessonCardWidget(
                      lesson: lesson,
                      grammarRules: rules,
                      hasPhrases: hasPhrases,
                      onStartLesson: () async {
                        await context.router.push(
                          ExerciseSessionRoute(
                            lessonId: lesson.id,
                            lessonTitle: lesson.title,
                          ),
                        );
                        ref.read(lessonMapControllerProvider.notifier).loadLessons();
                      },
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
          itemCount: lessons.length + 1, // +1 para el footer de más lecciones
          itemBuilder: (context, index) {
            if (index == lessons.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: _ComingSoonRoadmapFooter(info: info),
              );
            }

            final lesson = lessons[index];
            final rules = state.grammarRulesByLesson[lesson.id] ?? const [];
            final hasPhrases = (state.phrasesCountByLesson[lesson.id] ?? 0) > 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: LessonCardWidget(
                lesson: lesson,
                grammarRules: rules,
                hasPhrases: hasPhrases,
                onStartLesson: () async {
                  await context.router.push(
                    ExerciseSessionRoute(
                      lessonId: lesson.id,
                      lessonTitle: lesson.title,
                    ),
                  );
                  ref.read(lessonMapControllerProvider.notifier).loadLessons();
                },
              ),
            );
          },
        );
      },
    );
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
                  'Estamos expandiendo la ruta de aprendizaje con nuevas frases, vocabulario y ejercicios interactivos.',
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
