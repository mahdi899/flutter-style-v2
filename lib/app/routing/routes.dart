import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/chat_screen.dart';
import '../../features/closet/presentation/closet_screen.dart';
import '../../features/explore/presentation/explore_screen.dart';
import '../../features/filters/presentation/filters_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/shell/presentation/shell_screen.dart';
import '../../features/tryon/presentation/tryon_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRoutePath {
  static const String home = '/';
  static const String explore = '/explore';
  static const String closet = '/closet';
  static const String chat = '/chat';
  static const String tryOn = '/try-on';
  static const String profile = '/profile';
  static const String filters = '/filters';
}

class AppRouteName {
  static const String home = 'home';
  static const String explore = 'explore';
  static const String closet = 'closet';
  static const String chat = 'chat';
  static const String tryOn = 'try_on';
  static const String profile = 'profile';
  static const String filters = 'filters';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutePath.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(
        location: state.uri.toString(),
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoutePath.home,
          name: AppRouteName.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.explore,
          name: AppRouteName.explore,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ExploreScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.closet,
          name: AppRouteName.closet,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ClosetScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.chat,
          name: AppRouteName.chat,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.tryOn,
          name: AppRouteName.tryOn,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TryOnScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.profile,
          name: AppRouteName.profile,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutePath.filters,
      name: AppRouteName.filters,
      builder: (context, state) => const FiltersScreen(),
    ),
  ],
);
