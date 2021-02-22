import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/birthDate_textFormField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Step> steps;

  int _year;
  int _month;
  int _day;

  int _heightFeet;
  int _heightInches;
  int _weight;
  int _diagMonth;
  int _diagYear;

  String dropDownColon;
  String dropDownRectum;
  String dropDownSurgery;
  String dropDownGender;
  String dropDownRace;
  String dropDownEthnicities;
  String dropDownFeet;
  String dropDownInches;
  String dropDownDiagMonth;

  bool _colorectal;
  bool _surgery;
  bool _ostomy;

  var _dateTime;
  var result;


  List<String> _feet = List<String>.generate(9, (int index) => '${index + 1}');
  List<String> _inches = List<String>.generate(12, (int index) => '${index}');



  List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say'
  ];


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
    'Non-Hispanic or Latinx',
    'Unknown',
    'Prefer not to say',
  ];

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': false,
    'Appetite Loss': true,
    'Bloating': true,
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
    'Surgery':true,
    'Chemotherapy': false,
    'Radiation': false,
    'Other': true,
    'Uncertain': false,
  };


  setUserData() {
    userAgeMonth = 10;
    userAgeDay = 31;
    userAgeYear= 1984;
    dropDownFeet = "5";
    dropDownInches= "7";
    userWeight = 135;
    userDiagYear = 2019;
    dropDownGender = "Female";
    dropDownColon = "Stage 1";
    dropDownRace = 'More than one Race';
    dropDownEthnicities = 'Prefer not to say';
    // dropDownBirthMonth = "Jan";
    // dropDownBirthDay = "1";
    // dropDownDiagMonth = "Feb";
    dropDownDiagMonth = "February";
    _colorectal = true;
    _surgery = true;
    _ostomy = false;
    _dateTime = DateTime.now();
    result =
    "${_dateTime.month}/${_dateTime.day}/${_dateTime.year}";
  }

  // List<String> _days = List<String>.generate(31, (int index) => '${index + 1}');
  //
  // String dropDownBirthMonth;
  // String dropDownBirthDay;
  // String dropDownDiagMonth;



  Widget _buildDatePicker() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                  lastDate: DateTime(2050))
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
  String dropDownActivity = 'Lightly Active';
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
      value: dropDownColon,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownColon = value;
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
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Text(
          //           'You have left some required fields empty. Please be sure to fill the indicated fields.'),
          //     ],
          //   ),
          // ),
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

  next() {
    if (formKeys[currentStep].currentState.validate()) {
      currentStep + 1 != steps.length
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
      if (complete) {
        // for (int i = 0; i < formKeys.length; i++) {
        //   if (!formKeys[i].currentState.validate()){
        //
        //
        //   }

        submit();
      }
    }
    formKeys[currentStep].currentState.save();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    // for (int i = 0; i < formKeys.length; i++) {
    //   if (!formKeys[i].currentState.validate()) {
    //     StepState.error;
    //   }
    // }
    setState(() => currentStep = step);
  }

  submit() {
    print("is submitting!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }

  StepState _getState(int i) {
    if (currentStep >= i) {
      return StepState.complete;
    } else {
      // if (formKeys[currentStep].currentState != null && !formKeys[currentStep].currentState.validate()) {
      //   return StepState.error;
      // }
      return StepState.indexed;
    }
  }

  final TextEditingController _ageMonthController = new TextEditingController();
  int userAgeMonth;
  final TextEditingController _ageDayController = new TextEditingController();
  int userAgeDay;
  final TextEditingController _ageYearController = new TextEditingController();
  int userAgeYear;
  final TextEditingController _heightInchesController =
  new TextEditingController();
  int userInchesHeight;
  final TextEditingController _heightFeetController =
  new TextEditingController();
  int userFeetHeight;
  final TextEditingController _weightController = new TextEditingController();
  int userWeight;
  final TextEditingController _diagYearController = new TextEditingController();
  int userDiagYear;
  final TextEditingController _diagMonthController =
  new TextEditingController();
  int userDiagMonth;

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
                    key: formKeys[1],
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
                    key: formKeys[2],
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
                    key: formKeys[3],
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
                    key: formKeys[4],
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Edit your birth date:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        _buildDatePicker(),
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
                            child:  _buildHeightInches(),
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
