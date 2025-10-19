import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/bottom_sheet_base.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/pill.dart';
import '../../explore/presentation/explore_filters.dart';

class FilterSettingsSheet extends StatefulWidget {
  const FilterSettingsSheet({
    super.key,
    this.initialFilters = const <String, List<String>>{},
  });

  final Map<String, List<String>> initialFilters;

  @override
  State<FilterSettingsSheet> createState() => _FilterSettingsSheetState();
}

class _FilterSettingsSheetState extends State<FilterSettingsSheet> {
  late ExploreFilterType _activeSegment;
  late Map<ExploreFilterType, Set<String>> _selections;

  @override
  void initState() {
    super.initState();
    _activeSegment = ExploreFilterType.color;
    _selections = _initialSelections();
  }

  Map<ExploreFilterType, Set<String>> _initialSelections() {
    final Map<ExploreFilterType, Set<String>> map = <ExploreFilterType, Set<String>>{
      for (final ExploreFilterType type in ExploreFilterType.values) type: <String>{},
    };
    for (final ExploreFilterType type in ExploreFilterType.values) {
      final Object? values = widget.initialFilters[type.key];
      if (values is List) {
        map[type] = values.whereType<String>().toSet();
      }
    }
    return map;
  }

  void _toggleValue(ExploreFilterType type, String value) {
    setState(() {
      final Set<String> current = _selections[type] ?? <String>{};
      if (current.contains(value)) {
        current.remove(value);
      } else {
        current.add(value);
      }
      _selections = <ExploreFilterType, Set<String>>{
        ..._selections,
        type: Set<String>.from(current),
      };
    });
  }

  void _reset() {
    setState(() {
      _selections = <ExploreFilterType, Set<String>>{
        for (final ExploreFilterType type in ExploreFilterType.values)
          type: <String>{},
      };
    });
  }

  void _apply() {
    Navigator.of(context).pop(<String, List<String>>{
      for (final ExploreFilterType type in ExploreFilterType.values)
        type.key: (_selections[type] ?? <String>{}).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BottomSheetBase(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'تنظیمات فیلتر',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GlassCard(
              padding: const EdgeInsets.all(6),
              child: Row(
                children:
                    ExploreFilterType.values.map((ExploreFilterType type) {
                  final bool selected = type == _activeSegment;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        borderRadius: AppRadii.border24,
                        onTap: () => setState(() => _activeSegment = type),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: selected ? AppGradients.primary : null,
                            color: selected
                                ? null
                                : colorScheme.surface.withOpacity(0.68),
                            borderRadius: AppRadii.border24,
                            border: Border.all(
                              color: selected
                                  ? Colors.white.withOpacity(0.4)
                                  : colorScheme.outline.withOpacity(0.16),
                            ),
                            boxShadow: selected
                                ? const <BoxShadow>[AppShadows.soft]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              type.label,
                              style: textTheme.labelLarge?.copyWith(
                                color: selected
                                    ? Colors.white
                                    : colorScheme.onSurface,
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _FilterGroup(
              segment: _activeSegment,
              selections: _selections,
              onToggle: _toggleValue,
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: _reset,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      backgroundColor: colorScheme.surfaceVariant,
                      foregroundColor: colorScheme.onSurface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadii.border24,
                      ),
                    ),
                    child: const Text('بازنشانی'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GradientButton(
                    onPressed: _apply,
                    height: 54,
                    borderRadius: AppRadii.border24,
                    child: const Text('اعمال'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterGroup extends StatelessWidget {
  const _FilterGroup({
    required this.segment,
    required this.selections,
    required this.onToggle,
  });

  final ExploreFilterType segment;
  final Map<ExploreFilterType, Set<String>> selections;
  final void Function(ExploreFilterType, String) onToggle;

  @override
  Widget build(BuildContext context) {
    final List<String> options =
        ExploreFilterOptions.values[segment] ?? <String>[];
    final Set<String> selected = selections[segment] ?? <String>{};

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: options.map((String option) {
          final bool isSelected = selected.contains(option);
          if (segment == ExploreFilterType.color) {
            final Color tint = ExploreFilterOptions.colorPalette[option] ??
                Theme.of(context).colorScheme.primary;
            return _ColorSwatchChip(
              label: option,
              color: tint,
              selected: isSelected,
              onTap: () => onToggle(segment, option),
            );
          }
          return Pill(
            label: option,
            selected: isSelected,
            onSelected: (_) => onToggle(segment, option),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          );
        }).toList(),
      ),
    );
  }
}

class _ColorSwatchChip extends StatelessWidget {
  const _ColorSwatchChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextStyle labelStyle =
        Theme.of(context).textTheme.labelLarge ?? const TextStyle();

    final Color background = selected
        ? Color.alphaBlend(color.withOpacity(0.2), colorScheme.surface)
        : colorScheme.surface.withOpacity(0.72);
    final Color borderColor = selected
        ? color.withOpacity(0.45)
        : colorScheme.outline.withOpacity(0.12);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.border24,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: AppRadii.border24,
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(width: 16, height: 16),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: labelStyle.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
