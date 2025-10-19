import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class ClosetScreen extends StatelessWidget {
  const ClosetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Closet', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
