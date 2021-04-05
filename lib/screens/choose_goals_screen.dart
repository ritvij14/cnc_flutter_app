import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
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
          return _buildGoalView();
        },
        future: getGoals(),
      ),
    );
  }

  Widget _buildGoalView() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.black,
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
                        color: Colors.black,
                        height: 150,
                        child: ListView.builder(
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
          Container(
            color: _getColor("Fruits"),
            child: ExpansionTile(
              title: Text(
                "Fruit Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[

                Container(
                    color: _getColor("Fruits"),
                    height: 150,
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Fruits") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Vegetables"),
            child: ExpansionTile(
              title: Text(
                "Vegetable Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Vegetables"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Vegetables") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Grains"),
            child: ExpansionTile(
              title: Text(
                "Grain Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Grains"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Grains") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Protein"),
            child: ExpansionTile(
              title: Text(
                "Protein Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Protein"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Protein") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Dairy"),
            child: ExpansionTile(
              title: Text(
                "Dairy Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Dairy"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Dairy") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Snacks and Condiments"),
            child: ExpansionTile(
              title: Text(
                "Snack Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Snacks and Condiments"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Snacks and Condiments") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Beverage"),
            child: ExpansionTile(
              title: Text(
                "Beverage Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Beverage"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Beverage") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Physical Activity"),
            child: ExpansionTile(
              title: Text(
                "Physical Activity Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Container(
                    height: 150,
                    color: _getColor("Physical Activity"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type ==
                              "Physical Activity") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          )
        ]));
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
    int i = index+1;
    return
        Container(
          height: 50,
          color: Colors.white,
          child: Center(child: Text(i.toString() + ". " + weeklySavedGoalsModelList[index].goalDescription)));

  }

  Widget _buildSlideView(int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
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
              print(goals);
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
              print(goals);
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
    int i = 1 ;
    WeeklySavedGoalsModel m = new WeeklySavedGoalsModel(
        1,
        weeklyGoalsModelList[index].type,
        weeklyGoalsModelList[index].goalDescription,
        weeklyGoalsModelList[index].helpInfo,
        1);
    db2.saveWeeklySavedGoal(m);
  }

  deleteGoal(int index) async {
    int i = 1 ;
    WeeklySavedGoalsModel m = new WeeklySavedGoalsModel(
        1,
        weeklyGoalsModelList[index].type,
        weeklyGoalsModelList[index].goalDescription,
        weeklyGoalsModelList[index].helpInfo,
        1);
    db2.deleteByGoalDescription();
  }


}
