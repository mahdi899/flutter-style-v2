import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Explore', style: textTheme.headline1),
      ),
    );
  }
}
