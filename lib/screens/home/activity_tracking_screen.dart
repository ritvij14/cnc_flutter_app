import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_body_widget.dart';
import 'package:flutter/material.dart';

class ActivityTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracking'),
      ),
      body: ActivityTrackingBody(
          fitnessActivityModelList), //ToDo: swap with db connection

    );
  }
}
