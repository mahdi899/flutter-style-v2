import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Saved', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
