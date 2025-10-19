import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

class TryOnScreen extends StatelessWidget {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('پرو مجازی'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: AppRadii.border32,
                  gradient: AppGradients.primary,
                  boxShadow: const [AppShadows.soft],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smartphone_rounded,
                      color: Colors.white.withOpacity(0.85),
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'پرو مجازی آماده است',
                      style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تصویر خود را بارگذاری کنید یا از دوربین استفاده کنید.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_camera_rounded),
                    label: const Text('دوربین'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_library_rounded),
                    label: const Text('گالری'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadii.border16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
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
