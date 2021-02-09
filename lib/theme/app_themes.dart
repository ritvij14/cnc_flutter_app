import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
  AppTheme.Default: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green[700],
    cardColor: Colors.green[800],
    accentColor: Colors.green[400],
    highlightColor: Colors.white,
    shadowColor: Colors.black,
    buttonColor: Colors.green[700],
  ),
  AppTheme.DarkMode: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    cardColor: Colors.black,
    accentColor: Colors.grey[900],
    highlightColor: Colors.white,
    shadowColor: Colors.black,
    buttonColor: Colors.teal,
  ),
  AppTheme.PeriwinkleLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo[300],
    cardColor: Colors.indigo[400],
    accentColor: Colors.indigo[200],
    highlightColor: Colors.white,
    shadowColor: Colors.black,
    buttonColor: Colors.indigo[300],
  ),
  AppTheme.PinkLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red[300],
    cardColor: Colors.red[400],
    accentColor: Colors.red[200],
    highlightColor: Colors.white,
    shadowColor: Colors.black,
    buttonColor: Colors.red[300],
  ),
  AppTheme.TealLight: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.teal,
      cardColor: Colors.teal[600],
      accentColor: Colors.teal[300],
      highlightColor: Colors.white,
      shadowColor: Colors.black,
      buttonColor: Colors.teal),
};
}

enum AppTheme {
  Default,
  DarkMode,
  PeriwinkleLight,
  PinkLight,
  TealLight,
}

// enum AppTheme {
//   Default,
//   DarkMode,
//   PeriwinkleLight,
//   PinkLight,
//   TealLight,
// }
//
// var current = 0;
//
// setCurrent(newCurrent) {
//   if (newCurrent == "AppTheme.Default") {
//     current = 0;
//   } else if (newCurrent == "AppTheme.DarkMode") {
//     current = 1;
//   }
// }
//
// getCurrent() async {
//
//  await setTheme();
//   print(current.toString() + "    OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
//   if (current == 0) {
//     return appThemeData[AppTheme.Default];
//   } else if (current == 1) {
//     return appThemeData[AppTheme.DarkMode];
//   }
//   return appThemeData[AppTheme.Default];
// }
//
// setTheme() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String stringValue = prefs.getString('savedTheme');
//   if (stringValue.isNotEmpty) {
//     print(
//         "NOT null string++++++++++++++++++++++++++++++++++++++++++++++    " +
//             stringValue);
//     setCurrent(stringValue);
//     return stringValue;
//   } else {
//     stringValue = "AppTheme.Default";
//     setCurrent(stringValue);
//     return stringValue;
//   }
// }
//
// final appThemeData = {
//   AppTheme.Default: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.green[700],
//     cardColor: Colors.green[800],
//     accentColor: Colors.green[400],
//     highlightColor: Colors.white,
//     shadowColor: Colors.black,
//     buttonColor: Colors.green[700],
//   ),
//   AppTheme.DarkMode: ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.black,
//     cardColor: Colors.black,
//     accentColor: Colors.grey[900],
//     highlightColor: Colors.white,
//     shadowColor: Colors.black,
//     buttonColor: Colors.teal,
//   ),
//   AppTheme.PeriwinkleLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.indigo[300],
//     cardColor: Colors.indigo[400],
//     accentColor: Colors.indigo[200],
//     highlightColor: Colors.white,
//     shadowColor: Colors.black,
//     buttonColor: Colors.indigo[300],
//   ),
//   AppTheme.PinkLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.red[300],
//     cardColor: Colors.red[400],
//     accentColor: Colors.red[200],
//     highlightColor: Colors.white,
//     shadowColor: Colors.black,
//     buttonColor: Colors.red[300],
//   ),
//   AppTheme.TealLight: ThemeData(
//       brightness: Brightness.light,
//       primaryColor: Colors.teal,
//       cardColor: Colors.teal[600],
//       accentColor: Colors.teal[300],
//       highlightColor: Colors.white,
//       shadowColor: Colors.black,
//       buttonColor: Colors.teal),
// };
