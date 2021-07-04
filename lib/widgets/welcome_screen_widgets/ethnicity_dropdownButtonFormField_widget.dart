import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EthnicityDropdownWidget extends StatefulWidget {
  @override
  _EthnicityDropdownWidget createState() => _EthnicityDropdownWidget();
}

class _EthnicityDropdownWidget extends State<EthnicityDropdownWidget> {
  late String dropDownEthnicities;
  List<String> _ethnicities = [
    'Not of Hispanic, Latino, or Spanish origin',
    'Mexican, Mexican Am., Chicano',
    "Puerto Rican",
    'Cuban',
    'Two or more Hispanic, Latino, or Spanish origin ethnicities',
    'Other Hispanic, Latino, or Spanish origin',
    'Prefer not to say',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Ethnicity',
          border: OutlineInputBorder(),
          hintText: "Ethnicity"),
      value: dropDownEthnicities,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownEthnicities = value;
          });
      },
      items: _ethnicities
          .map((ethnicity) =>
              DropdownMenuItem(value: ethnicity, child: Text("$ethnicity")))
          .toList(),
    );
  }
}
