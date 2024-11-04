import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        indicatorColor: Colors.orange.withOpacity(0.3),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}