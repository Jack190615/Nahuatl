import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/views/dictionary/dictionary_search_view.dart';
import '../../presentation/views/exercise/exercise_session_view.dart';
import '../../presentation/views/lessons/lesson_map_view.dart';
import '../../presentation/views/lessons/lesson_theory_view.dart';
import '../../presentation/views/welcome/welcome_view.dart';

part 'app_router.gr.dart';

/// Configuración central de navegación declarativa con `AutoRoute`.
/// Utiliza `RouteType.adaptive()` para emplear transiciones nativas de Material en Android
/// y transiciones Cupertino (swipe back) cuando se despliegue en iOS.
@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // Pantalla inicial de bienvenida (sin login)
        AutoRoute(
          page: WelcomeRoute.page,
          path: '/',
          initial: true,
        ),
        // Mapa principal de lecciones
        AutoRoute(
          page: LessonMapRoute.page,
          path: '/lessons',
        ),
        // Bucle interactivo de 10 ejercicios de una lección
        AutoRoute(
          page: ExerciseSessionRoute.page,
          path: '/lessons/:lessonId/practice',
        ),
        // Estudio de lección teórica, fonética o introductoria
        AutoRoute(
          page: LessonTheoryRoute.page,
          path: '/lessons/:lessonId/theory',
        ),
        // Buscador Full-Text Search (FTS5)
        AutoRoute(
          page: DictionarySearchRoute.page,
          path: '/dictionary',
        ),
      ];
}

/// Provider de Riverpod para inyectar el router en `MaterialApp.router`.
final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
