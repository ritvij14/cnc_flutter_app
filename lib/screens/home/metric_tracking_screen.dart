import 'dart:convert';

import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/widgets/metric_tracking_widgets/metric_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MetricTrackingScreen extends StatefulWidget {
  final List<MetricModel> metricModelList = [];

  @override
  _MetricTrackingScreenState createState() => _MetricTrackingScreenState();
}

class _MetricTrackingScreenState extends State<MetricTrackingScreen> {
  var db = new MetricDBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Weight Tracking'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, '/inputMetric')
                        .then((value) => refresh());
                  },
                )
              ],
            ),
            body: StickyGroupedListView<MetricModel, DateTime>(
                floatingHeader: true,
                itemScrollController: GroupedItemScrollController(),
                scrollDirection: Axis.vertical,
                elements: widget.metricModelList,
                order: StickyGroupedListOrder.ASC,
                groupBy: (MetricModel element) => DateTime(
                    element.dateTime.year,
                    element.dateTime.month,
                    element.dateTime.day),
                groupComparator: (DateTime value1, DateTime value2) =>
                    value2.compareTo(value1),
                itemComparator: (MetricModel element1, MetricModel element2) =>
                    element1.dateTime.compareTo(element2.dateTime),
                // floatingHeader: true,
                groupSeparatorBuilder: (MetricModel element) => Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue[300]!,
                            border: Border.all(
                              color: Colors.blue[300]!,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${element.dateTime.month}/${element.dateTime.day}/${element.dateTime.year}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                itemBuilder: (_, MetricModel element) {
                  return Container(
                    child: MetricTrackingListTile(element),
                  );
                }));
      },
      future: getMetrics(),
    );
  }

  Future<void> refresh() async {
    await getMetrics();
    setState(() {});
  }

  getMetrics() async {
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id')!;
    var response = await db.getMetrics(int.parse(id));
    List<MetricModel> newMetricModelList = (json.decode(response.body) as List)
        .map((data) => MetricModel.fromJson(data))
        .toList();
    widget.metricModelList.addAll(newMetricModelList);
  }
}
