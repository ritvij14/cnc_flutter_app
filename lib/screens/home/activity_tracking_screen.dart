import 'dart:convert';

import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_input_activity_widget.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';

class ActivityTrackingScreen extends StatefulWidget {
  List<ActivityModel> activityModelList = [];

  @override
  _ActivityTrackingScreenState createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  var db = new ActivityDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracking'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
               await Navigator.push(context, new MaterialPageRoute(builder:(context) => ActivityTrackingInputScreen()));
               refresh();
            },
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: widget.activityModelList.length,
            itemBuilder: (context, index) {
              return ActivityTrackingListTile(widget.activityModelList[index]);
            },
          );
        },
        future: getActivities(),
      ),
    );
  }

  List<ActivityTrackingListTile> buildFitnessTrackingListTileWidgets(
      List<ActivityModel> fitnessActivityModelList) {
    List<ActivityTrackingListTile> fitnessTrackingListTileList = [];
    for (ActivityModel fitnessActivity in widget.activityModelList) {
      ActivityTrackingListTile fitnessTrackingListTile =
      new ActivityTrackingListTile(fitnessActivity);
      fitnessTrackingListTileList.add(fitnessTrackingListTile);
    }
    return fitnessTrackingListTileList;
  }


  getActivities() async {
    widget.activityModelList.clear();
    var response = await db.getActivities();
    List<ActivityModel> fa = (json.decode(response.body) as List)
        .map((data) => ActivityModel.fromJson(data))
        .toList();
    widget.activityModelList = fa;
  }

  void refresh() {
    setState(() {});
  }
}
