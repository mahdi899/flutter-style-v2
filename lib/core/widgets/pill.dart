import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextStyle labelStyle = Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    final BorderRadius radius = AppRadii.border24;

    final Color background = selected
        ? AppColors.accent.withValues(alpha: 0.12)
        : colorScheme.surface.withValues(alpha: 0.72);

    final Color foreground = selected
        ? AppColors.accent
        : colorScheme.onSurface.withValues(alpha: 0.8);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radius,
        onTap: onSelected != null ? () => onSelected!(!selected) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: radius,
            border: Border.all(
              color: selected
                  ? AppColors.accent.withValues(alpha: 0.3)
                  : colorScheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                IconTheme.merge(
                  data: IconThemeData(color: foreground, size: 18),
                  child: icon!,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: labelStyle.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
