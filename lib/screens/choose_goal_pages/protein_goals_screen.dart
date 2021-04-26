import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// void main() => runApp(GoalCalendar());

//void main() => runApp(ChooseWeeklyGoals());

class ChooseProteinGoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseProteinGoalsPage(title: 'Choose Weekly Goals'),
    );
  }
}

class ChooseProteinGoalsPage extends StatefulWidget {
  ChooseProteinGoalsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChooseProteinGoalsPageState createState() => _ChooseProteinGoalsPageState();
}

class _ChooseProteinGoalsPageState extends State<ChooseProteinGoalsPage> {
  List<String> goals = [];
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];
  List<WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];

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
          return _buildProteinGoalView();
        },
        future: getGoals(),
      ),
    );
  }

  Widget _buildProteinGoalView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            color: Theme.of(context).primaryColor,
            child:  Text(
                "Choose a Goal",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: weeklyGoalsModelList.length,
              itemBuilder: (context, index) {
                if (weeklyGoalsModelList[index].type == "Protein") {
                  return _buildSlideView(index);
                } else {
                  return _buildEmpty();
                }
              }),
          Container(
            color:  Theme.of(context).primaryColor,
            child: ExpansionTile(
              title: Text(
                "Chosen Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    color: Theme.of(context).primaryColor,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: weeklySavedGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklySavedGoalsModelList[index].type != null) {
                            return _buildListView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  _addGoal(String goal) {
    setState(() {
      if (goals == null) {
        goals = [];
        goals.add(goal);
      } else {
        goals.add(goal);
      }
    });
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

  Widget _buildListView(int index) {
    int i = index + 1;
    return Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Text(i.toString() + ". " + weeklySavedGoalsModelList[index].goalDescription));
  }

  Widget _buildSlideView(int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
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
              _addGoal(weeklyGoalsModelList[index].goalDescription);
              _showSnackBar(context, 'Added Goal to Weekly Goals');
              addSavedGoals(index);
            }),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Add',
            color: Colors.green,
            icon: Icons.add,
            onTap: () {
              _addGoal(weeklyGoalsModelList[index].goalDescription);
              _showSnackBar(context, 'Added Goal to Weekly Goals');
              addSavedGoals(index);
            }),
      ],
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

    for (int i = 0; i < wGDecode2.length; i++) {
      WeeklySavedGoalsModel weeklySavedGoalsModel = new WeeklySavedGoalsModel(
          wGDecode2[i]['id'],
          wGDecode2[i]['type'],
          wGDecode2[i]['goalDescription'],
          wGDecode2[i]['help_info'],
          wGDecode2[i]['user_id']);
      weeklySavedGoalsModelList.add(weeklySavedGoalsModel);
    }
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
          Text("Tried to add more than 3 Goals\n\nYou already have 3 goals selected for this week. Either "
              "delete a goal or complete a goal for this week to add more."),
          actions: <Widget>[
            TextButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }

  addSavedGoals(int index) async {
    int i = 1;
    int x = 0;
    if (weeklySavedGoalsModelList.length > 0){
      print(1);
      x = weeklySavedGoalsModelList[weeklySavedGoalsModelList.length-1].id+1;
      print(x);
    }
    else{
      print(2);
      x = 1;

    }
    if (weeklySavedGoalsModelList.length < 3){
      weeklySavedGoalsModelList.add(WeeklySavedGoalsModel(x,weeklyGoalsModelList[index].type,weeklyGoalsModelList[index].goalDescription, weeklyGoalsModelList[index].helpInfo,1));
      WeeklySavedGoalsModel m = new WeeklySavedGoalsModel(
          x,
          weeklyGoalsModelList[index].type,
          weeklyGoalsModelList[index].goalDescription,
          weeklyGoalsModelList[index].helpInfo,
          12);
      db2.saveWeeklySavedGoal(m);
    }
    else {
      _showAddDialog();
      print("longer than 3");
    }

  }

}
