import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_body_widget.dart';
import 'package:flutter/material.dart';

class SymptomTrackingScreen extends StatefulWidget {
  @override
  _SymptomTrackingScreenState createState() => _SymptomTrackingScreenState();
}

class _SymptomTrackingScreenState extends State<SymptomTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Tracker'),
      ),
      body: SymptomTrackingBody(),
    );
  }
}
