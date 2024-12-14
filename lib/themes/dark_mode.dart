import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF121212), // Neutral dark background
  cardColor: const Color(0xFF1F1B24), // Slightly lighter for cards
  colorScheme: ColorScheme.dark(
    primary: Colors.deepPurpleAccent.shade200, // Elegant purple for primary
    secondary: Colors.orangeAccent.shade200, // Bright orange for secondary
    surface: const Color(0xFF1F1B24), // Matches card color
    error: Colors.redAccent.shade100, // Subtle red for errors
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white70,
    onError: Colors.white,
  ),
  primaryColor: Colors.deepPurpleAccent.shade200,
  secondaryHeaderColor: const Color(0xFF2A2A2A), // Slightly lighter headers
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white54),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white38),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1F1B24), // Matches card color
    elevation: 3,
    shadowColor: Colors.black.withOpacity(0.5),
    foregroundColor: Colors.deepPurpleAccent.shade200,
    titleTextStyle: const TextStyle(
        color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
    iconTheme: const IconThemeData(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurpleAccent.shade200,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.orangeAccent.shade200),
      foregroundColor: Colors.orangeAccent.shade200,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    },
  ),
  dividerColor: Colors.grey.shade700,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.deepPurpleAccent.shade200,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  dialogBackgroundColor: const Color(0xFF1F1B24),
  iconTheme: IconThemeData(color: Colors.white70),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1F1B24),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.deepPurpleAccent.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.deepPurpleAccent.shade200, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white38),
  ),
);
