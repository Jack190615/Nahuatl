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
/// Ejecuta de forma transparente el Seeding transaccional de Drift en la primera instalación
/// y adapta su distribución para celulares y tabletas (Android e iOS).
@RoutePage()
class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrapAsync = ref.watch(appBootstrapProvider);

    return ResponsiveScaffold(
      bodyBuilder: (context, info) {
        final isTabletLandscape =
            info.isTablet && info.orientation == Orientation.landscape;

        return SingleChildScrollView(
          physics: MobilePlatformConfig.adaptiveScrollPhysics,
          padding: EdgeInsets.symmetric(vertical: info.verticalSpacing * 1.5),
          child: isTabletLandscape
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _HeroBrandSection(info: info)),
                    const SizedBox(width: 36),
                    Expanded(
                      child: _WelcomeActionSection(
                        info: info,
                        bootstrapAsync: bootstrapAsync,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: info.verticalSpacing),
                    _HeroBrandSection(info: info),
                    SizedBox(height: info.verticalSpacing * 1.5),
                    _WelcomeActionSection(
                      info: info,
                      bootstrapAsync: bootstrapAsync,
                    ),
                  ],
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
    final emblemSize = info.isTablet ? 136.0 : (info.isCompactPhone ? 96.0 : 114.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: emblemSize,
          height: emblemSize,
          decoration: BoxDecoration(
            color: AppColors.jadeLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.jadePrimary, width: 3),
          ),
          child: Icon(
            Icons.auto_stories_rounded,
            size: emblemSize * 0.48,
            color: AppColors.jadePrimary,
          ),
        ),
        SizedBox(height: info.verticalSpacing),
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
            fontSize: info.scaleFont(30),
            fontWeight: FontWeight.w900,
            color: AppColors.obsidianText,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Aprende la lengua de los antiguos mexicanos mediante lecciones interactivas, gramática estructurada y diccionario offline con búsqueda instantánea.',
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

class _WelcomeActionSection extends StatelessWidget {
  final ResponsiveInfo info;
  final AsyncValue<bool> bootstrapAsync;

  const _WelcomeActionSection({
    required this.info,
    required this.bootstrapAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _FeatureHighlightTile(
          icon: Icons.extension_rounded,
          title: '10 Ejercicios Dinámicos por Lección',
          subtitle: 'Pares de vocabulario, constructor de oraciones y traducción libre.',
        ),
        const SizedBox(height: 12),
        const _FeatureHighlightTile(
          icon: Icons.search_rounded,
          title: 'Diccionario FTS5 100% Offline',
          subtitle: 'Búsqueda instantánea en Náhuatl y Español sin necesidad de internet.',
        ),
        const SizedBox(height: 12),
        const _FeatureHighlightTile(
          icon: Icons.volume_up_rounded,
          title: 'Audio Integrado',
          subtitle: 'Escucha la pronunciación clásica en los vocablos y frases disponibles.',
        ),
        SizedBox(height: info.verticalSpacing * 1.5),
        bootstrapAsync.when(
          data: (_) => Column(
            children: [
              AppActionButton(
                label: 'Comenzar a aprender',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  context.router.replace(const LessonMapRoute());
                },
              ),
              const SizedBox(height: 12),
              AppActionButton(
                label: 'Explorar Diccionario Náhuatl',
                icon: Icons.book_outlined,
                variant: AppButtonVariant.secondary,
                onPressed: () {
                  context.router.push(const DictionarySearchRoute());
                },
              ),
            ],
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
                label: 'Continuar al mapa de lecciones',
                onPressed: () => context.router.replace(const LessonMapRoute()),
              ),
            ],
          ),
        ),
        SizedBox(height: info.verticalSpacing * 1.25),
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
      ],
    );
  }
}

class _FeatureHighlightTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureHighlightTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderOutline, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.jadeLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.jadePrimary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: info.scaleFont(15),
                    fontWeight: FontWeight.w800,
                    color: AppColors.obsidianText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: info.scaleFont(13),
                    color: AppColors.slateMuted,
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
