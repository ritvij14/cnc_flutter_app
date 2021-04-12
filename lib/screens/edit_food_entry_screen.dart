import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraction/fraction.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class EditFoodLogEntryScreen extends StatefulWidget {
  Food selection;
  String selectedDate;
  String entryTime;
  double portion;
  num id;

  EditFoodLogEntryScreen(Food selection, String selectedDate, String entryTime,
      double portion, num id) {
    this.selection = selection;

    this.selectedDate = selectedDate;
    this.entryTime = entryTime;
    this.portion = portion;
    this.id = id;
  }

  @override
  _EditFoodLogEntry createState() =>
      _EditFoodLogEntry(selection, selectedDate, entryTime, portion, id);
}

class _EditFoodLogEntry extends State<EditFoodLogEntryScreen> {
  Food currentFood;
  String selectedDate;
  String title;
  String subtitle = '';
  double titleBottomPadding = 20;

  bool showFat = false;
  bool showCarbs = false;
  bool showFraction = true;
  bool switched = false;
  bool wasChanged = false;
  String entryTimeAsString;
  double portion;
  num id;

  DateTime entryTime = DateTime.now();

  // DateTime entryTime = new DateTime(1, 1, 1, 13, 29);
  double actualPortion = 1;
  String servingAsFraction = '1';
  String actualServingAsFraction;
  int initialFirstSelection = 1;
  int initialSecondSelection = 0;
  int initialTimeFirstSelection = 1;
  int initialTimeSecondSelection = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController portionCtl = new TextEditingController();
  final TextEditingController dateCtl = new TextEditingController();

  var dropdownOptions = new Map();

