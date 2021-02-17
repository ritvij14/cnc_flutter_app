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
  Future<http.Response> searchFood(String query) async {
    var requestUrl = baseUrl + 'api/food/' + query + '/';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveFormInfo(
      String userId,
      String birthDate,
      String race,
      String ethnicity,
      String height,
      String weight,
      String activityLevel,
      String gIIssues,
      String colonCancer,
      String colonStage,
      String rectumCancer,
      String rectumStage,
      String lastDiagDate,
      String surgery,
      String radiation,
      String chemotherapy,
      String surgeryType) async {
    var requestUrl = baseUrl +
        'api/users/save/' +
        userId +
        "/" +
        birthDate +
        '/' +
        race +
        '/' +
        ethnicity +
        '/' +
        height +
        '/' +
        weight +
        '/' +
        activityLevel +
        '/' +
        gIIssues +
        '/' +
        colonCancer +
        '/' +
        colonStage +
        '/' +
        rectumCancer +
        '/' +
        rectumStage +
        '/' +
        lastDiagDate +
        '/' +
        surgery +
        '/' +
        radiation +
        '/' +
        chemotherapy +
        '/' +
        surgeryType;
    http.Response response =
        await http.post(Uri.encodeFull(requestUrl), headers: {});
    print(requestUrl);
    return response;
  }

  Future<http.Response> getActivities() async {
    var requestUrl = baseUrl + 'api/activity/all';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

}
