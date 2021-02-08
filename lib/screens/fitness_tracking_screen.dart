import 'package:flutter/material.dart';


class FitnessTrackingScreen extends StatefulWidget {
  @override
  _FitnessTrackingScreenState createState() => _FitnessTrackingScreenState();
}

class _FitnessTrackingScreenState extends State<FitnessTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
      ),
      body: Text('Physical Activity Tracker'),
    );
  }
}

