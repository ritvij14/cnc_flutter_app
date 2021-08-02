import 'dart:convert';
import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_tracking_list_tile_widget.dart';

class ActivityTrackingBody extends StatefulWidget {
  late final List<ActivityModel> activityModelList = [];

  @override
  _ActivityTrackingBodyState createState() => _ActivityTrackingBodyState();
}

class _ActivityTrackingBodyState extends State<ActivityTrackingBody> {
  var db = new ActivityDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  // List<ActivityTrackingListTile> buildFitnessTrackingListTileWidgets(
  //     List<ActivityModel> fitnessActivityModelList) {
  //   List<ActivityTrackingListTile> fitnessTrackingListTileList = [];
  //   for (ActivityModel fitnessActivity in widget.activityModelList) {
  //     ActivityTrackingListTile fitnessTrackingListTile =
  //         new ActivityTrackingListTile(fitnessActivity);
  //     fitnessTrackingListTileList.add(fitnessTrackingListTile);
  //   }
  //   return fitnessTrackingListTileList;
  // }

  getActivities() async {
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id')!;
    widget.activityModelList.clear();
    var response = await db.getActivities(int.parse(id));
    List<ActivityModel> fa = (json.decode(response.body) as List)
        .map((data) => ActivityModel.fromJson(data))
        .toList();
    widget.activityModelList.addAll(fa);
  }

  void update() {
    setState(() {});
  }
}
