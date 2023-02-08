import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.green,
    elevatedButtonTheme: elevatedButtonTheme(),
    bottomNavigationBarTheme: BottomBarTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
    primaryColor: Colors.green,
  );
}

OutlinedButtonThemeData outlinedButtonTheme() {
  return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          side: BorderSide(color: Colors.black.withOpacity(0.3))));
}

BottomNavigationBarThemeData BottomBarTheme() {
  return const BottomNavigationBarThemeData(
    selectedItemColor: Colors.green,
    showUnselectedLabels: false,
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: Colors.green,
    elevation: 0,
  ));
}
