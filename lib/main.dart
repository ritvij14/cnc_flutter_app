import 'dart:io';

import 'package:cnc_flutter_app/authorization.dart';
import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_overrides.dart';
import 'nutrition_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Authorization auth = Authorization();
  await Preferences.init();
  HttpOverrides.global = new MyHttpOverrides();
  final bool loggedIn = await auth.isLogged();
  final bool screenerComplete = await auth.isScreenerComplete();
  // ignore: unrelated_type_equality_checks
  final NutritionApp nutritionApp = NutritionApp(initialRoute: loggedIn == false ? '/login' : screenerComplete == false ? '/welcome' : '/home');
  runApp(nutritionApp);
}
