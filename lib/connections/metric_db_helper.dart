import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper_base.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:http/http.dart' as http;


class MetricDBHelper extends DBHelperBase{

  Future<http.Response> getMetrics() async {
    var requestUrl = baseUrl + 'api/metric/all';
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> saveNewMetric(
      MetricModel metricModel) async {
    var requestUrl = baseUrl + 'api/metric/add/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'weight': metricModel.weight.toString(),
          'dateTime': metricModel.dateTime.toIso8601String(),
        }));
  }
}