  _EditFoodLogEntry(Food selection, String selectedDate,
      String entryTimeAsString, double portion, num id) {
    currentFood = selection;
    this.selectedDate = selectedDate;
    this.entryTimeAsString = entryTimeAsString;
    this.portion = portion;
    this.id = id;

    entryTime = DateTime.parse(entryTimeAsString);

    if (portion <= 1 || portion % 1 == 0) {
      servingAsFraction = portion.toFraction().toString();
      actualServingAsFraction = portion.toFraction().toString();
    } else {
      servingAsFraction = portion.toMixedFraction().toString();
      actualServingAsFraction = portion.toMixedFraction().toString();
    }
    portionCtl.text = actualServingAsFraction;
    String hour = '';
    String minute = '';
    String tod = '';
    if (entryTime.hour == 12) {
      hour = entryTime.hour.toString();
      tod = 'PM';
    } else if (entryTime.hour > 12) {
      hour = (entryTime.hour - 12).toString();
      tod = 'PM';
    } else {
      hour = entryTime.hour.toString();
      if (entryTime.hour == 0) {
        hour = '12';
      }
      tod = 'AM';
    }
    if (entryTime.minute < 10) {
      minute = '0' + entryTime.minute.toString();
    } else {
      minute = entryTime.minute.toString();
    }

    dateCtl.text = hour + ':' + minute + ' ' + tod;

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

    if (currentFood.description.contains(',')) {
      title = currentFood.description.split(',')[0];
      title = title.capitalizeFirstofEach;
      int firstCommaIndex = currentFood.description.indexOf(',');
      subtitle = currentFood.description
          .substring(firstCommaIndex + 2, currentFood.description.length);
      subtitle = subtitle.capitalizeFirstofEach;
      titleBottomPadding = 0;
    } else {
      title = currentFood.description;
      title = title.capitalizeFirstofEach;
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
          portionCtl.text = actualServingAsFraction;
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
          if (portion <= 1 || portion % 1 == 0) {
            servingAsFraction = portion.toFraction().toString();
            actualServingAsFraction = portion.toFraction().toString();
          } else {
            servingAsFraction = portion.toMixedFraction().toString();
            actualServingAsFraction = portion.toMixedFraction().toString();
          }
          portionCtl.text = actualServingAsFraction;
          wasChanged = true;
          setState(() {});
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  updateEntry() async {
    var db = new DBHelper();
    var time = entryTime.toString().substring(0, 19);
    time = time.split(" ")[1];
    await db.updateFoodLogEntry(this.id, entryTime.toString(), portion);
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime:
        new TimeOfDay(hour: entryTime.hour, minute: entryTime.minute),
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: 'Time of Meal'
      // cancelText: 'testing'
    );

    if (t != null)
      setState(() {
        String hour = '';
        String minute = '';
        String tod = '';
        if (t.hour == 12) {
          hour = t.hour.toString();
          tod = 'PM';
        } else if (t.hour > 12) {
          hour = (t.hour - 12).toString();
          tod = 'PM';
        } else {
          hour = t.hour.toString();
          if (t.hour == 0) {
            hour = '12';
          }
          tod = 'AM';
        }
        if (t.minute < 10) {
          minute = '0' + t.minute.toString();
        } else {
          minute = t.minute.toString();
        }

        dateCtl.text = hour + ':' + minute + ' ' + tod;
        entryTime = new DateTime(
            entryTime.year, entryTime.month, entryTime.day, t.hour, t.minute);
      });
  }

  getIcon(x) {
    if (x) {
      return Icon(Icons.keyboard_arrow_up);
    }
    Icon(Icons.keyboard_arrow_down);
  }

  void closePage() {
    Navigator.of(context).pop();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
        child: const Text(
          'CANCEL',
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
    Widget confirmButton = FlatButton(
        child: const Text('CONFIRM', style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.grey[800],
        onPressed: () {
          Navigator.of(context).pop();
          closePage();
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:  Text("Are you sure you want to cancel this update?"),
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


  @override
  Widget build(BuildContext context) {
    String servingSizeAsFraction;
    if (switched) {
      if (portion <= 1 || portion % 1 == 0) {
        servingAsFraction = portion.toFraction().toString();
        actualServingAsFraction = portion.toFraction().toString();
      } else {
        servingAsFraction = portion.toMixedFraction().toString();
        actualServingAsFraction = portion.toMixedFraction().toString();
      }
      portionCtl.text = actualServingAsFraction;
    }

    if (currentFood.commonPortionSizeAmount > 1) {
      var x = currentFood.commonPortionSizeAmount.toMixedFraction();
      x.reduce();
      servingSizeAsFraction = x.toString().split(" ")[0];
    } else {
      var x = currentFood.commonPortionSizeAmount.toFraction();
      x.reduce();
      servingSizeAsFraction = x.toString();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if(wasChanged) {
              showAlertDialog(context);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text('Edit Entry'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(currentFood.description,
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),

              Padding(
                padding: EdgeInsets.only(
                    top: 15, bottom: titleBottomPadding, left: 10, right: 10),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),

              if (subtitle != '') ...[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 20, left: 10, right: 10),
                  child: Text(
                    subtitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              Expanded(
                child: Container(
                  height: 200,
                  child: ListView(
                    children: [
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.grey),
                        child: DataTable(
                          horizontalMargin:
                          MediaQuery.of(context).size.width / 12,
                          headingRowHeight: 0,
                          dataRowHeight: 30,
                          dividerThickness: 0,
                          dataTextStyle:
                          TextStyle(fontSize: 20, color: Colors.black),
                          // columnSpacing: MediaQuery.of(context).size.width/ 3,

                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                '',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Calories',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                                DataCell(Text(
                                    (currentFood.kcal * portion)
                                        .round()
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Total Fat',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      Text(
                                        (currentFood.fatInGrams * portion)
                                            .round()
                                            .toString() +
                                            'g',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (showFat) ...[
                                        GestureDetector(
                                            onTap: () {
                                              showFat = !showFat;
                                              setState(() {});
                                            },
                                            child:
                                            Icon(Icons.keyboard_arrow_up))
                                      ],
                                      if (!showFat) ...[
                                        GestureDetector(
                                            onTap: () {
                                              showFat = !showFat;
                                              setState(() {});
                                            },
                                            child:
                                            Icon(Icons.keyboard_arrow_down))
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (showFat) ...[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Saturated Fats')),
                                  DataCell(Text(
                                      (currentFood.saturatedFattyAcidsInGrams *
                                          portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Polyunsaturated Fats')),
                                  DataCell(Text(
                                      (currentFood.polyunsaturatedFattyAcidsInGrams *
                                          portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Monounsaturated Fats')),
                                  DataCell(Text(
                                      (currentFood.monounsaturatedFattyAcidsInGrams *
                                          portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                            ],
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Total Carbs                       ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      Text(
                                        (currentFood.fatInGrams * portion)
                                            .round()
                                            .toString() +
                                            'g',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (showCarbs) ...[
                                        GestureDetector(
                                            onTap: () {
                                              showCarbs = !showCarbs;
                                              setState(() {});
                                            },
                                            child:
                                            Icon(Icons.keyboard_arrow_up))
                                      ],
                                      if (!showCarbs) ...[
                                        GestureDetector(
                                            onTap: () {
                                              showCarbs = !showCarbs;
                                              setState(() {});
                                            },
                                            child:
                                            Icon(Icons.keyboard_arrow_down))
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (showCarbs) ...[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Insoluble Fiber')),
                                  DataCell(Text(
                                      (currentFood.insolubleFiberInGrams *
                                          portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Soluble Fiber')),
                                  DataCell(Text(
                                      (currentFood.solubleFiberInGrams *
                                          portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('  Sugars')),
                                  DataCell(Text(
                                      (currentFood.sugarInGrams * portion)
                                          .round()
                                          .toString() +
                                          'g')),
                                ],
                              ),
                            ],
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Protein',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  (currentFood.proteinInGrams * portion)
                                      .round()
                                      .toString() +
                                      'g',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Alcohol',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  (currentFood.alcoholInGrams * portion)
                                      .round()
                                      .toString() +
                                      'g',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Calcium',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  (currentFood.calciumInMilligrams * portion)
                                      .round()
                                      .toString() +
                                      'mg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Sodium',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  (currentFood.sodiumInMilligrams * portion)
                                      .round()
                                      .toString() +
                                      'mg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  'Vitamin D',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  (currentFood.vitaminDInMicrograms * portion)
                                      .round()
                                      .toString() +
                                      'mcg',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                child: Column(
                  children: [
                    if (showFraction) ...[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    showFraction = true;
                                    switched = true;
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Fractions",
                                    style: TextStyle(
                                        color: Theme.of(context).highlightColor),
                                  ),
                                )),
                            Expanded(
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).buttonColor,
                                      style: BorderStyle.solid,
                                      width: 2),
                                  onPressed: () {
                                    showFraction = false;
                                    switched = true;
                                    setState(() {});
                                  },
                                  child: Text("Decimal",
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor)),
                                )),
                          ]),
                    ],
                    if (!showFraction) ...[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).buttonColor,
                                      style: BorderStyle.solid,
                                      width: 2),
                                  onPressed: () {
                                    showFraction = true;
                                    switched = true;
                                    setState(() {});
                                  },
                                  child: Text("Fraction",
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor)),
                                )),
                            Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    showFraction = false;
                                    switched = true;
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Decimal",
                                    style: TextStyle(
                                        color: Theme.of(context).highlightColor),
                                  ),
                                )),
                          ]),
                    ],
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
                              if (showFraction) ...[
                                GestureDetector(
                                  onTap: () => showPickerModal(context),
                                  child: Container(
                                    color: Colors.grey[300],
                                    width: 175,
                                    child: TextFormField(
                                      enabled: false,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                      controller: portionCtl,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.only(bottom: 3, top: 5),
                                        hintText: "# of servings",
                                        isDense: true,
                                      ),
                                      onChanged: (text) {},
                                    ),
                                  ),
                                ),
                              ],
                              if (!showFraction) ...[
                                Container(
                                  color: Colors.grey[300],
                                  width: 175,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      // height: 2.0,
                                      // color: Colors.black
                                    ),
                                    initialValue:
                                    actualPortion.toStringAsFixed(2),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                      FilteringTextInputFormatter.deny(
                                          new RegExp('[ -]')),
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}'))
                                    ],
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                        decimal: true),
                                    // keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 3, top: 5),
                                      hintText: "# of servings",
                                      isDense: true,
                                      // border: InputBorder.none
                                    ),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        if (double.parse(text) > 10) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Value cannot be greater than 10')));
                                          // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Value cannot be greater than 10')));
                                          // portion = 1;
                                          // actualPortion = portion;
                                          //snack bar portion cannot be greater than 10
                                        } else {
                                          portion = double.parse(text);
                                          actualPortion = portion;
                                          initialFirstSelection =
                                              portion.floor();
                                          if (portion % 1 < 0.25) {
                                            initialSecondSelection = 0;
                                          } else if (portion % 1 < 0.5) {
                                            initialSecondSelection = 1;
                                          } else if (portion % 1 < 0.75) {
                                            initialSecondSelection = 2;
                                          } else {
                                            initialSecondSelection = 3;
                                          }
                                          wasChanged = true;
                                        }
                                      } else {
                                        portion = 1;
                                        actualPortion = portion;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                              SizedBox(height: 8),
                              Text(
                                'Time eaten',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: _pickTime,
                                child: Container(
                                  color: Colors.grey[300],
                                  width: 175,
                                  child: TextFormField(
                                    enabled: false,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    controller: dateCtl,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 3, top: 5),
                                      hintText: "Enter time",
                                      isDense: true,
                                    ),
                                    onChanged: (text) {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
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
                              if(wasChanged) {
                                showAlertDialog(context);
                              } else {
                                Navigator.pop(context, null);
                              }
                            },
                          ),
                          if(wasChanged) ... [
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
                                updateEntry();
                                Navigator.pop(context, null);
                              },
                            ),
                          ],

                          if(!wasChanged) ... [
                            FlatButton(
                                color: Colors.grey,
                                // padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () => {

                                }
                            ),
                          ],

                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 25))
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
