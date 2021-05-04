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
              color: Colors.blue[700],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Text(
            'Choose personal daily goals to view and set your own goals for each day. '
                'These goals are written in by you. You can add or delete goals at any point. '
                'To set a goal click on the day of the week and press the plus. Swipe left or right '
                'on a goal for more options.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          ),
          Center(child: ElevatedButton(
            child: Text('Personal Daily Goals',
            style: TextStyle(fontSize: 20.0,)),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).buttonColor, // foreground
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => DailyGoalsPage(),
              ));
            },
          ),),
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Text(
            'Choose weekly goals to view and set your own goals for each day. '
                'These goals are chosen from a list we have created for you. You can add '
                'or delete goals at any point. Choose a goal type and add a by swiping left or right. '
                'Swipe left or right on a goal for more options.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),),
          ElevatedButton(
            child: Text('Weekly Goals',
                style: TextStyle(fontSize: 20.0,)),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).buttonColor,
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
