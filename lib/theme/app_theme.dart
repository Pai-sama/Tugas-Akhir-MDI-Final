import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF076643);
  static const Color accentAmber = Color(0xFFFFAE19);
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF192A20);
  static const Color textMuted = Color(0xFF67746D);
  static const Color secondaryBeige = Color(0xFFF2EAD8);
  static const Color highlightGreen = Color(0xFFE6F4EA);
  static const Color highlightAmber = Color(0xFFFFF7E6);
  static const Color successGreen = Color(0xFF16A34A);
  static const Color errorRed = Color(0xFFDC2626);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentAmber,
        surface: cardWhite,
      ),
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textDark,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textDark,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          color: textDark,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textMuted,
          height: 1.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: cardWhite,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}