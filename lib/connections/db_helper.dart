import 'dart:convert';

import 'package:http/http.dart' as http;


class DBHelper {
  var baseUrl = 'http://10.0.2.2:8080/';
  //
  // http.Response response = await http.get(Uri.encodeFull(url), headers: {
  // "Authorization": "Bearer 5e46v0tks21zqvnloyua8e76bcsui9",
  // "Client-Id": "874uve10v0bcn3rmp2bq4cvz8fb5wj"
  // });

  // topStreamerInfo = json.decode(response.body);

  Future<bool> isEmailValid(String email) async {
    var requestUrl = baseUrl + 'api/users/checkIfEmailExists/' + email;
    print(requestUrl);
    http.Response response = await http.get(Uri.encodeFull(requestUrl), headers: {
    });
    response = json.decode(response.body);
    print(response);
  }
}