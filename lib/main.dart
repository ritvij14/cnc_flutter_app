import 'dart:io';

import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_overrides.dart';
import 'nutrition_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  HttpOverrides.global = new MyHttpOverrides();
  final NutritionApp nutritionApp = NutritionApp(initialRoute: isLogged() != null ? '/home' : '/',);
  runApp(nutritionApp);
}

Future<bool> isLogged() async {
  var sharedPref = await SharedPreferences.getInstance();
  String email = sharedPref.getString('email');
  print(email != null);
  return email != null;
}
