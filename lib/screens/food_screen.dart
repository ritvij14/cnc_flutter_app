import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:flutter_picker/flutter_picker.dart';

class FoodPage extends StatefulWidget {
  Food selection;
  String selectedDate;

  FoodPage(Food selection, String selectedDate) {
    this.selection = selection;
    this.selectedDate = selectedDate;
  }

  @override
  FoodProfile createState() => FoodProfile(selection, selectedDate);
}

class FoodProfile extends State<FoodPage> {
  Food currentFood;
  String selectedDate;

  // TimeOfDay timeOfDay = TimeOfDay.now();

  bool showFat = false;
  bool showCarbs = false;

  DateTime entryTime = DateTime.now();
  double portion = 1;
  double actualPortion = 1;
  String servingAsFraction = '1';
  String actualServingAsFraction;
  int initialFirstSelection = 1;
  int initialSecondSelection = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var dropdownOptions = new Map();

  FoodProfile(Food selection, String selectedDate) {
    currentFood = selection;
    this.selectedDate = selectedDate;
    // for (double i = 0.25; i < 10; i += 0.25) {
    //   var key;
    //   if (i <= 1) {
    //     key = i.toFraction().toString();
    //   } else {
    //     key = i.toMixedFraction().toString();
    //   }
    //   dropdownOptions[key] = i;
    // }
    if (portion <= 1) {
      servingAsFraction = portion.toFraction().toString();
      actualServingAsFraction = portion.toFraction().toString();
    } else {
      servingAsFraction = portion.toMixedFraction().toString();
      actualServingAsFraction = portion.toMixedFraction().toString();
    }
    String temp = portion.toString();
    initialFirstSelection = int.parse(temp.split(".")[0]);
    temp = portion.toString().split(".")[1];
    if (double.parse(temp) == 25) {
      initialSecondSelection = 1;
    } else if (double.parse(temp) == 5) {
      initialSecondSelection = 2;
    } else if (double.parse(temp) == 75) {
      initialSecondSelection = 3;
    } else {
      initialSecondSelection = 0;
    }
  }

  var pickerData = '''
[
    [ 
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9"
    ],
    [
        "",
        "1/4",
        "1/2",
        "3/4"
    ]
]
    ''';

