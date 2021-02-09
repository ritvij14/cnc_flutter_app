import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter/material.dart';
import 'nutrition_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(NutritionApp());
}

