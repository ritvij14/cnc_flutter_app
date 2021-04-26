import 'dart:developer';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/activity_model.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/diet_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodLogEntry> dayFoodLogEntryList = [];
  List<ActivityModel> dayActivityList = [];
  List<MetricModel> dayMetricList = [];
  List<SymptomModel> daySymptomList = [];

  refresh() {
    setState(() {
      // getDailyActivity();
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile')
                  .then((value) => rebuildAllChildren(context));
            },
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme.of(context).accentColor,
        children: [
          SpeedDialChild(
              child: Icon(Icons.food_bank),
              label: 'Log Food',
              onTap: () {
                showSearch(
                        context: context,
                        delegate: FoodSearch(DateTime.now().toString()))
                    .then((value) => setState(() {
                          rebuildAllChildren(context);
                          refresh();
                        }));
              }),

          // Navigator.pushNamed(context, '/inputActivity');
          SpeedDialChild(
              child: Icon(Icons.directions_run),
              label: 'Log Activity',
              onTap: () async {
                await Navigator.pushNamed(context, '/inputActivity')
                    .then((value) => setState(() {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("$value")));
                        }));
              }),
          SpeedDialChild(
              child: Icon(Icons.thermostat_outlined),
              label: 'Log Symptoms',
              onTap: () async {
                await Navigator.pushNamed(context, '/inputSymptom')
                    .then((value) => setState(() {
                          refresh();
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("$value")));
                        }));
              }),
          SpeedDialChild(
              child: Icon(Icons.question_answer),
              label: 'Log Questions',
              onTap: () {
                Navigator.pushNamed(context, '/questions');
              }),
          SpeedDialChild(
              child: Icon(MdiIcons.scale),
              label: 'Log Weight',
              onTap: () async {
                await Navigator.pushNamed(context, '/inputMetric')
                    .then((value) => setState(() {
                          refresh();

                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("$value")));
                        }));
              }),
          // SpeedDialChild(
          //     child: Icon(MdiIcons.abTesting),
          //     label: 'Test',
          //     onTap: () {
          //       Navigator.pushNamed(context, '/tests');
          //     }),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ListView(
            children: [
              DietSummaryWidget(),
              // HomeSummaryCardWidget('food', dayFoodLogEntryList),
              Card(
                child: FutureBuilder(
                    future: getDailyFood(),
                    builder: (context, projectSnap) {
                      return Column(
                        children: [
                          ExpansionTile(
                            title: Text('Daily Diet Summary'),
                            subtitle: dayFoodLogEntryList.length == 0
                                ? Text('No food tracked today!')
                                : dayFoodLogEntryList.length == 1
                                    ? Text(
                                        dayFoodLogEntryList.length.toString() +
                                            ' item totaling ' +
                                            getDayFoodCalories().toString() +
                                            ' calories.')
                                    : Text(
                                        dayFoodLogEntryList.length.toString() +
                                            ' items totaling ' +
                                            getDayFoodCalories().toString() +
                                            ' calories.'),
                            // subtitle: (dayFoodLogEntryList.length() == 0) ? Text(dayFoodLogEntryList.length.toString() + ' items totaling ' + getDayFoodCalories().toString() +  ' calories.'),
                            children: getDailyFoodChildren(),
                          ),
                        ],
                      );
                    }),
              ),
              Card(
                child: FutureBuilder(
                    future: getDailyActivity(),
                    builder: (context, projectSnap) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                          ),
                          Text(
                            "Daily Activity Summary",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          ExpansionTile(
                            title: dayActivityList.length == 0
                                ? Text(
                                    "No activities tracked today!",
                                  )
                                : Text(dayActivityList.length.toString() +
                                    " Activities Logged - " +
                                    getDayActivityMinutes().toString() +
                                    " Minutes"),
                            // subtitle: dayActivityList.length == 0 ? Text(
                            //     "No activities tracked!") : Text(dayActivityList
                            //     .length.toString() + " activities logged."),
                            children: getDailyActivityChildren(),
                          ),
                        ],
                      );
                    }),
              ),
              Card(
                child: FutureBuilder(
                    future: getDailyWeight(),
                    builder: (context, projectSnap) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                          ),
                          Text(
                            "Daily Weight Summary",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          ExpansionTile(
                            title: dayMetricList.length == 0
                                ? Text("No Weight Logged Today!")
                                : dayMetricList.length == 1
                                    ? Text(dayMetricList.length.toString() +
                                        " Weight Logged")
                                    : Text(dayMetricList.length.toString() +
                                        " Weights Logged"),
                            // subtitle: dayActivityList.length == 0 ? Text(
                            //     "No activities tracked!") : Text(dayActivityList
                            //     .length.toString() + " activities logged."),
                            children: getDailyWeightChildren(),
                          ),
                        ],
                      );
                    }),
              ),
              Card(
                child: FutureBuilder(
                    future: getDailySymptom(),
                    builder: (context, projectSnap) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                          ),
                          Text(
                            "Daily Symptom Summary",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          ExpansionTile(
                            title: daySymptomList.length == 0
                                ? Text("No Symptoms Logged Today!")
                                : daySymptomList.length == 1
                                    ? Text("1 Symptom logged")
                                    : Text(daySymptomList.length.toString() +
                                        " Symptoms Logged"),
                            // subtitle: dayActivityList.length == 0 ? Text(
                            //     "No activities tracked!") : Text(dayActivityList
                            //     .length.toString() + " activities logged."),
                            children: getDailySymptomChildren(),
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: WeeklyCalorieWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: MetricSummaryWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ActivitySummaryWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SymptomSummaryWidget(),
              // ),
              // Container(
              //   height: 50,
              // ),
            ],
          )),
    );
  }

  getDailyFood() async {
    List<FoodLogEntry> newFoodLogEntry = [];
    DBHelper db = new DBHelper();
    var response = await db.getFoodLog(DateTime.now().toIso8601String());
    var data = json.decode(response.body);
    for (int i = 0; i < data.length; i++) {
      FoodLogEntry foodLogEntry = new FoodLogEntry();
      foodLogEntry.portion = data[i]['portion'];
      Food food = new Food();
      String description = data[i]['food']['description'].toString();
      description = description.replaceAll('"', "");
      food.description = description;

      food.kcal = data[i]['food']['kcal'];
      // food.proteinInGrams = data[i]['food']['proteinInGrams'];
      // food.carbohydratesInGrams = data[i]['food']['carbohydratesInGrams'];
      // food.fatInGrams = data[i]['food']['fatInGrams'];
      // food.alcoholInGrams = data[i]['food']['alcoholInGrams'];
      // food.saturatedFattyAcidsInGrams =
      // data[i]['food']['saturatedFattyAcidsInGrams'];
      // food.polyunsaturatedFattyAcidsInGrams =
      // data[i]['food']['polyunsaturatedFattyAcidsInGrams'];
      // food.monounsaturatedFattyAcidsInGrams =
      // data[i]['food']['monounsaturatedFattyAcidsInGrams'];
      // food.insolubleFiberInGrams = data[i]['food']['insolubleFiberInGrams'];
      // food.solubleFiberInGrams = data[i]['food']['solubleFiberInGrams'];
      // food.sugarInGrams = data[i]['food']['sugarInGrams'];
      // food.calciumInMilligrams = data[i]['food']['calciumInMilligrams'];
      // food.sodiumInMilligrams = data[i]['food']['sodiumInMilligrams'];
      // food.vitaminDInMicrograms = data[i]['food']['vitaminDInMicrograms'];
      // food.commonPortionSizeAmount = data[i]['food']['commonPortionSizeAmount'];
      // food.commonPortionSizeGramWeight =
      // data[i]['food']['commonPortionSizeGramWeight'];
      // food.commonPortionSizeDescription =
      // data[i]['food']['commonPortionSizeDescription'];
      // food.commonPortionSizeUnit = data[i]['food']['commonPortionSizeUnit'];
      // food.nccFoodGroupCategory = data[i]['food']['nccFoodGroupCategory'];
      foodLogEntry.food = food;
      newFoodLogEntry.add(foodLogEntry);
    }
    dayFoodLogEntryList = newFoodLogEntry;
  }

  getDailyActivity() async {
    ActivityDBHelper db = new ActivityDBHelper();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getDayActivityList(int.parse(id));
    List<ActivityModel> newActivityList = (json.decode(response.body) as List)
        .map((data) => ActivityModel.fromJson(data))
        .toList();
    dayActivityList = newActivityList;
  }

  getDailyWeight() async {
    MetricDBHelper db = new MetricDBHelper();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getDayMetricList(int.parse(id));
    List<MetricModel> newMetricList = (json.decode(response.body) as List)
        .map((data) => MetricModel.fromJson(data))
        .toList();
    dayMetricList = newMetricList;
  }

  getDailySymptom() async {
    SymptomDBHelper db = new SymptomDBHelper();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getDaySymptomList(int.parse(id));
    List<SymptomModel> newSymptomList = (json.decode(response.body) as List)
        .map((data) => SymptomModel.fromJson(data))
        .toList();
    daySymptomList = newSymptomList;
  }

  getDailyActivityChildren() {
    if (dayActivityList.isEmpty) {
      return <Widget>[
        Text("Nothing here. Log some activities."),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/fitnessTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View All Activities")),
      ];
    } else if (dayActivityList.isNotEmpty) {
      return <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dayActivityList.length,
          itemBuilder: (context, index) {
            final item = dayActivityList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 2, 0, 2),
              child: Text(
                  item.type + " for " + item.minutes.toString() + " minutes."),
            );
          },
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/fitnessTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View All Activities")),
      ];
    }
    return <Widget>[];
  }

  getDailyFoodChildren() {
    if (dayFoodLogEntryList.isEmpty) {
      return <Widget>[
        Text("Nothing here. Log some foods."),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dietTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View All Foods")),
      ];
    } else if (dayFoodLogEntryList.isNotEmpty) {
      return <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dayFoodLogEntryList.length,
          itemBuilder: (context, index) {
            final item = dayFoodLogEntryList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 2, 0, 2),
              child: Text(item.food.description),
            );
          },
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dietTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View All Foods")),
      ];
    }
    return <Widget>[];
  }

  getDailyWeightChildren() {
    if (dayMetricList.isEmpty) {
      return <Widget>[
        Text("Nothing here. Log your weight!"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/metricTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View Weight Log")),
      ];
    } else if (dayMetricList.isNotEmpty) {
      return <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dayMetricList.length,
          itemBuilder: (context, index) {
            final item = dayMetricList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 2, 0, 2),
              child: Text(item.weight.toString() +
                  "lbs @ " +
                  DateFormat.Hm().format(item.dateTime.toLocal())),
            );
          },
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/metricTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View Weight Log")),
      ];
    }
    return <Widget>[];
  }

  getDayActivityMinutes() {
    int minutes = 0;
    for (ActivityModel activityModel in dayActivityList) {
      minutes += activityModel.minutes;
    }
    return minutes;
  }

  getDayFoodCalories() {
    int calories = 0;
    for (FoodLogEntry foodLogEntry in dayFoodLogEntryList) {
      calories += foodLogEntry.food.kcal.toInt();
    }
    return calories;
  }

  getGoals() async {
    var db2 = new WeeklySavedDBHelper();
    weeklySavedGoalsModelList.clear();
    var response2 = await db2.getWeeklySavedGoalsByUserID();
    var wGDecode2 = json.decode(response2.body);
  }

  getDailySymptomChildren() {
    if (daySymptomList.isEmpty) {
      return <Widget>[
        Text("No Symptoms Tracked Today!"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/symptomTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View Symptom Log")),
      ];
    } else if (daySymptomList.isNotEmpty) {
      return <Widget>[
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: daySymptomList.length,
          itemBuilder: (context, index) {
            final item = daySymptomList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 2, 0, 2),
              child: Text("Symptom(s) recorded @ " +
                  DateFormat.Hm().format(item.dateTime.toLocal())),
            );
          },
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/symptomTracking')
                  .then((value) => setState(() {
                        refresh();
                        rebuildAllChildren(context);
                      }));
            },
            child: Text("View Symptom Log")),
      ];
    }
    return <Widget>[];
  }
}
