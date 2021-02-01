import 'package:cnc_flutter_app/screens/home_screen.dart';
import 'package:cnc_flutter_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class NutritionApp extends StatefulWidget {

  @override
  _NutritionAppState createState() => _NutritionAppState();
}

class _NutritionAppState extends State<NutritionApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
              key: ValueKey('Home'),
              child: LoginScreen()),
        ],
        onPopPage: (route, result) {
          if(!route.didPop(result)) return false;

          return true;
        },
      ),
    );
  }
}
