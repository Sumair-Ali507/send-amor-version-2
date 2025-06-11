import 'package:flutter/material.dart';

import 'app_color.dart';
/*
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColor.primaryColor),
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(AppColor.primaryColor),
        onPrimary: const Color(AppColor.white),
        secondary: const Color(AppColor.deepOrange),
        surface: const Color(AppColor.grey),
        onSurface: const Color(AppColor.black),
      ),
      scaffoldBackgroundColor: const Color(AppColor.lightWhite),
      appBarTheme: const AppBarTheme(
        color: Color(AppColor.primaryColor),
        iconTheme: IconThemeData(color: Color(AppColor.white)),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(color: Color(AppColor.black)),
        displayMedium: TextStyle(color: Color(AppColor.black)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColor.primaryColor),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(AppColor.primaryColor),
        onPrimary: const Color(AppColor.white),
        secondary: const Color(AppColor.green),
        surface: const Color(AppColor.borderColor),
        onSurface: const Color(AppColor.white),
      ),
      scaffoldBackgroundColor: const Color(AppColor.black),
      appBarTheme: const AppBarTheme(
        color: Color(AppColor.darkBlue),
        iconTheme: IconThemeData(color: Color(AppColor.white)),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(color: Color(AppColor.white)),
        displayMedium: TextStyle(color: Color(AppColor.white)),
      ),
    );
  }
}
*/

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColor.primaryColor),
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(AppColor.primaryColor),
        onPrimary: const Color(AppColor.white),
        secondary: const Color(AppColor.black),
        surface: const Color(AppColor.grey),
        onSurface: const Color(AppColor.black),
      ),
      scaffoldBackgroundColor: const Color(AppColor.lightWhite),
      appBarTheme: const AppBarTheme(
        color: Color(AppColor.primaryColor),
        iconTheme: IconThemeData(color: Color(AppColor.white)),

      ),

      textTheme: const TextTheme(
        titleSmall: TextStyle(color: Color(AppColor.black)),
        titleMedium: TextStyle(color: Color(AppColor.black)),
        titleLarge: TextStyle(color: Color(AppColor.black)),
        displaySmall: TextStyle(color: Color(AppColor.black)),
        displayMedium: TextStyle(color: Color(AppColor.black)),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Color(AppColor.white)));

  static final ThemeData darkTheme = ThemeData(
      useMaterial3: true, // Enable Material 3
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColor.darkBlue), // Dark theme base color
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(AppColor.darkBlue), // Main accent color
        onPrimary: const Color(AppColor.white), // Text on primary surfaces
        secondary: const Color(AppColor.green), // Secondary action color
        surface: const Color(0xFF1E1E1E), // Card and surface color
        onSurface: const Color(0xFFE0E0E0), // Text on surfaces
        error: const Color(0xFFFF5252),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Background color
      appBarTheme: const AppBarTheme(
        color: Color(AppColor.darkBlue), // AppBar background
        iconTheme:
            IconThemeData(color: Color(AppColor.white)), // Icons in AppBar
      ),
      textTheme: const TextTheme(
        titleSmall: TextStyle(color: Color(0xFFE0E0E0)), // Light text
        titleMedium: TextStyle(color: Color(0xFFE0E0E0)),
        titleLarge: TextStyle(color: Color(0xFFE0E0E0)),
        displaySmall: TextStyle(color: Color(0xFFE0E0E0)),
        displayMedium: TextStyle(color: Color(0xFFE0E0E0)),
      ),
      buttonTheme: const ButtonThemeData(
          buttonColor: Color(AppColor.buttonBackgroundDark)));
}
