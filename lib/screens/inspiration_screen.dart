import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class InspirationScreen extends StatelessWidget {
  const InspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Inspiration', style: textTheme.headline1),
      ),
    );
  }
}
