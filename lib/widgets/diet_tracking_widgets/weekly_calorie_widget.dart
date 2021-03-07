import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class WeeklyCalorieWidget extends StatefulWidget {
  @override
  _WeeklyCalorieWidgetState createState() => _WeeklyCalorieWidgetState();

  WeeklyCalorieWidget() {
  }
}

class _WeeklyCalorieWidgetState extends State<WeeklyCalorieWidget> {

  _WeeklyCalorieWidgetState() {
  }

  List<Food> foods = [];
  List<FoodLogEntry> foodLogEntries = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  getFood() async {
    foodLogEntries.clear();
    var db = new DBHelper();
    DateTime selectedDate;
    // for(int i = 0; i < 7; i++) {
    //   selectedDate = DateTime.now().subtract(Duration(days: i));
    //   String key = selectedDate.toString().split(" ")[0];
    //   print(key);
    //   var response = await db.getFoodLog('1', key);
    //   var data = json.decode(response.body);
    //   // print(data[0]['entryTime'].runtimeType);
    //   // var x = TimeOfDay.fromDateTime(data[0]['entryTime']);
    //   // print(x);
    //   // print(data);
    //   for (int i = 0; i < data.length; i++) {
    //     FoodLogEntry foodLogEntry = new FoodLogEntry();
    //     foodLogEntry.id = data[i]['id'];
    //     foodLogEntry.entryTime = data[i]['entryTime'];
    //     foodLogEntry.date = data[i]['date'];
    //     foodLogEntry.portion = data[i]['portion'];
    //     // print(data[i]);
    //     // print(data[i]['entryTime']);
    //     Food food = new Food();
    //     String description = data[i]['food']['description'].toString();
    //     description = description.replaceAll('"', "");
    //     food.description = description;
    //     food.kcal = data[i]['food']['kcal'];
    //     food.proteinInGrams = data[i]['food']['proteinInGrams'];
    //     food.carbohydratesInGrams = data[i]['food']['carbohydratesInGrams'];
    //     food.fatInGrams = data[i]['food']['fatInGrams'];
    //     food.alcoholInGrams = data[i]['food']['alcoholInGrams'];
    //     food.saturatedFattyAcidsInGrams =
    //     data[i]['food']['saturatedFattyAcidsInGrams'];
    //     food.polyunsaturatedFattyAcidsInGrams =
    //     data[i]['food']['polyunsaturatedFattyAcidsInGrams'];
    //     food.monounsaturatedFattyAcidsInGrams =
    //     data[i]['food']['monounsaturatedFattyAcidsInGrams'];
    //     food.insolubleFiberInGrams = data[i]['food']['insolubleFiberInGrams'];
    //     food.solubleFiberInGrams = data[i]['food']['solubleFiberInGrams'];
    //     food.sugarInGrams = data[i]['food']['sugarInGrams'];
    //     food.calciumInMilligrams = data[i]['food']['calciumInMilligrams'];
    //     food.sodiumInMilligrams = data[i]['food']['sodiumInMilligrams'];
    //     food.vitaminDInMicrograms = data[i]['food']['vitaminDInMicrograms'];
    //     food.commonPortionSizeAmount =
    //     data[i]['food']['commonPortionSizeAmount'];
    //     food.commonPortionSizeGramWeight =
    //     data[i]['food']['commonPortionSizeGramWeight'];
    //     food.commonPortionSizeDescription =
    //     data[i]['food']['commonPortionSizeDescription'];
    //     food.commonPortionSizeUnit = data[i]['food']['commonPortionSizeUnit'];
    //     foodLogEntry.food = food;
    //     foodLogEntries.add(foodLogEntry);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 55),
                  child: new CircularPercentIndicator(
                    radius: 150.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 15.0,
                    percent: 0.4,
                    center: new Column(
                      children: [
                        Padding(padding: EdgeInsets.all(20)),
                        Text(
                          "700",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.0),
                        ),
                        Center(
                          child: Text(
                            "CALORIES UNDER BUDGET",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    // backgroundColor: Colors.yellow,
                    progressColor: Colors.red,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: 0.9,
                        center: Text("90.0%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: 0.8,
                        center: Text("80.0%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
