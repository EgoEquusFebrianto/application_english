import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
);

class SwitchModeProvider extends ChangeNotifier {
  ThemeData _themeData = light;

  ThemeData get themeData => _themeData;

  bool get darkMode => _themeData == dark;

  set themeData(ThemeData val) {
    _themeData = val;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = darkMode ? light : dark;
    notifyListeners();
  }
}
