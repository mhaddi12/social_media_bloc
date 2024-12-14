import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade100,
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Colors.blueAccent,
    secondary: Colors.orangeAccent,
    surface: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  secondaryHeaderColor: Colors.grey.shade200,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 2,
    foregroundColor: Colors.blueAccent,
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey.shade100,
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    },
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
