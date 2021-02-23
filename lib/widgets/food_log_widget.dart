// import 'dart:convert';
import 'dart:convert';
import 'dart:math';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';

// import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodLog extends StatefulWidget {
  String selectedDate;

  FoodLog(String selectedDate) {
    this.selectedDate = selectedDate;
  }

  @override
  _FoodLogState createState() => _FoodLogState(selectedDate);
}

class _FoodLogState extends State<FoodLog> {
  List<Food> foods = [];
  List<FoodLogEntry> foodLogEntries = [];
  String selectedDate;
  DateTime entryTime = DateTime.now();
  double tempPortion;

  _FoodLogState(String key) {
    this.selectedDate = key;
  }

  deleteEntry(foodLogEntryId) async {
    var db = new DBHelper();
    var response = await db.deleteFoodLogEntry(foodLogEntryId);
    setState(() {});
  }

  updateEntry(foodLogEntryId) async {
    var db = new DBHelper();
    var time = entryTime.toString().substring(0, 19);
    var response =
        await db.updateFoodLogEntry(foodLogEntryId, time, tempPortion);
    setState(() {});
  }

  update(context) {
    setState(() {});
  }

  getFood() async {
    foodLogEntries.clear();
    var db = new DBHelper();
    var response = await db.getFoodLog('1', selectedDate);
    var data = json.decode(response.body);
    // print(data[0]['entryTime'].runtimeType);
    // var x = TimeOfDay.fromDateTime(data[0]['entryTime']);
    // print(x);
    // print(data);
    for (int i = 0; i < data.length; i++) {
      FoodLogEntry foodLogEntry = new FoodLogEntry();
      foodLogEntry.id = data[i]['id'];
      foodLogEntry.entryTime = data[i]['entryTime'];
      foodLogEntry.date = data[i]['date'];
      foodLogEntry.portion = data[i]['portion'];
      // print(data[i]);
      // print(data[i]['entryTime']);
      Food food = new Food();
      String description = data[i]['food']['description'].toString();
      description = description.replaceAll('"', "");
      food.description = description;
      food.kcal = data[i]['food']['kcal'];
      food.proteinInGrams = data[i]['food']['proteinInGrams'];
      food.carbohydratesInGrams = data[i]['food']['carbohydratesInGrams'];
      food.fatInGrams = data[i]['food']['fatInGrams'];
      food.alcoholInGrams = data[i]['food']['alcoholInGrams'];
      food.saturatedFattyAcidsInGrams =
          data[i]['food']['saturatedFattyAcidsInGrams'];
      food.polyunsaturatedFattyAcidsInGrams =
          data[i]['food']['polyunsaturatedFattyAcidsInGrams'];
      food.monounsaturatedFattyAcidsInGrams =
          data[i]['food']['monounsaturatedFattyAcidsInGrams'];
      food.insolubleFiberInGrams = data[i]['food']['insolubleFiberInGrams'];
      food.solubleFiberInGrams = data[i]['food']['solubleFiberInGrams'];
      food.sugarInGrams = data[i]['food']['sugarInGrams'];
      food.calciumInMilligrams = data[i]['food']['calciumInMilligrams'];
      food.sodiumInMilligrams = data[i]['food']['sodiumInMilligrams'];
      food.vitaminDInMicrograms = data[i]['food']['vitaminDInMicrograms'];
      food.commonPortionSizeAmount = data[i]['food']['commonPortionSizeAmount'];
      food.commonPortionSizeGramWeight =
          data[i]['food']['commonPortionSizeGramWeight'];
      food.commonPortionSizeDescription =
          data[i]['food']['commonPortionSizeDescription'];
      food.commonPortionSizeUnit = data[i]['food']['commonPortionSizeUnit'];
      foodLogEntry.food = food;
      foodLogEntries.add(foodLogEntry);
    }
  }

  showAlertDialog(BuildContext context, foodLogEntryId, action, portion) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        deleteEntry(foodLogEntryId);
        Navigator.of(context).pop();
      },
    );

    Widget updateButton = FlatButton(
      child: Text("Update"),
      onPressed: () {
        updateEntry(foodLogEntryId);
        Navigator.of(context).pop();
      },
    );

    if (action == "delete") {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete Entry"),
        content: Text("Are you sure?"),
        actions: [
          cancelButton,
          deleteButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Update Entry"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              child: Column(
                children: [
                  Text('Number of servings'),
                  Container(
                    width: 125,
                    child: TextFormField(
                      initialValue: portion.toString(),
                      keyboardType: TextInputType.number,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // ],
                      decoration: InputDecoration(
                        hintText: "Enter portions",
                      ),
                      onChanged: (text) {
                        tempPortion = double.parse(text);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        actions: [
          cancelButton,
          updateButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      // child: Padding:
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Meals",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "OpenSans"),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    showSearch(
                            context: context,
                            delegate: FoodSearch(selectedDate))
                        .then((value) => update(context));
                  }),
            ],
          ),
        ),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foodLogEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      showAlertDialog(context, foodLogEntries[index].id,
                          'update', foodLogEntries[index].portion);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                foodLogEntries[index].food.description,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "OpenSans"),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    foodLogEntries[index].portion.toString() +
                                        " serving(s)",
                                    // breakfast[index].serving + " " + breakfast[index].unit,
                                    // "1.0 serving(s) ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          (foodLogEntries[index]
                                                          .food
                                                          .carbohydratesInGrams *
                                                      foodLogEntries[index]
                                                          .portion)
                                                  .toStringAsFixed(2) +
                                              "C",
                                          style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontSize: 10),
                                        ),
                                        Text(
                                          (foodLogEntries[index]
                                                          .food
                                                          .proteinInGrams *
                                                      foodLogEntries[index]
                                                          .portion)
                                                  .toStringAsFixed(2) +
                                              "P",
                                          style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontSize: 10),
                                        ),
                                        Text(
                                          (foodLogEntries[index]
                                                          .food
                                                          .fatInGrams *
                                                      foodLogEntries[index]
                                                          .portion)
                                                  .toStringAsFixed(2) +
                                              "F",
                                          style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontSize: 10),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showAlertDialog(
                                                context,
                                                foodLogEntries[index].id,
                                                "delete",
                                                0);
                                            // deleteEntry(foodLogEntries[index].id);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // child: Text(
                              //   // breakfast[index].serving + " " + breakfast[index].unit,
                              //   "1.0 serving(s) ",
                              //   textAlign: TextAlign.left,
                              //   style: TextStyle(
                              //       fontFamily: "OpenSans", fontSize: 10),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 0,
                );
              },
            );
          },
          future: getFood(),
        ),
      ]),
    );
  }
}
