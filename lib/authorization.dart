import 'package:shared_preferences/shared_preferences.dart';

class Auth {

  Future<bool> isNotLogged() async {
    var sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString('email');
    return email == null;
    // return Future<bool>.value(email == null);
  }
}