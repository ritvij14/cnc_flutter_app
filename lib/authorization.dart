import 'package:shared_preferences/shared_preferences.dart';

class Authorization {

  Future<bool> isLogged() async {
    var sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString('email');
    print(email != null);
    return email != null;
  }
}