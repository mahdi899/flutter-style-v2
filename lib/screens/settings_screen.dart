import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Settings', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
