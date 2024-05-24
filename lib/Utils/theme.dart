import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Cores Texto
Color primaryTextLight = const Color.fromARGB(255, 20, 24, 27);
Color secondaryTextLight = const Color.fromARGB(255, 20, 24, 27);
Color info = const Color.fromARGB(255, 87, 99, 108);
Color onPrimary = const Color.fromARGB(255, 255, 255, 255);

Color primaryTextDark = const Color.fromARGB(255, 255, 255, 255);
Color secondaryTextDark = const Color.fromARGB(255, 250, 250, 250);

// Cores Principais
Color primary = const Color.fromARGB(255, 25, 219, 138);
Color secondary = const Color.fromARGB(255, 54, 180, 255);
Color tertiary = const Color.fromARGB(255, 255, 161, 48);
Color accent1 = const Color.fromARGB(77, 25, 219, 138);
Color accent2 = const Color.fromARGB(77, 54, 180, 255);
Color accent3 = const Color.fromARGB(77, 255, 161, 48);

Color accent4Light = const Color.fromARGB(77, 224, 227, 231);
Color alternateLight = const Color.fromARGB(255, 224, 227, 231);
Color primaryBackgroundLight = const Color.fromARGB(255, 241, 244, 248);
Color secondaryBackgroundLight = const Color.fromARGB(255, 255, 255, 255);

Color alternateDark = const Color.fromARGB(255, 43, 50, 59);
Color accent4Dark = const Color.fromARGB(171, 43, 50, 59);
Color primaryBackgroundDark = const Color.fromARGB(255, 31, 31, 31);
Color secondaryBackgroundDark = const Color.fromARGB(255, 41, 41, 41);

ThemeData lighTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    inversePrimary: accent1,
    background: primaryBackgroundLight,
    surface: secondaryBackgroundLight,
    brightness: Brightness.light,
    onPrimary: onPrimary,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 57,
      color: primaryTextLight,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45,
      color: primaryTextLight,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 30,
      color: primaryTextLight,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 24,
      color: primaryTextLight,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      color: primaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      color: primaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: GoogleFonts.readexPro(
      fontSize: 22,
      color: primaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.readexPro(
      fontSize: 16,
      color: info,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: GoogleFonts.readexPro(
      fontSize: 14,
      color: info,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: GoogleFonts.readexPro(
      fontSize: 16,
      color: secondaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: GoogleFonts.readexPro(
      fontSize: 14,
      color: secondaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: GoogleFonts.readexPro(
      fontSize: 12,
      color: secondaryTextLight,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.readexPro(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.readexPro(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.readexPro(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    inversePrimary: accent1,
    surface: secondaryBackgroundDark,
    surfaceVariant: secondaryBackgroundDark,
    background: primaryBackgroundDark,
    onPrimary: onPrimary,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 57,
      color: primaryTextDark,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45,
      color: primaryTextDark,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 30,
      color: primaryTextDark,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      color: primaryTextDark,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      color: primaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 20,
      color: primaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: GoogleFonts.readexPro(
      fontSize: 22,
      color: primaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.readexPro(
      fontSize: 16,
      color: info,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: GoogleFonts.readexPro(
      fontSize: 14,
      color: info,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: GoogleFonts.readexPro(
      fontSize: 16,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: GoogleFonts.readexPro(
      fontSize: 14,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: GoogleFonts.readexPro(
      fontSize: 12,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.readexPro(
      fontSize: 16,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.readexPro(
      fontSize: 14,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.readexPro(
      fontSize: 12,
      color: secondaryTextDark,
      fontWeight: FontWeight.normal,
    ),
  ),
);
