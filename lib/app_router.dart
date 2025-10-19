import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/closet_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/account_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/inspiration_screen.dart';
import 'screens/face_screen.dart';
import 'screens/try_on_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String explore = '/explore';
  static const String closet = '/closet';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String account = '/account';
  static const String saved = '/saved';
  static const String inspiration = '/inspiration';
  static const String face = '/face';
  static const String tryOn = '/try-on';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    explore: (_) => const ExploreScreen(),
    closet: (_) => const ClosetScreen(),
    chat: (_) => const ChatScreen(),
    profile: (_) => const ProfileScreen(),
    settings: (_) => const SettingsScreen(),
    account: (_) => const AccountScreen(),
    saved: (_) => const SavedScreen(),
    inspiration: (_) => const InspirationScreen(),
    face: (_) => const FaceScreen(),
    tryOn: (_) => const TryOnScreen(),
  };
}
