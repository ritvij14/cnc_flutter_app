import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
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

  @override
  Widget build(BuildContext context) {
    getGoals();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return
                ListView.builder(
                  itemCount: weeklyGoalsModelList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          color: Colors.blue[800],
                          child: Text(
                            weeklyGoalsModelList[index].goalDescription,
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
                            weeklyGoalsModelList[index].helpInfo,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
          },
        future: getGoals(),
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

    //fix this later
    for (int i = 0; i < (wGDecode.length/2); i++) {
      weeklyGoalsModelList.removeAt(i*2);
    }

    print(weeklyGoalsModelList);
  }
}
