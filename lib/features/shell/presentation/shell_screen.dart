import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';

class ShellDestination {
  const ShellDestination({
    required this.path,
    required this.icon,
    required this.label,
  });

  final String path;
  final IconData icon;
  final String label;
}

class ShellScreen extends StatelessWidget {
  ShellScreen({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  final List<ShellDestination> _destinations = const [
    ShellDestination(
      path: AppRoutePath.home,
      icon: Icons.home_rounded,
      label: 'خانه',
    ),
    ShellDestination(
      path: AppRoutePath.explore,
      icon: Icons.explore_rounded,
      label: 'کاوش',
    ),
    ShellDestination(
      path: AppRoutePath.closet,
      icon: Icons.checkroom_rounded,
      label: 'کمد',
    ),
    ShellDestination(
      path: AppRoutePath.chat,
      icon: Icons.chat_rounded,
      label: 'گفتگو',
    ),
    ShellDestination(
      path: AppRoutePath.tryOn,
      icon: Icons.camera_alt_rounded,
      label: 'پرو مجازی',
    ),
    ShellDestination(
      path: AppRoutePath.profile,
      icon: Icons.person_rounded,
      label: 'پروفایل',
    ),
  ];

  int get _currentIndex {
    if (location == AppRoutePath.home) {
      return 0;
    }

    for (int i = 1; i < _destinations.length; i++) {
      final destination = _destinations[i];
      if (location.startsWith(destination.path)) {
        return i;
      }
    }

    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final destination = _destinations[index];
    if (destination.path != location) {
      context.go(destination.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onDestinationSelected(context, index),
        items: _destinations
            .map(
              (destination) => BottomNavigationBarItem(
                icon: Icon(destination.icon),
                label: destination.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
