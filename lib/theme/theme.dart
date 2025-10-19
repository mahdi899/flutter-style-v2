import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildLightTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: kBrand, brightness: Brightness.light),
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Vazirmatn',
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme, kLightText),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: kBrand, brightness: Brightness.dark),
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Vazirmatn',
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme, kDarkText),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color baseColor) {
  final applied = base.apply(
    fontFamily: 'Vazirmatn',
    bodyColor: baseColor,
    displayColor: baseColor,
  );

  return applied.copyWith(
    headline1: (applied.headline1 ?? const TextStyle()).copyWith(
      fontFamily: 'Vazirmatn',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.3,
      color: baseColor,
    ),
    bodyText1: (applied.bodyText1 ?? const TextStyle()).copyWith(
      fontFamily: 'Vazirmatn',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: baseColor,
    ),
    caption: (applied.caption ?? const TextStyle()).copyWith(
      fontFamily: 'Vazirmatn',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: baseColor.withOpacity(0.8),
    ),
  );
}
