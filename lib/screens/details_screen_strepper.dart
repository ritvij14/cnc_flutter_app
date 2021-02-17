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
  String dropDownRace;
  String dropDownEthnicities;

  bool _colon;

  bool _rectum;
  bool _surgery;
  bool _chemo;
  bool _radiation;

  //
  // Widget birthDay;
  // Widget birthMonth;
  // Widget birthYear;
  // Widget race;
  // Widget ethnicity;
  // Widget heightFeet;
  // Widget heightInches;
  // Widget weight;
  // Widget gIIssues;
  // Widget cancerTreatment;
  // Widget cancerHistory;

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

  List<String> _ethnicities = [
    'Not of Hispanic, Latino, or Spanish origin',
    'Mexican, Mexican Am., Chicano',
    "Puerto Rican",
    'Cuban',
    'Two or more Hispanic, Latino, or Spanish origin ethnicities',
    'Other Hispanic, Latino, or Spanish origin',
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

  Map<String, bool> surgeryType = {
    'Colectomy': false,
    'Ileostomy': false,
    'Polypectomy': false,
    'Other': true,
  };

  List<String> _cancerStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  setUserData() {
    userAgeMonth = 10;
    userAgeDay = 31;
    userAgeYear= 1984;
    userInchesHeight = 1;
    userFeetHeight = 6;
    userWeight = 135;
    userDiagYear = 2019;
    // userDiagMonth = 1;
    dropDownColon = "Stage 1";
    dropDownRectum;
    dropDownSurgery;
    dropDownRace = 'Prefer not to say';
    dropDownEthnicities = 'Prefer not to say';
    dropDownBirthMonth = "Jan";
    dropDownBirthDay = "1";
    dropDownDiagMonth = "Feb";

    _colon = true;
    _rectum = false;
    _surgery = false;
    _chemo = true;
    _radiation = false;
  }

  List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    "May",
    'June',
    'July',
    'Aug',
    'Sept',
    "Oct",
    'Nov',
    'Dec'
  ];

  List<String> _days = List<String>.generate(31, (int index) => '${index + 1}');

  String dropDownBirthMonth;
  String dropDownBirthDay;
  String dropDownDiagMonth;

  Widget _buildMonth(String field) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Month',
        border: OutlineInputBorder(),
        hintText: "Month",
      ),
      value: dropDownBirthMonth,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          if (field == "birth") {
            dropDownBirthMonth = Value;
            _month = _months.indexOf(Value) + 1;
          } else {
            dropDownDiagMonth = Value;
            _diagMonth = _months.indexOf(Value) + 1;
          }
        });
      },
      items: _months
          .map((month) => DropdownMenuItem(value: month, child: Text("$month")))
          .toList(),
    );
  }

  Widget _buildDay() {
    return Container(
        width: 10.0,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Day',
                    border: OutlineInputBorder(),
                    hintText: "Day",
                  ),
                  value: dropDownBirthDay,
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String Value) {
                    setState(() {
                      dropDownBirthDay = Value;
                      _day = _days.indexOf(Value) + 1;
                    });
                  },
                  items: _days
                      .map((day) =>
                      DropdownMenuItem(value: day, child: Text("$day")))
                      .toList(),
                ))));
  }

  Widget _buildBirthMonth() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Month',
        hintText: 'MM',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _ageMonthController,
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
      controller: _ageDayController,
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
        contentPadding:
        new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
      ),
      keyboardType: TextInputType.number,
      controller: _ageYearController,
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

  Widget _buildHeightFeet() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Feet',
        hintText: 'ft',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _heightFeetController,
      validator: (String value) {
        int height = int.tryParse(value);
        if (height == null) {
          return "Field Required";
        } else if (height <= 0) {
          return 'Height must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _heightFeet = int.tryParse(value);
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
      controller: _heightInchesController,
      validator: (String value) {
        int inches = int.tryParse(value);
        if (inches == null) {
          return null;
        } else if (inches >= 12) {
          return 'Inches must be less than 12';
        }
        return null;
      },
      onSaved: (String value) {
        _heightInches = int.tryParse(value);
      },
    );
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
              child: Text('Frequent Gastrointestinal Issues',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('(at least once every week within the last 2 months)',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildGICheckBoxes(),
        ]));
  }

  Widget _buildCancerHistoryYN(String cancer) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: cancer == "rectum" ? _rectum : _colon,
            onChanged: (value) {
              setState(() {
                cancer == "rectum" ? _rectum = value : _colon = value;
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
            groupValue: cancer == "rectum" ? _rectum : _colon,
            onChanged: (value) {
              setState(() {
                cancer == "rectum" ? _rectum = value : _colon = value;
                // Navigator.of(context, rootNavigator: true).pop();
                // _buildCancerHistory();
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildColonDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Colon Cancer Stage',
          border: OutlineInputBorder(),
          hintText: "Colon Cancer Stage"),
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

  Widget _buildRectumDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Rectum Cancer Stage',
          border: OutlineInputBorder(),
          hintText: "Rectum Cancer Stage"),
      value: dropDownRectum,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownRectum = value;
        });
      },
      items: _cancerStages
          .map((recStage) =>
          DropdownMenuItem(value: recStage, child: Text("$recStage")))
          .toList(),
    );
  }

  Widget _buildLastDiagMonth() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Month(optional)',
        hintText: 'MM',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _diagMonthController,
      validator: (String value) {
        int month = int.tryParse(value);
        if (month == null) {
          return null;
        } else if (month <= 0) {
          return 'Month must be greater than 0';
        } else if (month >= 13) {
          return 'Month cannot be greater than 12';
        }
        return null;
      },
      onSaved: (String value) {
        _diagMonth = int.tryParse(value);
      },
    );
  }

  Widget _buildLastDiagYear() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Year',
        hintText: 'YYYY',
        border: OutlineInputBorder(),
        contentPadding:
        new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
      ),
      keyboardType: TextInputType.number,
      controller: _diagYearController,
      validator: (String value) {
        int year = int.tryParse(value);
        if (year == null || year < 0) {
          return 'Field Required';
        }
        return null;
      },
      onSaved: (String value) {
        _diagYear = int.tryParse(value);
      },
    );
  }

  Widget _buildCancerHistory(TextEditingController yearController,
      TextEditingController monthController) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Do you have colon cancer?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildCancerHistoryYN("colon"),
          _colon == true ? _buildColonDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Do you have rectum cancer?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildCancerHistoryYN("rectum"),
          _rectum == true ? _buildRectumDropdown() : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? SizedBox(height: 20)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                  'When was your last cancer (any type of cancer) diagnosis?',
                  style: TextStyle(fontSize: 16)),
            ),
          )
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? SizedBox(height: 10)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? Row(children: <Widget>[
            Expanded(
              child: _buildMonth("diag"),
            ),
            Expanded(
              child: _buildLastDiagYear(),
            ),
          ])
              : SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTreatmentYN(String treatment) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: treatment == "surgery"
                ? _surgery
                : treatment == "chemo"
                ? _chemo
                : _radiation,
            onChanged: (value) {
              setState(() {
                treatment == "surgery"
                    ? _surgery = value
                    : treatment == "chemo"
                    ? _chemo = value
                    : _radiation = value;
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
            groupValue: treatment == "surgery"
                ? _surgery
                : treatment == "chemo"
                ? _chemo
                : _radiation,
            onChanged: (value) {
              setState(() {
                treatment == "surgery"
                    ? _surgery = value
                    : treatment == "chemo"
                    ? _chemo = value
                    : _radiation = value;
                // Navigator.of(context, rootNavigator: true).pop();
                // _buildCancerHistory();
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildSurgeryDropdown() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: surgeryType.keys.map((String key) {
        return new CheckboxListTile(
          title: new Text(key),
          value: surgeryType[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              surgeryType[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildCancerTreatment() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had cancer surgery?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("surgery"),
          _surgery == true
              ? Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('What procedure did you have?',
                  style: TextStyle(fontSize: 16)),
            ),
          )
              : SizedBox(height: 0),
          _surgery == true ? _buildSurgeryDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had radiation therapy?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("radiation"),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had chemotherapy?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("chemo"),
          SizedBox(height: 10),
        ],
      ),
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
    _ageMonthController.text = userAgeMonth.toString();
    _ageDayController.text = userAgeDay.toString();
    _ageYearController.text = userAgeYear.toString();
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
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(2),
                isActive: currentStep >= 1,
                title: const Text('Gastrointestinal Issues'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        _buildGIIssues(),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Cancer Treatment'),
                content: Container(
                  child: Form(
                    key: formKeys[4],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        _buildCancerTreatment(),
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
                        _buildCancerHistory(
                            _diagMonthController, _diagYearController),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Personal Data'),
                state: _getState(5),
                isActive: currentStep >= 4,
                content: Container(
                  child: Form(
                    key: formKeys[0],
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Edit your birth date:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(children: <Widget>[
                          Expanded(
                            child: _buildMonth("birth"),
                          ),
                          Expanded(
                            child: _buildDay(),
                          ),
                          Expanded(
                            child: _buildBirthYear(),
                          ),
                        ]),

                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Edit your height:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildHeightFeet(),
                        SizedBox(height: 10),
                        _buildHeightInches(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What race are you?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildRace(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What is your ethnicity?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        // ethnicity,
                        _buildEthnicity(),
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
