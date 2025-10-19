import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Profile', style: textTheme.headline1),
      ),
    );
  }
}
