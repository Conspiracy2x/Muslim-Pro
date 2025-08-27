import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gradientTheme.dart';

class AppTheme extends ChangeNotifier {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    cardTheme: const CardTheme(
      color: Colors.white,
      shadowColor: Colors.black12,
      elevation: 4, // Standard elevation for cards
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.ralewayTextTheme().copyWith(
      displayLarge: GoogleFonts.raleway(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.merriweather(
        color: Colors.black87,
        fontSize: 16,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.green.shade800,
        fontSize: 18,
      ),
    ),
    extensions: [GradientTheme.light],
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green.shade900,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 4,
      centerTitle: false,
      titleTextStyle: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade800,
      shadowColor: Colors.black54,
      elevation: 4,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green.shade800,
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.ralewayTextTheme().copyWith(
      displayLarge: GoogleFonts.raleway(
        color: Colors.amber.shade300,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.merriweather(
        color: Colors.white70,
        fontSize: 16,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.amber.shade300,
        fontSize: 18,
      ),
    ),
    extensions: [GradientTheme.dark],
  );

  ThemeData currentTheme = lightTheme;

  toggleTheme() {
    currentTheme = currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
