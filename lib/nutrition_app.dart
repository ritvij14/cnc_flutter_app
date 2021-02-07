import 'package:cnc_flutter_app/connections/mysql_connector.dart';
import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:cnc_flutter_app/screens/navigator_screen.dart';
import 'package:cnc_flutter_app/screens/login_screen.dart';
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
      }
    );
    //   future: Mysql.verifyUser(),
    //   builder: (BuildContext context, AsyncSnapshot<User> snapshot){
    //     if (snapshot.hasData){
    //       User user = snapshot.data;
    //       return HomeScreen();
    //     }
    //     return LoginScreen();
    //   },
    // );
  }

  static String determineInitRoute() {
    //check if logged in,
    //check if completed questionnaire,
    //if both are true login
    return '/';
  }
}
