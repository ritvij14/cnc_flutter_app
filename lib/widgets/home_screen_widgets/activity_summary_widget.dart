import 'package:flutter/material.dart';

class ActivitySummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      height: 150.0,
      child: InkWell(
        child: Text('Placeholder for Activity Summary.'),
        onTap: () {
          Navigator.pushNamed(context, '/fitnessTracking');
        },
      ),
    );
  }
}
