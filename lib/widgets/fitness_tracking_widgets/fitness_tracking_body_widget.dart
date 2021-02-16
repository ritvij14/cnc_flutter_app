import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/widgets/fitness_tracking_widgets/fitness_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';

import 'fitness_tracking_popup_input_activity_widget.dart';
import 'fitness_tracking_popup_modify_activity_widget.dart';


class FitnessTrackingBody extends StatefulWidget {

  List<FitnessActivity> fitnessActivityList;

  FitnessTrackingBody(List<FitnessActivity> fitnessActivityList){
    //to-do swap to db connection
    this.fitnessActivityList = fitnessActivityList;
  }

  @override
  _FitnessTrackingBodyState createState() => _FitnessTrackingBodyState();
}

class _FitnessTrackingBodyState extends State<FitnessTrackingBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: buildFitnessTrackingListTileWidgets(widget.fitnessActivityList),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FitnessTrackingPopupInputActivity(FitnessActivity.emptyConstructor());
            }
          ).then((val){
            setState(() {
              widget.fitnessActivityList.insert(0, val);
            });
          });
        },
      ),
    );
  }

  List<FitnessTrackingListTile> buildFitnessTrackingListTileWidgets(List<FitnessActivity> fitnessActivityModelList) {
    List<FitnessTrackingListTile> fitnessTrackingListTileList = [];
    for (FitnessActivity fitnessActivity in widget.fitnessActivityList){
      FitnessTrackingListTile fitnessTrackingListTile = new FitnessTrackingListTile(fitnessActivity);
      fitnessTrackingListTileList.add(fitnessTrackingListTile);
    }
    return fitnessTrackingListTileList;
  }
}
