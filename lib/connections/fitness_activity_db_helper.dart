import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper_base.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:http/http.dart' as http;

class ActivityDBHelper extends DBHelperBase {
  var baseUrl = 'https://10.0.2.2:7777/';

  Future<http.Response> getActivities() async {
    var requestUrl = baseUrl + 'api/fitnessActivity/all';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getActivityOptions() async {
    var requestUrl = baseUrl + 'api/activityOptions/all';
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveNewActivity(
      ActivityModel fitnessActivityModel) async {
    var requestUrl = baseUrl + 'api/fitnessActivity/add/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'type': fitnessActivityModel.type,
          'intensity': fitnessActivityModel.intensity.toString(),
          'minutes': fitnessActivityModel.minutes.toString(),
          'dateTime': fitnessActivityModel.dateTime.toIso8601String(),
        }));
  }
  Future<http.Response> updateExistingActivity(
      ActivityModel activityModel) async {
    var requestUrl = baseUrl + 'api/fitnessActivity/update/';
    var uriResponse = await http.put(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id': activityModel.id,
          'type': activityModel.type,
          'intensity': activityModel.intensity.toString(),
          'minutes': activityModel.minutes.toString(),
          'dateTime': activityModel.dateTime.toIso8601String(),
        }));
  }
}
