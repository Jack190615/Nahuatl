import 'package:flutter/material.dart';

/// Paleta de colores inspirada en códices mesoamericanos (Jade, Terracota y Obsidiana)
/// con alto contraste accesible (WCAG AA) tanto para Android como iOS.
class AppColors {
  AppColors._();

  static const Color jadePrimary = Color(0xFF0E7C61);
  static const Color jadeDark = Color(0xFF085441);
  static const Color jadeLight = Color(0xFFE4F5F0);

  static const Color terracottaAccent = Color(0xFFD95D39);
  static const Color goldHighlight = Color(0xFFE6A100);

  static const Color backgroundSurface = Color(0xFFF9F7F2);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color obsidianText = Color(0xFF1E2422);
  static const Color slateMuted = Color(0xFF5C6663);
  static const Color borderOutline = Color(0xFFDCE2DF);

  static const Color successGreen = Color(0xFF2E9E49);
  static const Color successSurface = Color(0xFFE8F7EC);
  static const Color errorRed = Color(0xFFD63638);
  static const Color errorSurface = Color(0xFFFDECEC);
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.jadePrimary,
      primary: AppColors.jadePrimary,
      secondary: AppColors.terracottaAccent,
      surface: AppColors.backgroundSurface,
      error: AppColors.errorRed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundSurface,
        foregroundColor: AppColors.obsidianText,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderOutline, width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderOutline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderOutline, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.jadePrimary, width: 2.0),
        ),
      ),
    );
  }
}
