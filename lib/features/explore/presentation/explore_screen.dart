import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/bottom_sheet_base.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/header_glass.dart';
import '../../../core/widgets/icon_badge.dart';
import '../../../core/widgets/pill.dart';
import '../../../core/widgets/toast.dart';
import 'explore_filters.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreFilterType _activeSegment = ExploreFilterType.color;
  Map<ExploreFilterType, Set<String>> _pendingFilters =
      _emptySelectionMap();
  Map<ExploreFilterType, Set<String>> _appliedFilters =
      _emptySelectionMap();
  final Set<String> _bookmarked = <String>{};

  List<ExploreItem> get _visibleItems {
    return _mockExploreItems.where((ExploreItem item) {
      return ExploreFilterType.values.every((ExploreFilterType type) {
        final Set<String> selected = _appliedFilters[type] ?? <String>{};
        if (selected.isEmpty) {
          return true;
        }
        switch (type) {
          case ExploreFilterType.color:
            return selected.contains(item.color);
          case ExploreFilterType.category:
            return selected.contains(item.category);
          case ExploreFilterType.season:
            return selected.contains(item.season);
          case ExploreFilterType.trend:
            return selected.contains(item.trend);
        }
      });
    }).toList();
  }

  bool get _hasPendingChanges => !_setMapEquals(_pendingFilters, _appliedFilters);

  static Map<ExploreFilterType, Set<String>> _emptySelectionMap() {
    return <ExploreFilterType, Set<String>>{
      for (final ExploreFilterType type in ExploreFilterType.values)
        type: <String>{},
    };
  }

  void _togglePendingValue(ExploreFilterType type, String value) {
    setState(() {
      final Set<String> values = _pendingFilters[type] ?? <String>{};
      if (values.contains(value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
      _pendingFilters = <ExploreFilterType, Set<String>>{
        ..._pendingFilters,
        type: Set<String>.from(values),
      };
    });
  }

  Future<void> _openFilterSettings() async {
    final Map<String, dynamic> extra = <String, dynamic>{
      'initialFilters': <String, List<String>>{
        for (final ExploreFilterType type in ExploreFilterType.values)
          type.key: (_pendingFilters[type] ?? <String>{}).toList(),
      },
    };

    final Map<String, dynamic>? result = await context.push<Map<String, dynamic>>(
      AppRoutePath.filters,
      extra: extra,
    );

    if (result == null) {
      return;
    }

    final Map<ExploreFilterType, Set<String>> updated = _selectionFromMap(result);
    setState(() {
      _pendingFilters = <ExploreFilterType, Set<String>>{
        for (final MapEntry<ExploreFilterType, Set<String>> entry
            in updated.entries)
          entry.key: Set<String>.from(entry.value),
      };
      _appliedFilters = <ExploreFilterType, Set<String>>{
        for (final MapEntry<ExploreFilterType, Set<String>> entry
            in updated.entries)
          entry.key: Set<String>.from(entry.value),
      };
    });
  }

  void _applyPendingFilters() {
    if (!_hasPendingChanges) {
      return;
    }
    setState(() {
      _appliedFilters = <ExploreFilterType, Set<String>>{
        for (final MapEntry<ExploreFilterType, Set<String>> entry
            in _pendingFilters.entries)
          entry.key: Set<String>.from(entry.value),
      };
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Toast(message: 'فیلترها به‌روزرسانی شد'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleBookmark(String id) {
    setState(() {
      if (_bookmarked.contains(id)) {
        _bookmarked.remove(id);
      } else {
        _bookmarked.add(id);
      }
    });
  }

  void _showPreview(ExploreItem item) {
    final BuildContext rootContext = context;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        final ColorScheme colorScheme = Theme.of(modalContext).colorScheme;
        final TextTheme textTheme = Theme.of(modalContext).textTheme;

        return BottomSheetBase(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.title,
                      style: textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(modalContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: AppRadii.border24,
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                    ),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext _, Object __, StackTrace? ___) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: colorScheme.onSurface.withOpacity(0.4),
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.72),
                ),
              ),
              const SizedBox(height: 24),
              GradientButton(
                onPressed: () {
                  Navigator.of(modalContext).pop();
                  _showToast(rootContext, 'افزوده شد');
                },
                child: const Text('افزودن به کمد'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Toast(message: message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 2),
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final List<ExploreItem> items = _visibleItems;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HeaderGlass(
                      title: Text('AStyle'),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'الهام بگیر',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _openFilterSettings,
                          child: const Text('تنظیمات فیلتر'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SegmentedControl(
                      active: _activeSegment,
                      onChanged: (ExploreFilterType value) {
                        setState(() => _activeSegment = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    _FilterOptionsRow(
                      segment: _activeSegment,
                      pendingFilters: _pendingFilters,
                      onToggle: _togglePendingValue,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      'پیشنهادهای منتخب',
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            if (items.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.filter_alt_off_outlined,
                        size: 48,
                        color: colorScheme.onSurface.withOpacity(0.4),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'موردی با این فیلترها پیدا نشد',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'فیلترها را تغییر دهید تا پیشنهادهای بیشتری ببینید.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final ExploreItem item = items[index];
                      final bool bookmarked = _bookmarked.contains(item.id);
                      return _ExploreCard(
                        item: item,
                        bookmarked: bookmarked,
                        onBookmarkToggle: () => _toggleBookmark(item.id),
                        onPreview: () => _showPreview(item),
                      );
                    },
                    childCount: items.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                ),
              ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                24,
                28,
                24,
                32 + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverToBoxAdapter(
                child: FilledButton.tonal(
                  onPressed: _hasPendingChanges ? _applyPendingFilters : null,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: colorScheme.surfaceVariant,
                    foregroundColor: colorScheme.onSurface,
                    disabledBackgroundColor:
                        colorScheme.surfaceVariant.withOpacity(0.6),
                    disabledForegroundColor:
                        colorScheme.onSurface.withOpacity(0.4),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadii.border24,
                    ),
                    textStyle:
                        theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  child: const Text('اعمال فیلترها'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Map<ExploreFilterType, Set<String>> _selectionFromMap(
    Map<String, dynamic> raw,
  ) {
    final Map<ExploreFilterType, Set<String>> mapped = _emptySelectionMap();
    for (final ExploreFilterType type in ExploreFilterType.values) {
      final Object? values = raw[type.key];
      if (values is List) {
        mapped[type] = values
            .whereType<String>()
            .map((String value) => value)
            .toSet();
      }
    }
    return mapped;
  }

  static bool _setMapEquals(
    Map<ExploreFilterType, Set<String>> a,
    Map<ExploreFilterType, Set<String>> b,
  ) {
    for (final ExploreFilterType type in ExploreFilterType.values) {
      final Set<String> first = a[type] ?? <String>{};
      final Set<String> second = b[type] ?? <String>{};
      if (!_setEquals(first, second)) {
        return false;
      }
    }
    return true;
  }

  static bool _setEquals(Set<String> a, Set<String> b) {
    if (identical(a, b)) {
      return true;
    }
    if (a.length != b.length) {
      return false;
    }
    for (final String value in a) {
      if (!b.contains(value)) {
        return false;
      }
    }
    return true;
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.active,
    required this.onChanged,
  });

  final ExploreFilterType active;
  final ValueChanged<ExploreFilterType> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GlassCard(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: ExploreFilterType.values.map((ExploreFilterType type) {
          final bool selected = type == active;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                borderRadius: AppRadii.border24,
                onTap: () => onChanged(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: selected ? AppGradients.primary : null,
                    color:
                        selected ? null : colorScheme.surface.withOpacity(0.68),
                    borderRadius: AppRadii.border24,
                    border: Border.all(
                      color: selected
                          ? Colors.white.withOpacity(0.4)
                          : colorScheme.outline.withOpacity(0.16),
                    ),
                    boxShadow:
                        selected ? const <BoxShadow>[AppShadows.soft] : null,
                  ),
                  child: Center(
                    child: Text(
                      type.label,
                      style: textTheme.labelLarge?.copyWith(
                        color:
                            selected ? Colors.white : colorScheme.onSurface,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterOptionsRow extends StatelessWidget {
  const _FilterOptionsRow({
    required this.segment,
    required this.pendingFilters,
    required this.onToggle,
  });

  final ExploreFilterType segment;
  final Map<ExploreFilterType, Set<String>> pendingFilters;
  final void Function(ExploreFilterType, String) onToggle;

  @override
  Widget build(BuildContext context) {
    final List<String> options =
        ExploreFilterOptions.values[segment] ?? <String>[];
    final Set<String> selected = pendingFilters[segment] ?? <String>{};

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Row(
        children: options.map((String option) {
          final bool isSelected = selected.contains(option);
          Widget child;
          if (segment == ExploreFilterType.color) {
            final Color tint = ExploreFilterOptions.colorPalette[option] ??
                Theme.of(context).colorScheme.primary;
            child = _ColorFilterChip(
              label: option,
              color: tint,
              selected: isSelected,
              onTap: () => onToggle(segment, option),
            );
          } else {
            child = Pill(
              label: option,
              selected: isSelected,
              onSelected: (_) => onToggle(segment, option),
            );
          }

          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: child,
          );
        }).toList(),
      ),
    );
  }
}

class _ColorFilterChip extends StatelessWidget {
  const _ColorFilterChip({
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                child: const SizedBox(height: 14, width: 14),
              ),
              const SizedBox(width: 8),
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

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({
    required this.item,
    required this.bookmarked,
    required this.onBookmarkToggle,
    required this.onPreview,
  });

  final ExploreItem item;
  final bool bookmarked;
  final VoidCallback onBookmarkToggle;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                      ),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext _, Object __, StackTrace? ___) {
                          return Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: colorScheme.onSurface.withOpacity(0.3),
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: IconBadge(
                    size: 42,
                    icon: const Icon(Icons.auto_awesome_rounded),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _ActionIconButton(
                        icon: Icons.visibility_outlined,
                        onPressed: onPreview,
                      ),
                      const SizedBox(height: 10),
                      _ActionIconButton(
                        icon: bookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        onPressed: onBookmarkToggle,
                        active: bookmarked,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.65),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({
    required this.icon,
    required this.onPressed,
    this.active = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color background = active
        ? Color.alphaBlend(
            colorScheme.primary.withOpacity(0.22),
            colorScheme.surface,
          )
        : colorScheme.surface.withOpacity(0.82);
    final Color foreground = active
        ? colorScheme.primary
        : colorScheme.onSurface.withOpacity(0.8);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            border: Border.all(
              color: active
                  ? colorScheme.primary.withOpacity(0.4)
                  : colorScheme.outline.withOpacity(0.12),
            ),
            boxShadow: const <BoxShadow>[AppShadows.soft],
          ),
          child: Icon(icon, size: 20, color: foreground),
        ),
      ),
    );
  }
}

class ExploreItem {
  const ExploreItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
    required this.category,
    required this.season,
    required this.trend,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String color;
  final String category;
  final String season;
  final String trend;
}

const List<ExploreItem> _mockExploreItems = <ExploreItem>[
  ExploreItem(
    id: 'tee-black-01',
    title: 'تی‌شرت چاپ‌دار مشکی',
    subtitle: 'استریت · تابستان',
    imageUrl:
        'https://images.unsplash.com/photo-1475180098004-ca77a66827be?auto=format&fit=crop&w=800&q=80',
    color: 'مشکی',
    category: 'استریت',
    season: 'تابستان',
    trend: 'ترند روز',
  ),
  ExploreItem(
    id: 'denim-blue-02',
    title: 'کت جین آبی کلاسیک',
    subtitle: 'کژوال · چهار فصل',
    imageUrl:
        'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?auto=format&fit=crop&w=800&q=80',
    color: 'آبی',
    category: 'کژوال',
    season: 'چهار فصل',
    trend: 'محبوب',
  ),
  ExploreItem(
    id: 'linen-cream-03',
    title: 'پیراهن لینن کرم',
    subtitle: 'مینیمال · بهار',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80',
    color: 'کرم',
    category: 'مینیمال',
    season: 'بهار',
    trend: 'مینیمال‌های نو',
  ),
  ExploreItem(
    id: 'suit-green-04',
    title: 'کت و شلوار سبز زمردی',
    subtitle: 'رسمی · زمستان',
    imageUrl:
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=800&q=80',
    color: 'سبز',
    category: 'رسمی',
    season: 'زمستان',
    trend: 'پیشنهاد استایلیست',
  ),
  ExploreItem(
    id: 'athleisure-gray-05',
    title: 'ست ورزشی طوسی',
    subtitle: 'ورزشی · تابستان',
    imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&q=80',
    color: 'طوسی',
    category: 'ورزشی',
    season: 'تابستان',
    trend: 'ترند روز',
  ),
  ExploreItem(
    id: 'dress-pink-06',
    title: 'پیراهن صورتی مینیمال',
    subtitle: 'مینیمال · تابستان',
    imageUrl:
        'https://images.unsplash.com/photo-1530023367847-a683933f4177?auto=format&fit=crop&w=800&q=80',
    color: 'صورتی',
    category: 'مینیمال',
    season: 'تابستان',
    trend: 'محبوب',
  ),
  ExploreItem(
    id: 'coat-olive-07',
    title: 'کت بارانی زیتونی',
    subtitle: 'بوهو · پاییز',
    imageUrl:
        'https://images.unsplash.com/photo-1515377905703-c4788e51af15?auto=format&fit=crop&w=800&q=80',
    color: 'زیتونی',
    category: 'بوهو',
    season: 'پاییز',
    trend: 'پیشنهاد استایلیست',
  ),
  ExploreItem(
    id: 'set-red-08',
    title: 'ست قرمز خاص شبانه',
    subtitle: 'استریت · زمستان',
    imageUrl:
        'https://images.unsplash.com/photo-1535025065093-7dcbc83482ee?auto=format&fit=crop&w=800&q=80',
    color: 'قرمز',
    category: 'استریت',
    season: 'زمستان',
    trend: 'ترند روز',
  ),
];
