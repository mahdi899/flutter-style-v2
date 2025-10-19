import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Home', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
