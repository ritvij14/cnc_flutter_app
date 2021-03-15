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
  List<String> goals = [];
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
                        color: Colors.white,
                        height: 150,
                        child: ListView.builder(
                            itemCount: goals.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Text((index+1).toString() + ". " + goals[index],
                                    style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              );
                            }))
                  ],
                ),
              ),
          Container(
            color: _getColor("Fruit"),
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
                    color: _getColor("Fruit"),
                    height: 150,
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Fruit") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Vegetable"),
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
                    color: _getColor("Vegetable"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Vegetable") {
                            return _buildSlideView(index);
                          } else {
                            return _buildEmpty();
                          }
                        }))
              ],
            ),
          ),
          Container(
            color: _getColor("Grain"),
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
                    color: _getColor("Grain"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Grain") {
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
            color: _getColor("Snack"),
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
                    color: _getColor("Snack"),
                    child: ListView.builder(
                        itemCount: weeklyGoalsModelList.length,
                        itemBuilder: (context, index) {
                          if (weeklyGoalsModelList[index].type == "Snack") {
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

  Widget _buildEmpty() {
    return Container(color: Colors.white // This is optional
        );
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
    }
    print(wGDecode.length);
  }
}
