import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BottomNavShell(
      child: Center(
        child: Text('Account', style: textTheme.headline1),
      ),
    );
  }
}
