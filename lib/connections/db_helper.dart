import 'dart:convert';

import 'package:http/http.dart' as http;

class DBHelper {
  var baseUrl = 'https://10.0.2.2:7777/';

  //
  // http.Response response = await http.get(Uri.encodeFull(url), headers: {
  // "Authorization": "Bearer 5e46v0tks21zqvnloyua8e76bcsui9",
  // "Client-Id": "874uve10v0bcn3rmp2bq4cvz8fb5wj"
  // });

  // topStreamerInfo = json.decode(response.body);

  Future<bool> isEmailValid(String email) async {
    var requestUrl = baseUrl + 'api/users/checkIfEmailExists/' + email;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    bool isValid = json.decode(response.body);
    return isValid;
  }

  //'valid' or 'invalid'
  Future<bool> login(String email, String password) async {
    var requestUrl =
        baseUrl + 'api/users/login/' + email + '/' + password + '/';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    print('here');
    // print(json.decode(response.body));
    return response.body.toString() == 'valid';
  }

  Future<http.Response> getFood() async {
    var requestUrl = baseUrl + 'api/food/all/';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }
}
