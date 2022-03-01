import 'package:cnc_flutter_app/src/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool('LOGIN');
    return isLoggedIn ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const MaterialApp();
            } else {
              return const LoginPage();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
