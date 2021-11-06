import 'package:flutter/material.dart';
import 'package:todo_manager/constants/app_colors.dart' as color;

class Themes {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    backgroundColor: color.white,
    scaffoldBackgroundColor: color.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: color.white,
      elevation: 0,
    ),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: color.black,
    scaffoldBackgroundColor: color.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: color.black,
      elevation: 0,
    ),
  );
}
