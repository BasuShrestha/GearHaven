import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF4F2ED),
    primary: Color(0xFF14213D),
    secondary: Color(0xFF00ADB5),
    tertiary: Color(0xFFFCA311),
  ),
);

ThemeData darkModeTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF1A1A1A),
    primary: Color(0xFF3E715F),
    secondary: Color(0xFF008C99),
    tertiary: Color(0xFFFFA500),
  ),
);
