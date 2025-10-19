import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/chat_screen.dart';
import '../../features/closet/presentation/closet_screen.dart';
import '../../features/explore/presentation/explore_screen.dart';
import '../../features/filters/presentation/filters_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/face_inspiration_screen.dart';
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
  static const String faceInspiration = '/face-inspiration';
}

class AppRouteName {
  static const String home = 'home';
  static const String explore = 'explore';
  static const String closet = 'closet';
  static const String chat = 'chat';
  static const String tryOn = 'try_on';
  static const String profile = 'profile';
  static const String filters = 'filters';
  static const String faceInspiration = 'face_inspiration';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutePath.home,
  errorBuilder: (context, state) => ShellScreen(
    location: AppRoutePath.home,
    child: const HomeScreen(),
  ),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(
        location:
            state.matchedLocation.isEmpty ? AppRoutePath.home : state.matchedLocation,
        child: child,
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.home,
          name: AppRouteName.home,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.explore,
          name: AppRouteName.explore,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ExploreScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.closet,
          name: AppRouteName.closet,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ClosetScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.chat,
          name: AppRouteName.chat,
          pageBuilder: (context, state) {
            String? prefill;
            final Object? extra = state.extra;
            if (extra is Map<String, dynamic>) {
              final Object? maybePrefill = extra['prefill'];
              if (maybePrefill is String) {
                prefill = maybePrefill;
              }
            }

            return NoTransitionPage(
              key: state.pageKey,
              child: ChatScreen(prefill: prefill),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.tryOn,
          name: AppRouteName.tryOn,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const TryOnScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.profile,
          name: AppRouteName.profile,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: AppRoutePath.faceInspiration,
          name: AppRouteName.faceInspiration,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const FaceInspirationScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutePath.filters,
      name: AppRouteName.filters,
      pageBuilder: (context, state) {
        Map<String, List<String>> initialFilters =
            const <String, List<String>>{};
        final Object? extra = state.extra;
        if (extra is Map<String, dynamic>) {
          final Object? maybeInitial = extra['initialFilters'];
          if (maybeInitial is Map) {
            final Map<String, List<String>> parsed =
                <String, List<String>>{};
            maybeInitial.forEach((Object? key, Object? value) {
              if (key is String) {
                if (value is List) {
                  parsed[key] = value.whereType<String>().toList();
                } else {
                  parsed[key] = const <String>[];
                }
              }
            });
            initialFilters = parsed;
          }
        }

        return CustomTransitionPage<Map<String, List<String>>>(
          key: state.pageKey,
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 280),
          reverseTransitionDuration: const Duration(milliseconds: 220),
          child: FiltersScreen(initialFilters: initialFilters),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final Animation<double> curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            final Animation<Offset> slideAnimation = Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curved);
            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
      },
    ),
  ],
);
