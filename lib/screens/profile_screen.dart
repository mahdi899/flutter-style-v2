import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Profile', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
