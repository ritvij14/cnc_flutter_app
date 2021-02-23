import 'dart:convert';

import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
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
    // print(json.decode(response.body));
    return response.body.toString() == 'valid';
  }

  Future<bool> getFormCompletionStatus(String email) async {
    var requestUrl =
        baseUrl + 'api/users/formstatus/' + email;
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response.body.toString() == 'true';
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
      String gender,
      String height,
      String weight,
      String activityLevel,
      String gIIssues,
      bool colorectalCancer,
      String colorectalStage,
      String lastDiagDate,
      String cancerTreatment) async {
    var requestUrl = baseUrl +
        'api/users/form/save/';
    var response = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'userId': userId,
          'birthDate': birthDate,
          'race': race,
          'ethnicity': ethnicity,
          'gender': gender,
          'height': height,
          'weight': weight,
          'activityLevel': activityLevel,
          'gastroIntestinalIssues': gIIssues,
          'colorectalCancer': colorectalCancer,
          'colorectalStage': colorectalStage,
          'lastDiagDate': lastDiagDate,
          'cancerTreatment': cancerTreatment
        }));
    return response;
  }


  // Future<http.Response> getActivities() async {
  //   var requestUrl = baseUrl + 'api/activity/all';
  //   http.Response response =
  //       await http.get(Uri.encodeFull(requestUrl), headers: {});
  //   return response;
  // }

  Future<http.Response> registerNewUser(UserModel userModel) async {
    var requestUrl =
        baseUrl + 'api/users/register/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': userModel.email,
          'password': userModel.password,
        }));
  }
//       await http.get(Uri.encodeFull(requestUrl), headers: {"Content-Type": "application/json"});
//   // print(json.decode(response.body));
//   print(response.body.toString());
//   return response.body.toString() == 'registered';
// }

  Future<http.Response> getFoodLog(userId, date) async {
    var requestUrl = baseUrl + 'api/users/' + userId + '/foodlog/' + date;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> deleteFoodLogEntry(foodLogEntryId) async {
    var requestUrl = baseUrl + 'api/users/foodlog/delete/' + foodLogEntryId.toString();
    http.Response response =
        await http.delete(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveNewFoodLogEntry(entryTime, date, userId, foodId, portion) async {
    var requestUrl = baseUrl + 'api/users/foodlog/save/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'entryTime': entryTime,
          'date': date,
          'userId': userId,
          'foodId': foodId,
          'portion': portion,
        }));
  }

  Future<http.Response> updateFoodLogEntry(id, entryTime, portion) async {
    var requestUrl = baseUrl + 'api/users/foodlog/update/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id': id,
          'entryTime': entryTime,
          'portion': portion,
        }));
  }
}

