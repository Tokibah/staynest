import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = _lightMode;
  get themeData => _themeData;

  void toggleMode() {
    _themeData = _themeData == _lightMode ? _darkMode : _lightMode;
    notifyListeners();
  }

  void setLight() {
    _themeData = _lightMode;
    notifyListeners();
  }

  static const Color darkBack = Color(0xFF323842);
  static const Color darkMain = Color.fromARGB(255, 217, 78, 122);
  static const Color darkSec = Color(0xFF73b5e7);

  static const Color lightBack = Color(0xFFf8f9fa);
  static const Color lightMain = Color(0xFF3977d5);
  static const Color lightSec = Colors.white;

  static final ThemeData _lightMode = ThemeData(
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: lightSec,
    ),
    colorScheme:
    const ColorScheme.light(primary: lightMain, secondary: lightSec),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent),
    scaffoldBackgroundColor: lightBack,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black, fontFamily: "NType"),
        bodySmall: TextStyle(color: Colors.black, fontFamily: "NType")),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.black,
            foregroundColor: lightBack)),
  );

  static final ThemeData _darkMode = ThemeData(
    snackBarTheme: const SnackBarThemeData(backgroundColor: darkSec),
    colorScheme: const ColorScheme.dark(primary: darkMain, secondary: darkSec),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent),
    scaffoldBackgroundColor: darkBack,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontFamily: "NType"),
        bodySmall: TextStyle(color: Colors.white, fontFamily: "NType")),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: darkMain,
            foregroundColor: Colors.white)),
  );
}
