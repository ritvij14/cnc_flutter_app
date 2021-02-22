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
  var d;

  _FoodLogState(String key) {
    this.selectedDate = key;
  }

  deleteEntry(foodLogEntryId) async {
    var db = new DBHelper();
    var response = await db.deleteFoodLogEntry(foodLogEntryId);
    setState(() {

    });
  }

  update() {
    setState(() {

    });
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
                    showSearch(context: context, delegate: FoodSearch(selectedDate)).then((value) =>update());
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
                  elevation: 0,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  foodLogEntries[index].portion.toString() + " serving(s)",
                                  // breakfast[index].serving + " " + breakfast[index].unit,
                                  // "1.0 serving(s) ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: "OpenSans", fontSize: 10),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                      (foodLogEntries[index]
                                                .food
                                                .carbohydratesInGrams * foodLogEntries[index].portion)
                                                .toString() +
                                            "C",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 10),
                                      ),
                                      Text(
                                        (foodLogEntries[index]
                                                .food
                                                .proteinInGrams * foodLogEntries[index].portion)
                                                .toString() +
                                            "P",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 10),
                                      ),
                                      Text(
                                          (foodLogEntries[index]
                                                .food
                                                .fatInGrams* foodLogEntries[index].portion)
                                                .toString() +
                                            "F",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 10),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deleteEntry(foodLogEntries[index].id);
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
