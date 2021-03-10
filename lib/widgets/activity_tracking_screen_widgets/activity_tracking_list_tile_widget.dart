import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'activity_tracking_popup_modify_activity_widget.dart';

class ActivityTrackingListTile extends StatefulWidget {
  ActivityModel activityModel;

  ActivityTrackingListTile(ActivityModel activityModel) {
    this.activityModel = activityModel;
  }

  @override
  _ActivityTrackingListTileState createState() =>
      _ActivityTrackingListTileState();
}

class _ActivityTrackingListTileState extends State<ActivityTrackingListTile> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      leading: Icon(getActivityIcon()),
      title: Text(widget.activityModel.type),
      subtitle: Text(widget.activityModel.minutes.toString() +
          ' minutes' +
          ' at intensity level ' +
          widget.activityModel.intensity.toString() +
          '\n' +
          DateFormat('MM/dd/yyyy').format(widget.activityModel.dateTime)),
      trailing: Text(widget.activityModel.getCalories().toString() + ' mets'),
      onTap: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:
                    FitnessTrackingPopupModifyActivity(widget.activityModel),
              );
            }).then((val) {
          refresh();
        });
      },
    );
  }

  IconData getActivityIcon() {
    if (widget.activityModel.type == 'Running' ||
        widget.activityModel.type == 'Jogging') {
      return Icons.directions_run;
    }
    if (widget.activityModel.type == 'Swimming') {
      return Icons.pool;
    }
    if (widget.activityModel.type == 'Cycling') {
      return Icons.directions_bike;
    }
    if (widget.activityModel.type == 'Hiking' ||
        widget.activityModel.type == 'Walking') {
      return Icons.directions_walk;
    }
  }
}
