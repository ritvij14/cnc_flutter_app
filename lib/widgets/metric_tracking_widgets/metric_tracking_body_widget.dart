import 'dart:convert';

import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/widgets/metric_tracking_widgets/metric_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetricTrackingBody extends StatefulWidget {
  @override
  _MetricTrackingBodyState createState() => _MetricTrackingBodyState();
}

class _MetricTrackingBodyState extends State<MetricTrackingBody> {
  List<MetricModel> metricModelList = [];

  var db = new MetricDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: metricModelList.length,
            itemBuilder: (context, index) {
              return MetricTrackingListTile(metricModelList[index]);
            },
          );
        },
        future: getMetrics(),
      ),
    );
  }

  getMetrics() async {
    metricModelList.clear();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getMetrics(int.parse(id));
    List<MetricModel> newMetricModelList =
        (json.decode(response.body) as List)
            .map((data) => MetricModel.fromJson(data))
            .toList();
    metricModelList = newMetricModelList;
  }
}
