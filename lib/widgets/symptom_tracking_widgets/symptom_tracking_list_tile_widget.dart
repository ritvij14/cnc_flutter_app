import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SymptomTrackingListTile extends StatefulWidget {
  SymptomModel symptomModel;

  SymptomTrackingListTile(SymptomModel symptomModel) {
    this.symptomModel = symptomModel;
  }

  @override
  _SymptomTrackingListTileState createState() =>
      _SymptomTrackingListTileState();
}

class _SymptomTrackingListTileState extends State<SymptomTrackingListTile> {
  int numberOfSymptoms = 0;

  @override
  void initState() {
    numberOfSymptoms = countSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        // title:Text(numberOfSymptoms.toString() + ' Symptoms'),
      title: Text((numberOfSymptoms == 1) ? '1 Symptom' : numberOfSymptoms.toString() + ' Symptoms'),
        subtitle: Text('test'),
    trailing: Text(DateFormat('yyyy-MM-dd').format(widget.symptomModel.dateTime)));
  }

  String buildText() {
    return '';
  }

  int countSymptoms() {
    int symptomCount = 0;
    if (widget.symptomModel.abdominalPain == true) {
      symptomCount++;
    }
    if (widget.symptomModel.vomiting == true) {
      symptomCount++;
    }
    if (widget.symptomModel.stomaProblems == true) {
      symptomCount++;
    }
    if (widget.symptomModel.nausea == true) {
      symptomCount++;
    }
    if (widget.symptomModel.diarrhea == true) {
      symptomCount++;
    }
    if (widget.symptomModel.constipation == true) {
      symptomCount++;
    }
    if (widget.symptomModel.bloating == true) {
      symptomCount++;
    }
    if (widget.symptomModel.appetiteLoss == true) {
      symptomCount++;
    }
    return symptomCount;
  }
}
