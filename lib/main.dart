import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/platform/mobile_platform_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  // Configuración de interfaz móvil (Android en Etapa 1, listo para iOS)
  await MobilePlatformConfig.configureSystemUI();

  runApp(
    const ProviderScope(
      child: NahuatlClasicoApp(),
    ),
  );
}

class NahuatlClasicoApp extends ConsumerWidget {
  const NahuatlClasicoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Náhuatl Clásico',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter.config(),
    );
  }
}
