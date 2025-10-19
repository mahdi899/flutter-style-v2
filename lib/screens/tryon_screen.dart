import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class TryOnScreen extends StatelessWidget {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Virtual Try-On', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
