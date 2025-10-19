import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final Set<String> _selectedStyles = <String>{'مینیمال'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = ['کژوال', 'مینیمال', 'کلاسیک', 'ورزشی', 'استریت', 'رسمی'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('فیلترها'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سبک مورد علاقه خود را انتخاب کنید',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: styles
                  .map(
                    (style) => FilterChip(
                      label: Text(style),
                      selected: _selectedStyles.contains(style),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            _selectedStyles.add(style);
                          } else {
                            _selectedStyles.remove(style);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_selectedStyles.toList()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: const RoundedRectangleBorder(borderRadius: AppRadii.border24),
              ),
              child: const Text('اعمال فیلترها'),
            ),
          ],
        ),
      ),
    );
  }
}
