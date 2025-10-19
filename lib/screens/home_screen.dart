import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Home', style: textTheme.headline1),
      ),
    );
  }
}
