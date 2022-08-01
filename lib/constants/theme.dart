import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mod_app/constants/colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      backgroundColor: const Color(0xfff6f6f6),
      primaryColor: AppColors.mainColor,
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromRGBO(224, 231, 255, 0.3), filled: true),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      )));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: const Color(0x00000000),
      primaryColor: AppColors.mainColor,
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromRGBO(224, 231, 255, 0.3), filled: true),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      )));
}
