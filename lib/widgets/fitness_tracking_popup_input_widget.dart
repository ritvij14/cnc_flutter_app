import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FitnessTrackingPopupInputWidget extends StatefulWidget {
  FitnessActivity fitnessActivity;

  FitnessTrackingPopupInputWidget(FitnessActivity fitnessActivity) {
    this.fitnessActivity = fitnessActivity;
  }

  @override
  _FitnessTrackingPopupInputWidgetState createState() =>
      _FitnessTrackingPopupInputWidgetState();
}

class _FitnessTrackingPopupInputWidgetState
    extends State<FitnessTrackingPopupInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity'),
              DropdownButton<String>(
                value: widget.fitnessActivity.type,
                icon: Icon(Icons.arrow_downward),
                elevation: 16,
                hint: Text('Select Activity'),
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
                onChanged: (String newValue) {
                  setState(() {
                    widget.fitnessActivity.type = newValue;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Intensity'),
              DropdownButton<int>(
                value: widget.fitnessActivity.intensity,
                icon: Icon(Icons.arrow_downward),
                elevation: 16,
                hint: Text('Select Intensity'),
                items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int newValue) {
                  setState(() {
                    widget.fitnessActivity.intensity = newValue;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Minutes'),
              Container(
                width: 125,
                child: TextFormField(
                    initialValue: widget.fitnessActivity.minutes.toString(),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter duration",
                    ),
                  onChanged: (text) {
                      widget.fitnessActivity.minutes = int.parse(text);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
