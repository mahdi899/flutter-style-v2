import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.gradient = AppGradients.primary,
    this.borderRadius = AppRadii.border16,
    this.shadow = const [AppShadows.soft],
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final EdgeInsetsGeometry padding;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadow;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final TextStyle? labelStyle = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600);

    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: enabled
              ? gradient
              : LinearGradient(
                  colors: <Color>[
                    Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  ],
                ),
          borderRadius: borderRadius,
          boxShadow: enabled ? shadow : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            child: Padding(
              padding: padding,
              child: DefaultTextStyle.merge(
                style: labelStyle,
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
