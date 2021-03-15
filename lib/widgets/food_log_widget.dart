// import 'dart:convert';
import 'dart:convert';
import 'dart:math';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/screens/daily_nutrition_breakdown_screen.dart';
import 'package:cnc_flutter_app/screens/edit_food_entry_screen.dart';

// import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraction/fraction.dart';

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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  getPortionAsFraction(double portion) {
    String servingAsFraction;
    if (portion <= 1 || portion % 1 == 0) {
      servingAsFraction = portion.toFraction().toString();
    } else {
      servingAsFraction = portion.toMixedFraction().toString();
    }
    if (portion == 1) {
      servingAsFraction += ' serving';
    } else {
      servingAsFraction += ' servings';
    }
    return servingAsFraction;
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
      child: Text("CANCEL",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("DELETE",
          style: TextStyle(color: Colors.white)),
      color: Colors.blue,
      onPressed: () {
        deleteEntry(foodLogEntryId);
        Navigator.of(context).pop();
      },
    );

    Widget updateButton = FlatButton(
      child: Text("UPDATE",
          style: TextStyle(color: Colors.white)),
      color: Colors.blue,
      onPressed: () {
        updateEntry(foodLogEntryId);
        Navigator.of(context).pop();
      },
    );

    if (action == "delete") {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Are you sure you would like to delete this entry?"),
        content: Text(foodLogEntryId + " with a portion size of " + portion),
        actions: [
          deleteButton,
          cancelButton,
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
          updateButton,
          cancelButton,
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

  showInfoDialog(BuildContext context, Food food, portion) {
    // set up the buttons
    Widget closeButton = FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(food.description),
      content: SingleChildScrollView(
        child: Container(
          width: 100,
          child: ListBody(
            children: <Widget>[
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (food.kcal * portion).round().toString(),
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Ink(
                child: ListTile(
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (food.carbohydratesInGrams * portion).round().toString() +
                        'g',
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (food.proteinInGrams * portion).round().toString() +
                        'g',
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    (food.fatInGrams * portion).round().toString() +
                        'g',
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        closeButton,
      ],
    );

    // AlertDialog alert = AlertDialog(
    //   title: Text(food.description),
    //   content: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //           width: 100,
    //           // height: 80,
    //           child: ListTile(
    //             title: Text(
    //               'Protein ',
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontStyle: FontStyle.italic),
    //             ),
    //             trailing: Text(
    //               (food.proteinInGrams * portion).toStringAsFixed(2) +
    //                   'g',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    //   actions: [
    //     closeButton,
    //   ],
    // );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 0),
      // child: Padding:
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   "Meals",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16,
              //       fontFamily: "OpenSans"),
              // ),
              ButtonTheme(
                height: 20,
                child: OutlineButton(
                  borderSide: BorderSide(
                      color: Theme.of(context).buttonColor,
                      style: BorderStyle.solid,
                      width: 2),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      new MaterialPageRoute(
                          builder: (_) =>
                              DailyNutritionBreakdown(foodLogEntries)),
                    );
                  },
                  child: Text("Nutrient Breakdown",
                      style: TextStyle(color: Theme.of(context).buttonColor)),
                ),
              ),
              // FlatButton(
              //   // textColor: Colors.white,
              //   onPressed: () {
              //     Navigator.of(context)
              //         .push(
              //       new MaterialPageRoute(
              //           builder: (_) =>
              //               DailyNutritionBreakdown(foodLogEntries)),
              //     );
              //   },
              //   child: Text("Nutrient Breakdown"),
              //   shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context)
              //         .push(
              //       new MaterialPageRoute(
              //           builder: (_) =>
              //               DailyNutritionBreakdown(foodLogEntries)),
              //     );
              //   },
              //   child: Text(
              //     "Nutrient Breakdown",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 16,
              //         fontFamily: "OpenSans"),
              //   ),
              // ),
              // IconButton(
              //     icon: Icon(Icons.add_circle),
              //     onPressed: () {
              //       showSearch(
              //               context: context,
              //               delegate: FoodSearch(selectedDate))
              //           .then((value) => update(context));
              //     }),
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
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    onTap: () {
                      showInfoDialog(context, foodLogEntries[index].food,
                          foodLogEntries[index].portion);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
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
                                    color: Theme.of(context).highlightColor,
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
                                    getPortionAsFraction(
                                        foodLogEntries[index].portion),
                                    // foodLogEntries[index].portion.toString() +
                                    //     " serving(s)",
                                    // breakfast[index].serving + " " + breakfast[index].unit,
                                    // "1.0 serving(s) ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 12,
                                        color:
                                            Theme.of(context).highlightColor),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        //       Text(
                                        //         (foodLogEntries[index]
                                        //             .food
                                        //             .carbohydratesInGrams *
                                        //             foodLogEntries[index]
                                        //                 .portion)
                                        //             .toStringAsFixed(2) +
                                        //             "C",
                                        //         style: TextStyle(
                                        //             fontFamily: "OpenSans",
                                        //             fontSize: 12,
                                        //           color: Theme.of(context).highlightColor,
                                        //         ),
                                        //       ),
                                        //       Text(
                                        //         (foodLogEntries[index]
                                        //             .food
                                        //             .proteinInGrams *
                                        //             foodLogEntries[index]
                                        //                 .portion)
                                        //             .toStringAsFixed(2) +
                                        //             "P",
                                        //         style: TextStyle(
                                        //             fontFamily: "OpenSans",
                                        //             fontSize: 12,
                                        //           color: Theme.of(context).highlightColor,),
                                        //
                                        //       ),
                                        //       Text(
                                        //         (foodLogEntries[index]
                                        //             .food
                                        //             .fatInGrams *
                                        //             foodLogEntries[index]
                                        //                 .portion)
                                        //             .toStringAsFixed(2) +
                                        //             "F",
                                        //         style: TextStyle(
                                        //             fontFamily: "OpenSans",
                                        //             fontSize: 12,
                                        //           color: Theme.of(context).highlightColor,),
                                        //       ),
                                        GestureDetector(

                                          onTap: () {
                                            Navigator.of(context)
                                                .push(
                                              new MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditFoodLogEntryScreen(foodLogEntries[index].food, foodLogEntries[index].date, foodLogEntries[index].entryTime, foodLogEntries[index].portion, foodLogEntries[index].id)),
                                            ).then((value) => update(context));
                                            // ).then((value) => rebuildAllChildren(context));
                                          },
                                          // onTap: () {
                                          //   showAlertDialog(
                                          //       context,
                                          //       foodLogEntries[index].id,
                                          //       'update',
                                          //       foodLogEntries[index].portion);
                                          // },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Theme.of(context)
                                                .highlightColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showAlertDialog(
                                                context,
                                                foodLogEntries[index].food.description,
                                                "delete",
                                                foodLogEntries[index].portion);
                                            // deleteEntry(foodLogEntries[index].id);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Theme.of(context)
                                                .highlightColor,
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
