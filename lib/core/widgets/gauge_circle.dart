import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class GaugeCircle extends StatelessWidget {
  const GaugeCircle({
    super.key,
    this.value = 0.64,
    this.size = 120,
    this.strokeWidth = 10,
    this.color,
    this.backgroundColor,
    this.center,
    this.showPercentage = true,
  }) : assert(value >= 0 && value <= 1, 'value must be between 0 and 1');

  final double value;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final Widget? center;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color resolvedColor = color ?? AppColors.primary;
    final Color resolvedBackground =
        backgroundColor ?? colorScheme.surfaceVariant.withOpacity(0.2);

    final Widget? centerWidget = center ??
        (showPercentage
            ? Text(
                '${(value * 100).round()}%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onBackground,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              )
            : null);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: value,
              backgroundColor: resolvedBackground,
              valueColor: AlwaysStoppedAnimation<Color>(resolvedColor),
              strokeWidth: strokeWidth,
            ),
          ),
          if (centerWidget != null) centerWidget,
        ],
      ),
    );
  }
}
