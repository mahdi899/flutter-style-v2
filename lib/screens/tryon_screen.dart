import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class TryOnScreen extends StatelessWidget {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Virtual Try-On', style: textTheme.headline1),
      ),
    );
  }
}
