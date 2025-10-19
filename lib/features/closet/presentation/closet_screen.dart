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
  final List<String> _categories = <String>[
    'همه',
    'مجلسی',
    'اسپورت',
    'مینیمال',
    'کژوال',
    'کلاسیک',
  ];

  final List<_ClosetItem> _items = <_ClosetItem>[
    const _ClosetItem(
      title: 'کت مخمل سرمه‌ای',
      category: 'مجلسی',
      palette: 'سرمه‌ای · نقره‌ای',
    ),
    const _ClosetItem(
      title: 'کتانی سفید نئونی',
      category: 'اسپورت',
      palette: 'سفید · سبز فلورسنت',
    ),
    const _ClosetItem(
      title: 'پلیور کرم بافت',
      category: 'مینیمال',
      palette: 'کرم · شیری',
    ),
    const _ClosetItem(
      title: 'پیراهن لینن آجری',
      category: 'کژوال',
      palette: 'آجری · برنزی',
    ),
    const _ClosetItem(
      title: 'کفش لوفر چرمی',
      category: 'کلاسیک',
      palette: 'قهوه‌ای · طلایی',
    ),
    const _ClosetItem(
      title: 'کت چرمی مشکی',
      category: 'اسپورت',
      palette: 'مشکی · دودی',
    ),
    const _ClosetItem(
      title: 'شلوار پارچه‌ای سفید',
      category: 'مینیمال',
      palette: 'سفید · نقره‌ای',
    ),
    const _ClosetItem(
      title: 'ساعت فلزی کلاسیک',
      category: 'کلاسیک',
      palette: 'نقره‌ای · مشکی',
    ),
  ];

  String _selectedCategory = 'همه';

  List<_ClosetItem> get _filteredItems {
    if (_selectedCategory == 'همه') {
      return _items;
    }
    return _items
        .where((item) => item.category == _selectedCategory)
        .toList(growable: false);
  }

  void _showAddItemSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
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
                'منبع تصویر را انتخاب کن (image_picker):',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('انتخاب از گالری'),
                subtitle: const Text('گالری گوشی با image_picker'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.photo_camera_rounded),
                title: const Text('گرفتن عکس جدید'),
                subtitle: const Text('باز کردن دوربین (Mock)'),
              ),
              const SizedBox(height: 12),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text('آیتم به‌صورت آزمایشی ذخیره شد'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('ذخیره آیتم'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSetSuggestionSheet(_ClosetItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
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
                      'پیشنهاد ست برای ${item.title}',
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
              ...List<Widget>.generate(3, (int index) {
                final List<String> combos = <String>[
                  'کت سفید کوتاه · شلوار راسته آبی',
                  'پیراهن چهارخانه مینیمال · کفش سفید',
                  'اکسسوری نقره‌ای · کیف دستی طوسی',
                ];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppRadii.border24,
                    boxShadow: const <BoxShadow>[AppShadows.soft],
                  ),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                        child: Text('S${index + 1}'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          combos[index],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (mounted) {
                    context.push(AppRoutePath.tryOn);
                  }
                },
                child: const Text('Try-On'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPreviewSheet(_ClosetItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
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
                  aspectRatio: 4 / 3,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF6366F1),
                          Color(0xFF8B5CF6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          item.category,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'ترکیب رنگ: ${item.palette}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'این آیتم برای رویدادهای ${item.category} بسیار مناسب است. '
                'می‌توانی در ست‌های بعدی از آن استفاده کنی.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSmartSuggestions() {
    const List<String> suggestions = <String>[
      'ست رسمی با کت مخمل + شلوار کرپ',
      'ترکیب مینیمال با پلیور کرم + شلوار سفید',
      'استایل خیابانی با کت چرمی + کتانی نئونی',
      'کژوال روزمره با پیراهن لینن + لوفر چرمی',
      'تیپ مهمانی با کت سفید + اکسسوری نقره‌ای',
    ];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
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
              ...suggestions.map((String item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppRadii.border24,
                    boxShadow: const <BoxShadow>[AppShadows.soft],
                  ),
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }),
              const SizedBox(height: 12),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text('به پیشنهادها اضافه شد'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('ذخیره به پیشنهادات'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'کمد هوشمند',
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'آیتم‌هایت را مدیریت کن و ست‌های جدید بساز',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _showAddItemSheet,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('افزودن آیتم'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((String category) {
                    final bool selected = category == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selected,
                        onSelected: (item) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _showSmartSuggestions,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xFF6D83F2),
                        Color(0xFF9B63F8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: AppRadii.border24,
                    boxShadow: const <BoxShadow>[AppShadows.soft],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              'ترکیب‌های جدید براساس سلیقه تو آماده‌ست!'
                              '\nبرای دیدن پیشنهادهای ذخیره‌شده لمس کن.',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final _ClosetItem item = _filteredItems[index];
                  return _ClosetCard(
                    item: item,
                    onPreview: () => _showPreviewSheet(item),
                    onBuildSet: () => _showSetSuggestionSheet(item),
                    onSave: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.title} ذخیره شد'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                'ترکیب دسته‌ها',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'نسبت آیتم‌های تو در هر دسته بر اساس داده‌های ثبت‌شده (Mock).',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              const StatBar(
                label: 'مجلسی',
                value: 0.32,
                valueLabel: '32%',
                color: Color(0xFF818CF8),
              ),
              const SizedBox(height: 16),
              const StatBar(
                label: 'اسپورت',
                value: 0.26,
                valueLabel: '26%',
                color: Color(0xFF34D399),
              ),
              const SizedBox(height: 16),
              const StatBar(
                label: 'مینیمال',
                value: 0.21,
                valueLabel: '21%',
                color: Color(0xFFFBBF24),
              ),
              const SizedBox(height: 16),
              const StatBar(
                label: 'کلاسیک',
                value: 0.21,
                valueLabel: '21%',
                color: Color(0xFFFB7185),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClosetCard extends StatelessWidget {
  const _ClosetCard({
    required this.item,
    required this.onPreview,
    required this.onBuildSet,
    required this.onSave,
  });

  final _ClosetItem item;
  final VoidCallback onPreview;
  final VoidCallback onBuildSet;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadii.border24,
        boxShadow: const <BoxShadow>[AppShadows.soft],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: AppRadii.border24,
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.primary.withValues(alpha: 0.85),
                      AppColors.secondary.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.checkroom_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: theme.textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            item.category,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _ClosetActionButton(
                label: '👕',
                tooltip: 'پیشنهاد ست',
                onTap: onBuildSet,
              ),
              _ClosetActionButton(
                label: '🔖',
                tooltip: 'ذخیره',
                onTap: onSave,
              ),
              _ClosetActionButton(
                label: '👁',
                tooltip: 'مشاهده',
                onTap: onPreview,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClosetActionButton extends StatelessWidget {
  const _ClosetActionButton({
    required this.label,
    required this.tooltip,
    required this.onTap,
  });

  final String label;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.border16,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHigh
                .withValues(alpha: 0.4),
            borderRadius: AppRadii.border16,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _ClosetItem {
  const _ClosetItem({
    required this.title,
    required this.category,
    required this.palette,
  });

  final String title;
  final String category;
  final String palette;
}
