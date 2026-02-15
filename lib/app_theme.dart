import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xff171717);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffA0A0A0);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarThemeData(
      backgroundColor: white,
      foregroundColor: black,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: .w500, color: black),
    ),
    dividerColor: black,
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: white,
        foregroundColor: black,
        textStyle: TextStyle(fontSize: 16, fontWeight: .bold, color: black),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(fontSize: 28, fontWeight: .bold, color: white),
      titleLarge: TextStyle(fontSize: 24, fontWeight: .w500, color: black),
      titleMedium: TextStyle(fontSize: 20, fontWeight: .bold, color: black),
      titleSmall: TextStyle(fontSize: 16, fontWeight: .bold, color: black),
      labelMedium: TextStyle(fontSize: 14, fontWeight: .w500, color: grey),
      labelSmall: TextStyle(fontSize: 12, fontWeight: .w500, color: grey),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarThemeData(
      backgroundColor: black,
      foregroundColor: white,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: .w500, color: white),
    ),
    dividerColor: white,
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: black,
        foregroundColor: white,
        textStyle: TextStyle(fontSize: 16, fontWeight: .bold, color: white),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(fontSize: 28, fontWeight: .bold, color: black),
      titleLarge: TextStyle(fontSize: 24, fontWeight: .w500, color: white),
      titleMedium: TextStyle(fontSize: 20, fontWeight: .bold, color: white),
      titleSmall: TextStyle(fontSize: 16, fontWeight: .bold, color: white),
      labelMedium: TextStyle(fontSize: 14, fontWeight: .w500, color: grey),
      labelSmall: TextStyle(fontSize: 12, fontWeight: .w500, color: grey),
    ),
  );
}
