import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  fontFamily: GoogleFonts.raleway().fontFamily,
  brightness: Brightness.light,
  primaryColor: Colors.blue, 
  primaryIconTheme: IconThemeData(
    color: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue, 
    elevation: 0, // No shadow
    iconTheme: IconThemeData(color: Colors.white), // Icon color
    titleTextStyle: TextStyle(color: Colors.white), // Title text color
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.black, // Icon color for light mode
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: GoogleFonts.raleway().fontFamily,

  brightness: Brightness.dark,
  primaryColor: Colors.indigo, // Adjust primary color as per your design
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900], // Adjust app bar color
    elevation: 0, // No shadow
    iconTheme: IconThemeData(color: Colors.white), // Icon color
    titleTextStyle: TextStyle(color: Colors.white), // Title text color
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    splashColor: Colors.indigo,
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.black, // Icon color for dark mode
  ),
);
