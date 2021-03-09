import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:flutter/material.dart';


void main() => runApp(WeeklyGoals());

class WeeklyGoals extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeeklyGoalsPage(title: 'Choose Weekly Goals'),
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
  var db = new WeeklyDBHelper();


  @override
  Widget build(BuildContext context) {
    getGoals();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'Check out Your Weekly Goals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.blue[800],
              child: Text(
                'Incorporate 3 fruits into a fruit smoothie into your day (1 day)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Here are some combinations to try:\n'
                    '-Starfruit and strawberries\n'
                    '-Avocado and papaya\n'
                    '-Cucumber, kale and pear\n'
                    '-Mango, cherry and dragonfruit',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.blue[800],
              child: Text(
                'Prepare two different non-starchy vegetables for 2 meals (5 days)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Examples of non-starchy vegetables are: '
                    '-Artichoke\n'
                    '-Broccoli\n'
                    '-Beans\n'
                    '-Brussels Sprouts',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.blue[800],
              child: Text(
                'Make and eat a salad that you’ve never made before (2 days)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Try using vegetables such as:\n'
                    '-Kale\n'
                    '-Arugula\n'
                    '-Cabbage\n',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getGoals() async{
    var db = new WeeklyDBHelper();
    var response = await db.getWeeklyGoals();
    var wGDecode = json.decode(response.body);

    print(wGDecode);

    var wG = WeeklyGoalsModel.fromJson(response);
  }

}
