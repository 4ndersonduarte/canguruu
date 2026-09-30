import 'package:flutter/material.dart';

abstract final class CanguruuColors {
  static const yellow = Color(0xFFFFD400);
  static const ink = Color(0xFF111111);
  static const offWhite = Color(0xFFFAF9F5);
  static const paper = Color(0xFFFFFFFF);
  static const yellowWash = Color(0xFFFFF2CC);
  static const mist = Color(0xFFEAF4EE);
  static const muted = Color(0xFF62645F);
  static const line = Color(0xFFDEDDD6);
  static const green = Color(0xFF347A55);
  static const red = Color(0xFFAB4D3B);
}

abstract final class CanguruuType {
  static const display = 'Trocchi';
  static const body = 'Inter';
  static const mono = 'JetBrainsMono';
  static const amount = TextStyle(
    fontFamily: display,
    fontSize: 26,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    height: 1.3,
  );
}

ThemeData canguruuTheme() {
  const scheme = ColorScheme.light(
    primary: CanguruuColors.ink,
    onPrimary: Colors.white,
    primaryContainer: CanguruuColors.yellow,
    onPrimaryContainer: CanguruuColors.ink,
    secondary: CanguruuColors.ink,
    onSecondary: Colors.white,
    secondaryContainer: CanguruuColors.yellow,
    onSecondaryContainer: CanguruuColors.ink,
    surface: CanguruuColors.paper,
    onSurface: CanguruuColors.ink,
    onSurfaceVariant: CanguruuColors.muted,
    surfaceTint: Colors.transparent,
    outline: CanguruuColors.line,
    outlineVariant: CanguruuColors.line,
    error: CanguruuColors.red,
  );
  const buttonText = TextStyle(
    fontFamily: CanguruuType.mono,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  final controlShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );
  final fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: CanguruuColors.line),
  );
  return ThemeData(
    useMaterial3: true,
    fontFamily: CanguruuType.body,
    colorScheme: scheme,
    scaffoldBackgroundColor: CanguruuColors.offWhite,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: CanguruuType.display,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.8,
      ),
      headlineMedium: TextStyle(
        fontFamily: CanguruuType.display,
        fontSize: 27,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.65,
      ),
      titleLarge: TextStyle(
        fontFamily: CanguruuType.display,
        fontSize: 21,
        fontWeight: FontWeight.w700,
        height: 1.35,
        letterSpacing: -0.3,
      ),
      titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 15, height: 1.6),
      bodyMedium: TextStyle(fontSize: 13, height: 1.55),
      labelLarge: buttonText,
    ).apply(bodyColor: CanguruuColors.ink, displayColor: CanguruuColors.ink),
    cardTheme: CardThemeData(
      elevation: 0,
      color: CanguruuColors.paper,
      surfaceTintColor: Colors.transparent,
      shadowColor: const Color(0x180E261D),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide.none,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CanguruuColors.paper,
      border: fieldBorder,
      enabledBorder: fieldBorder,
      focusedBorder: fieldBorder.copyWith(
        borderSide: const BorderSide(color: CanguruuColors.ink, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      labelStyle: const TextStyle(fontSize: 13, color: CanguruuColors.muted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 50),
        elevation: 0,
        shape: controlShape,
        backgroundColor: CanguruuColors.yellow,
        foregroundColor: CanguruuColors.ink,
        side: const BorderSide(color: CanguruuColors.ink, width: 0.8),
        textStyle: buttonText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: CanguruuColors.ink, width: 0.8),
        shape: controlShape,
        textStyle: buttonText,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: buttonText),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(controlShape),
        textStyle: const WidgetStatePropertyAll(buttonText),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: controlShape,
      side: const BorderSide(color: CanguruuColors.line),
      selectedColor: CanguruuColors.yellow,
      backgroundColor: CanguruuColors.paper,
      labelStyle: buttonText,
      showCheckmark: false,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: CanguruuColors.paper,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: CanguruuColors.line),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: CanguruuColors.line,
      thickness: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: CanguruuColors.ink,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
