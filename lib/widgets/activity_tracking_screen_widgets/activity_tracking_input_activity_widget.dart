import 'dart:convert';

import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../alerts.dart';

class ActivityTrackingInputScreen extends StatefulWidget {
  final ActivityModel fitnessActivity = ActivityModel.emptyConstructor();

  @override
  _ActivityTrackingInputScreenState createState() =>
      _ActivityTrackingInputScreenState();
}

class _ActivityTrackingInputScreenState
    extends State<ActivityTrackingInputScreen> {
  final db = ActivityDBHelper();
  final _formKey = GlobalKey<FormState>();
  bool activitySelected = false;
  bool minutesEntered = false;
  bool dateSelected = false;
  TextEditingController dateCtl = TextEditingController();
  List<ActivityModel> activityOptions = [];

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
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Activity'),
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Alerts().showAlert(context, false);
            },
          ),
        ),
        body: FutureBuilder(
            future: getActivityOptions(),
            builder: (context, projectSnap) {
              return Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Activity'),
                            Container(
                              width: 200,
                              child: DropdownButtonFormField<ActivityModel>(
                                isExpanded: true,
                                hint: Text('select'),
                                onChanged: (value) => setState(() {
                                  if (value == null) return null;
                                  widget.fitnessActivity.type = value.type;
                                  widget.fitnessActivity.intensity =
                                      value.intensity;
                                  activitySelected = true;
                                }),
                                validator: (value) {
                                  if (widget.fitnessActivity.type == null) {
                                    return 'Activity required';
                                  }
                                  return null;
                                },
                                items: activityOptions
                                    .map<DropdownMenuItem<ActivityModel>>(
                                        (ActivityModel value) {
                                  return DropdownMenuItem<ActivityModel>(
                                    value: value,
                                    child: Text(value.type,
                                        overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Intensity'),
                            Container(
                              width: 200,
                              child: Text(widget.fitnessActivity.intensity ==
                                      null
                                  ? 'Select Activity to view intensity'
                                  : widget.fitnessActivity.intensity == 1
                                      ? 'Light'
                                      : widget.fitnessActivity.intensity == 2
                                          ? 'Moderate'
                                          : 'Vigorous'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
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
                                initialValue: '',
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  hintText: "enter",
                                ),
                                onChanged: (text) {
                                  if (text.isNotEmpty) {
                                    widget.fitnessActivity.minutes =
                                        int.parse(text);
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Date'),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: dateCtl,
                                decoration: InputDecoration(hintText: 'select'),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date required';
                                  }
                                  return null;
                                },
                                // initialValue: '',
                                onTap: () async {
                                  DateTime? date = DateTime.now();
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  date = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          widget.fitnessActivity.dateTime,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now());
                                  if (date == null) return null;
                                  // dateCtl.text = date.toIso8601String();
                                  dateCtl.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  // dateCtl.text = date.toString();
                                  widget.fitnessActivity.dateTime = date;
                                  dateSelected = true;
                                },
                                // onChanged: (text){
                                //   // widget.fitnessActivity.dateTime = DateTime.parse(text);
                                // },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            child: Text('CANCEL',
                                style: TextStyle(color: Colors.grey)),
                            onPressed: () async {
                              Alerts().showAlert(context, false);
                              // showAlert().then(
                              //     Navigator.pop(context, "Cancelled Weight Input")
                              // );
                            },
                          ),
                          if (activitySelected &&
                              minutesEntered &&
                              dateSelected) ...[
                            FlatButton(
                              color: Theme.of(context).buttonColor,
                              child: Text(
                                'SAVE ENTRY',
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {});
                                  var sharedPref =
                                      await SharedPreferences.getInstance();
                                  String id = sharedPref.getString('id')!;
                                  widget.fitnessActivity.userId = int.parse(id);
                                  var x = await db
                                      .saveNewActivity(widget.fitnessActivity);
                                  Navigator.pop(context, 'Saved Activity');
                                }
                              },
                            ),
                          ],
                          if (!activitySelected ||
                              !minutesEntered ||
                              !dateSelected) ...[
                            FlatButton(
                              color: Colors.grey,
                              child: Text(
                                'SAVE ENTRY',
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ],
                      ),
                      // Expanded(
                      //   child: Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(15.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: TextButton(
                      //               child: Text('CANCEL'),
                      //               onPressed: () {
                      //                 Alerts().showAlert(context, false);
                      //
                      //                 // Navigator.pop(context, 'Cancelled Activity Input');
                      //               },
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: FlatButton(
                      //               color: Colors.blue,
                      //               child: Text('SAVE ENTRY'),
                      //               onPressed: () async {
                      //                 if (_formKey.currentState.validate()) {
                      //                   var sharedPref =
                      //                       await SharedPreferences.getInstance();
                      //                   String id = sharedPref.getString('id');
                      //                   widget.fitnessActivity.userId = int.parse(id);
                      //                   var x = await db
                      //                       .saveNewActivity(widget.fitnessActivity);
                      //                   Navigator.pop(context, 'Saved Activity');
                      //                 }
                      //               },
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }));
  }
}
