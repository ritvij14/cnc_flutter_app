// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/activity_dropdownButtonFormField_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/birthDate_textFormField_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/cancer_history_forms_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/cancer_treatment_forms_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/ethnicity_dropdownButtonFormField_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/gIIssues_checkbox_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/height_textFormFiled_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/race_dropdownButtonFormField_widget.dart';
// import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/weight_textFormField_widget.dart';
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Step> steps;

  List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    "May",
    'June',
    'July',
    'August',
    'September',
    "October",
    'November',
    'December'
  ];

  List<String> _feet = List<String>.generate(9, (int index) => '${index + 1}');
  List<String> _inches = List<String>.generate(12, (int index) => '${index}');

  String dropDownDiagMonth;

  var _dateTime;
  var result;

  Widget _buildDatePicker() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Please select your birthday:',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(height: 5),
          RaisedButton(
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.zero,
            //     side: BorderSide(color:  Theme.of(context).primaryColor)
            // ),
            child: Text(
              result != null ? result : 'SELECT DATE',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.blue,
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate:
                  _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  _dateTime = date;
                  result =
                  "${_dateTime.month}/${_dateTime.day}/${_dateTime.year}";
                });
              });
            },
          ),
        ]);
  }

  // Widget _buildMonth(String field) {
  //   return DropdownButtonFormField(
  //     isExpanded: true,
  //     decoration: InputDecoration(
  //       labelText: 'Month',
  //       border: OutlineInputBorder(),
  //       hintText: "Month",
  //     ),
  //     value: dropDownBirthMonth,
  //     validator: (value) => value == null ? 'Field Required' : null,
  //     onChanged: (String Value) {
  //       setState(() {
  //         if (field == "birth") {
  //           dropDownBirthMonth = Value;
  //           _month = _months.indexOf(Value) + 1;
  //         } else {
  //           dropDownDiagMonth = Value;
  //           _diagMonth = _months.indexOf(Value) + 1;
  //         }
  //       });
  //     },
  //     items: _months
  //         .map((month) => DropdownMenuItem(value: month, child: Text("$month")))
  //         .toList(),
  //   );
  // }
  //
  // Widget _buildDay() {
  //   return Container(
  //       width: 10.0,
  //       child: DropdownButtonHideUnderline(
  //           child: ButtonTheme(
  //               alignedDropdown: true,
  //               child: DropdownButtonFormField(
  //                 isExpanded: true,
  //                 decoration: InputDecoration(
  //                   labelText: 'Day',
  //                   border: OutlineInputBorder(),
  //                   hintText: "Day",
  //                 ),
  //                 value: dropDownBirthDay,
  //                 validator: (value) => value == null ? 'Field Required' : null,
  //                 onChanged: (String Value) {
  //                   setState(() {
  //                     dropDownBirthDay = Value;
  //                     _day = _days.indexOf(Value) + 1;
  //                   });
  //                 },
  //                 items: _days
  //                     .map((day) =>
  //                         DropdownMenuItem(value: day, child: Text("$day")))
  //                     .toList(),
  //               ))));
  // }

  // Widget _buildBirthMonth() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'Month',
  //       hintText: 'MM',
  //       border: OutlineInputBorder(),
  //     ),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int month = int.tryParse(value);
  //       if (month == null) {
  //         return "Field Required";
  //       } else if (month <= 0 || month >= 13) {
  //         return 'Month must be an integer 1 to 12';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _month = int.tryParse(value);
  //       print("SAVING MONTH");
  //     },
  //   );
  // }

  // Widget _buildBirthDay() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'Day',
  //       hintText: 'DD',
  //       border: OutlineInputBorder(),
  //     ),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int day = int.tryParse(value);
  //       if (day == null) {
  //         return "Field Required";
  //       } else if (day <= 0) {
  //         return 'Day must be greater than 0';
  //       } else if (day > 31) {
  //         return 'Day cannot be greater than 31';
  //       } else if (_day == 31) {
  //         if (_month == 2 ||
  //             _month == 4 ||
  //             _month == 6 ||
  //             _month == 9 ||
  //             _month == 11) {
  //           return 'Day cannot be 31 for the given month';
  //         } else {
  //           return null;
  //         }
  //       } else if (_day == 30) {
  //         if (_month == 2) {
  //           return 'Day cannot be 30 for the given month';
  //         }
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _day = int.tryParse(value);
  //     },
  //   );
  // }

  // Widget _buildBirthYear() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'Year',
  //       hintText: 'YYYY',
  //       border: OutlineInputBorder(),
  //       contentPadding:
  //           new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
  //     ),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int year = int.tryParse(value);
  //       if (year == null) {
  //         return "Field Required";
  //       } else if (year <= 0) {
  //         return 'Year must be greater than 0';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _year = int.tryParse(value);
  //     },
  //   );
  // }

  int _heightFeet = 0;
  int _heightInches = 0;
  String dropDownFeet;
  String dropDownInches;
  Widget heightFeet;
  Widget heightInches;

  Widget _buildHeightFeet() {
    return Container(
        width: 10.0,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Feet',
                    border: OutlineInputBorder(),
                    hintText: "Feet",
                  ),
                  value: dropDownFeet,
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String Value) {
                    setState(() {
                      dropDownFeet = Value;
                      _heightFeet = _feet.indexOf(Value) + 1;
                    });
                  },
                  items: _feet
                      .map((feet) =>
                      DropdownMenuItem(value: feet, child: Text("$feet")))
                      .toList(),
                ))));
  }

  Widget _buildHeightInches() {
    return Container(
        width: 10.0,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Inches',
                    border: OutlineInputBorder(),
                    hintText: "Inches",
                  ),
                  value: dropDownInches,
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String Value) {
                    setState(() {
                      dropDownInches = Value;
                      _heightInches = _inches.indexOf(Value) + 1;
                    });
                  },
                  items: _inches
                      .map((inch) =>
                      DropdownMenuItem(value: inch, child: Text("$inch")))
                      .toList(),
                ))));
  }


  int _weight = 0;
  Widget weight;

  Widget _buildWeight() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Weight(lbs)',
        hintText: 'Enter your weight in pounds(lbs).',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int weight = int.tryParse(value);
        if (weight == null) {
          return 'Field Required';
        } else if (weight <= 0) {
          return 'Weight must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _weight = int.tryParse(value);
      },
    );
  }

  String dropDownGender;
  List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say'
  ];
  Widget gender;

  Widget _buildGender() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
          hintText: "Gender"),
      value: dropDownGender,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownGender = Value;
        });
      },
      items: _genders
          .map((gender) =>
          DropdownMenuItem(value: gender, child: Text("$gender")))
          .toList(),
    );
  }

  String dropDownRace;
  List<String> _races = [
    'American Indian or Alaska Native',
    'Asian',
    'Black or African American',
    'Native Hawaiian or Other Pacific Islander',
    'White',
    'More than one Race',
    'Unknown',
    'Prefer not to say',
  ];
  Widget race;

  Widget _buildRace() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Race', border: OutlineInputBorder(), hintText: "Race"),
      value: dropDownRace,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownRace = Value;
        });
      },
      items: _races
          .map((race) => DropdownMenuItem(value: race, child: Text("$race")))
          .toList(),
    );
  }

  String dropDownEthnicities;
  List<String> _ethnicities = [
    'Hispanic or Latinx',
    'Non-Hispanic or Latinx',
    'Unknown',
    'Prefer not to say',
  ];
  Widget ethnicity;

  Widget _buildEthnicity() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Ethnicity',
          border: OutlineInputBorder(),
          hintText: "Ethnicity"),
      value: dropDownEthnicities,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownEthnicities = Value;
        });
      },
      items: _ethnicities
          .map((ethnicity) =>
          DropdownMenuItem(value: ethnicity, child: Text("$ethnicity")))
          .toList(),
    );
  }

  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];
  String dropDownActivity;
  Widget activity;

  Widget _buildActivity() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Activity Level',
          border: OutlineInputBorder(),
          hintText: "Activity Level"),
      value: dropDownActivity,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownActivity = Value;
        });
      },
      items: _activity
          .map((actLevel) =>
          DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
          .toList(),
    );
  }

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': false,
    'Appetite Loss': false,
    'Bloating': false,
    'Constipation': false,
    "Diarrhea": false,
    'Nausea/Vomiting': false,
    'Stoma Problems': false,
  };

  Widget GIIssues;

  Widget _buildGICheckBoxes() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: frequentIssues.keys.map((String key) {
        return new CheckboxListTile(
          contentPadding: EdgeInsets.all(0),
          title: new Text(key),
          value: frequentIssues[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              frequentIssues[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildGIIssues() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Mark all the frequent symptoms you experience:',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          _buildGICheckBoxes(),
        ]));
  }

  String dropDownStage;


  bool _colorectal = false;
  bool _surgery = false;

  Map<String, bool> treatmentType = {
    'Surgery': false,
    'Chemotherapy': false,
    'Radiation': false,
    'Other': false,
    'Uncertain': false,
  };

  List<String> _cancerStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  Widget cancerHistory;

  Widget _buildCancerHistoryYN(String cancer) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Were you diagnosed with colorectal cancer?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: ListTile(
                title: const Text('yes'),
                leading: Radio(
                  value: true,
                  groupValue: _colorectal,
                  onChanged: (value) {
                    setState(() {
                      _colorectal = value;
                      // Navigator.of(context, rootNavigator: true).pop();
                      // _buildCancerHistory();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('no'),
                leading: Radio(
                  value: false,
                  groupValue: _colorectal,
                  onChanged: (value) {
                    setState(() {
                      _colorectal = value;
                      // Navigator.of(context, rootNavigator: true).pop();
                      // _buildCancerHistory();
                    });
                  },
                ),
              ),
            ),
          ])
        ]));
  }

  Widget _buildColonrectalDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Cancer Stage',
          border: OutlineInputBorder(),
          hintText: "Cancer Stage"),
      value: dropDownStage,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownStage = value;
        });
      },
      items: _cancerStages
          .map((colStage) =>
          DropdownMenuItem(value: colStage, child: Text("$colStage")))
          .toList(),
    );
  }

  int _diagYear = 0;
  int _diagMonth = 0;
  Widget lastDiag;


  Widget _buildLastDiagMonth() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Month',
        border: OutlineInputBorder(),
        hintText: "Month",
      ),
      value: dropDownDiagMonth,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownDiagMonth = Value;
          _diagMonth = _months.indexOf(Value) + 1;
        });
      },
      items: _months
          .map((month) => DropdownMenuItem(value: month, child: Text("$month")))
          .toList(),
    );
  }

  Widget _buildLastDiagYear() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Year',
        hintText: 'YYYY',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int year = int.tryParse(value);
        if (year == null || year <= 0) {
          return 'Year must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _diagYear = int.tryParse(value);
      },
    );
  }

  Widget _buildCancerHistory() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildCancerHistoryYN("colorectal"),
        _colorectal == true ? SizedBox(height: 15) : SizedBox(height: 0),
        _colorectal == true
            ? Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child:
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                      'If known, what cancer stage were you initially diagnosed?',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 5),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(child: _buildColonrectalDropdown()),
                    IconButton(
                      icon: Icon(Icons.help_outline, color: Colors.blue),
                      tooltip: 'More Information',
                      onPressed: () {
                        setState(() {
                          _cancerStagesAlert();
                        });
                      },
                    ),
                  ]),
              SizedBox(height: 10),
            ]))
            : SizedBox(height: 0),
        _colorectal == true ? SizedBox(height: 15) : SizedBox(height: 0),
        _colorectal == true
            ? Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child:
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text('Approximate date of diagnosis:',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 10),
              _buildLastDiagMonth(),
              SizedBox(height: 5),
              _buildLastDiagYear(),
              SizedBox(height: 10)
            ]))
            : SizedBox(height: 0),
        _colorectal == true ? SizedBox(height: 10) : SizedBox(height: 0),
        _colorectal == true ? _buildSurgeryDropdown() : SizedBox(height: 0),
        _surgery == true ? SizedBox(height: 15) : SizedBox(height: 0),
        _surgery == true ? _buildOstomyYN() : SizedBox(height: 0),
      ],
      // ),
    );
  }

  Widget _buildSurgeryDropdown() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                  'Which cancer treatments were performed to treat your colorectal cancer? Mark all that apply:',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: treatmentType.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key),
                value: treatmentType[key],
                activeColor: Theme.of(context).buttonColor,
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    treatmentType[key] = value;
                    if (key == 'Surgery') {
                      if (_surgery) {
                        _surgery = false;
                      } else {
                        _surgery = true;
                      }
                    }
                  });
                },
              );
            }).toList(),
          )
        ]));
  }

  bool _ostomy;

  Widget _buildOstomyYN() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(children: <Widget>[
            Text('Do you currently have an ostomy?',
                style: TextStyle(fontSize: 16)),
            Container(
              padding: const EdgeInsets.all(0.0),
              width: 30.0,
              child: IconButton(
                icon: Icon(Icons.help_outline, color: Colors.blue),
                tooltip: 'More Information',
                onPressed: () {
                  setState(() {
                    _ostomyAlert();
                  });
                },
              ),
            )
          ]),
          Row(children: <Widget>[
            Expanded(
              child: ListTile(
                title: const Text('yes'),
                leading: Radio(
                  value: true,
                  groupValue: _ostomy,
                  onChanged: (value) {
                    setState(() {
                      _ostomy = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('no'),
                leading: Radio(
                  value: false,
                  groupValue: _ostomy,
                  onChanged: (value) {
                    setState(() {
                      _ostomy = value;
                    });
                  },
                ),
              ),
            ),
          ])
        ]));
  }

  _cancerStagesAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancer stages guide'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Stage 0:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Cancer in its earliest stage, only in the lining. Cancer has not spread to lymph nodes or other parts of the body.'),
                SizedBox(height: 15),
                Text('Stage 1:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Cancer has reached the muscle layer of the colon or rectum, but has not spread to lymph nodes or other parts of the body.'),
                SizedBox(height: 15),
                Text('Stage 2:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Cancer has either grown through the wall of the colon, or rectum, or reached stomach lining. Nearby organs may be affected, but cancer has not spread to nearby lymph nodes.'),
                SizedBox(height: 15),
                Text('Stage 3:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Cancer has spread to nearby lymph nodes and/or nearby organs.'),
                SizedBox(height: 15),
                Text('Stage 4:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Most advanced cancer, cancer has reached distant organs.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _ostomyAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('More information on ostomy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'An ostomy is a pouch that attaches to the body to collect waste.')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _emptyFieldsAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Current Forms Incomplete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You have left some required fields empty or have filled them out incorrectly. Please be sure to fill all the indicated fields correctly before moving to other forms.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _successfulAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form successfully submitted'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You can view and update these forms fields in the PROFILE tab by tapping on the Personal Details button.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val){
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int currentStep = 0;
  bool complete = false;
  bool isFirstStep = true;
  bool isLastStep = false;
  next() {
    if (formKeys[currentStep].currentState.validate()) {
      formKeys[currentStep].currentState.save();

      if (currentStep + 1 != steps.length) {
        goTo(currentStep + 1);
        setState(() => complete = false);
      } else {
        setState(() => complete = true);
      }
      if (complete) {
        submit();
      }
    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    if (!formKeys[currentStep].currentState.validate()) {
      _emptyFieldsAlert();
    } else {
      setState(() => currentStep = step);
    }

    setState((){
      currentStep = step;
      if(currentStep == 0){
        isFirstStep = true;
        isLastStep = false;
      }else if(currentStep + 1 < steps.length){
        isFirstStep = false;
        isLastStep = false;
      } else{
        isLastStep = true;
      }
    });

  }

  var birthDate;
  var lastDiagDate;

  submit() {
    birthDate = _dateTime;
    lastDiagDate = new DateTime(_diagYear, _diagMonth, 1);
    int height = (_heightFeet * 12) + _heightInches;
    String checkedTreatmentTypes = "";

    for (var key in treatmentType.keys) {

      if (checkedTreatmentTypes  == "") {
        checkedTreatmentTypes = treatmentType[key].toString();
      } else {
        checkedTreatmentTypes  += "," + (treatmentType[key].toString());
      }
    }

    checkedTreatmentTypes +=  "," + (_ostomy.toString());


    String gIIssues = "";
    for (var key in frequentIssues.keys) {
      if (frequentIssues[key]) {
        if (gIIssues == "") {
          gIIssues = key;
        } else {
          gIIssues = gIIssues + "," + key;
          print(gIIssues);
        }
      }
    }


    DBHelper db = new DBHelper();

    db.saveFormInfo(
        "1",
        birthDate.toString().split(" ")[0],
        dropDownRace.replaceAll(" ", "-"),
        dropDownEthnicities.replaceAll(" ", "-"),
        dropDownGender.replaceAll(" ", "-"),
        height.toString(),
        _weight.toString(),
        dropDownActivity.replaceAll(" ", "-"),
        gIIssues,
        _colorectal,
        dropDownStage,
        lastDiagDate.toString().split(" ")[0],
        checkedTreatmentTypes );
    _successfulAlert();
    print("is submitting!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }

  StepState _getState(int i) {
    if (currentStep >= i) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  final TextEditingController _ageMonthController = new TextEditingController();
  int userAgeMonth = 33;
  final TextEditingController _ageDayController = new TextEditingController();
  int userAgeDay = 33;
  final TextEditingController _ageYearController = new TextEditingController();
  int userYearMonth = 33;
  final TextEditingController _heightInchesController =
  new TextEditingController();
  int userInchesHeight = 65;
  final TextEditingController _heightFeetController =
  new TextEditingController();
  int userFeetHeight = 65;
  final TextEditingController _weightController = new TextEditingController();
  int userWeight = 130;
  final TextEditingController _diagYearController = new TextEditingController();
  int userDiagYear = 1;
  final TextEditingController _diagMonthController =
  new TextEditingController();
  int userDiagMonth = 1;

  @override
  void initState() {
    _ageMonthController.text = userAgeMonth.toString();
    _ageDayController.text = userAgeDay.toString();
    _ageYearController.text = userYearMonth.toString();
    _heightFeetController.text = userFeetHeight.toString();
    _heightInchesController.text = userInchesHeight.toString();
    _weightController.text = userWeight.toString();
    _diagYearController.text = userDiagYear.toString();
    _diagMonthController.text = userDiagMonth.toString();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // birthDay = _buildBirthDay();
    // birthMonth = _buildBirthMonth();
    // birthYear = _buildBirthYear();
    heightFeet = _buildHeightFeet();
    heightInches = _buildHeightInches();
    weight = _buildWeight();
    race = _buildRace();
    ethnicity = _buildEthnicity();
    activity = _buildActivity();
    GIIssues = _buildGIIssues();
    cancerHistory = _buildCancerHistory();
    // cancerTreatment = _buildCancerTreatment();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stepper(
            steps: steps = <Step>[
              Step(
                title: const Text('Personal Data'),
                state: _getState(1),
                isActive: currentStep >= 0,
                content: Container(
                  child: Form(
                    key: formKeys[0],
                    child: Column(
                      children: <Widget>[
                        _buildDatePicker(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "Please make selections from the following dropdowns that best describe yourself:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        // SizedBox(height: 5),
                        // Row(children: <Widget>[
                        //   Expanded(
                        //     child: _buildMonth("birth"),
                        //   ),
                        //   Expanded(
                        //     child: _buildDay(),
                        //   ),
                        //   Expanded(
                        //     child: birthYear,
                        //   ),
                        // ]),

                        SizedBox(height: 10),
                        race,
                        SizedBox(height: 15),
                        ethnicity,
                        SizedBox(height: 15),
                        _buildGender(),
                        SizedBox(height: 15),
                        // EthnicityDropdownWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(2),
                isActive: currentStep >= 1,
                title: const Text('Health Information'),
                content: Container(
                  child: Form(
                    key: formKeys[1],
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Please enter your height:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(children: <Widget>[
                          Expanded(
                            child: heightFeet,
                          ),

                          //  SizedBox(height: 10),
                          Expanded(
                            child: heightInches,
                          )
                        ]),
                        // HeightFormWidget(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Please enter your weight:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        // WeightFormWidget(),
                        weight,
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "What is your usual physical activity level?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        // ActivityDropdownWidget(),
                        activity,
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Frequent Symptoms'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        GIIssues,
                        SizedBox(height: 15),
                        // GIIssuesCheckboxWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(4),
                isActive: currentStep >= 3,
                title: const Text('Cancer History'),
                content: Container(
                  child: Form(
                    key: formKeys[3],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        cancerHistory,
                        SizedBox(height: 15),
                        // CancerHistoryWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              // Step(
              //   state: _getState(5),
              //   isActive: currentStep >= 4,
              //   title: const Text('Cancer Treatment'),
              //   content: Container(
              //     child: Form(
              //       key: formKeys[4],
              //       child: Column(
              //         children: <Widget>[
              //           SizedBox(height: 5),
              //           cancerTreatment,
              //           // CancerTreatmentWidget(),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  isLastStep ?  FlatButton(
                    onPressed:  onStepContinue,
                    child: const Text('SUBMIT',
                        style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                  ) :  FlatButton(
                    onPressed:  onStepContinue,
                    child: const Text('CONTINUE',
                        style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10),
                  ),
                  isFirstStep ? SizedBox(height:0) : FlatButton(
                    onPressed: onStepCancel,
                    child: const Text(
                      'BACK',
                      style: TextStyle( color: Colors.grey),
                    ),
                    // color: Colors.grey,
                  ),
                ],
              );
            },

          ),
        ),
      ]),
    );
  }
}
