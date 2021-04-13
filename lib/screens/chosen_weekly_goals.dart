import 'dart:convert';
import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:cnc_flutter_app/connections/weekly_goals_saved_db_helper.dart';
import 'package:cnc_flutter_app/models/weekly_goals_model.dart';
import 'package:cnc_flutter_app/models/weekly_goals_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';

import './choose_goals_screen.dart';
import './weekly_goals_screen.dart';
import 'choose_goal_pages/activity_goals_screen.dart';
import 'choose_goal_pages/beverage_goals_screen.dart';
import 'choose_goal_pages/dairy_goals_screen.dart';
import 'choose_goal_pages/fruit_goals_screen.dart';
import 'choose_goal_pages/grain_goals_screen.dart';
import 'choose_goal_pages/protein_goals_screen.dart';
import 'choose_goal_pages/snack_goals_screen.dart';
import 'choose_goal_pages/vegetable_goals_screen.dart';

class ChosenWeeklyGoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseGoalsPage(title: 'Weekly Goals'),
    );
  }
}

class ChosenWeeklyGoalsPage extends StatefulWidget {
  ChosenWeeklyGoalsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChosenWeeklyGoalsPageState createState() => _ChosenWeeklyGoalsPageState();
}

class _ChosenWeeklyGoalsPageState extends State<ChosenWeeklyGoalsPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  CalendarController _controller2;
  Map<DateTime, List<dynamic>> _events2;
  List<dynamic> _selectedEvents2;
  TextEditingController _eventController2;
  SharedPreferences prefs2;

  int totalWeeklyGoalsCompleted;
  int totalPersonalGoalsCompleted;

  List<String> goals;
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];
  List<WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];
  var db = new WeeklyDBHelper();
  final db2 = WeeklySavedDBHelper();

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    totalWeeklyGoalsCompleted = prefs.getInt("weekly goal total");
    totalPersonalGoalsCompleted = prefs.getInt("personal goal total");
    _events = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("events") ?? "{}")));
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];

    _controller2 = CalendarController();
    _eventController2 = TextEditingController();
    _events2 = {};
    _selectedEvents2 = [];
    initPrefs();
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Weekly Goals'),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return buildGoalCalendarView();
        },
        future: getGoals(),
      ),
    );
  }

  Widget buildGoalCalendarView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            events: _events,
            initialCalendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
                canEventMarkersOverflow: true,
                todayColor: Theme.of(context).accentColor,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              formatButtonShowsNext: false,
            ),
            onDaySelected: (date, events, holidays) {
              update(context);
              setState(() {
                _selectedEvents = events;
              });
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            calendarController: _controller,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Weekly Goals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      PopupMenuButton(
                        icon: Icon(Icons.add),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Fruits'),
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Vegetables'),
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Grains'),
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Protein'),
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Dairy'),
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Snack'),
                              style: ElevatedButton.styleFrom(
                                primary: _getColor("Snacks and Condiments"),
                                // background
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
                          ),
                          PopupMenuItem(
                            child: ElevatedButton(
                              child: Text('Beverage'),
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
                          ),
                          PopupMenuItem(
                              child: ElevatedButton(
                            child: Text('Activity'),
                            style: ElevatedButton.styleFrom(
                              primary: _getColor("Physical Activity"),
                              // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(new MaterialPageRoute(
                                    builder: (_) => ChooseActivityGoals(),
                                  ))
                                  .then((value) => update(context));
                            },
                          ))
                        ],
                        onSelected: (route) {
                          print(route);
                          // Note You must create respective pages for navigation
                          Navigator.pushNamed(context, route);
                        },
                      ),
                    ]),
              ],
            ),
          ),
          ),

          weeklySavedGoalsModelList.length > 0
              ? _buildWeeklyView()
              : SizedBox(height: 0),
          totalWeeklyGoalsCompleted != null
              ? _buildGetWeeklyCompleted()
              : SizedBox(height: 0),
        ],
      ),
    );
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

  Widget _buildGetWeeklyCompleted() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Text(
        'Total Weekly Goals Completed: ' +
            prefs.getInt("weekly goal total").toString(),
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildGetPersonalCompleted() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Text(
        'Total Personal Goals Completed: ' +
            prefs.getInt("personal goal total").toString(),
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  update(context) {
    setState(() {});
  }

  Widget _buildWeeklyView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: weeklySavedGoalsModelList.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(weeklySavedGoalsModelList[index].goalDescription),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                  caption: 'Completed',
                  color: Colors.green,
                  icon: Icons.check,
                  onTap: () {
                    deleteByGoalDescription(
                        weeklySavedGoalsModelList[index].id);
                    if (totalWeeklyGoalsCompleted == null) {
                      totalWeeklyGoalsCompleted = 1;
                      prefs.setInt(
                          "weekly goal total", totalWeeklyGoalsCompleted);
                    } else {
                      totalWeeklyGoalsCompleted =
                          (totalWeeklyGoalsCompleted + 1);
                      prefs.setInt(
                          "weekly goal total", totalWeeklyGoalsCompleted);
                    }

                    prefs.setInt(
                        "weekly goal total", totalWeeklyGoalsCompleted);
                    _eventController2.clear();
                    update(context);
                    _showSnackBar(context, 'Completed Goal');
                  }),
              IconSlideAction(
                  caption: 'Copy',
                  color: Colors.grey[400],
                  icon: Icons.content_copy,
                  onTap: () {
                    FlutterClipboard.copy(weeklySavedGoalsModelList[index]
                        .goalDescription
                        .toString());
                    _showSnackBar(context, 'Copied to Clipboard');
                  }),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () {
                    Share.share(
                        weeklySavedGoalsModelList[index]
                            .goalDescription
                            .toString(),
                        subject:
                            'Check out my new goal on the Enact diet tracking app!');
                  }),
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    update(context);
                    deleteByGoalDescription(
                        weeklySavedGoalsModelList[index].id);
                    _showSnackBar(context, 'Deleted Goal');
                  }),
            ],
          );
        });
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  getGoals() async {
    weeklyGoalsModelList.clear();
    var dbs = new WeeklyDBHelper();
    var response = await dbs.getWeeklyGoals();
    var wGDecode = json.decode(response.body);

    for (int i = 0; i < wGDecode.length; i++) {
      WeeklyGoalsModel weeklyGoalsModel = new WeeklyGoalsModel(
          wGDecode[i]['type'],
          wGDecode[i]['goalDescription'],
          wGDecode[i]['help_info']);
      weeklyGoalsModelList.add(weeklyGoalsModel);
    }

    weeklySavedGoalsModelList.clear();
    var dbs2 = new WeeklySavedDBHelper();
    var response2 = await dbs2.getWeeklySavedGoals();
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
    print(weeklySavedGoalsModelList.length);
  }

  deleteByGoalDescription(int d) {
    db2.deleteWeeklyGoalsSavedByID(d);
  }
}
