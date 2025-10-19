import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = AppRadii.border24,
    this.borderColor,
    this.gradient,
    this.boxShadow = const [AppShadows.soft],
    this.clipBehavior = Clip.antiAlias,
    this.constraints,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient ??
                LinearGradient(
                  colors: <Color>[
                    colorScheme.surface.withValues(alpha: 0.78),
                    colorScheme.surface.withValues(alpha: 0.62),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.18),
            ),
            borderRadius: borderRadius,
            boxShadow: boxShadow,
          ),
          child: Container(
            constraints: constraints,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
