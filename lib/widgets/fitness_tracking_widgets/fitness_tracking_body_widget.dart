import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';

import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:cnc_flutter_app/widgets/fitness_tracking_widgets/fitness_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';

import 'fitness_tracking_popup_input_activity_widget.dart';
import 'fitness_tracking_popup_modify_activity_widget.dart';

class FitnessTrackingBody extends StatefulWidget {
  List<FitnessActivityModel> fitnessActivityList = [];

  FitnessTrackingBody(List<FitnessActivityModel> fitnessActivityList) {

    //to-do swap to db connection
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
              }).then((val) {
            setState(() {
              // addActivity(val);
              // if (val != null) widget.fitnessActivityList.insert(0, val);
              // print(widget.fitnessActivityList.length);

            });
          });
        },
      ),
    );

    // return Scaffold(
    // body: ListView(
    //   children: buildFitnessTrackingListTileWidgets(widget.fitnessActivityList),
    // ),
    // floatingActionButton: FloatingActionButton(
    //   backgroundColor: Theme.of(context).accentColor,
    //   child: Icon(Icons.add),
    //   onPressed: (){
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return FitnessTrackingPopupInputActivity(FitnessActivity.emptyConstructor());
    //       }
    //     ).then((val){
    //       setState(() {
    //         if(val != null)
    //         widget.fitnessActivityList.insert(0, val);
    //       });
    //     });
    //   },
    // ),
    // );
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

  // getActivities() async {
  //   var response = await db.getActivities();
  //   var data = json.decode(response.body);
  //   for (int i = 0; i < data.length; i++){
  //     FitnessActivity fitnessActivity = new FitnessActivity(
  //       data[i]['type'],
  //       data[i]['intensity'],
  //       data[i]['minutes']);
  //     widget.fitnessActivityList.add(fitnessActivity);
  //   }
  //   widget.fitnessActivityList.add(FitnessActivity('running', 100, 3));
  // }
  getActivities() async {
    var response = await db.getActivities();
    // var fitnessActivityJson = jsonDecode(response)
    // Iterable l = json.decode(response.body);
    // print(json.decode(response.body));

    List<FitnessActivityModel> fa = (json.decode(response.body) as List)
        .map((data) => FitnessActivityModel.fromJson(data))
        .toList();
    widget.fitnessActivityList = fa;
    // setState(() {
    //
    // });
  }

}
