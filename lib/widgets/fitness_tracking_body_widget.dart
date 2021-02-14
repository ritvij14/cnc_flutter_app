import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:cnc_flutter_app/widgets/fitness_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';


class FitnessTrackingBody extends StatelessWidget {

  List<FitnessActivity> fitnessActivityList;

  FitnessTrackingBody(List<FitnessActivity> fitnessActivityList){
    //to-do swap to db connection
    this.fitnessActivityList = fitnessActivityList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: buildFitnessTrackingListTileWidgets(fitnessActivityList),
      ),
    );
  }

  List<FitnessTrackingListTile> buildFitnessTrackingListTileWidgets(List<FitnessActivity> fitnessActivityModelList) {
    List<FitnessTrackingListTile> fitnessTrackingListTileList = [];
    for (FitnessActivity fitnessActivity in fitnessActivityList){
      FitnessTrackingListTile fitnessTrackingListTile = new FitnessTrackingListTile(fitnessActivity);
      fitnessTrackingListTileList.add(fitnessTrackingListTile);
    }
    return fitnessTrackingListTileList;
  }
}
