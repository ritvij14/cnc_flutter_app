
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityDropdownWidget extends StatefulWidget {
  final List<String> activity;
  final  String dropDownActivity;

  const ActivityDropdownWidget({Key key, this.activity, this.dropDownActivity}) : super(key: key);
  @override
  _ActivityDropdownWidget createState() => _ActivityDropdownWidget();
}

class _ActivityDropdownWidget extends State<ActivityDropdownWidget> {
  String dropDownActivity;

  getDropdownAct(){
    return dropDownActivity;
  }

@override
Widget build(BuildContext context) {
  return DropdownButtonFormField(
    decoration: InputDecoration(
        labelText: 'Activity Level',
        border: OutlineInputBorder(),
        hintText: "Activity Level"),
    value: widget.dropDownActivity,
    validator: (value) => value == null ? 'Field Required' : null,
    onChanged: (String Value) {
      setState(() {
        dropDownActivity = Value;
      });
    },
    items: widget.activity
        .map((actLevel) =>
        DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
        .toList(),
  );
}
}