import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  BadgePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  late SharedPreferences prefs;
  var db = new WeeklyDBHelper();
  final db2 = WeeklySavedDBHelper();

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

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
    return SingleChildScrollView(
        child: Column(
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
            padding: EdgeInsets.only(
                top: 30.0, left: 15.0, right: 15.0, bottom: 10.0),
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
            padding:
                EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 0),
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
          Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Text(
              'Reset Badge Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.blue[700],
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Fruits'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Fruits"), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("fruit goals total", 0);
              prefs.setInt("fruitBadge1", 0);
              prefs.setInt("fruitBadge2", 0);
              prefs.setInt("fruitBadge3", 0);
              _showSnackBar(context, 'Reset Fruit Badges');
            },
          ),
          ElevatedButton(
            child: Text('Vegetables'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Vegetables"),
              // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("vegetable goals total", 0);
              prefs.setInt("vegetableBadge1", 0);
              prefs.setInt("vegetableBadge2", 0);
              prefs.setInt("vegetableBadge3", 0);
              _showSnackBar(context, 'Reset Vegetable Badges');
            },
          ),
          ElevatedButton(
            child: Text('Grains'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Grains"), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("grain goals total", 0);
              prefs.setInt("grainBadge1", 0);
              prefs.setInt("grainBadge2", 0);
              prefs.setInt("grainBadge3", 0);
              _showSnackBar(context, 'Reset Grain Badges');
            },
          ),
          ElevatedButton(
              child: Text('Protein'),
              style: ElevatedButton.styleFrom(
                primary: _getColor("Protein"), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                prefs.setInt("protein goals total", 0);
                prefs.setInt("proteinBadge1", 0);
                prefs.setInt("proteinBadge2", 0);
                prefs.setInt("proteinBadge3", 0);
                _showSnackBar(context, 'Reset Protein Badges');
              }),
          ElevatedButton(
            child: Text('Dairy'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Dairy"), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("dairy goals total", 0);
              prefs.setInt("dairyBadge1", 0);
              prefs.setInt("dairyBadge2", 0);
              prefs.setInt("dairyBadge3", 0);
              _showSnackBar(context, 'Reset Dairy Badges');
            },
          ),
          ElevatedButton(
            child: Text('Snack'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Snacks and Condiments"),
              // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("snack goals total", 0);
              prefs.setInt("snackBadge1", 0);
              prefs.setInt("snackBadge2", 0);
              prefs.setInt("snackBadge3", 0);
              _showSnackBar(context, 'Reset Snack Badges');
            },
          ),
          ElevatedButton(
            child: Text('Beverage'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Beverage"), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("beverage goals total", 0);
              prefs.setInt("beverageBadge1", 0);
              prefs.setInt("beverageBadge2", 0);
              prefs.setInt("beverageBadge3", 0);
              _showSnackBar(context, 'Reset Beverage Badges');
            },
          ),
          ElevatedButton(
            child: Text('Activity'),
            style: ElevatedButton.styleFrom(
              primary: _getColor("Physical Activity"),
              // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              prefs.setInt("activity goals total", 0);
              prefs.setInt("activityBadge1", 0);
              prefs.setInt("activityBadge2", 0);
              prefs.setInt("activityBadge3", 0);
              _showSnackBar(context, 'Reset Activity Badges');
            },
          )
        ]));
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
            onPressed: () {},
          ),
          Text(j),
        ]);
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Color _getColor(String index) {
    if (index == "Fruits") {
      return Colors.red;
    } else if (index == "Vegetables") {
      return Colors.green;
    } else if (index == "Grains") {
      return Colors.orange[300]!;
    } else if (index == "Protein") {
      return Colors.deepPurple[300]!;
    } else if (index == "Dairy") {
      return Colors.blue[600]!;
    } else if (index == "Snacks and Condiments") {
      return Colors.pink[300]!;
    } else if (index == "Beverage") {
      return Colors.teal[400]!;
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
