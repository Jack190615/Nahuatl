import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/responsive/responsive_info.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/app_action_button.dart';
import '../../widgets/common/responsive_scaffold.dart';

/// Pantalla Inicial de Bienvenida (sin login).
/// Diseño limpio y enfocado: Logo de Huehuetéotl, Título, Subtítulo, Botón de inicio y marca.
@RoutePage()
class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrapAsync = ref.watch(appBootstrapProvider);

    return ResponsiveScaffold(
      bodyBuilder: (context, info) {
        return Center(
          child: SingleChildScrollView(
            physics: MobilePlatformConfig.adaptiveScrollPhysics,
            padding: EdgeInsets.symmetric(
              vertical: info.verticalSpacing * 2,
              horizontal: info.isTablet ? 32 : 12,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeroBrandSection(info: info),
                  SizedBox(height: info.verticalSpacing * 2.2),
                  _WelcomeActionSection(
                    info: info,
                    bootstrapAsync: bootstrapAsync,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroBrandSection extends StatelessWidget {
  final ResponsiveInfo info;

  const _HeroBrandSection({required this.info});

  @override
  Widget build(BuildContext context) {
    final emblemSize =
        info.isTablet ? 152.0 : (info.isCompactPhone ? 112.0 : 132.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logotipo oficial con la imagen de Huehuetéotl (assets/huehueteotl.jpg)
        Container(
          width: emblemSize,
          height: emblemSize,
          decoration: BoxDecoration(
            color: AppColors.jadeLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.jadePrimary, width: 3.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.jadePrimary.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/huehueteotl.jpg',
              width: emblemSize,
              height: emblemSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.auto_stories_rounded,
                size: emblemSize * 0.48,
                color: AppColors.jadePrimary,
              ),
            ),
          ),
        ),
        SizedBox(height: info.verticalSpacing * 1.25),
        Text(
          'Niltze! · ¡Bienvenido!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: info.scaleFont(15),
            fontWeight: FontWeight.w700,
            color: AppColors.terracottaAccent,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Náhuatl Clásico',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: info.scaleFont(32),
            fontWeight: FontWeight.w900,
            color: AppColors.obsidianText,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Aprende la lengua de los antiguos mexicanos mediante lecciones interactivas, gramática estructurada, diccionario offline y análisis de mitos.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: info.scaleFont(15),
            color: AppColors.slateMuted,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _WelcomeActionSection extends ConsumerWidget {
  final ResponsiveInfo info;
  final AsyncValue<bool> bootstrapAsync;

  const _WelcomeActionSection({
    required this.info,
    required this.bootstrapAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        bootstrapAsync.when(
          data: (_) => AppActionButton(
            label: 'Comenzar a aprender',
            icon: Icons.arrow_forward_rounded,
            onPressed: () {
              try {
                // Si está dentro del Shell con BottomNavigationBar, cambia suavemente a la pestaña de Lecciones
                final tabsRouter = AutoTabsRouter.of(context, watch: false);
                tabsRouter.setActiveIndex(1);
              } catch (_) {
                // Fallback si la vista se prueba de manera aislada
                context.router.push(const LessonMapRoute());
              }
            },
          ),
          loading: () => const AppActionButton(
            label: 'Preparando base de datos local...',
            isLoading: true,
            onPressed: null,
          ),
          error: (err, _) => Column(
            children: [
              Text(
                'Aviso al inicializar datos: $err',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.errorRed),
              ),
              const SizedBox(height: 12),
              AppActionButton(
                label: 'Continuar a las lecciones',
                onPressed: () {
                  try {
                    final tabsRouter = AutoTabsRouter.of(context, watch: false);
                    tabsRouter.setActiveIndex(1);
                  } catch (_) {
                    context.router.push(const LessonMapRoute());
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: info.verticalSpacing * 1.5),
        Center(
          child: Text(
            "powered by Axolot's Studios",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: info.scaleFont(12.5),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: AppColors.slateMuted,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.slateMuted,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            icon: const Icon(Icons.sync_rounded, size: 15),
            label: Text(
              'Recargar base de datos local',
              style: TextStyle(
                fontSize: info.scaleFont(11),
                color: AppColors.slateMuted,
              ),
            ),
            onPressed: () async {
              final seeder = ref.read(databaseSeederServiceProvider);
              await seeder.forceReseed();
              ref.invalidate(appBootstrapProvider);
              ref.read(lessonMapControllerProvider.notifier).loadLessons();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✓ Base de datos local recargada con éxito'),
                    backgroundColor: AppColors.successGreen,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
