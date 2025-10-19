import 'package:flutter/material.dart';

import 'package:astyle_flutter/core/widgets/glass_card.dart';

class Toast extends StatelessWidget {
  const Toast({
    super.key,
    required this.message,
    this.icon,
    this.action,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  final String message;
  final Widget? icon;
  final Widget? action;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GlassCard(
      padding: padding,
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 420),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            IconTheme(
              data: IconThemeData(color: colorScheme.primary, size: 20),
              child: icon!,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                height: 1.3,
              ),
            ),
          ),
          if (action != null) ...<Widget>[
            const SizedBox(width: 12),
            DefaultTextStyle.merge(
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
              child: action!,
            ),
          ],
        ],
      ),
    );
  }
}
