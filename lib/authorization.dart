import 'package:shared_preferences/shared_preferences.dart';

class Authorization {

  Future<bool> isLogged() async {
    var sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString('email');
    if(email != null){
      print('User is already logged in, routing to home');
    } else {
      print('User is not logged in, routing to login');
    }
    return email != null;
  }
}