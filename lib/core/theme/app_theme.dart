import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF6C63FF), // Vibrant Purple
        secondary: const Color(0xFF03DAC6), // Teal Accent
        surface: const Color(0xFF1E1E1E),
        error: const Color(0xFFCF6679),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ),
      // cardTheme: CardTheme(
      //   color: const Color(0xFF1E1E1E),
      //   elevation: 8,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
