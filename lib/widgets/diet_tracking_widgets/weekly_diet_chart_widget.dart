import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WeeklyDietChart extends StatefulWidget {
  @override
  _WeeklyDietChartState createState() => _WeeklyDietChartState();
}

class _WeeklyDietChartState extends State<WeeklyDietChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 10.0,
          percent: 0.8,
          header: Text("Icon header"),
          center: Icon(
            Icons.person_pin,
            size: 50.0,
            color: Colors.blue,
          ),
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
        ),
        CircularPercentIndicator(
          radius: 130.0,
          animation: true,
          animationDuration: 1200,
          lineWidth: 15.0,
          percent: 0.4,
          center: Text(
            "40 hours",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.yellow,
          progressColor: Colors.red,
        ),
      ],
    );

  }
}
