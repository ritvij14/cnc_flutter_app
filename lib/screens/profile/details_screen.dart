import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/theme/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../nutrient_ratio_screen.dart';

class DetailsScreen extends StatefulWidget {
  int proteinPercent = 0;
  int carbohydratePercent = 0;
  int fatPercent = 0;

  DetailsScreen(int carbohydrateRatio, int proteinRatio, int fatRatio) {
    carbohydratePercent = carbohydrateRatio;
    proteinPercent = proteinRatio;
    fatPercent = fatRatio;
  }

  @override
  _DetailsScreenState createState() =>
      _DetailsScreenState(carbohydratePercent, proteinPercent, fatPercent);
}

//   @override
//   _DetailsScreenState createState() => _DetailsScreenState();
// }

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController proteinCtl = new TextEditingController();
  TextEditingController carbohydrateCtl = new TextEditingController();
  TextEditingController fatCtl = new TextEditingController();

  int proteinPercent = 0;
  int carbohydratePercent = 0;
  int fatPercent = 0;

  int initialProteinPercent = 0;
  int initialCarbohydratePercent = 0;
  int initialFatPercent = 0;

  int ratioTotal = 100;
  bool wasChanged = false;
  bool valid = false;

  final carbohydrateKey = GlobalKey<FormState>();
  final proteinKey = GlobalKey<FormState>();
  final fatKey = GlobalKey<FormState>();

  _DetailsScreenState(
      int carbohydratePercent, int proteinPercent, int fatPercent) {
    this.carbohydratePercent = carbohydratePercent;
    this.proteinPercent = proteinPercent;
    this.fatPercent = fatPercent;

    this.initialCarbohydratePercent = carbohydratePercent;
    this.initialProteinPercent = proteinPercent;
    this.initialFatPercent = fatPercent;

    ratioTotal =
        this.carbohydratePercent + this.proteinPercent + this.fatPercent;
    carbohydrateCtl.text = this.carbohydratePercent.toString();
    proteinCtl.text = this.proteinPercent.toString();
    fatCtl.text = this.fatPercent.toString();
  }

  List<Step> steps;

  int _heightFeet;
  int _heightInches;
  int _weight;
  int initialWeight;

  String dropDownActivity;
  String initialActivity;

  String dropDownSurgery;
  String dropDownGender;
  String dropDownRace;
  String dropDownEthnicities;
  String dropDownFeet;
  String dropDownInches;
  String dropDownDiagMonth;

  var _dateTime;
  String buns;

  void updateRatios() async {
    bool a = carbohydrateKey.currentState.validate();
    bool b = proteinKey.currentState.validate();
    bool c = fatKey.currentState.validate();

    if (a && b && c) {
      var db = new DBHelper();
      await db.saveRatios(fatPercent, proteinPercent, carbohydratePercent);
      Navigator.pop(context, null);
      valid = true;
    }
  }

  Future<bool> setUserData() async {
    var db = new DBHelper();
    var response = await db.getUserInfo();
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
    initialActivity = data['activityLevel'].toString().replaceAll('-', ' ');
    dropDownActivity = initialActivity;
    dropDownEthnicities = data['ethnicity'].toString().replaceAll('-', ' ');
    dropDownRace = data['race'].toString().replaceAll('-', ' ');
    dropDownGender = data['gender'].toString().replaceAll('-', ' ');
    userWeight = data['weight'];
    _weight = userWeight;
    _weightController.text = userWeight.toString();

    var totalHeight = data['height'];
    dropDownInches = totalHeight.remainder(12).toString();
    _heightInches = totalHeight.remainder(12);
    var tempHeight = totalHeight / 12;
    dropDownFeet = tempHeight.truncate().toString();
    _heightFeet = tempHeight.truncate();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("CONFIRM", style: TextStyle(color: Colors.white)),
      color: Colors.blue,
      onPressed: () {
        Navigator.of(context).pop();
        closePage();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to cancel this update?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void closePage() {
    Navigator.of(context).pop();
  }


  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];

  Widget activity;


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

  var birthDate;

  submit() {
    birthDate = _dateTime;
    int height = (_heightFeet * 12) + _heightInches;

    if (_weightController.text == null || _weightController.text.isEmpty) {
      _weight = userWeight;
    }

    DBHelper db = new DBHelper();
    db.deleteUserGiIssues();
    db.updateFormInfo(
      birthDate.toString().split(" ")[0],
      dropDownRace.replaceAll(" ", "-"),
      dropDownEthnicities.replaceAll(" ", "-"),
      dropDownGender.replaceAll(" ", "-"),
      height.toString(),
      _weight.toString(),
      dropDownActivity.replaceAll(" ", "-"),
    );
  }

  final TextEditingController dateCtl = new TextEditingController();

  final TextEditingController _weightController = new TextEditingController();
  int userWeight;
  int userDiagYear;

  @override
  void initState() {
    // _weightController.text = userWeight.toString();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, projectSnap) {
          return new Scaffold(
            appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      if (wasChanged) {
                        showAlertDialog(context);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
              title: Text('Update Personal Details'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    TextFormField(
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
                        if (_weight != userWeight) {
                          wasChanged = true;
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "Macronutrient Distribution Breakdown: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [

                            // SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: "You have ",
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ((carbohydratePercent != null
                                          ? carbohydratePercent
                                          : 0) +
                                          (proteinPercent != null ? proteinPercent : 0) +
                                          (fatPercent != null ? fatPercent : 0))
                                          .toString() +
                                          "%",
                                      style: TextStyle(
                                          color: ((carbohydratePercent != null
                                              ? carbohydratePercent
                                              : 0) +
                                              (proteinPercent != null
                                                  ? proteinPercent
                                                  : 0) +
                                              (fatPercent != null ? fatPercent : 0)) !=
                                              100
                                              ? Colors.red
                                              : Colors.green)),
                                  TextSpan(
                                      text: " of 100% assigned: ",
                                      style: TextStyle(color: Theme.of(context).hintColor)),
                                  TextSpan(
                                      text: (((carbohydratePercent != null
                                          ? carbohydratePercent
                                          : 0) +
                                          (proteinPercent != null
                                              ? proteinPercent
                                              : 0) +
                                          (fatPercent != null ? fatPercent : 0)) -
                                          100)
                                          .abs()
                                          .toString() +
                                          "%",
                                      style: TextStyle(
                                          color: (((carbohydratePercent != null
                                              ? carbohydratePercent
                                              : 0) +
                                              (proteinPercent != null
                                                  ? proteinPercent
                                                  : 0) +
                                              (fatPercent != null
                                                  ? fatPercent
                                                  : 0)) -
                                              100)
                                              .abs() !=
                                              0
                                              ? Colors.red
                                              : Colors.green)),
                                  (((carbohydratePercent != null ? carbohydratePercent : 0) +
                                      (proteinPercent != null ? proteinPercent : 0) +
                                      (fatPercent != null ? fatPercent : 0)) -
                                      100) >=
                                      1
                                      ? TextSpan(
                                      text: " over\n", style: TextStyle(color: Theme.of(context).hoverColor))
                                      : TextSpan(
                                      text: " remaining\n",
                                      style: TextStyle(color: Theme.of(context).hintColor))
                                ],
                              ),
                            ),

                            Row(children: <Widget>[
                              Expanded(
                                child: Form(
                                  key: carbohydrateKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Carbohydrate %',
                                      // hintText: 'Carbs %',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: carbohydrateCtl,
                                    validator: (String value) {
                                      int carbs = int.tryParse(value);
                                      if (carbs == null) {
                                        return 'Field Required';
                                      } else if (carbohydratePercent +
                                          proteinPercent +
                                          fatPercent !=
                                          100) {
                                        return 'Values must add up to 100';
                                      } else if (carbs <= 0) {
                                        return 'Value must be greater than 0';
                                      } else if (carbs >= 99) {
                                        return 'Value must be less than 99';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                                    ],
                                    onChanged: (String value) {
                                      carbohydratePercent = int.tryParse(value);
                                      if (carbohydratePercent != initialCarbohydratePercent) {
                                        wasChanged = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Form(
                                  key: proteinKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Protein %',
                                      // hintText: 'Carbs %',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: proteinCtl,
                                    validator: (String value) {
                                      int protein = int.tryParse(value);
                                      if (protein == null) {
                                        return 'Field Required';
                                      } else if (proteinPercent +
                                          carbohydratePercent +
                                          fatPercent !=
                                          100) {
                                        return 'Values must add up to 100';
                                      } else if (protein <= 0) {
                                        return 'Value must be greater than 0';
                                      } else if (protein >= 99) {
                                        return 'Value must be less than 99';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                                    ],
                                    onChanged: (String value) {
                                      proteinPercent = int.tryParse(value);
                                      if (proteinPercent != initialProteinPercent) {
                                        wasChanged = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Form(
                                  key: fatKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Fat %',
                                      // hintText: 'Carbs %',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: fatCtl,
                                    validator: (String value) {
                                      int fat = int.tryParse(value);
                                      if (fat == null) {
                                        return 'Field Required';
                                      } else if (fatPercent +
                                          carbohydratePercent +
                                          proteinPercent !=
                                          100) {
                                        return 'Values must add up to 100';
                                      } else if (fat <= 0) {
                                        return 'Value must be greater than 0';
                                      } else if (fat >= 99) {
                                        return 'Value must be less than 99';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                                    ],
                                    onChanged: (String value) {
                                      fatPercent = int.tryParse(value);
                                      if (fatPercent != initialFatPercent) {
                                        wasChanged = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    // NutrientRatioScreen(
                    //     carbohydrateRatio, proteinRatio, fatRatio),
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
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Activity Level',
                          border: OutlineInputBorder(),
                          hintText: "Activity Level"),
                      value: dropDownActivity,
                      validator: (value) => value == null ? 'Field Required' : null,
                      onChanged: (String Value) {
                        dropDownActivity = Value;
                        if (initialActivity != dropDownActivity) {
                          wasChanged = true;
                        }
                        // setState(() {});
                      },
                      items: _activity
                          .map((actLevel) =>
                          DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
                          .toList(),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            // padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('CANCEL',
                                style: TextStyle(color: Colors.grey)),
                            onPressed: () {
                              if (wasChanged) {
                                showAlertDialog(context);
                              } else {
                                Navigator.pop(context, null);
                              }
                            },
                          ),
                          if (wasChanged && (carbohydratePercent+fatPercent+proteinPercent == 100)) ...[
                            FlatButton(
                              color: Colors.blue,
                              // padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                updateRatios();
                                submit();
                                _savedAlert();
                                // if (valid) {
                                //   Navigator.pop(context, null);
                                // }
                              },
                            ),
                          ],
                          if (!wasChanged || (carbohydratePercent+fatPercent+proteinPercent != 100)) ...[
                            FlatButton(
                                color: Colors.grey,
                                // padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () => {}),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        },
        future: setUserData());
  }
}