  showPickerModal(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(pickerData), isArray: true),
        changeToFirst: false,
        hideHeader: false,
        selecteds: [initialFirstSelection, initialSecondSelection],
        onSelect: (Picker picker, int index, List<int> selected) {
          int firstNumber = int.parse(picker.getSelectedValues()[0]);
          double secondNumber;
          if (picker.getSelectedValues()[1] == '1/4') {
            secondNumber = 0.25;
          } else if (picker.getSelectedValues()[1] == '1/2') {
            secondNumber = 0.5;
          } else if (picker.getSelectedValues()[1] == '3/4') {
            secondNumber = 0.75;
          } else {
            secondNumber = 0;
          }
          portion = secondNumber + firstNumber;
          this.setState(() {
            // stateText = picker.adapter.toString();
          });
        },
        onCancel: () {
          portion = actualPortion;
          servingAsFraction = actualServingAsFraction;
          setState(() {});
        },
        onConfirm: (Picker picker, List value) {
          int firstNumber = int.parse(picker.getSelectedValues()[0]);
          double secondNumber;
          if (picker.getSelectedValues()[1] == '1/4') {
            secondNumber = 0.25;
          } else if (picker.getSelectedValues()[1] == '1/2') {
            secondNumber = 0.5;
          } else if (picker.getSelectedValues()[1] == '3/4') {
            secondNumber = 0.75;
          } else {
            secondNumber = 0;
          }

          portion = secondNumber + firstNumber;
          String temp = portion.toString();
          initialFirstSelection = int.parse(portion.toString().split(".")[0]);
          temp = portion.toString().split(".")[1];
          if (double.parse(temp) == 25) {
            initialSecondSelection = 1;
          } else if (double.parse(temp) == 5) {
            initialSecondSelection = 2;
          } else if (double.parse(temp) == 75) {
            initialSecondSelection = 3;
          } else {
            initialSecondSelection = 0;
          }
          actualPortion = portion;
          if (portion <= 1) {
            servingAsFraction = portion.toFraction().toString();
            actualServingAsFraction = portion.toFraction().toString();
          } else {
            servingAsFraction = portion.toMixedFraction().toString();
            actualServingAsFraction = portion.toMixedFraction().toString();
          }
          setState(() {
            // saveNewEntry();
            // Navigator.pop(context, null);
          });
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  showPicker(BuildContext context) {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(pickerData), isArray: true),
        changeToFirst: false,
        hideHeader: false,
        selecteds: [initialFirstSelection, initialSecondSelection],
        onSelect: (Picker picker, int index, List<int> selected) {
          int firstNumber = int.parse(picker.getSelectedValues()[0]);
          double secondNumber;
          if (picker.getSelectedValues()[1] == '1/4') {
            secondNumber = 0.25;
          } else if (picker.getSelectedValues()[1] == '1/2') {
            secondNumber = 0.5;
          } else if (picker.getSelectedValues()[1] == '3/4') {
            secondNumber = 0.75;
          } else {
            secondNumber = 0;
          }
          portion = secondNumber + firstNumber;
          this.setState(() {
            // stateText = picker.adapter.toString();
          });
        },
        onCancel: () {
          portion = actualPortion;
          servingAsFraction = actualServingAsFraction;
          setState(() {});
        },
        onConfirm: (Picker picker, List value) {
          int firstNumber = int.parse(picker.getSelectedValues()[0]);
          double secondNumber;
          if (picker.getSelectedValues()[1] == '1/4') {
            secondNumber = 0.25;
          } else if (picker.getSelectedValues()[1] == '1/2') {
            secondNumber = 0.5;
          } else if (picker.getSelectedValues()[1] == '3/4') {
            secondNumber = 0.75;
          } else {
            secondNumber = 0;
          }

          portion = secondNumber + firstNumber;
          String temp = portion.toString();
          initialFirstSelection = int.parse(portion.toString().split(".")[0]);
          temp = portion.toString().split(".")[1];
          if (double.parse(temp) == 25) {
            initialSecondSelection = 1;
          } else if (double.parse(temp) == 5) {
            initialSecondSelection = 2;
          } else if (double.parse(temp) == 75) {
            initialSecondSelection = 3;
          } else {
            initialSecondSelection = 0;
          }
          actualPortion = portion;
          if (portion <= 1) {
            servingAsFraction = portion.toFraction().toString();
            actualServingAsFraction = portion.toFraction().toString();
          } else {
            servingAsFraction = portion.toMixedFraction().toString();
            actualServingAsFraction = portion.toMixedFraction().toString();
          }
          setState(() {
            // saveNewEntry();
            // Navigator.pop(context, null);
          });
        });
    picker.show(_scaffoldKey.currentState);
  }

  saveNewEntry() async {
    var db = new DBHelper();
    var time = entryTime.toString().substring(0, 19);
    time = time.split(" ")[1];
    var dateTime = selectedDate + " " + time;
    var response = await db.saveNewFoodLogEntry(
        dateTime, selectedDate, 1, currentFood.id, portion);
  }

  // _pickTime() async {
  //   TimeOfDay t = await showTimePicker(
  //       context: context,
  //       initialTime: timeOfDay,
  //     initialEntryMode: TimePickerEntryMode.input,
  //     helpText: 'Time of Meal'
  //     // cancelText: 'testing'
  //
  //   );
  //   if(t != null)
  //     setState(() {
  //       timeOfDay = t;
  //       print('Time of Day in food = ' + timeOfDay.toString());
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    String servingSizeAsFraction;
    if (currentFood.commonPortionSizeAmount > 1) {
      var x = currentFood.commonPortionSizeAmount.toMixedFraction();
      x.reduce();
      servingSizeAsFraction = x.toString().split(" ")[0];
    } else {
      var x = currentFood.commonPortionSizeAmount.toFraction();
      x.reduce();
      servingSizeAsFraction = x.toString();
    }

    if (showFat && showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.kcal * portion).toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Saturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.saturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Polyunsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.polyunsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Monounsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.monounsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.insolubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.solubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sugarInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Serving Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          servingSizeAsFraction +
                              // currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                              " " +
                              currentFood.commonPortionSizeUnit,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Number of Servings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            width: 150,
                            child: InkWell(
                              onTap: () => showPickerModal(context),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 35,
                                  ),
                                  child: Row(
                                    children: [
                                      Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          Text(
                                            servingAsFraction,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Icon(Icons.edit) // icon-2
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Theme.of(context).primaryColor,
                  child: RaisedButton(
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Save entry'),
                    onPressed: () {
                      saveNewEntry();
                      Navigator.pop(context, null);
                    },
                  ),
                ),
              ),
            ]),
          ));
    } else if (showFat) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.kcal * portion).toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Saturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.saturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Polyunsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.polyunsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Monounsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.monounsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Serving Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          servingSizeAsFraction +
                              // currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                              " " +
                              currentFood.commonPortionSizeUnit,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Number of Servings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            width: 150,
                            child: InkWell(
                              onTap: () => showPickerModal(context),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 35,
                                  ),
                                  child: Row(
                                    children: [
                                      Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          Text(
                                            servingAsFraction,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Icon(Icons.edit) // icon-2
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Theme.of(context).primaryColor,
                  child: RaisedButton(
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Save entry'),
                    onPressed: () {
                      saveNewEntry();
                      Navigator.pop(context, null);
                    },
                  ),
                ),
              ),
            ]),
          ));
    } else if (showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.kcal * portion).toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.insolubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.solubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sugarInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Serving Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          servingSizeAsFraction +
                              // currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                              " " +
                              currentFood.commonPortionSizeUnit,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Number of Servings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            width: 150,
                            child: InkWell(
                              onTap: () => showPickerModal(context),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 35,
                                  ),
                                  child: Row(
                                    children: [
                                      Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          Text(
                                            servingAsFraction,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Icon(Icons.edit) // icon-2
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Theme.of(context).primaryColor,
                  child: RaisedButton(
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Save entry'),
                    onPressed: () {
                      saveNewEntry();
                      Navigator.pop(context, null);
                    },
                  ),
                ),
              ),
            ]),
          ));
    } else {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(currentFood.description),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  // subtitle: Text(
                  //   currentFood.commonPortionSizeDescription
                  //       .replaceAll('"', ''),
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  trailing: Text(
                    (currentFood.kcal * portion).toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Serving Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          servingSizeAsFraction +
                              // currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                              " " +
                              currentFood.commonPortionSizeUnit,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Number of Servings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            width: 150,
                            child: InkWell(
                              // onTap: () => showPickerModal(context),
                              onTap: () => showPickerModal(context),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 35,
                                  ),
                                  child: Row(
                                    children: [
                                      Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          Text(
                                            servingAsFraction,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Icon(Icons.edit) // icon-2
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  buttonColor: Theme.of(context).primaryColor,
                  child: RaisedButton(
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Save entry'),
                    onPressed: () {
                      saveNewEntry();
                      Navigator.pop(context, null);
                    },
                  ),
                ),
              ),
            ]),
          ));
    }
  }
}
