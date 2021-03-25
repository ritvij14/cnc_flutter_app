import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityTrackingInputScreen extends StatefulWidget {
  ActivityModel fitnessActivity = new ActivityModel.emptyConstructor();

  @override
  _ActivityTrackingInputScreenState createState() =>
      _ActivityTrackingInputScreenState();
}

class _ActivityTrackingInputScreenState
    extends State<ActivityTrackingInputScreen> {
  final db = ActivityDBHelper();
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Activity'),
      ),
      body: Form(
        key: _formKey,
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
                //   width: 125,
                //   child: DropdownButtonFormField<String>(
                //     value: widget.fitnessActivity.type,
                //     hint: Text('select'),
                //     onChanged: (type) =>
                //         setState(() => widget.fitnessActivity.type = type),
                //     validator: (value) =>

                //     items: [
                //       'Running',
                //       'Walking',
                //       'Cycling',
                //       'Jogging',
                //       'Swimming',
                //       'Hiking',
                //     ].map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   ),
                // ),
                Container(
                  width: 200,
                  child: DropdownButtonFormField<ActivityModel>(
                    isExpanded: true,
                    // value: widget.fitnessActivity,
                    // value: fitnessActivityMasterList[0],
                    hint: Text('select'),
                    onChanged: (value) => setState(() {
                      widget.fitnessActivity.type = value.type;
                      widget.fitnessActivity.intensity = value.intensity;
                    }),
                    validator: (value) {
                      if (widget.fitnessActivity.type == null) {
                        return 'Activity required';
                      }
                      return null;
                    },
                    items: fitnessActivityMasterList
                        .map<DropdownMenuItem<ActivityModel>>(
                            (ActivityModel value) {
                      return DropdownMenuItem<ActivityModel>(
                        value: value,
                        child:
                            Text(value.type, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
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
                  child: Text(widget.fitnessActivity.intensity == null
                      ? ''
                      : widget.fitnessActivity.intensity == 1
                          ? 'Light'
                          : widget.fitnessActivity.intensity == 2
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
                      if (value.isEmpty) {
                        return 'Minutes required';
                      }
                      return null;
                    },
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      hintText: "enter",
                    ),
                    onChanged: (text) {
                      widget.fitnessActivity.minutes = int.parse(text);
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
                  child: TextFormField(
                    controller: dateCtl,
                    decoration: InputDecoration(hintText: 'select'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Date required';
                      }
                      return null;
                    },
                    // initialValue: '',
                    onTap: () async {
                      DateTime date = DateTime.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = await showDatePicker(
                          context: context,
                          initialDate: widget.fitnessActivity.dateTime,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now());
                      // dateCtl.text = date.toIso8601String();
                      dateCtl.text = DateFormat('yyyy-MM-dd').format(date);
                      // dateCtl.text = date.toString();
                      widget.fitnessActivity.dateTime = date;
                    },
                    // onChanged: (text){
                    //   // widget.fitnessActivity.dateTime = DateTime.parse(text);
                    // },
                  ),
                )
              ],
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
                      child: Text('Submit'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var sharedPref = await SharedPreferences.getInstance();
                          String id = sharedPref.getString('id');
                          widget.fitnessActivity.userId = int.parse(id);
                          var x = await db.saveNewActivity(widget.fitnessActivity);
                          Navigator.pop(context, 'Saved Activity');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
