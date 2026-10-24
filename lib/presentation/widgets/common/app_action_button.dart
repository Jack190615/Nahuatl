import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';
import '../../../core/theme/app_theme.dart';

enum AppButtonVariant {
  primary,
  secondary,
  danger,
}

/// Botón táctil reutilizable estilo Duolingo, responsivo para celulares y tabletas.
class AppActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool expandWidth;

  const AppActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.expandWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final info = ResponsiveInfo.fromContext(context);
    final buttonHeight = info.isTablet ? 58.0 : (info.isCompactPhone ? 48.0 : 54.0);

    final Color backgroundColor;
    final Color foregroundColor;
    final BorderSide borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = AppColors.jadePrimary;
        foregroundColor = Colors.white;
        borderSide = BorderSide.none;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = AppColors.cardSurface;
        foregroundColor = AppColors.jadePrimary;
        borderSide = const BorderSide(color: AppColors.jadePrimary, width: 2.0);
        break;
      case AppButtonVariant.danger:
        backgroundColor = AppColors.errorRed;
        foregroundColor = Colors.white;
        borderSide = BorderSide.none;
        break;
    }

    final child = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: info.scaleFont(20)),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: info.scaleFont(16),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          );

    return SizedBox(
      width: expandWidth ? double.infinity : null,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: AppColors.borderOutline,
          disabledForegroundColor: AppColors.slateMuted,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: borderSide,
          ),
        ),
        child: child,
      ),
    );
  }
}
