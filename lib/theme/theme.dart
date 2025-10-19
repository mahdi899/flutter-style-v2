import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: kBrand, brightness: Brightness.light),
    useMaterial3: true,
    brightness: Brightness.light,
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: kBrand, brightness: Brightness.dark),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}
