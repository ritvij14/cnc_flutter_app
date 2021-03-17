import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:cnc_flutter_app/theme/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'test@gmail.com': 'test1234',
  'hunter@gmail.com': 'hunter',
  '': '',
};

class LoginScreen extends StatelessWidget {
  var db = new DBHelper();

  // bool formComplete = true;

  Duration get loginTime => Duration(milliseconds: 2000);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      //user doesn't exist in db
      if (await db.isEmailValid(data.name) == false) {
        return 'Username does not exist';
      }
      var response = await db.login(data.name, data.password);
      if (response == "invalid") {
        return 'Incorrect password';
      }
      saveUserIDtoPref(response);

      //TODO remove store email code.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', '${data.name}');

      return null;
    });
  }

  Future<String> _registerUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      //check if username is already taken
      if (await db.isEmailValid(data.name) == true) {
        return 'Username is already taken.';
      }
      //create new user, save to db, then save to shared pref
      UserModel userModel = new UserModel(data.name, data.password);
      var response = await db.registerNewUser(userModel);
      String currentUserID = response.body;
      saveUserIDtoPref(currentUserID);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    //TODO add in logic to recover password
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // title: 'ENACT',
      logo: 'assets/logo.png',
      title: '',
      theme: LoginTheme(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          cardTheme: CardTheme(color: Colors.blue),
          // inputTheme: InputDecorationTheme(
          //   // fillColor: Colors.blue
          // ),
          buttonTheme: LoginButtonTheme(
            backgroundColor: Colors.blue[900],
          )),
      onLogin: _authUser,
      onSignup: _registerUser,
      onSubmitAnimationCompleted: () async {
        String route = await welcomeScreenComplete();
        print(route);
        Navigator.pushReplacementNamed(context, route);
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  Future<String> welcomeScreenComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');
    var response = await db.getFormCompletionStatus(id);
    bool formComplete = (response.toString() == 'true');
    print('The welcome screener came back as ' + formComplete.toString());
    if (formComplete) {
      return '/home';
    } else {
      return '/welcome';
    }
  }

  saveUserIDtoPref(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
  }
}
