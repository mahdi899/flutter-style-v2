import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/bottom_sheet_base.dart';
import '../../../core/widgets/dialog_base.dart';
import '../../../core/widgets/gauge_circle.dart';
import '../../../core/widgets/glass_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _trendsKey = GlobalKey();
  final GlobalKey _faceInspoKey = GlobalKey();

  late final List<_Mission> _missions = <_Mission>[
    _Mission(
      title: 'امروز امتحانش کن',
      description: 'یک آیتم ترندی از فهرست زیر انتخاب کن.',
      target: _MissionTarget.trends,
    ),
    _Mission(
      title: 'از چهره‌های الهام بگیر',
      description: 'یک استایل انتخاب کن و امتیاز بده.',
      target: _MissionTarget.faceInspiration,
    ),
    _Mission(
      title: 'آیتم دلخواهت را ذخیره کن',
      description: 'یکی از پیشنهادها را بعداً ذخیره کن.',
      target: _MissionTarget.trends,
    ),
    _Mission(
      title: 'به استایلیستت بازخورد بده',
      description: 'نظرت را برای امروز ثبت کن.',
      target: _MissionTarget.feedback,
    ),
  ];

  late final List<_MissionStatus> _missionStatuses =
      List<_MissionStatus>.filled(_missions.length, _MissionStatus.pending);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleMissionComplete(int index) {
    final _Mission mission = _missions[index];
    switch (mission.target) {
      case _MissionTarget.trends:
        _scrollToKey(_trendsKey);
        break;
      case _MissionTarget.faceInspiration:
        _scrollToKey(_faceInspoKey);
        break;
      case _MissionTarget.feedback:
        _showFeedbackDialog();
        break;
    }

    setState(() {
      _missionStatuses[index] = _MissionStatus.done;
    });
  }

  void _handleMissionSkip(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ماموریت رد شد'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {
      _missionStatuses[index] = _MissionStatus.skipped;
    });
  }

  void _scrollToKey(GlobalKey key) {
    final BuildContext? targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        alignment: 0.1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openTrendBottomSheet(_Trend trend) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
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
                      trend.title,
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
                    decoration: BoxDecoration(
                      gradient: trend.gradient,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          trend.tag,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                trend.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.push(AppRoutePath.tryOn),
                child: const Text('امتحان کن'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFeedbackDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return DialogBase(
          title: const Text('بازخورد امروز'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  _FeedbackChip(label: 'دوست داشتم', icon: Icons.favorite_border),
                  _FeedbackChip(label: 'نه چندان', icon: Icons.thumb_down_alt_outlined),
                  _FeedbackChip(label: 'بعداً می‌پرسم', icon: Icons.schedule_rounded),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'جزئیات بیشتری می‌خواهی بنویسی؟',
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('لغو'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ثبت'),
            ),
          ],
        );
      },
    );
  }

  void _openChatWithPrefill() {
    context.go(
      AppRoutePath.chat,
      extra: <String, String>{
        'prefill': 'فردا جلسه رسمی دارم، چه استایلی پیشنهاد می‌کنی؟',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              borderRadius: AppRadii.border32,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                    child: const Icon(Icons.person_rounded, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Astyle AI',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'استایلیست اختصاصی شما آماده است',
                          style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'فیلترها',
                    onPressed: () => context.push(AppRoutePath.filters),
                    icon: const Icon(Icons.tune_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFF5F5FF),
              Color(0xFFEFF1FF),
              Color(0xFFF9F5FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(24, 140, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GlassCard(
                borderRadius: AppRadii.border32,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'مدیر استایل شما',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'سلام! من مدیر استایل شخصی‌ات هستم. اجازه بده با هم روزت را استایل کنیم.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFF6C63FF),
                      Color(0xFF7C7BFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppRadii.border32,
                  boxShadow: const <BoxShadow>[AppShadows.soft],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'سؤالی داری؟ از من بپرس!',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _openChatWithPrefill,
                          icon: const Icon(Icons.chat_bubble_outline_rounded),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'من برای جلسه رسمی فردایت چه ترکیبی پیشنهاد کنم؟',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.88),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      onPressed: _openChatWithPrefill,
                      child: const Text('بیا صحبت کنیم'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: AppRadii.border24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'پاسخ امروز',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'برای جلسه رسمی فردا، کت مشکی مینیمال را با پیراهن سفید و شلوار پارچه‌ای ذغالی امتحان کن. برای ایجاد تضاد، ساعت نقره‌ای و پین یقه را فراموش نکن.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const <Widget>[
                  _ActionChip(label: 'مینیمال'),
                  _ActionChip(label: 'جلسه رسمی'),
                  _ActionChip(label: 'اکسسوری براق'),
                  _ActionChip(label: 'کلاسیک'),
                ],
              ),
              const SizedBox(height: 24),
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                borderRadius: AppRadii.border32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'نکته‌های سریع',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const _QuickTip(
                      icon: Icons.workspace_premium_outlined,
                      title: 'دوخت تمیز',
                      subtitle: 'لباس‌های اتوکشیده اعتماد به نفس را بالا می‌برند.',
                    ),
                    const SizedBox(height: 12),
                    const _QuickTip(
                      icon: Icons.local_laundry_service_outlined,
                      title: 'پارچه‌های نفس‌گیر',
                      subtitle: 'کت نازک پشمی یا کتان برای جلسات طولانی عالی است.',
                    ),
                    const SizedBox(height: 12),
                    const _QuickTip(
                      icon: Icons.brush_outlined,
                      title: 'جزئیات کوچک',
                      subtitle: 'پین یقه یا دستمال جیبی طرح‌دار نقطه تمایز توست.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GlassCard(
                      borderRadius: AppRadii.border32,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GaugeCircle(
                            value: 0.64,
                            size: 140,
                            strokeWidth: 12,
                            color: AppColors.primary,
                            backgroundColor: colorScheme.primary.withValues(alpha: 0.08),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'آمادگی استایل امروز',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'ماموریت‌های امروز',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double itemWidth =
                      (constraints.maxWidth - 16) / 2; // 16 spacing between
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List<Widget>.generate(_missions.length, (int index) {
                      final _Mission mission = _missions[index];
                      return SizedBox(
                        width: constraints.maxWidth < 600 ? constraints.maxWidth : itemWidth,
                        child: _MissionCard(
                          mission: mission,
                          status: _missionStatuses[index],
                          onDone: () => _handleMissionComplete(index),
                          onSkip: () => _handleMissionSkip(index),
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                'ترندهای امروز',
                style: theme.textTheme.headlineSmall,
                key: _trendsKey,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _trends.length,
                  separatorBuilder: (item, e) => const SizedBox(width: 16),
                  itemBuilder: (BuildContext context, int index) {
                    final _Trend trend = _trends[index];
                    return _TrendCard(
                      trend: trend,
                      onPreview: () => _openTrendBottomSheet(trend),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'الهام از چهره‌ها',
                style: theme.textTheme.headlineSmall,
                key: _faceInspoKey,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _faces.length,
                  separatorBuilder: (item, e) => const SizedBox(width: 16),
                  itemBuilder: (BuildContext context, int index) {
                    final _FaceInspiration face = _faces[index];
                    return _FaceCard(
                      face: face,
                      onExplore: () => context.push(AppRoutePath.faceInspiration),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: theme.textTheme.titleMedium,
                      ),
                      onPressed: () => context.push(AppRoutePath.explore),
                      child: const Text('مشاهدهٔ پیشنهادها'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                      onPressed: _showFeedbackDialog,
                      child: const Text('ثبت بازخورد'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              GlassCard(
                padding: const EdgeInsets.all(24),
                borderRadius: AppRadii.border32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on_rounded, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'تهران، ایران',
                          style: theme.textTheme.titleMedium,
                        ),
                        const Spacer(),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: AppRadii.border16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Text(
                              '24°',
                              style: theme.textTheme.titleMedium?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _WeatherMetric(
                            label: 'رطوبت',
                            value: '58%',
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WeatherMetric(
                            label: 'شاخص UV',
                            value: '3 / ملایم',
                            color: const Color(0xFFF97316),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WeatherMetric(
                            label: 'باد',
                            value: '12 km/h',
                            color: const Color(0xFF22C55E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GlassCard(
                padding: const EdgeInsets.all(24),
                borderRadius: AppRadii.border32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'گزارش‌های امروز',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 180,
                      child: _GraphPlaceholder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _MissionTarget { trends, faceInspiration, feedback }

enum _MissionStatus { pending, done, skipped }

class _Mission {
  const _Mission({
    required this.title,
    required this.description,
    required this.target,
  });

  final String title;
  final String description;
  final _MissionTarget target;
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.mission,
    required this.status,
    required this.onDone,
    required this.onSkip,
  });

  final _Mission mission;
  final _MissionStatus status;
  final VoidCallback onDone;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final bool isInactive = status != _MissionStatus.pending;
    final Color borderColor = status == _MissionStatus.skipped
        ? Colors.red.withValues(alpha: 0.35)
        : colorScheme.primary.withValues(alpha: 0.25);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: status == _MissionStatus.skipped ? 0.5 : 1,
      child: GlassCard(
        borderRadius: AppRadii.border24,
        padding: const EdgeInsets.all(20),
        borderColor: borderColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    mission.title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (status == _MissionStatus.done)
                  Icon(Icons.check_circle, color: colorScheme.primary),
                if (status == _MissionStatus.skipped)
                  const Icon(Icons.close_rounded, color: Colors.redAccent),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              mission.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                    onPressed: isInactive ? null : onDone,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('انجامش کن'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: isInactive ? null : onSkip,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE11D48),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('رد کن'),
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

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}

class _QuickTip extends StatelessWidget {
  const _QuickTip({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: AppRadii.border16,
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeatherMetric extends StatelessWidget {
  const _WeatherMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GlassCard(
      borderRadius: AppRadii.border24,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      boxShadow: const <BoxShadow>[],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _GraphPlaceholder extends StatelessWidget {
  const _GraphPlaceholder();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GraphPainter(Theme.of(context).colorScheme.primary),
    );
  }
}

class _GraphPainter extends CustomPainter {
  _GraphPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..strokeWidth = 1.2;
    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    final double height = size.height - 20;
    final double width = size.width - 24;
    final double startX = 12;
    final double startY = height;

    path.moveTo(startX, startY);
    path.quadraticBezierTo(width * 0.25, height * 0.7, width * 0.35, height * 0.5);
    path.quadraticBezierTo(width * 0.5, height * 0.3, width * 0.65, height * 0.55);
    path.quadraticBezierTo(width * 0.8, height * 0.8, width, height * 0.35);

    canvas.drawLine(Offset(startX, 0), Offset(startX, height + 4), axisPaint);
    canvas.drawLine(Offset(startX, height + 4), Offset(width + 8, height + 4), axisPaint);
    canvas.drawPath(path, linePaint);

    final Paint dotPaint = Paint()..color = color;
    for (final Offset point in <Offset>[
      Offset(width * 0.35, height * 0.5),
      Offset(width * 0.65, height * 0.55),
      Offset(width, height * 0.35),
    ]) {
      canvas.drawCircle(point, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeedbackChip extends StatelessWidget {
  const _FeedbackChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      avatar: Icon(icon, size: 18),
      selected: false,
      onSelected: (item) {},
      showCheckmark: false,
    );
  }
}

class _Trend {
  const _Trend({
    required this.title,
    required this.tag,
    required this.description,
    required this.gradient,
  });

  final String title;
  final String tag;
  final String description;
  final Gradient gradient;
}

const List<_Trend> _trends = <_Trend>[
  _Trend(
    title: 'مینیمال شهری',
    tag: '#UrbanMinimal',
    description: 'کت‌های سبک با جزئیات فلزی برای جلسات عصرگاهی و دورهمی‌های کاری.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFF1E40AF), Color(0xFF60A5FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  _Trend(
    title: 'صورتی مونوکروم',
    tag: '#PinkStatement',
    description: 'ترکیب صورتی‌های طیفی با کفش‌های سفید برای ایجاد تضاد ظریف.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFFF472B6), Color(0xFFFDE68A)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ),
  _Trend(
    title: 'لایه‌لایه پاییزی',
    tag: '#LayerSeason',
    description: 'ترکیب لایه‌ای سویشرت نازک و کت بارانی کوتاه برای هوای معتدل.',
    gradient: LinearGradient(
      colors: <Color>[Color(0xFF92400E), Color(0xFFF59E0B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
];

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.trend, required this.onPreview});

  final _Trend trend;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 220,
      child: GlassCard(
        borderRadius: AppRadii.border32,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: AppRadii.radius32),
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: trend.gradient),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        trend.tag,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trend.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trend.description,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: onPreview,
                        child: const Text('بیشتر ببین'),
                      ),
                      IconButton(
                        tooltip: 'پیش‌نمایش',
                        onPressed: onPreview,
                        icon: const Icon(Icons.remove_red_eye_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaceInspiration {
  const _FaceInspiration({
    required this.name,
    required this.role,
    required this.score,
    required this.color,
  });

  final String name;
  final String role;
  final int score;
  final Color color;
}

const List<_FaceInspiration> _faces = <_FaceInspiration>[
  _FaceInspiration(
    name: 'سارا نیک‌پی',
    role: 'کارآفرین مد',
    score: 92,
    color: Color(0xFF6366F1),
  ),
  _FaceInspiration(
    name: 'مهتاب دریایی',
    role: 'استایلیست تلویزیون',
    score: 88,
    color: Color(0xFFEC4899),
  ),
  _FaceInspiration(
    name: 'لیا سهرابی',
    role: 'مدل فشن',
    score: 95,
    color: Color(0xFFF59E0B),
  ),
];

class _FaceCard extends StatelessWidget {
  const _FaceCard({required this.face, required this.onExplore});

  final _FaceInspiration face;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 200,
      child: GlassCard(
        borderRadius: AppRadii.border32,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 26,
                  backgroundColor: face.color.withValues(alpha: 0.18),
                  child: Icon(Icons.wb_incandescent_outlined, color: face.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        face.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        face.role,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Icon(Icons.star_rounded, color: face.color),
                const SizedBox(width: 8),
                Text(
                  '${face.score}',
                  style: theme.textTheme.headlineSmall?.copyWith(color: face.color),
                ),
                const SizedBox(width: 4),
                Text(
                  'امتیاز الهام',
                  style: theme.textTheme.labelMedium,
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'بیشتر',
                  onPressed: onExplore,
                  icon: const Icon(Icons.lightbulb_outline),
                ),
              ],
            ),
            const Spacer(),
            FilledButton(
              onPressed: onExplore,
              style: FilledButton.styleFrom(
                backgroundColor: face.color,
                foregroundColor: Colors.white,
              ),
              child: const Text('برو به الهام'),
            ),
          ],
        ),
      ),
    );
  }
}
