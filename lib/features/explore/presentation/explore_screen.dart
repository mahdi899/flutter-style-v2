import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('کاوش'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        children: List.generate(
          6,
          (index) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppRadii.border24,
              gradient: AppGradients.primary,
              boxShadow: const [AppShadows.soft],
            ),
            child: Center(
              child: Text(
                'کالکشن ${index + 1}',
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
