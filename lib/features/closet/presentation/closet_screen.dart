import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/bottom_sheet_base.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/stat_bar.dart';

class ClosetScreen extends StatefulWidget {
  const ClosetScreen({super.key});

  @override
  State<ClosetScreen> createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen> {
  final List<_ClosetItem> _items = <_ClosetItem>[
    const _ClosetItem(
      title: 'کت و شلوار نقره‌ای',
      category: 'مجلسی',
      description: 'کت تک دکمه همراه با شلوار راسته و پیراهن سفید.',
      colors: <Color>[Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
    ),
    const _ClosetItem(
      title: 'کت چرم کوتاه',
      category: 'اسپورت',
      description: 'کت چرم مشکی همراه با تی‌شرت خاکستری.',
      colors: <Color>[Color(0xFF1F2937), Color(0xFF374151)],
    ),
    const _ClosetItem(
      title: 'پیراهن لینن روشن',
      category: 'مینیمال',
      description: 'پیراهن یقه‌دار کرمی با بافت طبیعی.',
      colors: <Color>[Color(0xFFFFF7ED), Color(0xFFFDE68A)],
    ),
    const _ClosetItem(
      title: 'کفش کتانی قرمز',
      category: 'روزمره',
      description: 'کتانی سبک با رویه مشبک و زیره سفید.',
      colors: <Color>[Color(0xFFFF4D67), Color(0xFFFF8C68)],
    ),
    const _ClosetItem(
      title: 'بارانی کاراملی',
      category: 'کاری',
      description: 'بارانی نیم‌تنه با کمربند و یقه پهن.',
      colors: <Color>[Color(0xFFFFEDD5), Color(0xFFFECACA)],
    ),
    const _ClosetItem(
      title: 'شلوار جین آبی تیره',
      category: 'اسپورت',
      description: 'جین فیت آزاد با زانوهای سنگ‌شور شده.',
      colors: <Color>[Color(0xFF1E40AF), Color(0xFF3B82F6)],
    ),
  ];

  final List<String> _categories = <String>[
    'همه',
    'مجلسی',
    'اسپورت',
    'مینیمال',
    'روزمره',
    'کاری',
  ];

  String _selectedCategory = 'همه';
  final Set<int> _savedItems = <int>{};

  void _openAddItemSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomSheetBase(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'افزودن آیتم جدید',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'یک گزینه را برای انتخاب تصویر اتاق لباست انتخاب کن. اتصال واقعی به گالری به صورت نمایشی است.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72)),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  child: const Icon(Icons.photo_library_rounded),
                ),
                title: const Text('انتخاب از گالری'),
                subtitle: const Text('image_picker (Mock)'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تصویر جدید به صورت آزمایشی ذخیره شد.'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const Divider(height: 32),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.12),
                  child: const Icon(Icons.camera_alt_rounded),
                ),
                title: const Text('گرفتن عکس'),
                subtitle: const Text('به زودی فعال می‌شود'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('برای فعال‌سازی دسترسی دوربین به راهنما مراجعه کن.'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
                  borderRadius: AppRadii.border24,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'اگر دسترسی به گالری فعال نشد، از مسیر تنظیمات > برنامه‌ها > Astyle اجازه دسترسی بده.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSmartSuggestionSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomSheetBase(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: math.min(MediaQuery.of(context).size.height * 0.7, 520),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'پیشنهادهای هوشمند ذخیره‌شده',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final _Suggestion suggestion = _suggestions[index];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.35),
                          borderRadius: AppRadii.border24,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: suggestion.gradient,
                                      borderRadius: AppRadii.border16,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          suggestion.title,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          suggestion.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: GradientButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('«${suggestion.title}» به پیشنهادات ذخیره شد.'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: const Text('ذخیره به پیشنهادات'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: _suggestions.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openPreviewSheet(_ClosetItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: AppRadii.border24,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: item.colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.32),
                            borderRadius: AppRadii.border16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Text(
                              item.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.85)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSetSuggestion(_ClosetItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomSheetBase(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'ست پیشنهادی با ${item.title}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._mockSets.map((SetSuggestion set) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.35),
                      borderRadius: AppRadii.border24,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              gradient: set.gradient,
                              borderRadius: AppRadii.border16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  set.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  set.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutePath.tryOn);
                },
                child: const Text('Try-On'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleSave(int index) {
    setState(() {
      if (_savedItems.contains(index)) {
        _savedItems.remove(index);
      } else {
        _savedItems.add(index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _savedItems.contains(index)
              ? 'آیتم به ذخیره‌ها اضافه شد.'
              : 'آیتم از ذخیره‌ها حذف شد.',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<_ClosetItem> visibleItems = _selectedCategory == 'همه'
        ? _items
        : _items.where((_) => _.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('کمد لباس تو'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: FilledButton.icon(
              onPressed: _openAddItemSheet,
              icon: const Icon(Icons.add_rounded),
              label: const Text('افزودن آیتم'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'دسته‌بندی‌ها',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 46,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final String category = _categories[index];
                        final bool isSelected = category == _selectedCategory;
                        return ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: _categories.length,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _openSmartSuggestionSheet,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFF6366F1),
                            Color(0xFFA855F7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: AppRadii.border32,
                        boxShadow: const <BoxShadow>[AppShadows.soft],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'پیشنهاد هوشمند',
                                  style: theme.textTheme.titleLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'ست‌های پیشنهادی هوش مصنوعی بر اساس آیتم‌های کمد تو',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.auto_awesome_rounded,
                              color: Colors.white70),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final _ClosetItem item = visibleItems[index];
                  final int originalIndex = _items.indexOf(item);
                  final bool isSaved = _savedItems.contains(originalIndex);
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: AppRadii.border24,
                      boxShadow: const <BoxShadow>[AppShadows.soft],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: AppRadii.border24,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: item.colors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.title,
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.category,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => _openSetSuggestion(item),
                                tooltip: 'ست‌ساز',
                                icon: const Text('👕', style: TextStyle(fontSize: 20)),
                              ),
                              IconButton(
                                onPressed: () => _toggleSave(originalIndex),
                                tooltip: 'ذخیره',
                                icon: Text(
                                  isSaved ? '💜' : '🔖',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _openPreviewSheet(item),
                                tooltip: 'مشاهده',
                                icon: const Text('👁', style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: visibleItems.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.78,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ترکیب دسته‌ها',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  const StatBar(
                    label: 'مجلسی',
                    value: 0.32,
                    valueLabel: '32%',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  StatBar(
                    label: 'اسپورت',
                    value: 0.24,
                    valueLabel: '24%',
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(height: 20),
                  const StatBar(
                    label: 'مینیمال',
                    value: 0.18,
                    valueLabel: '18%',
                    color: AppColors.accent,
                  ),
                  const SizedBox(height: 20),
                  StatBar(
                    label: 'سایر',
                    value: 0.26,
                    valueLabel: '26%',
                    color: theme.colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClosetItem {
  const _ClosetItem({
    required this.title,
    required this.category,
    required this.description,
    required this.colors,
  });

  final String title;
  final String category;
  final String description;
  final List<Color> colors;
}

class SetSuggestion {
  const SetSuggestion({
    required this.title,
    required this.description,
    required this.gradient,
  });

  final String title;
  final String description;
  final Gradient gradient;
}

class _Suggestion {
  const _Suggestion({
    required this.title,
    required this.description,
    required this.gradient,
  });

  final String title;
  final String description;
  final Gradient gradient;
}

const List<SetSuggestion> _mockSets = <SetSuggestion>[
  SetSuggestion(
    title: 'پیراهن سفید + کراوات طوسی',
    description: 'ست کلاسیک برای قرار رسمی همراه با اکسسوری نقره‌ای.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFE5E7EB), Color(0xFF94A3B8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  SetSuggestion(
    title: 'کفش کالج قهوه‌ای',
    description: 'هماهنگ با کمربند چرمی و ساعت قهوه‌ای.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFB45309), Color(0xFFFBBF24)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  SetSuggestion(
    title: 'کت بارانی کاراملی',
    description: 'پیشنهاد مکمل برای روزهای بارانی و خنک.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFF59E0B), Color(0xFFF97316)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];

const List<_Suggestion> _suggestions = <_Suggestion>[
  _Suggestion(
    title: 'ست عصر جمعه',
    description: 'کت چرم کوتاه + تی‌شرت سفید + شلوار جین آبی تیره.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  _Suggestion(
    title: 'مهمانی دوستانه',
    description: 'پیراهن لینن روشن همراه با کفش کتانی قرمز برای تضاد جذاب.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  _Suggestion(
    title: 'جلسه رسمی',
    description: 'کت و شلوار نقره‌ای + پیراهن سفید + ساعت فلزی.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFE2E8F0), Color(0xFFCBD5F5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  _Suggestion(
    title: 'کژوال شهری',
    description: 'کت چرم کوتاه + تی‌شرت طوسی + کتانی سفید.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFF111827), Color(0xFF1F2937)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  _Suggestion(
    title: 'روزهای بارانی',
    description: 'بارانی کاراملی همراه با بوت کوتاه مشکی و کیف چرمی.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFCD34D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];
