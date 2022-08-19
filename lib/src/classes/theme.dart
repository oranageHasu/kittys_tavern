// Dark Theme
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appDarkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 31, 31, 31),
    onPrimary: Colors.white,
    secondary: Colors.amber,
    onSecondary: Colors.amber,
    error: Colors.amber,
    onError: Colors.amber,
    background: Colors.amber,
    onBackground: Colors.amber,
    surface: Colors.amber,
    onSurface: Colors.amber,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white.withOpacity(0.25),
  ),
  scrollbarTheme: ScrollbarThemeData(
    trackColor: MaterialStateProperty.all(appDarkAccentColor),
    thumbColor: MaterialStateProperty.all(Colors.white),
  ),
  dividerColor: Colors.white12,
  textTheme: TextTheme(
    titleSmall: GoogleFonts.signikaNegative(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.signikaNegative(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelSmall: GoogleFonts.signikaNegative(
      fontSize: 14.0,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.signikaNegative(
      fontSize: 18.0,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.signikaNegative(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

// Light Theme
ThemeData appLightTheme = ThemeData().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 97, 184, 255),
    onPrimary: Colors.white,
    secondary: Colors.amber,
    onSecondary: Colors.amber,
    error: Colors.amber,
    onError: Colors.amber,
    background: Colors.amber,
    onBackground: Colors.amber,
    surface: Colors.amber,
    onSurface: Colors.amber,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.25),
  ),
  scrollbarTheme: ScrollbarThemeData(
    trackColor: MaterialStateProperty.all(appLightAccentColor),
    thumbColor: MaterialStateProperty.all(appLightAccentColor),
  ),
  dividerColor: Colors.black12,
  textTheme: TextTheme(
    titleSmall: GoogleFonts.signikaNegative(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.signikaNegative(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.signikaNegative(
      fontSize: 14.0,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.signikaNegative(
      fontSize: 18.0,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.signikaNegative(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

// Light Theme Colors
const Color appLightAccentColor = Color.fromRGBO(0, 0, 0, 0.05);

// Dark Theme Colors
const Color appDarkAccentColor = Color.fromRGBO(255, 255, 255, 0.05);
