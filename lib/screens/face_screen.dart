import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class FaceScreen extends StatelessWidget {
  const FaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Face Capture', style: textTheme.headline1),
      ),
    );
  }
}
