import 'package:shared_preferences/shared_preferences.dart';

import 'connections/db_helper.dart';

class Authorization {

  var db = new DBHelper();

  Future<bool> isLogged() async {
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    if(id != null){
      print('User is already logged in, routing to home');
    } else {
      print('User is not logged in, routing to login');
    }
    return id != null;
  }

  Future<bool> isScreenerComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get('id');
    if(id == null){
      return false;
    }
    var response = await db.getFormCompletionStatus(id);

    bool formComplete = (response.toString() == 'true');

    print('The welcome screener came back as ' + formComplete.toString());
    if (formComplete) {
      return true;
    } else {
      return false;
    }
  }
}