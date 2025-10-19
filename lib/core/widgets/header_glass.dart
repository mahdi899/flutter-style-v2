import 'package:flutter/material.dart';

import 'package:astyle_flutter/core/widgets/glass_card.dart';
import 'package:astyle_flutter/core/widgets/gradient_button.dart';

class HeaderGlass extends StatelessWidget {
  const HeaderGlass({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.onTrailingPressed,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget resolvedLeading = leading ??
        Icon(
          Icons.nights_stay_rounded,
          color: colorScheme.onSurface,
        );

    final Widget resolvedTitle = title ??
        Text(
          'لوگو / عنوان',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        );

    final Widget resolvedTrailing = trailing ??
        SizedBox(
          height: 48,
          child: GradientButton(
            onPressed: onTrailingPressed,
            child: const Text('✦'),
          ),
        );

    return GlassCard(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          resolvedLeading,
          const SizedBox(width: 16),
          Expanded(
            child: DefaultTextStyle(
              style: textTheme.titleLarge ?? const TextStyle(),
              child: Align(
                alignment: Alignment.center,
                child: resolvedTitle,
              ),
            ),
          ),
          const SizedBox(width: 16),
          resolvedTrailing,
        ],
      ),
    );
  }
}
