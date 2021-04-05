import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(WeeklyGoals());

class WeeklyGoals extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeeklyGoalsPage(title: 'Chosen Weekly Goals'),
    );
  }
}

class WeeklyGoalsPage extends StatefulWidget {
  WeeklyGoalsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WeeklyGoalsPageState createState() => _WeeklyGoalsPageState();
}

class _WeeklyGoalsPageState extends State<WeeklyGoalsPage> {
  List<String> goals;
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];

  var db = new WeeklyDBHelper();
  final db2 = WeeklySavedDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return buildGoalView();
        },
        future: getGoals(),
      ),
    );
  }

  Widget buildGoalView() {
    return ListView.builder(
      itemCount: weeklyGoalsModelList.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: _getColor(weeklyGoalsModelList[index].type),
              child: ExpansionTile(
                title: Text(
                  weeklyGoalsModelList[index].goalDescription,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      weeklyGoalsModelList[index].helpInfo,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getColor(String index) {
    if (index == "Fruits") {
      return Colors.red;
    } else if (index == "Vegetables") {
      return Colors.green;
    } else if (index == "Grains") {
      return Colors.orange[300];
    } else if (index == "Protein") {
      return Colors.deepPurple[300];
    } else if (index == "Dairy") {
      return Colors.blue[600];
    } else if (index == "Snacks and Condiments") {
      return Colors.pink[300];
    } else if (index == "Beverage") {
      return Colors.teal[400];
    } else if (index == "Physical Activity") {
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }

  getGoals() async {
    weeklyGoalsModelList.clear();
    var db = new WeeklyDBHelper();
    var response = await db.getWeeklyGoals();
    var wGDecode = json.decode(response.body);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklyGoalsModel weeklyGoalsModel = new WeeklyGoalsModel(
          wGDecode[i]['type'],
          wGDecode[i]['goalDescription'],
          wGDecode[i]['help_info']);
      weeklyGoalsModelList.add(weeklyGoalsModel);
      print(wGDecode[i]['type']);
      print(wGDecode[i]['goalDescription']);
      print(wGDecode[i]['help_info']);
    }
    print(wGDecode.length);

    weeklySavedGoalsModelList.clear();
    var db2 = new WeeklySavedDBHelper();
    var response2 = await db2.getWeeklySavedGoals();
    var wGDecode2 = json.decode(response2.body);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklySavedGoalsModel weeklySavedGoalsModel = new WeeklySavedGoalsModel(
          wGDecode2[i]['id'],
          wGDecode2[i]['type'],
          wGDecode2[i]['goalDescription'],
          wGDecode2[i]['help_info'],
          wGDecode2[i]['user_id']);
      weeklySavedGoalsModelList..add(weeklySavedGoalsModel);
      print(wGDecode2[i]['type']);
      print(wGDecode2[i]['goalDescription']);
      print(wGDecode2[i]['help_info']);
    }
    print(wGDecode2.length);
  }

  addSavedGoals(int index) async {
    int i = 1;
    WeeklySavedGoalsModel m = new WeeklySavedGoalsModel(
        1,
        weeklyGoalsModelList[index].type,
        weeklyGoalsModelList[index].goalDescription,
        weeklyGoalsModelList[index].helpInfo,
        1);
    db2.saveWeeklySavedGoal(m);
  }
}
