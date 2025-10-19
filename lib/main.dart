import 'package:flutter/material.dart';
import 'app_router.dart';
import 'theme/theme.dart';

void main() {
  runApp(const AStyleApp());
}

class AStyleApp extends StatelessWidget {
  const AStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AStyle Flutter',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.home,
      routes: AppRouter.routes,
    );
  }
}
