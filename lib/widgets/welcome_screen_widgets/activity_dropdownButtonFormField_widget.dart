import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityDropdownWidget extends StatefulWidget {
  final List<String> activity;
  final String dropDownActivity;

  const ActivityDropdownWidget(
      {Key? key, required this.activity, required this.dropDownActivity})
      : super(key: key);
  @override
  _ActivityDropdownWidget createState() => _ActivityDropdownWidget();
}

class _ActivityDropdownWidget extends State<ActivityDropdownWidget> {
  late String dropDownActivity;

  getDropdownAct() {
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
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownActivity = value;
          });
      },
      items: widget.activity
          .map((actLevel) =>
              DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
          .toList(),
    );
  }
}
