import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Step> steps;

  int _heightFeet;
  int _heightInches;
  int _weight;
  int _diagMonth;
  int _diagYear;

  String dropDownActivity;
  String dropDownStage;
  String dropDownSurgery;
  String dropDownGender;
  String dropDownRace;
  String dropDownEthnicities;
  String dropDownFeet;
  String dropDownInches;
  String dropDownDiagMonth;

  bool _colorectal = false;
  bool _surgery = false;
  bool _ostomy = false;

  var _dateTime;
  String buns;

  List<String> _feet = List<String>.generate(9, (int index) => '${index + 1}');
  List<String> _inches = List<String>.generate(12, (int index) => '${index}');

  List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

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

  List<String> _ethnicities = [
    'Hispanic or Latinx',
    'Non Hispanic or Latinx',
    'Unknown',
    'Prefer not to say',
  ];

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': false,
    'Appetite Loss': false,
    'Bloating': false,
    'Constipation': false,
    "Diarrhea": false,
    'Nausea/Vomiting': false,
    'Stoma Problems': false,
  };

  List<String> _cancerStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

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

  Map<String, bool> treatmentType = {
    'Surgery': false,
    'Chemotherapy': false,
    'Radiation': false,
    'Other': false,
    'Uncertain': false,
  };

  Future<bool> setUserData() async {
    var db = new DBHelper();
    var response = await db.getUserInfo("1");
    var data = json.decode(response.body);
    print(data);
    _dateTime = data['dateOfBirth'];
    buns = data['dateOfBirth'].toString().split("T")[0];
    print(buns);
    String year = buns.split("-")[0];
    String month = buns.split("-")[1];
    String day = buns.split("-")[2];
    buns = month + '-' + day + '-' + year;
    dateCtl.text = buns;
    dropDownActivity = data['activityLevel'].toString().replaceAll('-', ' ');
    dropDownEthnicities = data['ethnicity'].toString().replaceAll('-', ' ');
    dropDownRace = data['race'].toString().replaceAll('-', ' ');
    dropDownGender = data['gender'].toString().replaceAll('-', ' ');
    userWeight = data['weight'];
    _weightController.text = userWeight.toString();

    // print(userWeight.runtimeType);
    var totalHeight = data['height'];
    dropDownInches = totalHeight.remainder(12).toString();
    _heightInches = totalHeight.remainder(12);
    var tempHeight = totalHeight / 12;
    dropDownFeet = tempHeight.truncate().toString();
    _heightFeet = tempHeight.truncate();

    if (data['colorectal']) {
      _colorectal = true;
      var tempDiagDate = DateTime.parse(data["diagnosisDate"]);
      var tempMonth = "${tempDiagDate.month}";
      print(tempMonth);
      dropDownDiagMonth = _months[num.parse(tempMonth) - 1];
      _diagMonth = num.parse(tempMonth);
      dropDownStage = "Stage " + data['stage'].toString();
      userDiagYear = num.parse("${tempDiagDate.year}");
      _diagYearController.text = userDiagYear.toString();
      _diagYear = userDiagYear;
      bool tempSurgery = false;
      bool tempChemo = false;
      bool tempRad = false;
      bool tempOther = false;
      bool tempUncertain = false;

        tempSurgery = data['surgery'];
        _surgery = true;
        tempChemo = data['chemo'];
        tempRad = data['radiation'];
        tempOther = data['other'];
        tempUncertain = data['uncertain'];


      treatmentType = {
        'Surgery': tempSurgery,
        'Chemotherapy': tempChemo,
        'Radiation': tempRad,
        'Other': tempOther,
        'Uncertain': tempUncertain,
      };
      if (data['ostomy']) {
        _ostomy = true;
      }
    }

    bool abdominalPain = false;
    bool appetiteLoss = false;
    bool bloating = false;
    bool constipation = false;
    bool diarrhea = false;
    bool nausea = false;
    bool stomaProblems = false;

    if (data['abdominalPain'] != null) {
      abdominalPain = true;
    }
    if (data['appetiteLoss'] != null) {
      appetiteLoss = true;
    }
    if (data['bloating'] != null) {
      bloating = true;
    }
    if (data['constipation'] != null) {
      constipation = true;
    }
    if (data['diarrhea'] != null) {
      diarrhea = true;
    }
    if (data['nausea'] != null) {
      nausea = true;
    }
    if (data[' stomaProblems'] != null) {
      stomaProblems = true;
    }

    frequentIssues = {
      'Abdominal Pain': abdominalPain,
      'Appetite Loss': appetiteLoss,
      'Bloating': bloating,
      'Constipation': constipation,
      "Diarrhea": diarrhea,
      'Nausea/Vomiting': nausea,
      'Stoma Problems': stomaProblems,
    };
  }

  Widget _buildBirthDatePicker() {
    return FutureBuilder(
        builder: (context, projectSnap) {
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Text('Your birthday:', style: TextStyle(fontSize: 18))),
              Expanded(
                  child: Container(
                    child: TextFormField(
                      // initialValue: '5',
                      controller: dateCtl,
                      decoration: InputDecoration(hintText: 'Select Date'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Date required';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime date = DateTime.now();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        dateCtl.text = DateFormat('MM-dd-yyyy').format(date);
                        _dateTime = dateCtl.text;
                      },
                    ),
                  ))
            ],
          );
        },
        future: setUserData());

  }

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

  Widget _buildWeight(TextEditingController controller) {
    return FutureBuilder(
        builder: (context, projectSnap) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Weight(lbs)',
              hintText: 'Enter your weight in pounds(lbs).',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            controller: _weightController,
            validator: (String value) {
              int weight = int.tryParse(value);
              if (weight == null) {
                return 'Field Required';
              } else if (weight <= 0) {
                return 'Weight must be greater than 0';
              }
              return null;
            },
            onChanged: (String value) {
              _weight = int.tryParse(value);
              print(_weight);
            },
          );
        },
        future: setUserData());
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Weight(lbs)',
        hintText: 'Enter your weight in pounds(lbs).',
        border: OutlineInputBorder(),
      ),
      // initialValue: userWeight.toString(),
      keyboardType: TextInputType.number,
      controller: _weightController,
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

  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];

  Widget activity;

  Widget _buildActivity() {
    return FutureBuilder(
        builder: (context, projectSnap) {
          return DropdownButtonFormField(
            decoration: InputDecoration(
                labelText: 'Activity Level',
                border: OutlineInputBorder(),
                hintText: "Activity Level"),
            value: dropDownActivity,
            validator: (value) => value == null ? 'Field Required' : null,
            onChanged: (String Value) {
              dropDownActivity = Value;
              // setState(() {
              // });
            },
            items: _activity
                .map((actLevel) =>
                DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
                .toList(),
          );
        },
        future: setUserData());

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
          onChanged: (bool value) {
            frequentIssues[key] = value;
            // setState(() {
              // frequentIssues[key] = value;
            // });
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
      controller: _diagYearController,
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

  Widget _buildCancerHistory(TextEditingController _diagYearController) {
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
          title: Text('Empty Form Fields'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You have left some required fields empty. Please be sure to fill the indicated fields.'),
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

  _savedAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Content Saved'),
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
        _savedAlert();
      }
    }
  }

  cancel() {
    if (currentStep > 0) {
      setStepState(currentStep - 1);
    }
  }

  goTo(int step) {
    if (!formKeys[currentStep].currentState.validate()) {
      _emptyFieldsAlert();
    } else {
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

  submit() {
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
      if (frequentIssues[key]) {
        if (gIIssues == "") {
          gIIssues = key;
        } else {
          gIIssues = gIIssues + "," + key;
          print(gIIssues);
        }
      }
    }

    if (gIIssues == "") {
      gIIssues = "na";
    }

    if (!_colorectal) {
      dropDownStage = "na";
      checkedTreatmentTypes = "na";
    }

    DBHelper db = new DBHelper();
    db.deleteUserGiIssues("1");

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
        checkedTreatmentTypes);
  }

  StepState _getState(int i) {
    if (currentStep >= i) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  final TextEditingController dateCtl = new TextEditingController();

  // final TextEditingController _ageMonthController = new TextEditingController();
  // int userAgeMonth;
  // final TextEditingController _ageDayController = new TextEditingController();
  // int userAgeDay;
  // final TextEditingController _ageYearController = new TextEditingController();
  // int userAgeYear;
  // final TextEditingController _heightInchesController =
  // new TextEditingController();
  // int userInchesHeight;
  // final TextEditingController _heightFeetController =
  // new TextEditingController();
  // int userFeetHeight;
  final TextEditingController _weightController = new TextEditingController();
  int userWeight = 1;
  final TextEditingController _diagYearController = new TextEditingController();
  int userDiagYear;

  // final TextEditingController _diagMonthController =
  // new TextEditingController();
  // int userDiagMonth;

  @override
  void initState() {
    setUserData();
    // _ageMonthController.text = userAgeMonth.toString();
    // _ageDayController.text = userAgeDay.toString();
    // _ageYearController.text = userAgeYear.toString();
    // _heightFeetController.text = userFeetHeight.toString();
    // _heightInchesController.text = userInchesHeight.toString();
    _weightController.text = userWeight.toString();
    _diagYearController.text = userDiagYear.toString();

    // _diagMonthController.text = userDiagMonth.toString();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Update Personal Details'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stepper(
            steps: steps = <Step>[
              Step(
                state: _getState(1),
                isActive: currentStep >= 0,
                title: const Text('Health and Fitness'),
                content: Container(
                  child: Form(
                    key: formKeys[0],
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Update your weight:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildWeight(_weightController),
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
                state: _getState(2),
                isActive: currentStep >= 1,
                title: const Text('Frequent Symptoms'),
                content: Container(
                  child: Form(
                    key: formKeys[1],
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
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Cancer History'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        _buildCancerHistory(_diagYearController),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Personal Data'),
                state: _getState(4),
                isActive: currentStep >= 3,
                content: Container(
                  child: Form(
                    key: formKeys[3],
                    child: Column(
                      children: <Widget>[
                        _buildBirthDatePicker(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Edit your height:",
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
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     child: Text(
                        //         "Update the selectionsthe following dropdowns that best describe yourself:",
                        //         style: TextStyle(fontSize: 18)),
                        //   ),
                        // ),
                        // SizedBox(height: 10),
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
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          submit();
          _savedAlert();
        },
        label: Text(
          'Save',
          style: TextStyle(color: Theme.of(context).highlightColor),
        ),
        icon: Icon(Icons.save, color: Theme.of(context).highlightColor),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
