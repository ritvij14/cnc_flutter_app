import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'fitness_tracking_popup_modify_activity_widget.dart';

class FitnessTrackingListTile extends StatefulWidget {
  FitnessActivityModel fitnessActivity;

  FitnessTrackingListTile(FitnessActivityModel fitnessActivity) {
    this.fitnessActivity = fitnessActivity;
  }

  @override
  _FitnessTrackingListTileState createState() =>
      _FitnessTrackingListTileState();
}

class _FitnessTrackingListTileState extends State<FitnessTrackingListTile> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      leading: Icon(getActivityIcon()),
      title: Text(widget.fitnessActivity.type),
      subtitle: Text(widget.fitnessActivity.minutes.toString() +
          ' minutes' +
          ' at intensity level ' +
          widget.fitnessActivity.intensity.toString() +
          '\n' +
          DateFormat('yyyy-MM-dd').format(widget.fitnessActivity.dateTime)),
      trailing: Text(widget.fitnessActivity.getCalories().toString() + 'cal'),
      onTap: () async {
        print(widget.fitnessActivity.intensity);
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:
                    FitnessTrackingPopupModifyActivity(widget.fitnessActivity),
              );
            }).then((val) {
          refresh();
        });
      },
    );
  }

  IconData getActivityIcon() {
    if (widget.fitnessActivity.type == 'Running' ||
        widget.fitnessActivity.type == 'Jogging') {
      return Icons.directions_run;
    }
    if (widget.fitnessActivity.type == 'Swimming') {
      return Icons.pool;
    }
    if (widget.fitnessActivity.type == 'Cycling') {
      return Icons.directions_bike;
    }
    if (widget.fitnessActivity.type == 'Hiking' ||
        widget.fitnessActivity.type == 'Walking') {
      return Icons.directions_walk;
    }
  }
}
