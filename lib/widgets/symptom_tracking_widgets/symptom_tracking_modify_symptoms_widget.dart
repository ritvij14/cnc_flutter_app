import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class SymptomTrackingModifyScreen extends StatefulWidget {

  SymptomModel symptomModel;

  SymptomTrackingModifyScreen(SymptomModel symptomModel){
    this.symptomModel = symptomModel;
  }

  @override
  _SymptomTrackingModifyScreenState createState() => _SymptomTrackingModifyScreenState();
}

class _SymptomTrackingModifyScreenState extends State<SymptomTrackingModifyScreen> {
  final db = SymptomDBHelper();
  TextEditingController dateCtl = TextEditingController(text: DateFormat('MM/dd/yyyy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Symptoms'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Date',
                style: TextStyle(
                    fontSize: 16
                ),),
              Container(
                width: 200,
                child: TextFormField(
                  enableInteractiveSelection: false,
                  controller: dateCtl,
                  // initialValue: widget.symptomModel.dateTime.month.toString() + '/' + widget.symptomModel.dateTime.day.toString() + '/' + widget.symptomModel.dateTime.year.toString(),
                  onTap: () async {
                    DateTime date = widget.symptomModel.dateTime;
                    DateTime now = DateTime.now();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                      context: context,
                      initialDate: widget.symptomModel.dateTime,
                      firstDate: DateTime(now.year, now.month, now.day -1),
                      lastDate: DateTime.now(),
                    );
                    dateCtl.text = DateFormat('MM/dd/yyyy').format(date);
                    widget.symptomModel.dateTime = date;
                  },

                ),
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
            child: TextField(
                maxLength: 256,
                maxLengthEnforced: true,
                onChanged: (value){
                  widget.symptomModel.other = value;
                }
                ,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type any other symptoms here.'
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Update'),
                    onPressed: () {
                      db.updateExistingSymptom(widget.symptomModel);
                      Navigator.pop(context, widget.symptomModel);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
