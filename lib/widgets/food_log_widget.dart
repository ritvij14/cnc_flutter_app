// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // rebuildAllChildren(context);
  }

  update() async {
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

  getMealTime(String c) {
    var time = DateTime.parse(c);
    var hour = time.hour == 0
        ? 12
        : time.hour <= 12
        ? time.hour
        : time.hour - 12;
    var tod = time.hour < 12 ? 'AM' : 'PM';
    return hour.toString() + ':'+time.minute.toString().padLeft(2, '0') + ' '+ tod;
  }

  getFood() async {
    foodLogEntries.clear();
    var db = new DBHelper();
    var response = await db.getFoodLog(selectedDate);
    var data = json.decode(response.body);
    // var x = TimeOfDay.fromDateTime(data[0]['entryTime']);
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
      food.nccFoodGroupCategory = data[i]['food']['nccFoodGroupCategory'];
      foodLogEntry.food = food;
      foodLogEntries.add(foodLogEntry);
    }
  }
  Icon getIcon(String category) {
    if (category == 'Vegetables and vegetable products') {
      return Icon(
        FontAwesomeIcons.carrot,
        color: getColor(category),
      );
    } else if (category == 'Meat, fish, and poultry') {
      return Icon(
        FontAwesomeIcons.drumstickBite,
        color: getColor(category),
      );
    } else if (category == 'Beverages') {
      return Icon(
        Icons.local_cafe,
        color: getColor(category),
      );
    } else if (category == 'Desserts' ||
        category == 'Candy, sugar, and sweets') {
      return Icon(
        FontAwesomeIcons.birthdayCake,
        color: getColor(category),
      );
    } else if (category == 'Grain products') {
      return Icon(
        FontAwesomeIcons.breadSlice,
        color: getColor(category),
      );
    } else if (category == 'Milk, cream, cheese, and related products') {
      return Icon(
        FontAwesomeIcons.cheese,
        color: getColor(category),
      );
    } else if (category == 'Fats, oils, and nuts') {
      return Icon(
        Icons.grain,
        color: getColor(category),
      );
    } else if (category == 'Eggs and related products') {
      return Icon(
        FontAwesomeIcons.egg,
        color: getColor(category),
      );
    } else if (category == 'Fruits and fruit products') {
      return Icon(
        FontAwesomeIcons.appleAlt,
        color: getColor(category),
      );
    } else if (category == 'Commercial entrees and dinners') {
      return Icon(
        Icons.dinner_dining,
        color: getColor(category),
      );
    } else if (category == 'Soups, gravy, and sauces') {
      return Icon(
        Icons.ramen_dining,
        color: getColor(category),
      );
    }
    // last is misc
    return Icon(
      Icons.food_bank,
      color: getColor(category),
    );
  }

  Color getColor(String category) {
    if (category == 'Vegetables and vegetable products') {
      return Colors.green[700];
    } else if (category == 'Meat, fish, and poultry') {
      return Colors.deepPurple[300];
    } else if (category == 'Beverages') {
      return Colors.teal[400];
    } else if (category == 'Desserts' ||
        category == 'Candy, sugar, and sweets') {
      return Colors.pink[300];
    } else if (category == 'Grain products') {
      return Colors.orange[300];
    } else if (category == 'Milk, cream, cheese, and related products') {
      return Colors.blue[600];
    } else if (category == 'Fats, oils, and nuts') {
      return Colors.brown[600];
    } else if (category == 'Eggs and related products') {
      return Colors.yellow[200];
    } else if (category == 'Fruits and fruit products') {
      return Colors.red;
    } else if (category == 'Commercial entrees and dinners') {
      return Colors.lightGreen[600];
    } else if (category == 'Soups, gravy, and sauces') {
      return Colors.deepOrange[400];
    }
    return Colors.indigo[400];
  }


  showAlertDialog(BuildContext context, foodLogEntryId, description, action, portion) {
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
      color: Theme.of(context).buttonColor,
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
        title: Text("Delete Entry"),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Are you sure you would like to delete this entry?:\n\n',),
              TextSpan(text:  description + " with a portion size of " + portion.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text:  '\n\nThis action cannot be undone.')
            ],
          ),
        ),

        // Text('Are you sure you would like to delete this entry?: \n\n' + description + " with a portion size of " + portion.toString()+'\n\nThis action cannot be undone.'),
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
      // padding: EdgeInsets.symmetric(vertical: 0),
      // child: Padding:
      child: Column(children: [
        // Container(
        //   padding: EdgeInsets.only(left: 5, right: 0),
        //   child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   "Meals",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16,
              //       fontFamily: "OpenSans"),
              // ),
          FlatButton(
          child: Text("View Today's Nutrient Breakdown",
          style: TextStyle(color: Colors.white)),
      color:Theme.of(context).buttonColor,
      onPressed: () {
        Navigator.of(context)
            .push(
          new MaterialPageRoute(
              builder: (_) =>
                  DailyNutritionBreakdown(foodLogEntries)),
        );
      },
    ),
              // ButtonTheme(
              //   height: 20,
              //   child: OutlineButton(
              //     borderSide: BorderSide(
              //         color: Theme.of(context).buttonColor,
              //         style: BorderStyle.solid,
              //         width: 2),
              //     onPressed: () {
              //       Navigator.of(context)
              //           .push(
              //         new MaterialPageRoute(
              //             builder: (_) =>
              //                 DailyNutritionBreakdown(foodLogEntries)),
              //       );
              //     },
              //     child: Text("View Today's Nutrient Breakdown",
              //         style: TextStyle(color: Theme.of(context).buttonColor)),
              //   ),
              // ),

            ],
          ),
        // Divider(
        //   color: Colors.grey[600],
        //   height: 0,
        //   thickness: 1,
        // ),
        // ),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // separatorBuilder: (context, index) {
              //   return Divider(
              //     color: Colors.white,
              //     height: 0,
              //     thickness: 0,
              //   );
              // },
              itemCount: foodLogEntries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   width: 15,
                      //   height: double.infinity,
                      //   child: Text(''),
                      //   color:
                      //   getColor(foodLogEntries[index].food.nccFoodGroupCategory),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                      ),
                      getIcon(foodLogEntries[index].food.nccFoodGroupCategory),
                    ],
                  ),
                  title: Text(
                    foodLogEntries[index].food.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle:   Text(
                    getPortionAsFraction(
                        foodLogEntries[index].portion)+ " ("+   (foodLogEntries[index].portion * foodLogEntries[index].food.commonPortionSizeAmount).toString() + " " + foodLogEntries[index].food.commonPortionSizeUnit + ")" ' at ' + getMealTime(foodLogEntries[index].entryTime),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showAlertDialog(
                          context,
                          foodLogEntries[index].id,
                          foodLogEntries[index].food.description,
                          "delete",
                          foodLogEntries[index].portion);
                    },

                    child: Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      new MaterialPageRoute(
                          builder: (_) =>
                              EditFoodLogEntryScreen(foodLogEntries[index].food, foodLogEntries[index].date, foodLogEntries[index].entryTime, foodLogEntries[index].portion, foodLogEntries[index].id)),
                    ).then((value) => update());
                  },
                );
              },
            );
          },
          future: getFood(),
        ),
        // Divider(
        //   color: Colors.grey[600],
        //   height: 0,
        //   thickness: 1,
        // )

      ]),
    );
  }
}