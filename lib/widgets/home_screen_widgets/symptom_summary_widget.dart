import 'package:flutter/material.dart';

class SymptomSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      height: 150.0,
      child: InkWell(
        child: Text('Placeholder for Symptom Summary.'),
        onTap: () {
          Navigator.pushNamed(context, '/symptomTracking');
        },
      ),
    );
  }
}
