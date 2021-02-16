import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FitnessTrackingPopupInputActivity extends StatefulWidget {
  FitnessActivity fitnessActivity;

  FitnessTrackingPopupInputActivity(FitnessActivity fitnessActivity) {
    this.fitnessActivity = fitnessActivity;
  }

  @override
  _FitnessTrackingPopupInputActivityState createState() =>
      _FitnessTrackingPopupInputActivityState();
}

class _FitnessTrackingPopupInputActivityState
    extends State<FitnessTrackingPopupInputActivity> {
  final _formKey = GlobalKey<FormState>();

  // bool _activityCompleted = false;
  // bool _intensityCompleted = false;
  // bool _minutesCompleted = false;
  // bool _formComplete = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Activity'),
                Container(
                  width: 125,
                  child: DropdownButtonFormField<String>(
                    value: widget.fitnessActivity.type,
                    hint: Text('select'),
                    onChanged: (type) =>
                        setState(() => widget.fitnessActivity.type = type),
                    validator: (value) => value == null ? 'Activity required' : null,
                    items: [
                      'running',
                      'walking',
                      'cycling',
                      'jogging',
                      'swimming',
                      'hiking'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Activity'),
            //     DropdownButton<String>(
            //       value: widget.fitnessActivity.type,
            //       icon: Icon(Icons.arrow_downward),
            //       elevation: 16,
            //       hint: Text('Select Activity'),
            //       items: [
            //         'running',
            //         'walking',
            //         'cycling',
            //         'jogging',
            //         'swimming',
            //         'hiking'
            //       ].map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //       onChanged: (String newValue) {
            //         _activityCompleted = true;
            //         setState(() {
            //           widget.fitnessActivity.type = newValue;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Intensity'),
                Container(
                  width: 125,
                  child: DropdownButtonFormField<int>(
                    value: widget.fitnessActivity.intensity,
                    hint: Text('select'),
                    onChanged: (type) =>
                        setState(() => widget.fitnessActivity.intensity = type),
                    validator: (value) => value == null ? 'Activity required' : null,
                    items: [1,2,3,4,5].map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Intensity'),
            //     DropdownButton<int>(
            //       value: widget.fitnessActivity.intensity,
            //       icon: Icon(Icons.arrow_downward),
            //       elevation: 16,
            //       hint: Text('Select Intensity'),
            //       items:
            //           [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
            //         return DropdownMenuItem<int>(
            //           value: value,
            //           child: Text(value.toString()),
            //         );
            //       }).toList(),
            //       onChanged: (int newValue) {
            //         _intensityCompleted = true;
            //         setState(() {
            //           widget.fitnessActivity.intensity = newValue;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Minutes'),
                Container(
                  width: 125,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter number of minutes.';
                      }
                      return null;
                    },
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter duration",
                    ),
                    onChanged: (text) {
                      // _minutesCompleted = true;
                      widget.fitnessActivity.minutes = int.parse(text);
                    },
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context, widget.fitnessActivity);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void saveMethod() {
    print('Saved Activity');
  }
}
