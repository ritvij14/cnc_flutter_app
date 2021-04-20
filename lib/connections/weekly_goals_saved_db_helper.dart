import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeeklySavedDBHelper extends DBHelper {
  var baseUrl = 'https://enact-crc-app.herokuapp.com/';

  Future<http.Response> getWeeklySavedGoals() async {
    var requestUrl = baseUrl + 'api/weekly_goals_saved/all/';
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getWeeklySavedGoalsByUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/weekly_goals_saved/all/$userId';
    var queryParameters = {
      'userId': userId.toString(),
    };
    var uri =
    Uri.https('10.0.2.2:7777', '/api/weekly_goals_saved/all/$userId', queryParameters);

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
    var uriResponse = await http.post(requestUrl,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('id');
    var requestUrl = baseUrl + 'api/weekly_goals_saved/delete/$userId';
    http.Response response =
    await http.delete(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

}