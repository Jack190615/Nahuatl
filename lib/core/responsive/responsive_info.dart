import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Categorización de pantalla enfocada en dispositivos móviles (Celulares y Tabletas).
enum DeviceScreenType {
  /// Teléfonos compactos (< 360dp de ancho)
  mobileCompact,

  /// Teléfonos estándar (360dp - 599dp de ancho)
  mobileRegular,

  /// Tabletas pequeñas / Phablets en horizontal (600dp - 839dp)
  tabletSmall,

  /// Tabletas grandes (>= 840dp)
  tabletLarge,
}

/// Objeto de valor inmutable que encapsula las métricas responsivas de la vista actual.
@immutable
class ResponsiveInfo {
  final Size screenSize;
  final Orientation orientation;
  final DeviceScreenType deviceType;

  const ResponsiveInfo({
    required this.screenSize,
    required this.orientation,
    required this.deviceType,
  });

  factory ResponsiveInfo.fromContext(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.orientationOf(context);
    final shortestSide = mediaQuery.shortestSide;
    final width = mediaQuery.width;

    final DeviceScreenType type;
    if (shortestSide >= 600 || width >= 840) {
      type = width >= 840
          ? DeviceScreenType.tabletLarge
          : DeviceScreenType.tabletSmall;
    } else if (width < 360) {
      type = DeviceScreenType.mobileCompact;
    } else {
      type = DeviceScreenType.mobileRegular;
    }

    return ResponsiveInfo(
      screenSize: mediaQuery,
      orientation: orientation,
      deviceType: type,
    );
  }

  bool get isTablet =>
      deviceType == DeviceScreenType.tabletSmall ||
      deviceType == DeviceScreenType.tabletLarge;

  bool get isCompactPhone => deviceType == DeviceScreenType.mobileCompact;

  /// Padding horizontal adaptativo para vistas móviles y tabletas.
  double get horizontalPadding {
    switch (deviceType) {
      case DeviceScreenType.mobileCompact:
        return 14.0;
      case DeviceScreenType.mobileRegular:
        return 20.0;
      case DeviceScreenType.tabletSmall:
        return 32.0;
      case DeviceScreenType.tabletLarge:
        return 48.0;
    }
  }

  /// Espaciado vertical base entre bloques de contenido.
  double get verticalSpacing {
    switch (deviceType) {
      case DeviceScreenType.mobileCompact:
        return 12.0;
      case DeviceScreenType.mobileRegular:
        return 16.0;
      case DeviceScreenType.tabletSmall:
        return 22.0;
      case DeviceScreenType.tabletLarge:
        return 28.0;
    }
  }

  /// Ancho máximo del contenedor central para evitar que en tabletas los botones
  /// o textos se estiren de extremo a extremo perdiendo ergonomía táctil.
  double get maxContentWidth {
    switch (deviceType) {
      case DeviceScreenType.mobileCompact:
      case DeviceScreenType.mobileRegular:
        return double.infinity;
      case DeviceScreenType.tabletSmall:
        return 680.0;
      case DeviceScreenType.tabletLarge:
        return 820.0;
    }
  }

  /// Número de columnas recomendadas para grillas de lecciones o tarjetas.
  int get gridColumns {
    if (deviceType == DeviceScreenType.tabletLarge) return 2;
    if (deviceType == DeviceScreenType.tabletSmall &&
        orientation == Orientation.landscape) {
      return 2;
    }
    return 1;
  }

  /// Factor de escala tipográfica suave para pantallas compactas o tabletas.
  double scaleFont(double baseSize) {
    if (isCompactPhone) return baseSize * 0.92;
    if (isTablet) return math.min(baseSize * 1.15, baseSize + 6.0);
    return baseSize;
  }
}

/// Widget constructor reutilizable para construir interfaces responsivas basadas en [ResponsiveInfo].
class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final info = ResponsiveInfo.fromContext(context);
        return builder(context, info);
      },
    );
  }
}
