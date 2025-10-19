import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFA855F7);
  static const Color accent = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color lightBackground = Color(0xFFF6F8FF);
  static const Color darkBackground = Color(0xFF0F172A);
}

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppRadii {
  static const Radius radius16 = Radius.circular(16);
  static const Radius radius24 = Radius.circular(24);
  static const Radius radius32 = Radius.circular(32);

  static const BorderRadius border16 = BorderRadius.all(radius16);
  static const BorderRadius border24 = BorderRadius.all(radius24);
  static const BorderRadius border32 = BorderRadius.all(radius32);
}

class AppShadows {
  static const BoxShadow soft = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  );
}

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final bool isLight = brightness == Brightness.light;
    final ColorScheme baseScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );

    final ColorScheme colorScheme = baseScheme.copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accent,
      error: AppColors.warning,
      background: isLight ? AppColors.lightBackground : AppColors.darkBackground,
      surface: isLight ? Colors.white : const Color(0xFF1E293B),
      onBackground: isLight ? AppColors.darkBackground : Colors.white,
      onSurface: isLight ? AppColors.darkBackground : Colors.white,
    );

    final TextTheme textTheme = _textTheme(brightness).apply(
      displayColor: colorScheme.onBackground,
      bodyColor: colorScheme.onBackground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Vazirmatn',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardTheme(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.border24),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.border16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        selectedColor: AppColors.accent.withOpacity(0.12),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.border16),
        labelStyle: textTheme.labelMedium ?? const TextStyle(fontWeight: FontWeight.w600),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadii.border24,
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.border24,
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.border24,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.border24),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: textTheme.labelMedium,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withOpacity(0.2),
        space: 0,
        thickness: 1,
      ),
      shadowColor: Colors.black.withOpacity(0.12),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final ThemeData base = ThemeData(brightness: brightness, useMaterial3: true);
    final TextTheme textTheme = base.textTheme;

    return textTheme.copyWith(
      headlineLarge: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
      headlineMedium: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
      headlineSmall: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      bodySmall: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
      labelLarge: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      labelMedium: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      labelSmall: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
