import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xff171717);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffA0A0A0);

  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarThemeData(
      backgroundColor: black,
      foregroundColor: white,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: .w500, color: white),
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
