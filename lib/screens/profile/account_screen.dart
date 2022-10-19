import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountScreen extends StatefulWidget {
  int initialProteinRatio = 0;
  int initialCarbohydrateRatio = 0;
  int initialFatRatio = 0;
  int initialWeight = 0;
  String initialActivity = '';

  AccountScreen(int initialProteinRatio, int initialCarbohydrateRatio,
      int initialFatRatio, int initialWeight, String initialActivity) {
    this.initialProteinRatio = initialProteinRatio;
    this.initialCarbohydrateRatio = initialCarbohydrateRatio;
    this.initialFatRatio = initialFatRatio;
    this.initialWeight = initialWeight;
    this.initialActivity = initialActivity;
  }

  @override
  _AccountScreenState createState() => _AccountScreenState(
      this.initialProteinRatio,
      this.initialCarbohydrateRatio,
      this.initialFatRatio,
      this.initialWeight,
      this.initialActivity);
}

class _AccountScreenState extends State<AccountScreen> {
  int initialProteinRatio = 0;
  int initialCarbohydrateRatio = 0;
  int initialFatRatio = 0;
  int initialWeight = 0;
  String initialActivity = '';
  TextEditingController weightCtl = new TextEditingController();
  TextEditingController proteinCtl = new TextEditingController();
  TextEditingController carbohydrateCtl = new TextEditingController();
  TextEditingController fatCtl = new TextEditingController();

  _AccountScreenState(int initialProteinRatio, int initialCarbohydrateRatio,
      int initialFatRatio, int initialWeight, String initialActivity) {
    this.initialProteinRatio = initialProteinRatio;
    this.initialCarbohydrateRatio = initialCarbohydrateRatio;
    this.initialFatRatio = initialFatRatio;
    this.initialWeight = initialWeight;
    this.initialActivity = initialActivity;
    weightCtl.text = this.initialWeight.toString();
    proteinCtl.text = this.initialProteinRatio.toString();
    carbohydrateCtl.text = this.initialCarbohydrateRatio.toString();
    fatCtl.text = this.initialFatRatio.toString();
    newCarbohydrates = this.initialCarbohydrateRatio;
    newProtein = this.initialProteinRatio;
    newFat = this.initialFatRatio;
    newActivity = this.initialActivity;
    newWeight = this.initialWeight;
  }

  late int newWeight;

  late int newCarbohydrates;
  late int newFat;
  late int newProtein;

  late String newActivity;
  late bool weightChanged = false;
  late bool proteinChanged = false;
  late bool carbohydrateChanged = false;
  late bool fatChanged = false;
  late bool activityChanged = false;

  final carbohydrateKey = GlobalKey<FormState>();
  final proteinKey = GlobalKey<FormState>();
  final fatKey = GlobalKey<FormState>();

