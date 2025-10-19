import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routing/routes.dart';

class ShellDestination {
  const ShellDestination({
    required this.path,
    required this.icon,
    required this.label,
    this.isCenter = false,
  });

  final String path;
  final IconData icon;
  final String label;
  final bool isCenter;
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
      label: 'الهام',
    ),
    ShellDestination(
      path: AppRoutePath.chat,
      icon: Icons.chat_bubble_rounded,
      label: 'چت',
      isCenter: true,
    ),
    ShellDestination(
      path: AppRoutePath.closet,
      icon: Icons.checkroom_rounded,
      label: 'کمد',
    ),
    ShellDestination(
      path: AppRoutePath.profile,
      icon: Icons.person_rounded,
      label: 'پروفایل',
    ),
  ];

  int get _currentIndex {
    final index = _destinations.indexWhere((destination) {
      if (destination.path == AppRoutePath.home) {
        return location == destination.path;
      }
      return location.startsWith(destination.path);
    });

    return index < 0 ? 0 : index;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final destination = _destinations[index];
    if (destination.path != location) {
      context.go(destination.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox.expand(child: child),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_destinations.length, (index) {
                final destination = _destinations[index];
                final isActive = index == _currentIndex;

                return Expanded(
                  child: _NavigationItem(
                    destination: destination,
                    isActive: isActive,
                    onTap: () => _onDestinationSelected(context, index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.destination,
    required this.isActive,
    required this.onTap,
  });

  final ShellDestination destination;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (destination.isCenter) {
      final gradient = LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
      );

      return Center(
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isActive ? gradient : null,
                color: isActive
                    ? null
                    : colorScheme.surfaceVariant.withOpacity(0.9),
              ),
              child: Icon(
                destination.icon,
                color: isActive
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    final textStyle = theme.textTheme.labelSmall;
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                destination.icon,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 4),
              Text(
                destination.label,
                style: textStyle?.copyWith(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
