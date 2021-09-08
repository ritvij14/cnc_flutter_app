import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaceDropdownWidget extends StatefulWidget {
  @override
  _RaceDropdownWidget createState() => _RaceDropdownWidget();
}

class _RaceDropdownWidget extends State<RaceDropdownWidget> {
  late String dropDownRace;
  List<String> _races = [
    'American Indian or Alaska Native',
    'Asian',
    'Black or African American',
    'Native Hawaiian or Other Pacific Islander',
    'White',
    'Two or More Races',
    'Other',
    'Prefer not to say',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Race', border: OutlineInputBorder(), hintText: "Race"),
      value: dropDownRace,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownRace = value;
          });
      },
      items: _races
          .map((race) => DropdownMenuItem(value: race, child: Text("$race")))
          .toList(),
    );
  }
}
