import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.valueLabel,
    this.color,
    this.backgroundColor,
  }) : assert(value >= 0 && value <= 1, 'value must be between 0 and 1');

  final String label;
  final double value;
  final String? valueLabel;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Color resolvedColor = color ?? AppColors.primary;
    final Color resolvedBackground = backgroundColor ??
        colorScheme.surfaceVariant.withOpacity(0.3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (valueLabel != null)
              Text(
                valueLabel!,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: AppRadii.border16,
          child: SizedBox(
            height: 12,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: resolvedBackground),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FractionallySizedBox(
                    alignment: AlignmentDirectional.centerStart,
                    widthFactor: value,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            resolvedColor,
                            resolvedColor.withOpacity(0.7),
                          ],
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
