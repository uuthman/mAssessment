import 'package:flutter/material.dart';

class AppColors {
  final Color sandstone500 = Color(0xFFA5957E);
  final Color amber600 = Color(0xFFFB9E12);
  final Color charcoal900 = Color(0xFF232220);
  final Color graphite800 = Color(0xFF2B2B2B);
  final Color obsidian950 = Color(0xFF232120);
  final Color ivory100 = Color(0xFFFAF5EC);
  final Color white = Color(0xFFFFFFFF);
  final Color black = Color(0xFF000000);
  final Color amber100 = Color(0xFFFAD8B0);

  ThemeData toThemeData() {
    ColorScheme colorScheme = ColorScheme(
        brightness: Brightness.dark,
        primary: amber600,
        primaryContainer: amber600,
        secondary: amber600,
        secondaryContainer: amber600,
        surface: sandstone500,
        onSurface: charcoal900,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400);


    var theme = ThemeData.from(textTheme: ThemeData.dark().textTheme, colorScheme: colorScheme);

    return theme;
  }
}