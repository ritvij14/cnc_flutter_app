import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../alerts.dart';

class SymptomTrackingModifyScreen extends StatefulWidget {
  final SymptomModel symptomModel;

  SymptomTrackingModifyScreen(this.symptomModel);

  @override
  _SymptomTrackingModifyScreenState createState() =>
      _SymptomTrackingModifyScreenState(symptomModel);
}

class _SymptomTrackingModifyScreenState
    extends State<SymptomTrackingModifyScreen> {
  final db = SymptomDBHelper();
  late bool initialAbdominal;
  late bool initialAppetite;
  late bool initialBloating;
  late bool initialConstipation;
  late bool initialDiarrhea;
  late bool initialNausea;
  late bool initialStoma;
  late bool initialVomiting;
  late String initialOther;
  TextEditingController dateCtl = TextEditingController(
      text: DateFormat('MM/dd/yyyy').format(DateTime.now()));

  _SymptomTrackingModifyScreenState(SymptomModel symptomModel) {
    initialAbdominal = symptomModel.abdominalPain;
    initialAppetite = symptomModel.appetiteLoss;
    initialBloating = symptomModel.bloating;
    initialConstipation = symptomModel.constipation;
    initialDiarrhea = symptomModel.diarrhea;
    initialNausea = symptomModel.nausea;
    initialStoma = symptomModel.stomaProblems;
    initialVomiting = symptomModel.vomiting;
    initialOther = symptomModel.other;
  }

  bool wasChanged() {
    return initialAbdominal != widget.symptomModel.abdominalPain ||
        initialAppetite != widget.symptomModel.appetiteLoss ||
        initialBloating != widget.symptomModel.bloating ||
        initialConstipation != widget.symptomModel.constipation ||
        initialDiarrhea != widget.symptomModel.diarrhea ||
        initialNausea != widget.symptomModel.nausea ||
        initialStoma != widget.symptomModel.stomaProblems ||
        initialVomiting != widget.symptomModel.vomiting ||
        initialOther != widget.symptomModel.other;
  }

  // var otherController = TextEditingController(text: widget.symptomModel.other);

  @override
  Widget build(BuildContext context) {
    dateCtl = TextEditingController(
        text: DateFormat('MM/dd/yyyy').format(widget.symptomModel.dateTime));
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Symptoms'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (wasChanged()) {
              Alerts().showAlert(context, true);
              // showAlertDialog(context);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Date',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                  width: 200,
                  child: Text(DateFormat('MM/dd/yyyy')
                      .format(widget.symptomModel.dateTime))
                  // child: TextFormField(
                  //   enableInteractiveSelection: false,
                  //   controller: dateCtl,
                  //   // initialValue: widget.symptomModel.dateTime.month.toString() + '/' + widget.symptomModel.dateTime.day.toString() + '/' + widget.symptomModel.dateTime.year.toString(),
                  //   onTap: () async {
                  //     DateTime date = widget.symptomModel.dateTime;
                  //     DateTime now = DateTime.now();
                  //     FocusScope.of(context).requestFocus(new FocusNode());
                  //     date = await showDatePicker(
                  //       context: context,
                  //       initialDate: widget.symptomModel.dateTime,
                  //       firstDate: DateTime(now.year, now.month, now.day -1),
                  //       lastDate: DateTime.now(),
                  //     );
                  //     dateCtl.text = DateFormat('MM/dd/yyyy').format(date);
                  //     widget.symptomModel.dateTime = date;
                  //   },
                  //
                  // ),
                  ),
            ],
          ),
          SwitchListTile(
            title: Text('Abdominal Pain'),
            value: widget.symptomModel.abdominalPain,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.abdominalPain = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Appetite Loss'),
            value: widget.symptomModel.appetiteLoss,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.appetiteLoss = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Bloating'),
            value: widget.symptomModel.bloating,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.bloating = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Constipation'),
            value: widget.symptomModel.constipation,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.constipation = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Diarrhea'),
            value: widget.symptomModel.diarrhea,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.diarrhea = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Nausea'),
            value: widget.symptomModel.nausea,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.nausea = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Stoma Problems'),
            value: widget.symptomModel.stomaProblems,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.stomaProblems = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Vomiting'),
            value: widget.symptomModel.vomiting,
            onChanged: (bool value) {
              setState(() {
                widget.symptomModel.vomiting = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                initialValue: widget.symptomModel.other,
                maxLength: 256,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onChanged: (value) {
                  widget.symptomModel.other = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type any other symptoms here.')),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      if (wasChanged()) {
                        Alerts().showAlert(context, true);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                if (wasChanged()) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        db.updateExistingSymptom(widget.symptomModel);
                        Navigator.pop(context, widget.symptomModel);
                      },
                    ),
                  ),
                ],
                if (!wasChanged()) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {},
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getOtherText() {
    return widget.symptomModel.other;
  }
}
