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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late List<Step> steps;

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

  var _dateTime;
  var result;

  int _heightFeet = 0;
  int _heightInches = 0;
  String? dropDownFeet;
  String? dropDownInches;

  int _weight = 0;
  String? dropDownGender;
  List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

  String? dropDownRace;
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
  String? dropDownEthnicities;
  List<String> _ethnicities = [
    'Hispanic or Latinx',
    'Non Hispanic or Latinx',
    'Unknown',
    'Prefer not to say',
  ];
  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];
  String? dropDownActivity;

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': false,
    'Appetite Loss': false,
    'Bloating': false,
    'Constipation': false,
    "Diarrhea": false,
    'Nausea/Vomiting': false,
    'Stoma Problems': false,
  };

  String? dropDownStage;

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

  String? dropDownDiagMonth;
  int _diagYear = 0;
  int _diagMonth = 0;
  bool _ostomy = false;

  bool userConsent = false;
  bool userOptIn = true;

  Widget _buildtemp() {
    return Row(children: <Widget>[
      new Transform.scale(
        scale: 1.5,
        child: new Checkbox(
            value: userConsent,
            onChanged: (bool? newvalue) {
              if (newvalue != null)
                setState(() {
                  userConsent = newvalue;
                });
            }),
      ),
      Expanded(
          child: Text(
              "I understand agree to Cancer DietAssist's Terms of Service and Private Policy")),
      IconButton(
        icon: Icon(
          Icons.policy,
          color: Theme.of(context).buttonColor,
          size: 35,
        ),
        tooltip: 'Private Policy',
        onPressed: () {
          setState(() {
            openUrl();
          });
        },
      ),
    ]);
  }

  void openUrl() {
    String url =
        'https://www.privacypolicies.com/live/1407360e-2832-431e-a2a3-32d08bf7b34a';
    launch(url);
  }

  Widget _buildOptIn() {
    return CheckboxListTile(
      title: Text("I would like to participate in the research study"),
      subtitle: Text(
          "You will be asked to fill out the following forms regarding you and your current health"),
      value: userOptIn,
      onChanged: (bool? newvalue) {
        if (newvalue != null)
          setState(() {
            userOptIn = newvalue;
          });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildBirthDatePicker() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: Text('Your birthday:', style: TextStyle(fontSize: 18))),
        Expanded(
            child: Container(
          child: TextFormField(
            controller: dateCtl,
            decoration: InputDecoration(hintText: 'Select Date'),
            validator: (String? value) {
              if (value == null) {
                return 'Date required';
              }
              return null;
            },
            onTap: () async {
              DateTime? date = DateTime.now();
              FocusScope.of(context).requestFocus(new FocusNode());
              date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());

              if (date != null) {
                dateCtl.text = DateFormat('MM-dd-yyyy').format(date);
                _dateTime = dateCtl.text;
              }
            },
          ),
        ))
      ],
    );
  }

  // Widget _buildDatePicker() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Container(
  //             child: Text('Please select your birthday:',
  //                 style: TextStyle(fontSize: 18)),
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         RaisedButton(
  //           child: Text(
  //             result != null ? result : 'SELECT DATE',
  //             style: TextStyle(
  //               fontSize: 18,
  //               color: Theme.of(context).highlightColor,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           color: Colors.blue,
  //           onPressed: () {
  //             showDatePicker(
  //                     context: context,
  //                     initialDate:
  //                         _dateTime == null ? DateTime.now() : _dateTime,
  //                     firstDate: DateTime(1900),
  //                     lastDate: DateTime.now())
  //                 .then((date) {
  //               setState(() {
  //                 _dateTime = date;
  //                 result =
  //                     "${_dateTime.month}/${_dateTime.day}/${_dateTime.year}";
  //               });
  //             });
  //           },
  //         ),
  //       ]);
  // }

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
                  value: dropDownFeet ?? _feet[0],
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String? value) {
                    if (value != null)
                      setState(() {
                        dropDownFeet = value;
                        _heightFeet = _feet.indexOf(value) + 1;
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
                  value: dropDownInches ?? _inches[0],
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String? value) {
                    if (value != null)
                      setState(() {
                        dropDownInches = value;
                        _heightInches = _inches.indexOf(value) + 1;
                      });
                  },
                  items: _inches
                      .map((inch) =>
                          DropdownMenuItem(value: inch, child: Text("$inch")))
                      .toList(),
                ))));
  }

  Widget _buildWeight() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Weight(lbs)',
        hintText: 'Enter your weight in pounds(lbs).',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) return 'Field Required';
        int weight = int.tryParse(value)!;
        if (weight <= 0) {
          return 'Weight must be greater than 0';
        }
        return null;
      },
      onSaved: (String? value) {
        if (value != null) _weight = int.tryParse(value)!;
      },
    );
  }

  Widget _buildGender() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
          hintText: "Gender"),
      value: dropDownGender ?? _genders[0],
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownGender = value;
          });
      },
      items: _genders
          .map((gender) =>
              DropdownMenuItem(value: gender, child: Text("$gender")))
          .toList(),
    );
  }

  Widget _buildRace() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Race', border: OutlineInputBorder(), hintText: "Race"),
      value: dropDownRace ?? _races[0],
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

  Widget _buildEthnicity() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: 'Ethnicity',
          border: OutlineInputBorder(),
          hintText: "Ethnicity"),
      value: dropDownEthnicities ?? _ethnicities[0],
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

  Widget _buildActivity() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Activity Level',
          border: OutlineInputBorder(),
          hintText: "Activity Level"),
      value: dropDownActivity ?? _activity[0],
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownActivity = value;
          });
      },
      items: _activity
          .map((actLevel) =>
              DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
          .toList(),
    );
  }

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
          onChanged: (bool? value) {
            if (value != null)
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
                title: const Text('Yes'),
                leading: Radio(
                    value: true,
                    groupValue: _colorectal,
                    onChanged: (bool? value) {
                      if (value != null)
                        setState(() {
                          _colorectal = value;
                        });
                    }),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('No'),
                leading: Radio(
                  value: false,
                  groupValue: _colorectal,
                  onChanged: (bool? value) {
                    if (value != null)
                      setState(() {
                        _colorectal = value;
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
      value: dropDownStage ?? _cancerStages[0],
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
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

  Widget _buildLastDiagMonth() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Month',
        border: OutlineInputBorder(),
        hintText: "Month",
      ),
      value: dropDownDiagMonth ?? _months[0],
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String? value) {
        if (value != null)
          setState(() {
            dropDownDiagMonth = value;
            _diagMonth = _months.indexOf(value) + 1;
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
      validator: (String? value) {
        if (value == null) return null;
        int year = int.tryParse(value)!;
        if (year <= 0) {
          return 'Year must be greater than 0';
        }
      },
      onSaved: (String? value) {
        if (value != null) _diagYear = int.tryParse(value)!;
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
                onChanged: (bool? value) {
                  if (value != null)
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
                title: const Text('Yes'),
                leading: Radio(
                  value: true,
                  groupValue: _ostomy,
                  onChanged: (bool? value) {
                    if (value != null)
                      setState(() {
                        _ostomy = value;
                      });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('No'),
                leading: Radio(
                  value: false,
                  groupValue: _ostomy,
                  onChanged: (bool? value) {
                    if (value != null)
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
              child: Text('OK'),
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
          // title: Text('Form successfully submitted'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Form successfully submitted!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  _agreementAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Form successfully submitted'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You must read and accept our Terms and Conditions before continuing'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _optOutAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Since you have opted out of the study, you will be taken to the home screen of the application. If you wish to opt in, you can via the Personal Details button under the PROFILE tab.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
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
    if (!userConsent) {
      _agreementAlert();
    } else if (formKeys[currentStep].currentState!.validate() && userOptIn) {
      formKeys[currentStep].currentState!.save();

      if (currentStep + 1 != steps.length) {
        goTo(currentStep + 1);
        setState(() => complete = false);
      } else {
        setState(() => complete = true);
      }
      if (complete) {
        submit();
        _successfulAlert();
      }
    } else if (!userOptIn) {
      _optOutAlert();
      submit();
    }
  }

  cancel() {
    if (currentStep > 0) {
      setStepState(currentStep - 1);
    }
  }

  goTo(int step) {
    if (!formKeys[currentStep].currentState!.validate()) {
      _emptyFieldsAlert();
    } else if (userConsent) {
      setStepState(step);
    }
  }

  setStepState(int step) {
    setState(() {
      currentStep = step;
      if (currentStep == 0) {
        isFirstStep = true;
        isLastStep = false;
      } else if (currentStep + 1 < steps.length) {
        isFirstStep = false;
        isLastStep = false;
      } else {
        isLastStep = true;
      }
    });
  }

  var birthDate;
  var lastDiagDate;

  submit() async {
    if (!userOptIn) {
      dropDownRace = "na";
      dropDownEthnicities = "na";
      dropDownGender = "na";
      dropDownActivity = "na";
    }

    birthDate = _dateTime;
    lastDiagDate = new DateTime(_diagYear, _diagMonth, 1);
    int height = (_heightFeet * 12) + _heightInches;
    String checkedTreatmentTypes = "";

    for (var key in treatmentType.keys) {
      if (checkedTreatmentTypes == "") {
        checkedTreatmentTypes = treatmentType[key].toString();
      } else {
        checkedTreatmentTypes += "," + (treatmentType[key].toString());
      }
    }

    checkedTreatmentTypes += "," + (_ostomy.toString());

    String gIIssues = "";
    for (var key in frequentIssues.keys) {
      if (frequentIssues[key]!) {
        if (gIIssues == "") {
          gIIssues = key;
        } else {
          gIIssues = gIIssues + "," + key;
        }
      }
    }
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id')!;
    // if (gIIssues == "") {
    //   gIIssues = "na";
    // }
    //
    // if (!_colorectal) {
    //   dropDownStage = "na";
    //   checkedTreatmentTypes = "na";
    // }

    DBHelper db = new DBHelper();

    db.saveFormInfo(
        birthDate.toString().split(" ")[0],
        dropDownRace ?? _races[0].replaceAll(" ", "-"),
        dropDownEthnicities ?? _ethnicities[0].replaceAll(" ", "-"),
        dropDownGender ?? _genders[0].replaceAll(" ", "-"),
        height.toString(),
        _weight.toString(),
        dropDownActivity ?? _activity[0].replaceAll(" ", "-"),
        gIIssues,
        _colorectal,
        dropDownStage ?? _cancerStages[0],
        lastDiagDate.toString().split(" ")[0],
        checkedTreatmentTypes);
  }

  StepState _getState(int i) {
    if (currentStep >= i) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  TextEditingController dateCtl = TextEditingController();
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
    _heightFeetController.text = userFeetHeight.toString();
    _heightInchesController.text = userInchesHeight.toString();
    _weightController.text = userWeight.toString();
    _diagYearController.text = userDiagYear.toString();
    _diagMonthController.text = userDiagMonth.toString();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stepper(
            steps: steps = <Step>[
              Step(
                title: const Text('User Agreement'),
                state: _getState(1),
                isActive: currentStep >= 0,
                content: Container(
                  child: Form(
                    key: formKeys[0],
                    child: Column(
                      children: <Widget>[
                        // _buildConsentBox(),
                        _buildtemp(),
                        SizedBox(height: 15),
                        // _buildOptIn(),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Personal Data'),
                state: _getState(2),
                isActive: currentStep >= 1,
                content: Container(
                  child: Form(
                    key: formKeys[1],
                    child: Column(
                      children: <Widget>[
                        _buildBirthDatePicker(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "Please make selections from the following dropdowns that best describe yourself:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildRace(),
                        SizedBox(height: 15),
                        _buildEthnicity(),
                        SizedBox(height: 15),
                        _buildGender(),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Health Information'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
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
                            child: _buildHeightFeet(),
                          ),
                          Expanded(
                            child: _buildHeightInches(),
                          )
                        ]),
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
                        _buildWeight(),
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
                        _buildActivity(),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(4),
                isActive: currentStep >= 3,
                title: const Text('Frequent Symptoms'),
                content: Container(
                  child: Form(
                    key: formKeys[3],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        _buildGIIssues(),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(5),
                isActive: currentStep >= 4,
                title: const Text('Cancer History'),
                content: Container(
                  child: Form(
                    key: formKeys[4],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        _buildCancerHistory(),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              return Row(
                children: <Widget>[
                  isLastStep
                      ? FlatButton(
                          onPressed: controlsDetails.onStepContinue,
                          child: const Text('SUBMIT',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        )
                      : FlatButton(
                          onPressed: controlsDetails.onStepContinue,
                          child: const Text('CONTINUE',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                  new Padding(
                    padding: new EdgeInsets.all(10),
                  ),
                  isFirstStep
                      ? SizedBox(height: 0)
                      : FlatButton(
                          onPressed: controlsDetails.onStepCancel,
                          child: const Text(
                            'BACK',
                            style: TextStyle(color: Colors.grey),
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
