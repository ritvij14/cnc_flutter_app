import 'dart:convert';

import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper_base.dart';

class DBHelper extends DBHelperBase {

  Future<bool> isEmailValid(String email) async {
    var requestUrl = baseUrl + 'api/users/checkIfEmailExists/' + email;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    bool isValid = json.decode(response.body);
    return isValid;
  }

  //user id as a string or 'invalid'
  Future<String> login(String email, String password) async {
    var requestUrl =
        baseUrl + 'api/users/login/' + email + '/' + password + '/';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response.body.toString();
  }

  Future<bool> getFormCompletionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/formstatus/' + userId;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});

    return response.body.toString() == 'true';
  }

  Future<http.Response> getFood() async {
    var requestUrl = baseUrl + 'api/food/all';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> searchFood(String query) async {
    var requestUrl = baseUrl + 'api/food/search/' + query;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getUserFrequentFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/' + userId + '/foodlog/frequent';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/' + userId + '/get';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveRatios(
    int fatPercent,
    int proteinPercent,
    int carbohydratePercent,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/profile/ratios';
    var response = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'userId': userId,
          'fatPercent': fatPercent,
          'proteinPercent': proteinPercent,
          'carbohydratePercent': carbohydratePercent,
        }));
    return response;
  }

  Future<http.Response> updateWeight(MetricModel metricModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/$userId/update/weight/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'weight': metricModel.weight.toString(),
          'dateTime': metricModel.dateTime.toIso8601String(),
        }));
  }

  Future<http.Response> saveFormInfo(
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/form/save/';
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

  Future<http.Response> updateFormInfo(
    String birthDate,
    String race,
    String ethnicity,
    String gender,
    String height,
    String weight,
    String activityLevel,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/form/update/';
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
        }));
    return response;
  }

  Future<http.Response> updateFormInfoBasic(
    String weight,
    String activityLevel,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/form/update/basic';
    var response = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'userId': userId,
          'weight': weight,
          'activityLevel': activityLevel,
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
    var requestUrl = baseUrl + 'api/users/register/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': userModel.email,
          'password': userModel.password,
        }));
    return uriResponse;
  }

  resetPassword(String email) async{

    var queryParameters = {
      'email': email,
    };
    var uri =
    Uri.https(baseUri, 'api/users/resetPassword', queryParameters);

    var response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    return response;

  }


  Future<http.Response> getFoodLog(date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/' + userId + '/foodlog/' + date;
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> deleteFoodLogEntry(foodLogEntryId) async {
    var requestUrl =
        baseUrl + 'api/users/foodlog/delete/' + foodLogEntryId.toString();
    http.Response response =
        await http.delete(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> deleteUserGiIssues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/users/' + userId + '/delete/issues/';
    http.Response response =
        await http.delete(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveNewFoodLogEntry(
      entryTime, date, foodId, portion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
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

