import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_info.dart';

/// Scaffold base reutilizable que garantiza `SafeArea` (Android / iOS) y
/// restricción de ancho máximo centrada (`maxContentWidth`) en tabletas.
class ResponsiveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, ResponsiveInfo info) bodyBuilder;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool applyHorizontalPadding;

  const ResponsiveScaffold({
    super.key,
    this.appBar,
    required this.bodyBuilder,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.applyHorizontalPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: ResponsiveLayoutBuilder(
          builder: (context, info) {
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: info.maxContentWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        applyHorizontalPadding ? info.horizontalPadding : 0,
                  ),
                  child: bodyBuilder(context, info),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
