import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/responsive_scaffold.dart';

/// Módulo de Blog y Divulgación Cultural.
/// Espacio dedicado al análisis de mitos, análisis crítico del lenguaje,
/// cosmovisión y filosofía en Náhuatl Clásico.
@RoutePage()
class BlogView extends StatelessWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Blog y Cosmovisión',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      bodyBuilder: (context, info) {
        return SingleChildScrollView(
          physics: MobilePlatformConfig.adaptiveScrollPhysics,
          padding: EdgeInsets.symmetric(vertical: info.verticalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroBlogBanner(info: info),
              SizedBox(height: info.verticalSpacing * 1.5),
              Row(
                children: [
                  const Icon(
                    Icons.auto_stories_rounded,
                    color: AppColors.goldHighlight,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Próximas Publicaciones',
                    style: TextStyle(
                      fontSize: info.scaleFont(18),
                      fontWeight: FontWeight.w800,
                      color: AppColors.obsidianText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _BlogTopicCard(
                category: 'ANÁLISIS DE MITOS',
                title: 'El mito del Quinto Sol (Nāhui Ollin) y la creación humana',
                summary:
                    'Estudio lingüístico del relato de Quetzalcóatl en el Mictlan para rescatar los huesos preciosos de las generaciones anteriores.',
                estimatedDate: 'Próximamente',
              ),
              const SizedBox(height: 14),
              const _BlogTopicCard(
                category: 'CRÍTICA DEL LENGUAJE',
                title: 'Los difrasismos: La poesía conceptual del náhuatl',
                summary:
                    'Cómo dos términos yuxtapuestos crean un tercer concepto metafórico profundo, como "In xōchitl in cuīcatl" (la flor y el canto: arte/verdad).',
                estimatedDate: 'Próximamente',
              ),
              const SizedBox(height: 14),
              const _BlogTopicCard(
                category: 'FILOSOFÍA MESOAMERICANA',
                title: 'Teōtl y la naturaleza del cosmos en los tlamatinimeh',
                summary:
                    'Exploración filosófica sobre el concepto de lo sagrado y el dinamismo del universo según los sabios de la tradición clásica.',
                estimatedDate: 'Próximamente',
              ),
              SizedBox(height: info.verticalSpacing),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.jadeLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.jadePrimary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.school_rounded,
                      color: AppColors.jadePrimary,
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Contenido académico y pedagógico en desarrollo activo junto con docentes de Náhuatl Clásico.',
                        style: TextStyle(
                          fontSize: info.scaleFont(13.5),
                          color: AppColors.jadeDark,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _HeroBlogBanner extends StatelessWidget {
  final ResponsiveInfo info;

  const _HeroBlogBanner({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(info.isTablet ? 24 : 18),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderOutline, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.goldHighlight.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'PRÓXIMAMENTE',
                  style: TextStyle(
                    fontSize: info.scaleFont(11),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.goldHighlight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Análisis Crítico & Pensamiento Clásico',
            style: TextStyle(
              fontSize: info.scaleFont(22),
              fontWeight: FontWeight.w900,
              color: AppColors.obsidianText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Un espacio para ir más allá de la gramática: adéntrate en la cosmogonía, la literatura oral y el pensamiento de los pueblos nahuas.',
            style: TextStyle(
              fontSize: info.scaleFont(14.5),
              color: AppColors.slateMuted,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogTopicCard extends StatelessWidget {
  final String category;
  final String title;
  final String summary;
  final String estimatedDate;

  const _BlogTopicCard({
    required this.category,
    required this.title,
    required this.summary,
    required this.estimatedDate,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: info.scaleFont(11),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: AppColors.terracottaAccent,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.borderOutline.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    estimatedDate,
                    style: TextStyle(
                      fontSize: info.scaleFont(10.5),
                      fontWeight: FontWeight.w700,
                      color: AppColors.slateMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: info.scaleFont(16.5),
                fontWeight: FontWeight.w800,
                color: AppColors.obsidianText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              summary,
              style: TextStyle(
                fontSize: info.scaleFont(13.5),
                color: AppColors.slateMuted,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
