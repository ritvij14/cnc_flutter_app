import 'package:flutter/material.dart';

enum AppTheme {
  Default,
  DarkMode,
  PeriwinkleLight,
  PinkLight,
  TealLight,
}

final appThemeData = {
  AppTheme.Default: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green[700],
    cardColor: Colors.green[800],
    accentColor: Colors.green[400],
    highlightColor: Colors.white,

  ),
  AppTheme.DarkMode: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    cardColor: Colors.black,
    accentColor: Colors.grey[900],
    highlightColor: Colors.white,
  ),
  AppTheme.PeriwinkleLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo[300],
    cardColor: Colors.indigo[400],
    accentColor: Colors.indigo[200],
    highlightColor: Colors.white,
  ),
  AppTheme.PinkLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red[300],
    cardColor: Colors.red[400],
    accentColor: Colors.red[200],
    highlightColor: Colors.white,
  ),
  AppTheme.TealLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    cardColor: Colors.teal[600],
    accentColor: Colors.teal[300],
    highlightColor: Colors.white,
  ),
};