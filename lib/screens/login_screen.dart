import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:cnc_flutter_app/theme/bloc/bloc.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'test@gmail.com': 'test1234',
  'hunter@gmail.com': 'hunter',
  '': '',
};

final encryptionKey = encrypt.Key.fromUtf8("oKLS5V5QycG3MYzZYhVCbSpvDeQxx5xk");
final encrypter =
    encrypt.Encrypter(encrypt.AES(encryptionKey, mode: encrypt.AESMode.cbc));
final iv = encrypt.IV.fromLength(16);

class LoginScreen extends StatelessWidget {
  var db = new DBHelper();

  // final privateKey = "MIIBOQIBAAJBAKWzaxbF6oAXQmF0Qufqy/YPGvSNvbI6p0J+9RCQjcnmt9JZdS5gjY4j/Lrr7NuoAkRb5hNxL9F5cOV8WyP+WM8CAwEAAQJAbVqaOv5Ew2IWQeCLYyjWkD3pySld3qjMx5qnutXbbTmPS/XHlQ5dt08tug4CoTcGvIvVA5ULablAuai0xCzbsQIhAOpPV1eFWsPkQlBsONPqEHgOt2ckyEFWDV3DVT6L1a0ZAiEAtQovPRc9TYWOwSQFCoSXQAkzJph3zGoBNKWfJrLeCicCIG5RPMYwOzPP3IkQ6xCbO3XLN/6QCtj4MwLaXOA95jTBAiAQ0UliG26ObQG932K4f2itgi1GQJOgYZiLE3edWLBXsQIgFsSLREPQd1O7aTvsOy5Fi6CQjHkhsqiO5WIdLzVw2RQ=";
  // final publicKey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKWzaxbF6oAXQmF0Qufqy/YPGvSNvbI6p0J+9RCQjcnmt9JZdS5gjY4j/Lrr7NuoAkRb5hNxL9F5cOV8WyP+WM8CAwEAAQ==";
  // final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));

  Duration get loginTime => Duration(milliseconds: 2000);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      //user doesn't exist in db
      if (await db.isEmailValid(data.name) == false) {
        return 'Username does not exist';
      }
      var response = await db.login(
          data.name, encrypter.encrypt(data.password, iv: iv).base64);
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
    return Future.delayed(loginTime).then((_) async {
      //check if username is already taken
      if (await db.isEmailValid(data.name) == true) {
        return 'Username is already taken.';
      }
      //create new user, save to db, then save to shared pref
      // final encryptedPass = encrypter.encrypt(data.password, iv: iv);
      // print(encryptedPass.runtimeType);
      UserModel userModel = new UserModel(
          data.name, encrypter.encrypt(data.password, iv: iv).base64);
      var response = await db.registerNewUser(userModel);
      String currentUserID = response.body;
      saveUserIDtoPref(currentUserID);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) async {
      if (await db.isEmailValid(name) == false) {
        return "It looks like there isn't an account with that email.";
      }
      //Recover password logic here
      var response = await db.resetPassword(name);

      //Recover password logic end
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // title: 'ENACT',
      logo: 'assets/logo.png',
      title: 'v0.10',
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
        Navigator.pushReplacementNamed(context, route);
      },
      onRecoverPassword: _recoverPassword,

      messages: LoginMessages(
          recoverPasswordDescription:
              "We will send you an email to reset your password."),
    );
  }

  Future<String> welcomeScreenComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');
    var response = await db.getFormCompletionStatus();
    bool formComplete = (response.toString() == 'true');
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
