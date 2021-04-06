import 'dart:convert';

import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/widgets/metric_tracking_widgets/metric_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetricTrackingScreen extends StatefulWidget {
  @override
  _MetricTrackingScreenState createState() => _MetricTrackingScreenState();
}

class _MetricTrackingScreenState extends State<MetricTrackingScreen> {

  List<MetricModel> metricModelList = [];
  var db = new MetricDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracking'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/inputMetric').then((value) => refresh());
              ;
            },
          )
        ],
      ),
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

  Future<void> refresh() async {
    await getMetrics();
    setState(() {});
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
