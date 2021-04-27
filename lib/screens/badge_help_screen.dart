import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(BadgeHelp());

class BadgeHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BadgePage(title: 'Badges Information'),
    );
  }
}

class BadgePage extends StatefulWidget {
  BadgePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Badges Explained',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.blue[700],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Text(
              'As you complete goals of different categories you will be awarded a new badge. By tapping '
                  'on the badge you can view how many goals have been completed so far for that category. '
                  'Each badge has multiple evolutions.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', 1),
              _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', 1),
              _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', 1)
            ],
            ),
          ),

        ]);
    }

  Widget _buildTotalBadge(String i, String j, int a) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Image.asset(i),
            iconSize: 75,
            onPressed: () {
            },
          ),
          Text(
              j
          ),
        ]);
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

  Widget _buildEmpty() {
    return Container(color: Colors.white // This is optional
    );
  }

  Widget _buildText() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Center(
        child: Text(
          "There are no weekly goals chosen currently",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
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
    }

    weeklySavedGoalsModelList.clear();
    var db2 = new WeeklySavedDBHelper();
    var response2 = await db2.getWeeklySavedGoalsByUserID();
    var wGDecode2 = json.decode(response2.body);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklySavedGoalsModel weeklySavedGoalsModel = new WeeklySavedGoalsModel(
          wGDecode2[i]['id'],
          wGDecode2[i]['type'],
          wGDecode2[i]['goalDescription'],
          wGDecode2[i]['help_info'],
          wGDecode2[i]['user_id']);
      weeklySavedGoalsModelList.add(weeklySavedGoalsModel);
    }
    print(wGDecode2.length);
  }
}
