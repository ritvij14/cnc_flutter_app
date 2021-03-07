import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_modify_symptoms_widget.dart';
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

  refresh() {
    setState(() {
      numberOfSymptoms = countSymptoms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // title:Text(numberOfSymptoms.toString() + ' Symptoms'),
      title: Text((numberOfSymptoms == 1)
          ? '1 Symptom'
          : numberOfSymptoms.toString() + ' Symptoms'),
      subtitle: Text(buildSymptomText()),
      trailing:
          Text(DateFormat('MM/dd/yyyy').format(widget.symptomModel.dateTime)),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SymptomTrackingModifyScreen(widget.symptomModel)),

        ).then((value){
          widget.symptomModel = value;
          refresh();
        });
      },
    );
  }

  String buildSymptomText() {
    String symptoms = '';
    if (numberOfSymptoms == 0) {
      return 'No symptoms';
    } else if (numberOfSymptoms == 1) {
      return (widget.symptomModel.abdominalPain == true)
          ? 'Abdominal Pain'
          : (widget.symptomModel.vomiting == true)
              ? 'Vomiting'
              : (widget.symptomModel.stomaProblems == true)
                  ? 'Stoma Problems'
                  : (widget.symptomModel.nausea == true)
                      ? 'Nausea'
                      : (widget.symptomModel.diarrhea == true)
                          ? 'Diarrhea'
                          : (widget.symptomModel.constipation == true)
                              ? 'Constipation'
                              : (widget.symptomModel.bloating == true)
                                  ? 'Bloating'
                                  : (widget.symptomModel.appetiteLoss == true)
                                      ? 'Appetite Loss'
                                      : '';
    } else {
      if (widget.symptomModel.abdominalPain == true) {
        symptoms = symptoms + 'Abdominal Pain, ';
      }
      if (widget.symptomModel.vomiting == true) {
        symptoms = symptoms + 'Vomiting, ';
      }
      if (widget.symptomModel.stomaProblems == true) {
        symptoms = symptoms + 'Stoma Problems, ';
      }
      if (widget.symptomModel.nausea == true) {
        symptoms = symptoms + 'Nausea, ';
      }
      if (widget.symptomModel.diarrhea == true) {
        symptoms = symptoms + 'Diarrhea, ';
      }
      if (widget.symptomModel.constipation == true) {
        symptoms = symptoms + 'Constipation, ';
      }
      if (widget.symptomModel.bloating == true) {
        symptoms = symptoms + 'Bloating, ';
      }
      if (widget.symptomModel.appetiteLoss == true) {
        symptoms = symptoms + 'Appetite Loss, ';
      }
      if (widget.symptomModel.other != '') {
        symptoms = symptoms + 'Other, ';
      }
    }
    symptoms = symptoms.substring(0, symptoms.lastIndexOf(","));
    return symptoms;
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
