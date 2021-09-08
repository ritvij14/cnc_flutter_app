import 'dart:convert';

import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../alerts.dart';

class ActivityTrackingModifyActivity extends StatefulWidget {
  final ActivityModel activityModel;

  ActivityTrackingModifyActivity(this.activityModel);

  @override
  _ActivityTrackingModifyActivityState createState() =>
      _ActivityTrackingModifyActivityState(activityModel);
}

class _ActivityTrackingModifyActivityState
    extends State<ActivityTrackingModifyActivity> {
  late int initialMinutes;
  late DateTime initialDate;
  bool minutesEntered = false;
  final db = ActivityDBHelper();
  final _formKey = GlobalKey<FormState>();
  // List<String> activitiesList = getActivityStringList();
  List<String> activitiesList = [];

  TextEditingController dateCtl = TextEditingController();
  List<ActivityModel> activityOptions = [];

  _ActivityTrackingModifyActivityState(ActivityModel activityModel) {
    initialMinutes = activityModel.minutes;
    initialDate = activityModel.dateTime;
  }

  getActivityOptions() async {
    //only do if list is empty?
    // activityOptions.clear();
    if (activityOptions.isEmpty) {
      var response = await db.getActivityOptions();
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (data[i]['isVisible']) {
          ActivityModel temp = ActivityModel.activityOptions(
              data[i]['type'], data[i]['intensity']);
          activityOptions.add(temp);
          activitiesList.add(data[i]['type']);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dateCtl = TextEditingController(
        text: DateFormat('MM/dd/yyyy').format(widget.activityModel.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Activity'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (initialMinutes != widget.activityModel.minutes) {
              Alerts().showAlert(context, true);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text('New Fitness Activity'),
                  //   ],
                  // ),
                  // Divider(
                  //   thickness: 2,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Activity'),
                      // Container(
                      // ),
                      Container(
                        width: 200,
                        child: Text(widget.activityModel.type),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text('Activity'),
                  //     // Container(
                  //     // ),
                  //     Container(
                  //       width: 200,
                  //       child: DropdownButtonFormField<String>(
                  //         isExpanded: true,
                  //         // value: widget.fitnessActivity,
                  //         // value: widget.activityModel.type,
                  //         hint: Text('select'),
                  //         onChanged: (value) =>
                  //             setState(() {
                  //               widget.activityModel.type = value;
                  //               int index = fitnessActivityMasterList.indexWhere((element) => element.type == value);
                  //               widget.activityModel.intensity = fitnessActivityMasterList[index].intensity;
                  //             }
                  //             ),
                  //         validator: (value) =>
                  //         value == null ? 'Activity required' : null,
                  //         items: activitiesList.map<DropdownMenuItem<String>>((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(value),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text('Intensity'),
                  //     Container(
                  //       width: 125,
                  //       child: DropdownButtonFormField<int>(
                  //         value: widget.fitnessActivity.intensity,
                  //         hint: Text('select'),
                  //         onChanged: (type) =>
                  //             setState(() => widget.fitnessActivity.intensity = type),
                  //         validator: (value) =>
                  //             value == null ? 'Intensity required' : null,
                  //         items:
                  //             [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                  //           return DropdownMenuItem<int>(
                  //             value: value,
                  //             child: Text(value.toString()),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Intensity'),
                      Container(
                        width: 200,
                        child: Text(widget.activityModel.intensity == null
                            ? ''
                            : widget.activityModel.intensity == 1
                                ? 'Light'
                                : widget.activityModel.intensity == 2
                                    ? 'Moderate'
                                    : 'Vigorous'),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Minutes'),
                      Container(
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Minutes required';
                            }
                            return null;
                          },
                          initialValue: widget.activityModel.minutes.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            hintText: "enter",
                          ),
                          onChanged: (text) {
                            if (text.isNotEmpty) {
                              widget.activityModel.minutes = int.parse(text);
                              minutesEntered = true;
                            } else {
                              minutesEntered = false;
                            }
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Date'),
                      Container(
                        width: 200,
                        child: Text(DateFormat('MM/dd/yyyy')
                            .format(widget.activityModel.dateTime)),

                        // TextFormField(
                        //   enableInteractiveSelection: false,
                        //   controller: dateCtl,
                        //   // decoration: InputDecoration(hintText: 'select'),
                        //   // initialValue: '',
                        //   onTap: () async {
                        //     DateTime date = widget.activityModel.dateTime;
                        //     DateTime now = DateTime.now();
                        //     FocusScope.of(context).requestFocus(new FocusNode());
                        //     date = await showDatePicker(
                        //         context: context,
                        //         initialDate: widget.activityModel.dateTime,
                        //         firstDate: DateTime(now.year, now.month, now.day -1),
                        //         lastDate: DateTime.now());
                        //     // dateCtl.text = date.toIso8601String();
                        //     dateCtl.text = DateFormat('MM/dd/yyyy').format(date);
                        //     // dateCtl.text = date.toString();
                        //     widget.activityModel.dateTime = date;
                        //     dateSelected = true;
                        //     if(initialDate!=date) {
                        //       wasChanged = true;
                        //     }
                        //   },
                        //   // onChanged: (text){
                        //   //   // widget.fitnessActivity.dateTime = DateTime.parse(text);
                        //   // },
                        // ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          // padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('CANCEL',
                              style: TextStyle(color: Colors.grey)),
                          onPressed: () {
                            if (initialMinutes !=
                                widget.activityModel.minutes) {
                              Alerts().showAlert(context, true);
                              // showAlertDialog(context);
                            } else {
                              Navigator.pop(context, null);
                            }
                          },
                        ),
                        if (minutesEntered &&
                            initialMinutes != widget.activityModel.minutes) ...[
                          FlatButton(
                            color: Theme.of(context).buttonColor,
                            // padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var x = db.updateExistingActivity(
                                    widget.activityModel);

                                Navigator.pop(context, widget.activityModel);
                              }
                              // updateEntry();
                              // Navigator.pop(context, null);
                            },
                          ),
                        ],
                        if (initialMinutes == widget.activityModel.minutes ||
                            !minutesEntered) ...[
                          FlatButton(
                              color: Colors.grey,
                              // padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              onPressed: () => {}),
                        ],
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: RaisedButton(
                    //         child: Text('Cancel'),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: RaisedButton(
                    //         child: Text('Update'),
                    //         onPressed: () {
                    //           if (_formKey.currentState.validate()) {
                    //             var x = db.updateExistingActivity(widget.activityModel);
                    //             print(widget.activityModel.id);
                    //             print(widget.activityModel.intensity);
                    //             print(widget.activityModel.dateTime);
                    //             print(widget.activityModel.minutes);
                    //             print(widget.activityModel.type);
                    //             print(widget.activityModel.mets);
                    //             print(widget.activityModel.metsPerHour);
                    //
                    //             Navigator.pop(context, widget.activityModel);
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),
          );
        },
        future: getActivityOptions(),
      ),
    );
  }

  ActivityModel getExistingActivity() {
    return widget.activityModel;
  }

  static List<String> getActivityStringList() {
    List<String> output = [];
    fitnessActivityMasterList.forEach((element) {
      output.add(element.type);
    });
    return output;
  }
}
