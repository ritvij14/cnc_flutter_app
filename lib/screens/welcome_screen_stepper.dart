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

  int _year = 0;
  int _month = 0;
  int _day = 0;

  Widget birthDay;
  Widget birthMonth;
  Widget birthYear;

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
        print("SAVING MONTH");
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

  int _heightFeet = 0;
  int _heightInches = 0;
  Widget heightFeet;
  Widget heightInches;

  Widget _buildHeightFeet() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Feet',
        hintText: 'ft',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
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

  String dropDownRace;
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
    'Not of Hispanic, Latino, or Spanish origin',
    'Mexican, Mexican Am., Chicano',
    "Puerto Rican",
    'Cuban',
    'Two or more Hispanic, Latino, or Spanish origin ethnicities',
    'Other Hispanic, Latino, or Spanish origin',
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

  String dropDownColon;
  String dropDownRectum;

  bool _colon = false;
  bool _rectum = false;
  bool _surgery = false;
  bool _chemo = false;
  bool _radiation = false;

  Map<String, bool> surgeryType = {
    'Colectomy': false,
    'Ileostomy': false,
    'Polypectomy': false,
    'Other': false,
  };

  List<String> _colonStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  Widget cancerHistory;

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
      items: _colonStages
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
      items: _colonStages
          .map((recStage) =>
              DropdownMenuItem(value: recStage, child: Text("$recStage")))
          .toList(),
    );
  }

  int _diagYear = 0;
  int _diagMonth = 0;
  Widget lastDiag;

  Widget _buildLastDiagMonth() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Month(optional)',
        hintText: 'MM',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
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
              ? _buildLastDiagMonth()
              : SizedBox(height: 10),
          _rectum == true || _colon == true
              ? SizedBox(height: 10)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? _buildLastDiagYear()
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

  Widget cancerTreatment;

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

  _successfulAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form successfully submitted'),

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
    // for (int i = 0; i < formKeys.length; i++) {
    //   if (!formKeys[i].currentState.validate()) {
    //     StepState.error;
    //   }
    // }
    setState(() => currentStep = step);
  }

  var birthDate;
  var lastDiagDate;

  submit() {
    birthDate = new DateTime(_year, _month, _day);
    lastDiagDate = new DateTime(_diagYear, _diagMonth, 1);
    int height = (_heightFeet * 12) + _heightInches;
    String checkedSurgeryTypes = "";

    for (var key in surgeryType.keys) {
      if (surgeryType[key]) {
        if (checkedSurgeryTypes == "") {
          checkedSurgeryTypes = key;
        } else {
          checkedSurgeryTypes += "," + key;
        }
      }
    }
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

    String colonStage = "-1";
    String rectumStage = "-1";
    if (_colon) {
      colonStage = dropDownColon.substring(6, 6);
    }

    if (_rectum) {
      rectumStage = dropDownRectum.substring(6, 6);
    }

    DBHelper db = new DBHelper();

    db.saveFormInfo(
        "1",
        birthDate.toString().split(" ")[0],
        dropDownRace.replaceAll(" ", "-"),
        dropDownEthnicities.replaceAll(" ", "-"),
        height.toString(),
        _weight.toString(),
        dropDownActivity.replaceAll(" ", "-"),
        gIIssues,
        _colon.toString(),
        colonStage,
        _rectum.toString(),
        rectumStage,
        lastDiagDate.toString().split(" ")[0],
        _surgery.toString(),
        _radiation.toString(),
        _chemo.toString(),
        checkedSurgeryTypes);


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
    birthDay = _buildBirthDay();
    birthMonth = _buildBirthMonth();
    birthYear = _buildBirthYear();
    heightFeet = _buildHeightFeet();
    heightInches = _buildHeightInches();
    weight = _buildWeight();
    race = _buildRace();
    ethnicity = _buildEthnicity();
    activity = _buildActivity();
    GIIssues = _buildGIIssues();
    cancerHistory = _buildCancerHistory();
    cancerTreatment = _buildCancerTreatment();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
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
                        // BirthdayFormWidget(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Please enter your birth date:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        birthMonth,
                        SizedBox(height: 10),
                        birthDay,
                        SizedBox(height: 10),
                        birthYear,
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What race are you?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        race,
                        // RaceDropdownWidget(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What is your ethnicity?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        ethnicity,
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
                        heightFeet,
                        SizedBox(height: 10),
                        heightInches,
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
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Gastrointestinal Issues'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        GIIssues,
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
                        // CancerHistoryWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(5),
                isActive: currentStep >= 4,
                title: const Text('Cancer Treatment'),
                content: Container(
                  child: Form(
                    key: formKeys[4],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        cancerTreatment,
                        // CancerTreatmentWidget(),
                      ],
                    ),
                  ),
                ),
              )
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
          ),
        ),
      ]),
    );
  }
}