  Future<void> save() async {
    bool a = carbohydrateKey.currentState!.validate();
    bool b = proteinKey.currentState!.validate();
    bool c = fatKey.currentState!.validate();
    var db = new DBHelper();
    if (a && b && c) {
      await db.saveRatios(newFat, newProtein, newCarbohydrates);
    }
    db.updateFormInfoBasic(newWeight.toString(), newActivity);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = TextButton(
      child: Text("CONFIRM", style: TextStyle(color: Colors.white)),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              if (weightChanged ||
                  activityChanged ||
                  proteinChanged ||
                  carbohydrateChanged ||
                  fatChanged) {
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
            children: [
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
                controller: weightCtl,
                validator: (String? value) {
                  if (value == null) return 'Field Required';
                  int weight = int.tryParse(value)!;
                  if (weight <= 0) {
                    return 'Weight must be greater than 0';
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    newWeight = int.tryParse(value)!;
                    if (newWeight != initialWeight) {
                      weightChanged = true;
                    } else {
                      weightChanged = false;
                    }
                  } else {
                    // newWeight = initialWeight;
                    weightChanged = false;
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
                                text: ((newCarbohydrates != null
                                                ? newCarbohydrates
                                                : 0) +
                                            (newProtein != null
                                                ? newProtein
                                                : 0) +
                                            (newFat != null ? newFat : 0))
                                        .toString() +
                                    "%",
                                style: TextStyle(
                                    color: ((newCarbohydrates != null
                                                    ? newCarbohydrates
                                                    : 0) +
                                                (newProtein != null
                                                    ? newProtein
                                                    : 0) +
                                                (newFat != null
                                                    ? newFat
                                                    : 0)) !=
                                            100
                                        ? Colors.red
                                        : Colors.green)),
                            TextSpan(
                                text: " of 100% assigned: ",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                            TextSpan(
                                text: (((newCarbohydrates != null
                                                    ? newCarbohydrates
                                                    : 0) +
                                                (newProtein != null
                                                    ? newProtein
                                                    : 0) +
                                                (newFat != null ? newFat : 0)) -
                                            100)
                                        .abs()
                                        .toString() +
                                    "%",
                                style: TextStyle(
                                    color: (((newCarbohydrates != null
                                                            ? newCarbohydrates
                                                            : 0) +
                                                        (newProtein != null
                                                            ? newProtein
                                                            : 0) +
                                                        (newFat != null
                                                            ? newFat
                                                            : 0)) -
                                                    100)
                                                .abs() !=
                                            0
                                        ? Colors.red
                                        : Colors.green)),
                            (((newCarbohydrates != null
                                                ? newCarbohydrates
                                                : 0) +
                                            (newProtein != null
                                                ? newProtein
                                                : 0) +
                                            (newFat != null ? newFat : 0)) -
                                        100) >=
                                    1
                                ? TextSpan(
                                    text: " over\n",
                                    style: TextStyle(
                                        color: Theme.of(context).hoverColor))
                                : TextSpan(
                                    text: " remaining\n",
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor))
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
                              validator: (String? value) {
                                if (value == null) return 'Field Required';
                                int carbs = int.tryParse(value)!;
                                if (newCarbohydrates + newProtein + newFat !=
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[ -.]')),
                              ],
                              onChanged: (String value) {
                                if (value.isNotEmpty) {
                                  newCarbohydrates = int.tryParse(value)!;
                                  if (newCarbohydrates !=
                                      initialCarbohydrateRatio) {
                                    carbohydrateChanged = true;
                                  } else {
                                    carbohydrateChanged = false;
                                  }
                                } else {
                                  carbohydrateChanged = false;
                                  newCarbohydrates = 0;
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
                              validator: (String? value) {
                                if (value == null) return 'Field Required';
                                int protein = int.tryParse(value)!;
                                if (newProtein + newCarbohydrates + newFat !=
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[ -.]')),
                              ],
                              onChanged: (String value) {
                                if (value.isNotEmpty) {
                                  newProtein = int.tryParse(value)!;
                                  if (newProtein != initialProteinRatio) {
                                    proteinChanged = true;
                                  } else {
                                    proteinChanged = false;
                                  }
                                } else {
                                  proteinChanged = false;
                                  newProtein = 0;
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
                              validator: (String? value) {
                                if (value == null) return 'Field Required';
                                int fat = int.tryParse(value)!;
                                if (newFat + newCarbohydrates + newProtein !=
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[ -.]')),
                              ],
                              onChanged: (String value) {
                                if (value.isNotEmpty) {
                                  newFat = int.tryParse(value)!;
                                  if (newFat != initialFatRatio) {
                                    fatChanged = true;
                                  } else {
                                    fatChanged = false;
                                  }
                                } else {
                                  fatChanged = false;
                                  newFat = 0;
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
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text("What is your usual physical activity level?",
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: 'Activity Level',
                    border: OutlineInputBorder(),
                    hintText: "Activity Level"),
                value: newActivity,
                validator: (value) => value == null ? 'Field Required' : null,
                onChanged: (String? value) {
                  if (value == null) return;
                  newActivity = value;
                  if (initialActivity != newActivity) {
                    activityChanged = true;
                  } else {
                    activityChanged = false;
                  }
                  setState(() {});
                },
                items: [
                  'Sedentary',
                  'Lightly Active',
                  'Moderately Active',
                  'Vigorously Active',
                ]
                    .map((actLevel) => DropdownMenuItem(
                        value: actLevel, child: Text("$actLevel")))
                    .toList(),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      child:
                          Text('CANCEL', style: TextStyle(color: Colors.grey)),
                      onPressed: () {
                        if (weightChanged ||
                            activityChanged ||
                            proteinChanged ||
                            carbohydrateChanged ||
                            fatChanged) {
                          showAlertDialog(context);
                        } else {
                          Navigator.pop(context, null);
                        }
                      },
                    ),
                    if ((weightChanged ||
                            activityChanged ||
                            proteinChanged ||
                            carbohydrateChanged ||
                            fatChanged) &&
                        (newFat + newProtein + newCarbohydrates == 100)) ...[
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          save();
                          _savedAlert();
                          // if (valid) {
                          //   Navigator.pop(context, null);
                          // }
                        },
                      ),
                    ],
                    if (!weightChanged &&
                            !activityChanged &&
                            !proteinChanged &&
                            !carbohydrateChanged &&
                            !fatChanged ||
                        (newFat + newProtein + newCarbohydrates != 100)) ...[
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                          ),
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
        ));
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
