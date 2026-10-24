import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';

/// Contenedor principal de la aplicación con barra de navegación inferior (BottomNavigationBar).
/// Integra las 4 secciones clave del ecosistema:
/// 1. Inicio / Bienvenida (con logo oficial e identidad de marca)
/// 2. Lecciones (Ruta interactiva de aprendizaje)
/// 3. Diccionario (Buscador offline FTS5)
/// 4. Blog (Cosmovisión, análisis de mitos y divulgación lingüística)
@RoutePage()
class MainShellView extends StatelessWidget {
  const MainShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        WelcomeRoute(),
        LessonMapRoute(),
        DictionarySearchRoute(),
        BlogRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            height: 64,
            backgroundColor: AppColors.cardSurface,
            surfaceTintColor: Colors.transparent,
            indicatorColor: AppColors.jadeLight,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: AppColors.jadePrimary, size: 24);
              }
              return const IconThemeData(color: AppColors.slateMuted, size: 24);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.jadeDark,
                );
              }
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.slateMuted,
              );
            }),
          ),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.borderOutline,
                  width: 1.0,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: tabsRouter.activeIndex,
              onDestinationSelected: tabsRouter.setActiveIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Inicio',
                  tooltip: 'Pantalla de Inicio',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book_rounded),
                  label: 'Lecciones',
                  tooltip: 'Ruta de Aprendizaje',
                ),
                NavigationDestination(
                  icon: Icon(Icons.translate_outlined),
                  selectedIcon: Icon(Icons.translate_rounded),
                  label: 'Diccionario',
                  tooltip: 'Buscador FTS5',
                ),
                NavigationDestination(
                  icon: Icon(Icons.auto_stories_outlined),
                  selectedIcon: Icon(Icons.auto_stories_rounded),
                  label: 'Blog',
                  tooltip: 'Blog y Cosmovisión',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
