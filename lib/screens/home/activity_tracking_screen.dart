import 'dart:convert';

import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_input_activity_widget.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class ActivityTrackingScreen extends StatefulWidget {
  List<ActivityModel> activityModelList = [];

  @override
  _ActivityTrackingScreenState createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  var db = new ActivityDBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Activity Tracking'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                ActivityTrackingInputScreen()));
                    refresh();
                  },
                )
              ],
            ),
            body: StickyGroupedListView<ActivityModel, DateTime>(
                floatingHeader: true,
                itemScrollController: GroupedItemScrollController(),
                scrollDirection: Axis.vertical,
                elements: widget.activityModelList,
                order: StickyGroupedListOrder.ASC,
                groupBy: (ActivityModel element) => DateTime(
                    element.dateTime.year,
                    element.dateTime.month,
                    element.dateTime.day),
                groupComparator: (DateTime value1, DateTime value2) =>
                    value2.compareTo(value1),
                itemComparator:
                    (ActivityModel element1, ActivityModel element2) =>
                        element1.dateTime.compareTo(element2.dateTime),
                // floatingHeader: true,
                groupSeparatorBuilder: (ActivityModel element) => Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            border: Border.all(
                              color: Colors.blue[300],
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
                itemBuilder: (_, ActivityModel element) {
                  return Container(
                    child: ActivityTrackingListTile(element),
                  );
                }));
      },
      future: getActivities(),
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
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getActivities(int.parse(id));
    List<ActivityModel> fa = (json.decode(response.body) as List)
        .map((data) => ActivityModel.fromJson(data))
        .toList();
    widget.activityModelList = fa;
  }

  void refresh() {
    setState(() {});
  }
}
