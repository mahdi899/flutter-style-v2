import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class InspirationScreen extends StatelessWidget {
  const InspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Inspiration', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
