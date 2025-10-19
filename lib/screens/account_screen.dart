import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Account', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
