import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';

import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';

import 'fitness_tracking_list_tile_widget.dart';
import 'fitness_tracking_popup_input_activity_widget.dart';
import 'fitness_tracking_popup_modify_activity_widget.dart';

class FitnessTrackingBody extends StatefulWidget {
  List<FitnessActivityModel> fitnessActivityList = [];

  FitnessTrackingBody(List<FitnessActivityModel> fitnessActivityList) {
    this.fitnessActivityList = fitnessActivityList;
  }

  @override
  _FitnessTrackingBodyState createState() => _FitnessTrackingBodyState();
}

class _FitnessTrackingBodyState extends State<FitnessTrackingBody> {
  var db = new FitnessActivityDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: widget.fitnessActivityList.length,
            itemBuilder: (context, index) {
              return FitnessTrackingListTile(widget.fitnessActivityList[index]);
            },
          );
        },
        future: getActivities(),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FitnessTrackingPopupInputActivity(
                    FitnessActivityModel.emptyConstructor());
              }).then((val) => update());
        },
      ),
    );

  }

  List<FitnessTrackingListTile> buildFitnessTrackingListTileWidgets(
      List<FitnessActivityModel> fitnessActivityModelList) {
    List<FitnessTrackingListTile> fitnessTrackingListTileList = [];
    for (FitnessActivityModel fitnessActivity in widget.fitnessActivityList) {
      FitnessTrackingListTile fitnessTrackingListTile =
          new FitnessTrackingListTile(fitnessActivity);
      fitnessTrackingListTileList.add(fitnessTrackingListTile);
    }
    return fitnessTrackingListTileList;
  }

  getActivities() async {
    widget.fitnessActivityList.clear();
    var response = await db.getActivities();
    List<FitnessActivityModel> fa = (json.decode(response.body) as List)
        .map((data) => FitnessActivityModel.fromJson(data))
        .toList();
    widget.fitnessActivityList = fa;
  }

  void update() {
    setState(() {
    });
  }

}
