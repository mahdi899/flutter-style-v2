import 'package:flutter/material.dart';
import '../app_router.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key, required this.child});
  final Widget child;

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _index = 0;
  final _tabs = [
    AppRouter.home,
    AppRouter.explore,
    AppRouter.closet,
    AppRouter.chat,
    AppRouter.profile,
  ];

  void _onTap(int i) {
    setState(() => _index = i);
    Navigator.of(context).pushReplacementNamed(_tabs[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _onTap,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.checkroom_outlined), label: 'Closet'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
            NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
