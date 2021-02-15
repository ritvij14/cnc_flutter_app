import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';

import 'fitness_tracking_popup_modify_activity_widget.dart';

class FitnessTrackingListTile extends StatefulWidget {
  FitnessActivity fitnessActivity;

  FitnessTrackingListTile(FitnessActivity fitnessActivity) {
    this.fitnessActivity = fitnessActivity;
  }

  @override
  _FitnessTrackingListTileState createState() =>
      _FitnessTrackingListTileState();

}


class _FitnessTrackingListTileState extends State<FitnessTrackingListTile> {

  refresh(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(getActivityIcon()),
      title: Text(widget.fitnessActivity.type),
      subtitle: Text(widget.fitnessActivity.minutes.toString() + ' minutes' + ' at intensity level ' + widget.fitnessActivity.intensity.toString()),
      trailing: Text(widget.fitnessActivity.getCalories().toString() + 'cal'),
      onTap: () async {
        print(widget.fitnessActivity.intensity);
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: FitnessTrackingPopupModifyActivity(widget.fitnessActivity),
              );
            }).then((val){
              refresh();
        });
      },
    );
  }

  IconData getActivityIcon() {
    if (widget.fitnessActivity.type == 'running' ||
        widget.fitnessActivity.type == 'jogging') {
      return Icons.directions_run;
    }
    if (widget.fitnessActivity.type == 'swimming') {
      return Icons.pool;
    }
    if (widget.fitnessActivity.type == 'cycling') {
      return Icons.directions_bike;
    }
    if (widget.fitnessActivity.type == 'hiking' ||
        widget.fitnessActivity.type == 'walking') {
      return Icons.directions_walk;
    }
  }
}
