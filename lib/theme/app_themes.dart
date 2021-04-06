import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.Default: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue[700],
      cardColor: Colors.blue[800],
      accentColor: Colors.blue[400],
      highlightColor: Colors.white,
      shadowColor: Colors.black,
      buttonColor: Colors.blue[700],
      dividerColor: Colors.transparent,
    ),
    AppTheme.DarkMode: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      cardColor: Colors.black,
      accentColor: Colors.grey[900],
      highlightColor: Colors.white,
      shadowColor: Colors.black,
      buttonColor: Colors.teal,
      dividerColor: Colors.transparent,
    ),
    // AppTheme.PeriwinkleLight: ThemeData(
    //   brightness: Brightness.light,
    //   primaryColor: Colors.indigo[300],
    //   cardColor: Colors.indigo[400],
    //   accentColor: Colors.indigo[200],
    //   highlightColor: Colors.white,
    //   shadowColor: Colors.black,
    //   buttonColor: Colors.indigo[300],
    //   dividerColor: Colors.transparent,
    // ),
    // AppTheme.PinkLight: ThemeData(
    //   brightness: Brightness.light,
    //   primaryColor: Colors.red[300],
    //   cardColor: Colors.red[400],
    //   accentColor: Colors.red[200],
    //   highlightColor: Colors.white,
    //   shadowColor: Colors.black,
    //   buttonColor: Colors.red[300],
    //   dividerColor: Colors.transparent,
    // ),
    // AppTheme.TealLight: ThemeData(
    //     brightness: Brightness.light,
    //     primaryColor: Colors.teal,
    //     cardColor: Colors.teal[600],
    //     accentColor: Colors.teal[300],
    //     highlightColor: Colors.white,
    //     shadowColor: Colors.black,
    //     buttonColor: Colors.teal),
  };
}

enum AppTheme {
  Default,
  DarkMode,
  // PeriwinkleLight,
  // PinkLight,
  // TealLight,
}
