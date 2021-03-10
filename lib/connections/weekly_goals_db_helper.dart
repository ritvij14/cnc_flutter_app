import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:http/http.dart' as http;

class WeeklyDBHelper extends DBHelper {
  var baseUrl = 'https://10.0.2.2:7777/';

  Future<http.Response> getWeeklyGoals() async {
    var requestUrl = baseUrl + 'api/weekly_goals/all/';
    http.Response response =
      await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveWeeklyGoal(
      WeeklyGoalsModel weeklyGoalsModel) async {
    var requestUrl = baseUrl + 'api/weekly_goals/add/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'type': weeklyGoalsModel.type,
          'goalDescription': weeklyGoalsModel.goalDescription,
          'helpInfo': weeklyGoalsModel.helpInfo,
        }));
  }

}