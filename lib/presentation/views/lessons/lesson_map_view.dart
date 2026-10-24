import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/responsive_scaffold.dart';
import '../../widgets/lesson/lesson_card_widget.dart';

/// Vista principal del Mapa de Lecciones.
/// Adapta automáticamente el listado a 1 columna en celulares o 2 columnas en tabletas.
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
          return GridView.builder(
            physics: MobilePlatformConfig.adaptiveScrollPhysics,
            padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 280,
            ),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final rules = state.grammarRulesByLesson[lesson.id] ?? const [];
              return LessonCardWidget(
                lesson: lesson,
                grammarRules: rules,
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
          );
        }

        return ListView.separated(
          physics: MobilePlatformConfig.adaptiveScrollPhysics,
          padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
          itemCount: lessons.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            final rules = state.grammarRulesByLesson[lesson.id] ?? const [];
            return LessonCardWidget(
              lesson: lesson,
              grammarRules: rules,
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
        );
      },
    );
  }
}
