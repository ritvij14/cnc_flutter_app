import 'package:flutter/material.dart';

class HeightFormWidget extends StatefulWidget {
  @override
  _HeightFormWidget createState() => _HeightFormWidget();
}

class _HeightFormWidget extends State<HeightFormWidget> {
  late int _heightFeet;
  late int _heightInches;
  late Widget heightFeet;
  late Widget heightInches;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child:
              Text("Please enter your height:", style: TextStyle(fontSize: 18)),
        ),
      ),
      SizedBox(height: 5),
      _buildHeightFeet(),
      SizedBox(height: 10),
      _buildHeightInches(),
    ]));
  }

  Widget _buildHeightFeet() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Feet',
        hintText: 'ft',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) return "Field Required";
        int height = int.tryParse(value)!;
        if (height <= 0) {
          return 'Height must be greater than 0';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) _heightFeet = int.tryParse(value)!;
      },
    );
  }

  Widget _buildHeightInches() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Inches',
        hintText: 'in',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) return null;
        int inches = int.tryParse(value)!;
        if (inches >= 12) {
          return 'Inches must be less than 12';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) _heightInches = int.tryParse(value)!;
      },
    );
  }
}
