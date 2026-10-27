import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/mobile_platform_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/responsive_scaffold.dart';
import '../../widgets/dictionary/dictionary_entry_card.dart';

/// Vista responsiva del Diccionario con soporte Full-Text Search (FTS5) en SQLite.
@RoutePage()
class DictionarySearchView extends ConsumerWidget {
  const DictionarySearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(dictionarySearchControllerProvider);
    final controller = ref.read(dictionarySearchControllerProvider.notifier);

    return ResponsiveScaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Volver a Inicio',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            try {
              final tabsRouter = AutoTabsRouter.of(context, watch: false);
              tabsRouter.setActiveIndex(0);
            } catch (_) {
              context.router.maybePop();
            }
          },
        ),
        title: const Text(
          'Diccionario Náhuatl (FTS5)',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      bodyBuilder: (context, info) {
        return Column(
          children: [
            SizedBox(height: info.verticalSpacing * 0.5),
            TextField(
              onChanged: controller.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Buscar en náhuatl o español (ej. atl, calli, agua)...',
              ),
            ),
            SizedBox(height: info.verticalSpacing * 0.75),
            if (!searchState.isLoading && searchState.results.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
                child: Row(
                  children: [
                    Text(
                      '${searchState.results.length} vocablos',
                      style: TextStyle(
                        fontSize: info.scaleFont(12.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.jadeDark,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.sort_by_alpha_rounded,
                      size: 16,
                      color: AppColors.slateMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Orden alfabético (A-Z)',
                      style: TextStyle(
                        fontSize: info.scaleFont(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: searchState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : searchState.results.isEmpty
                      ? Center(
                          child: Text(
                            'No se encontraron vocablos para "${searchState.query}".',
                            style: TextStyle(
                              fontSize: info.scaleFont(15),
                              color: AppColors.slateMuted,
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: MobilePlatformConfig.adaptiveScrollPhysics,
                          padding: EdgeInsets.only(bottom: info.verticalSpacing),
                          itemCount: searchState.results.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return DictionaryEntryCard(
                              entry: searchState.results[index],
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}
