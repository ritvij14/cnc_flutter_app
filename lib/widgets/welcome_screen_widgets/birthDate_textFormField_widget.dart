import 'package:flutter/material.dart';


class BirthdayFormWidget extends StatefulWidget {
  @override
  _BirthdayFormWidget createState() => _BirthdayFormWidget();
}

class _BirthdayFormWidget extends State<BirthdayFormWidget> {
  int _year = 0;
  int _month = 0;
  int _day = 0;

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text("Please enter your birth date:",
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 5),
              _buildBirthMonth(),
              SizedBox(height: 10),
              _buildBirthDay(),
              SizedBox(height: 10),
              _buildBirthYear(),
            ]));
  }






  Widget _buildBirthMonth() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Month',
        hintText: 'MM',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int month = int.tryParse(value);
        if (month == null) {
          return "Field Required";
        } else if (month <= 0 || month >= 13) {
          return 'Month must be an integer 1 to 12';
        }
        return null;
      },
      onSaved: (String value) {
        _month = int.tryParse(value);
      },
    );
  }

  Widget _buildBirthDay() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Day',
        hintText: 'DD',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int day = int.tryParse(value);
        if (day == null) {
          return "Field Required";
        } else if (day <= 0) {
          return 'Day must be greater than 0';
        } else if (day > 31) {
          return 'Day cannot be greater than 31';
        } else if (_day == 31) {
          if (_month == 2 ||
              _month == 4 ||
              _month == 6 ||
              _month == 9 ||
              _month == 11) {
            return 'Day cannot be 31 for the given month';
          } else {
            return null;
          }
        } else if (_day == 30) {
          if (_month == 2) {
            return 'Day cannot be 30 for the given month';
          }
        }
        return null;
      },
      onSaved: (String value) {
        _day = int.tryParse(value);
      },
    );
  }

  Widget _buildBirthYear() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Year',
        hintText: 'YYYY',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int year = int.tryParse(value);
        if (year == null) {
          return "Field Required";
        } else if (year <= 0) {
          return 'Year must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _year = int.tryParse(value);
      },
    );
  }
}