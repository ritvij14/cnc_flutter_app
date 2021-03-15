import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// void main() => runApp(GoalCalendar());

//void main() => runApp(ChooseWeeklyGoals());

class ChooseWeeklyGoals extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseGoalsPage(title: 'Choose Weekly Goals'),
    );
  }
}

class ChooseGoalsPage extends StatefulWidget {
  ChooseGoalsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChooseGoalsPageState createState() => _ChooseGoalsPageState();
}

class _ChooseGoalsPageState extends State<ChooseGoalsPage> {
  List<String> goals;
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];
  var db = new WeeklyDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: weeklyGoalsModelList.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: Container(
                  color: _getColor(weeklyGoalsModelList[index].type),
                  child: ListTile(
                    title: Text(weeklyGoalsModelList[index].type),
                    subtitle: Text(weeklyGoalsModelList[index].goalDescription),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                      caption: 'Add',
                      color: Colors.green,
                      icon: Icons.add,
                      onTap: () {
                        //_addGoal(items[index].subtitle);
                        print(goals);
                        _showSnackBar(context, 'Added Goal to Weekly Goals');
                      }
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Add',
                      color: Colors.green,
                      icon: Icons.add,
                      onTap: () {//
                        print(goals);
                        _showSnackBar(context, 'Added Goal to Weekly Goals');
                      }
                  ),
                ],
              );
            });
        },
        future: getGoals(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }


  _addGoal(String goal) {
    if (goals == null) {
      goals = [];
      goals.add(goal);
    }
    else {
      goals.add(goal);
    }
  }

  Color _getColor(String index) {
    if (index == "Fruit") {
      return Colors.red;
    } else if (index == "Vegetable") {
      return Colors.green;
    } else if (index == "Grain") {
      return Colors.orange[300];
    } else if (index == "Protein") {
      return Colors.deepPurple[300];
    } else if (index == "Dairy") {
      return Colors.blue[600];
    } else if (index == "Snack") {
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
    }
    print(wGDecode.length);
  }
}
