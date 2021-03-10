import 'package:cnc_flutter_app/widgets/metric_tracking_widgets/metric_tracking_body_widget.dart';
import 'package:flutter/material.dart';

class MetricTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metric Tracker'),
      ),
      body: MetricTrackingBody(),
    );
  }
}
