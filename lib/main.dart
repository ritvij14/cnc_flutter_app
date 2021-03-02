import 'dart:io';

import 'package:cnc_flutter_app/authorization.dart';
import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_overrides.dart';
import 'nutrition_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Authorization auth = Authorization();
  final bool loggedIn = await auth.isLogged();
  await Preferences.init();
  HttpOverrides.global = new MyHttpOverrides();
  // ignore: unrelated_type_equality_checks
  final NutritionApp nutritionApp = NutritionApp(initialRoute: loggedIn == true ? '/' : '/login',);
  runApp(nutritionApp);
}
