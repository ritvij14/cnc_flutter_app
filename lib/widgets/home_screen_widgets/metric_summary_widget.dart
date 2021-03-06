import 'package:flutter/material.dart';

class MetricSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      height: 150.0,
      child: InkWell(
        child: Text('Placeholder for Metric Summary.'),
        onTap: () {
          Navigator.pushNamed(context, '/metricTracking');
        },
      ),
    );
  }
}