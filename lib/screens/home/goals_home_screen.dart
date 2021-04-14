import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:cnc_flutter_app/screens/chosen_weekly_goals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../daily_goals_screen.dart';

void main() => runApp(GoalsHome());

class GoalsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoalsHomePage(title: 'Goals'),
    );
  }
}

class GoalsHomePage extends StatefulWidget {
  GoalsHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GoalsHomePageState createState() => _GoalsHomePageState();
}

class _GoalsHomePageState extends State<GoalsHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildGoalView());
  }

  Widget buildGoalView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Click to View Your Goals',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(child: ElevatedButton(
            child: Text('Personal Daily Goals',
            style: TextStyle(fontSize: 20.0,)),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor, // background
              onPrimary: Colors.black, // foreground
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => DailyGoalsPage(),
              ));
            },
          ),),
          ElevatedButton(
            child: Text('Weekly Goals',
                style: TextStyle(fontSize: 20.0,)),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor, // background
              onPrimary: Colors.black, // foreground
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => ChosenWeeklyGoalsPage(),
              ));
            },
          ),
        ]);
  }
}
