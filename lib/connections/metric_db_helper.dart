import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper_base.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:http/http.dart' as http;

class MetricDBHelper extends DBHelperBase {
  Future<http.Response> getAllMetrics() async {
    var requestUrl = baseUrl + 'api/metric/all';
    http.Response response = await http.get(Uri.parse(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getMetrics(int userId) async {
    var queryParameters = {
      'userId': userId.toString(),
    };
    var uri = Uri.https(baseUri, '/api/metric/all/user', queryParameters);

    var response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<http.Response> saveNewMetric(MetricModel metricModel) async {
    var requestUrl = baseUrl + 'api/metric/add/';
    var uriResponse = await http.post(Uri.parse(requestUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'weight': metricModel.weight.toString(),
          'dateTime': metricModel.dateTime.toIso8601String(),
          'userId': metricModel.userId.toString(),
        }));
  }

  Future<http.Response> getMetricsForPastDays(
      int userId, int numberOfDays) async {
    var queryParameters = {
      'userId': userId.toString(),
      'numberOfDays': numberOfDays.toString(),
    };

    var uri = Uri.https(baseUri, '/api/metric/user/range', queryParameters);

    var response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<http.Response> getDayMetricList(int userId) async {
    var queryParameters = {
      'userId': userId.toString(),
    };

    var uri = Uri.https(baseUri, '/api/metric/day/user', queryParameters);

    var response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }
}
