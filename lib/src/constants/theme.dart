import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mod_app/src/constants/colors.dart';

class ThemePreference {
  static const THEME_STATUS = "THEME_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  bool _darkmode = false;

  ThemeProvider(bool isDarkTheme) {
    _darkmode = isDarkTheme;
  }

  bool get getDarkMode => _darkmode;

  void setDarkThemeMode(bool data) {
    _darkmode = data;
    darkThemePreference.setDarkTheme(data);
    notifyListeners();
  }

  void switchThemeMode() {
    _darkmode = !_darkmode;
    darkThemePreference.setDarkTheme(_darkmode);
    notifyListeners();
  }
}

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: const Color(0xfff6f6f6),
    primaryColor: mainColor,
    primarySwatch: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromRGBO(224, 231, 255, 0.3), filled: true));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: const Color(0x00000000),
    primaryColor: mainColor,
    primarySwatch: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromRGBO(224, 231, 255, 0.3), filled: true));
