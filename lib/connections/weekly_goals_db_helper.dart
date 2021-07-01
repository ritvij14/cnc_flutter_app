import 'dart:convert';

import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper_base.dart';

class WeeklyDBHelper extends DBHelperBase {
  Future<http.Response> getWeeklyGoals() async {
    var requestUrl = baseUrl + 'api/weekly_goals/all/';
    http.Response response = await http.get(Uri.parse(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveWeeklyGoal(
      WeeklyGoalsModel weeklyGoalsModel) async {
    var requestUrl = baseUrl + 'api/weekly_goals/add/';
    var uriResponse = await http.post(Uri.parse(requestUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'type': weeklyGoalsModel.type,
          'goalDescription': weeklyGoalsModel.goalDescription,
          'help_info': weeklyGoalsModel.helpInfo,
        }));
  }
}
