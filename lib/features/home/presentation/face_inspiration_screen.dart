import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class FaceInspirationScreen extends StatelessWidget {
  const FaceInspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الهام از چهره‌ها'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _faceInspirationItems.length,
        separatorBuilder: (item, e) => const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          final _FaceInspirationItem item = _faceInspirationItems[index];
          return GlassCard(
            borderRadius: AppRadii.border24,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 28,
                  backgroundColor: item.color.withValues(alpha: 0.15),
                  child: Icon(item.icon, color: item.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.role,
                        style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: item.color,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('مشاهده'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FaceInspirationItem {
  const _FaceInspirationItem({
    required this.name,
    required this.role,
    required this.icon,
    required this.color,
  });

  final String name;
  final String role;
  final IconData icon;
  final Color color;
}

const List<_FaceInspirationItem> _faceInspirationItems = <_FaceInspirationItem>[
  _FaceInspirationItem(
    name: 'نغمه صادقی',
    role: 'بنیان‌گذار برند نغمه',
    icon: Icons.workspace_premium_outlined,
    color: Color(0xFF6366F1),
  ),
  _FaceInspirationItem(
    name: 'مانا طاهری',
    role: 'استایلیست دیجیتال',
    icon: Icons.lightbulb_outline,
    color: Color(0xFFEC4899),
  ),
  _FaceInspirationItem(
    name: 'نیکا فرهمند',
    role: 'مدل و بلاگر استایل',
    icon: Icons.auto_awesome,
    color: Color(0xFFF59E0B),
  ),
  _FaceInspirationItem(
    name: 'دانیال عطا',
    role: 'مدیر هنری کمپین‌ها',
    icon: Icons.local_fire_department_outlined,
    color: Color(0xFF22C55E),
  ),
];
