import 'dart:convert';

import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:cnc_flutter_app/screens/choose_goal_pages/activity_goals_screen.dart';
import 'package:cnc_flutter_app/screens/choose_goal_pages/dairy_goals_screen.dart';
import 'package:cnc_flutter_app/screens/choose_goal_pages/grain_goals_screen.dart';
import 'package:cnc_flutter_app/screens/choose_goal_pages/snack_goals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'choose_goal_pages/beverage_goals_screen.dart';
import 'choose_goal_pages/fruit_goals_screen.dart';
import 'choose_goal_pages/protein_goals_screen.dart';
import 'choose_goal_pages/vegetable_goals_screen.dart';

// void main() => runApp(GoalCalendar());

//void main() => runApp(ChooseWeeklyGoals());

class ChooseWeeklyGoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseGoalsPage(title: 'Choose Weekly Goals'),
    );
  }
}

class ChooseGoalsPage extends StatefulWidget {
  ChooseGoalsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChooseGoalsPageState createState() => _ChooseGoalsPageState();
}

class _ChooseGoalsPageState extends State<ChooseGoalsPage> {
  List<String> goals = [];
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];
  List<WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];

  var db = new WeeklyDBHelper();
  var db2 = new WeeklySavedDBHelper();

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
            color: Theme.of(context).primaryColor,
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
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Fruit Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Fruits"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseFruitGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Vegetable Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Vegetables"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseVegetableGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Grain Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Grains"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseGrainGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Protein Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Protein"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseProteinGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Dairy Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Dairy"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseDairyGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Snack Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Snacks and Condiments"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseSnackGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Beverage Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Beverage"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseBeverageGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Physical Activity Goals",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Choose Goal'),
                    style: ElevatedButton.styleFrom(
                      primary: _getColor("Physical Activity"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                            builder: (_) => ChooseActivityGoals(),
                          ))
                          .then((value) => update(context));
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  update(context) {
    setState(() {});
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
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

  Widget _buildListView(int index) {
    int i = index + 1;
    return Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Text(i.toString() +
            ". " +
            weeklySavedGoalsModelList[index].goalDescription));
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
    weeklySavedGoalsModelList.clear();
    var response = await db.getWeeklyGoals();
    var wGDecode = json.decode(response.body);
    var response2 = await db2.getWeeklySavedGoals();
    var wGDecode2 = json.decode(response2.body);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklyGoalsModel weeklyGoalsModel = new WeeklyGoalsModel(
          wGDecode[i]['type'],
          wGDecode[i]['goalDescription'],
          wGDecode[i]['help_info']);
      weeklyGoalsModelList.add(weeklyGoalsModel);
    }
    print(wGDecode.length);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklySavedGoalsModel weeklySavedGoalsModel = new WeeklySavedGoalsModel(
          wGDecode2[i]['id'],
          wGDecode2[i]['type'],
          wGDecode2[i]['goalDescription'],
          wGDecode2[i]['help_info'],
          wGDecode2[i]['user_id']);
      weeklySavedGoalsModelList.add(weeklySavedGoalsModel);
    }
  }

  addSavedGoals(int index) async {
    int i = 1;
    int x = 0;
    if (weeklySavedGoalsModelList.length > 0) {
      x = weeklySavedGoalsModelList[weeklySavedGoalsModelList.length - 1].id +
          1;
    } else {
      x = 1;
    }
    weeklySavedGoalsModelList.add(WeeklySavedGoalsModel(
        x,
        weeklyGoalsModelList[index].type,
        weeklyGoalsModelList[index].goalDescription,
        weeklyGoalsModelList[index].helpInfo,
        1));
    WeeklySavedGoalsModel m = new WeeklySavedGoalsModel(
        x,
        weeklyGoalsModelList[index].type,
        weeklyGoalsModelList[index].goalDescription,
        weeklyGoalsModelList[index].helpInfo,
        1);
    db2.saveWeeklySavedGoal(m);
  }
}
