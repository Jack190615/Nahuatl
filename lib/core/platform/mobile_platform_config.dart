import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Abstracción y utilidades de plataforma móvil.
/// Etapa 1: Android prioritario.
/// Preparado nativamente para adaptarse a iOS sin modificar las vistas.
class MobilePlatformConfig {
  MobilePlatformConfig._();

  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Configura el estilo de la barra de estado y navegación del sistema operativo
  /// (Edge-to-Edge en Android y brillo adaptativo para iOS).
  static Future<void> configureSystemUI() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // En tabletas se permite rotación horizontal adicionalmente si se desea
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // Para iOS
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Devuelve la física de scroll nativa según la plataforma móvil (Android vs iOS).
  static ScrollPhysics get adaptiveScrollPhysics => isIOS
      ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
      : const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
