import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';
import '../../../app/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('استایل شما'),
        actions: [
          IconButton(
            tooltip: 'فیلترها',
            onPressed: () => context.push(AppRoutePath.filters),
            icon: const Icon(Icons.tune_rounded),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'روز بخیر! چه لباسی دوست دارید؟',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: AppRadii.border32,
              boxShadow: const [AppShadows.soft],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ترکیب پیشنهادی امروز',
                  style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  'کت یاسی + شلوار کرم + کتانی سبز',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go(AppRoutePath.tryOn),
                  child: const Text('پرو مجازی'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'دسته‌بندی‌ها',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _CategoryChip(label: 'روزمره'),
              _CategoryChip(label: 'رسمی'),
              _CategoryChip(label: 'ورزشی'),
              _CategoryChip(label: 'مینیمال'),
              _CategoryChip(label: 'کلاسیک'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }
}
