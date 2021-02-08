import 'package:cnc_flutter_app/connections/mysql_connector.dart';
import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:cnc_flutter_app/screens/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/fitness_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/navigator_screen.dart';
import 'package:cnc_flutter_app/screens/login_screen.dart';
import 'package:cnc_flutter_app/screens/summary_screen.dart';
import 'package:cnc_flutter_app/screens/symptom_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class NutritionApp extends StatelessWidget {

  String initialRoute = determineInitRoute();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/': (context) => LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/home' : (context) => NavigatorScreen(),
        '/summary' : (context) => SummaryScreen(),
        '/dietTracking' : (context) => DietTrackingScreen(),
        '/fitnessTracking' : (context) => FitnessTrackingScreen(),
        '/symptomTracking' : (context) => SymptomTrackingScreen(),




      }
    );
  }

  static String determineInitRoute() {
    //check if logged in,
    //check if completed questionnaire,
    //if both are true login
    return '/';
  }
}


