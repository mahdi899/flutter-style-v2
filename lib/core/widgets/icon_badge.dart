import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.size = 40,
    this.backgroundGradient = AppGradients.primary,
    this.padding = const EdgeInsets.all(10),
  });

  final Widget icon;
  final double size;
  final Gradient backgroundGradient;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          shape: BoxShape.circle,
          boxShadow: const <BoxShadow>[AppShadows.soft],
        ),
        child: Padding(
          padding: padding,
          child: FittedBox(
            child: IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
