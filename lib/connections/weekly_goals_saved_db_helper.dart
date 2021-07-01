import 'dart:convert';

import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper_base.dart';

class WeeklySavedDBHelper extends DBHelperBase {
  Future<http.Response> getWeeklySavedGoals() async {
    var requestUrl = baseUrl + 'api/weekly_goals_saved/all/';
    http.Response response = await http.get(Uri.parse(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getWeeklySavedGoalsByUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/weekly_goals_saved/all/$userId';
    var queryParameters = {
      'userId': userId.toString(),
    };
    var uri = Uri.https(
        baseUri, '/api/weekly_goals_saved/all/$userId', queryParameters);

    var response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<http.Response> saveWeeklySavedGoal(
      WeeklySavedGoalsModel weeklySavedGoalsModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/weekly_goals_saved/add/';
    var uriResponse = await http.post(Uri.parse(requestUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id': weeklySavedGoalsModel.id,
          'type': weeklySavedGoalsModel.type,
          'goalDescription': weeklySavedGoalsModel.goalDescription,
          'help_info': weeklySavedGoalsModel.helpInfo,
          'userId': userId,
        }));
  }

  Future<http.Response> deleteWeeklyGoalsSavedByID(int id) async {
    var requestUrl = baseUrl + 'api/weekly_goals_saved/delete/$id';
    http.Response response =
        await http.delete(Uri.parse(requestUrl), headers: {});
    return response;
  }
}
