import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('چت استایلیست'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => Align(
                  alignment:
                      index.isEven ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? theme.colorScheme.primary.withOpacity(0.12)
                          : theme.colorScheme.surface,
                      borderRadius: index.isEven
                          ? const BorderRadius.only(
                              topLeft: AppRadii.radius24,
                              topRight: AppRadii.radius24,
                              bottomLeft: AppRadii.radius24,
                            )
                          : const BorderRadius.only(
                              topLeft: AppRadii.radius24,
                              topRight: AppRadii.radius24,
                              bottomRight: AppRadii.radius24,
                            ),
                    ),
                    child: Text(
                      index.isEven
                          ? 'استایلیست: این ترکیب برای رویداد رسمی عالی است!'
                          : 'کاربر: گزینه دیگری داری؟',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'پیام خود را بنویسید...',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
