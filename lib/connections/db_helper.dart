import 'dart:convert';

import 'package:cnc_flutter_app/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper_base.dart';

class DBHelper{
  var baseUrl = 'https://10.0.2.2:7777/';

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

  Future<http.Response> getUserFrequentFoods(userId) async {
    var requestUrl = baseUrl + 'api/users/' + userId.toString() + '/foodlog/frequent';
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getUserInfo(userId) async {
    var requestUrl = baseUrl + 'api/users/' + userId + '/get';
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

  Future<http.Response> updateFormInfo(
      String userId,
      String birthDate,
      String race,
      String ethnicity,
      String gender,
      String height,
      String weight,
      String activityLevel,
  ) async {
    var requestUrl = baseUrl +
        'api/users/form/update/';
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
    print("this is the response body");
    print(uriResponse.body);
  }


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

  Future<http.Response> deleteUserGiIssues(userId) async {
    var requestUrl = baseUrl + 'api/users/'+userId+'/delete/issues/';
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

