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
import 'badge_help_screen.dart';
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

  int totalWeeklyGoalsCompleted = 0;
  int totalActivityGoals = 0;
  int totalBeverageGoals = 0;
  int totalDairyGoals = 0;
  int totalFruitGoals = 0;
  int totalGrainGoals = 0;
  int totalProteinGoals = 0;
  int totalSnackGoals = 0;
  int totalVegetableGoals = 0;

  List<String> goals;
  List<WeeklyGoalsModel> weeklyGoalsModelList = [];
  List<WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];
  var db = new WeeklyDBHelper();
  final db2 = WeeklySavedDBHelper();

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    totalWeeklyGoalsCompleted = prefs.getInt("weekly goal total");
    totalActivityGoals = prefs.getInt("activity goals total");
    totalDairyGoals = prefs.getInt("dairy goals total");
    totalFruitGoals = prefs.getInt("fruit goals total");
    totalBeverageGoals = prefs.getInt("beverage goals total");
    totalGrainGoals = prefs.getInt("grain goals total");
    totalProteinGoals = prefs.getInt("protein goals total");
    totalSnackGoals = prefs.getInt("snack goals total");
    totalVegetableGoals = prefs.getInt("vegetable goals total");

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
                          'Your Goals',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
                        TextButton(
                          child: Icon(Icons.info),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).primaryColor, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(new MaterialPageRoute(
                                  builder: (_) => WeeklyGoals(),
                                ))
                                .then((value) => update(context));
                          },
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
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
                                  primary: _getColor("Vegetables"),
                                  // background
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 25),
            color: Theme.of(context).primaryColor,
            child: ExpansionTile(
              title: Text(
                "Your Badges",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              children: <Widget>[

                Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
                TextButton(
                  child: Icon(Icons.info),
                  style: ElevatedButton.styleFrom(
                    primary:
                    Theme.of(context).primaryColor, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(
                      builder: (_) => BadgeHelp(),
                    ))
                        .then((value) => update(context));
                  },
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Total Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalWeeklyGoalsCompleted == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalWeeklyGoalsCompleted != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalWeeklyGoalsCompleted)
                          : SizedBox(height: 0),
                      totalWeeklyGoalsCompleted != null &&
                              totalWeeklyGoalsCompleted >= 25
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalWeeklyGoalsCompleted)
                          : SizedBox(height: 0),
                      totalWeeklyGoalsCompleted != null &&
                              totalWeeklyGoalsCompleted >= 50
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalWeeklyGoalsCompleted)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Fruit Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalFruitGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalFruitGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalFruitGoals)
                          : SizedBox(height: 0),
                      totalFruitGoals != null &&
                          totalFruitGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalFruitGoals)
                          : SizedBox(height: 0),
                      totalFruitGoals != null &&
                          totalFruitGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalFruitGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Vegetable Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalVegetableGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalVegetableGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalVegetableGoals)
                          : SizedBox(height: 0),
                      totalVegetableGoals != null &&
                          totalVegetableGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalVegetableGoals)
                          : SizedBox(height: 0),
                      totalVegetableGoals != null &&
                          totalVegetableGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalVegetableGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Grains Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalGrainGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalGrainGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalGrainGoals)
                          : SizedBox(height: 0),
                      totalGrainGoals != null &&
                          totalGrainGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalGrainGoals)
                          : SizedBox(height: 0),
                      totalGrainGoals != null &&
                          totalGrainGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalGrainGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Protein Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalProteinGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalProteinGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalProteinGoals)
                          : SizedBox(height: 0),
                      totalProteinGoals != null &&
                          totalProteinGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalProteinGoals)
                          : SizedBox(height: 0),
                      totalProteinGoals != null &&
                          totalProteinGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalProteinGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Dairy Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalDairyGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalDairyGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalDairyGoals)
                          : SizedBox(height: 0),
                      totalDairyGoals != null &&
                          totalDairyGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalDairyGoals)
                          : SizedBox(height: 0),
                      totalDairyGoals != null &&
                          totalDairyGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalDairyGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Snack Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalSnackGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalSnackGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalSnackGoals)
                          : SizedBox(height: 0),
                      totalSnackGoals != null &&
                          totalSnackGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalSnackGoals)
                          : SizedBox(height: 0),
                      totalSnackGoals != null &&
                          totalSnackGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalSnackGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Beverage Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalBeverageGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalBeverageGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalBeverageGoals)
                          : SizedBox(height: 0),
                      totalBeverageGoals != null &&
                          totalBeverageGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalBeverageGoals)
                          : SizedBox(height: 0),
                      totalBeverageGoals != null &&
                          totalBeverageGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalBeverageGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  child:  Text(
                    "Activity Badges",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      totalActivityGoals == null
                          ? Text("No Badges Achieved Yet")
                          : SizedBox(height: 0),
                      totalActivityGoals != null
                          ? _buildTotalBadge('./assets/images/badge1.png', 'Rank 1', totalActivityGoals)
                          : SizedBox(height: 0),
                      totalActivityGoals != null &&
                          totalActivityGoals >= 5
                          ? _buildTotalBadge('./assets/images/badge2.png', 'Rank 2', totalActivityGoals)
                          : SizedBox(height: 0),
                      totalActivityGoals != null &&
                          totalActivityGoals >= 10
                          ? _buildTotalBadge('./assets/images/badge3.png', 'Rank 3', totalActivityGoals)
                          : SizedBox(height: 0),
                    ],
                  ),
                ),

              ],
            ),
          ),
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

  _showTotalDialog(int i) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Goals Completed\n\nYou have completed a total of " +
                  i.toString() +
                  " goals so far!"),
              actions: <Widget>[
                FlatButton(
                  child: const Text('OKAY',
                      style:
                      TextStyle(color: Colors.white)),
                  color: Theme.of(context).buttonColor,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.grey[800],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  _showCongratsDialog(String i) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Column( children:[
            Text("New Badge\n\nYou have gained a new badge."),
            Container(
              child: Image(
                height: 75,
                width: 75,
                image: AssetImage(i),
              ),
            ),],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OKAY',
            style:
            TextStyle(color: Colors.white)),
              color: Theme.of(context).buttonColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.grey[800],
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }

  Widget _buildTotalBadge(String i, String j, int a) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Image.asset(i),
            iconSize: 75,
            onPressed: () {
              _showTotalDialog(a);
            },
          ),
          Text(
            j
          ),
        ]);
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

                    if(totalActivityGoals == null && weeklySavedGoalsModelList[index].type == "Physical Activity") {
                      totalActivityGoals = 1;
                      prefs.setInt(
                          "activity goals total", totalActivityGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Physical Activity"){
                      totalActivityGoals =
                      (totalActivityGoals + 1);
                      prefs.setInt(
                          "activity goals total", totalActivityGoals);
                    }

                    if(totalBeverageGoals == null && weeklySavedGoalsModelList[index].type == "Beverage") {
                      totalBeverageGoals = 1;
                      prefs.setInt(
                          "beverage goals total", totalBeverageGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Beverage"){
                      totalBeverageGoals =
                      (totalBeverageGoals + 1);
                      prefs.setInt(
                          "beverage goals total", totalBeverageGoals);
                    }

                    if(totalDairyGoals == null && weeklySavedGoalsModelList[index].type == "Dairy") {
                      totalDairyGoals = 1;
                      prefs.setInt("dairy goals total", totalDairyGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Dairy"){
                      totalDairyGoals = (totalDairyGoals + 1);
                      prefs.setInt("dairy goals total", totalDairyGoals);
                    }

                    if(totalFruitGoals == null && weeklySavedGoalsModelList[index].type == "Fruits") {
                      totalFruitGoals = 1;
                      prefs.setInt(
                          "fruit goals total", totalFruitGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Fruits") {
                      totalFruitGoals =
                      (totalFruitGoals + 1);
                      prefs.setInt(
                          "fruit goals total", totalFruitGoals);
                    }

                    if(totalGrainGoals == null && weeklySavedGoalsModelList[index].type == "Grains") {
                      totalGrainGoals = 1;
                      prefs.setInt(
                          "grain goals total", totalGrainGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Grains") {
                      totalGrainGoals =
                      (totalGrainGoals + 1);
                      prefs.setInt(
                          "grain goals total", totalGrainGoals);
                    }

                    if(totalProteinGoals == null && weeklySavedGoalsModelList[index].type == "Protein") {
                      totalProteinGoals = 1;
                      prefs.setInt(
                          "protein goals total", totalProteinGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Protein") {
                      totalProteinGoals =
                      (totalProteinGoals + 1);
                      prefs.setInt(
                          "protein goals total", totalProteinGoals);
                    }

                    if(totalSnackGoals == null && weeklySavedGoalsModelList[index].type == "Snacks and Condiments") {
                      totalSnackGoals = 1;
                      prefs.setInt(
                          "snack goals total", totalSnackGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Snacks and Condiments") {
                      totalSnackGoals =
                      (totalSnackGoals + 1);
                      prefs.setInt(
                          "snack goals total", totalSnackGoals);
                    }

                    if(totalVegetableGoals == null && weeklySavedGoalsModelList[index].type == "Vegetables") {
                      totalVegetableGoals = 1;
                      prefs.setInt(
                          "vegetable goals total", totalVegetableGoals);
                    } else if (weeklySavedGoalsModelList[index].type == "Vegetables") {
                      totalVegetableGoals =
                      (totalVegetableGoals + 1);
                      prefs.setInt(
                          "vegetable goals total", totalVegetableGoals);
                    }

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
                    prefs.setInt(
                        "activity goals total", totalActivityGoals);
                    prefs.setInt(
                        "beverage goals total", totalBeverageGoals);
                    prefs.setInt(
                        "dairy goals total", totalDairyGoals);
                    prefs.setInt(
                        "fruit goals total", totalFruitGoals);
                    prefs.setInt(
                        "grain goals total", totalGrainGoals);
                    prefs.setInt(
                        "protein goals total", totalProteinGoals);
                    prefs.setInt(
                        "snack goals total", totalSnackGoals);
                    prefs.setInt(
                        "vegetable goals total", totalVegetableGoals);

                    _eventController2.clear();
                    update(context);

                    if(totalFruitGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalFruitGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalFruitGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalVegetableGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalVegetableGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalVegetableGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalGrainGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalGrainGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalGrainGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalProteinGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalProteinGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalProteinGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalDairyGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalDairyGoals== 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalDairyGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalSnackGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalSnackGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalSnackGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalBeverageGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalBeverageGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalBeverageGoals== 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

                    if(totalActivityGoals == 1){
                      _showCongratsDialog('./assets/images/badge1.png');
                    }
                    if(totalActivityGoals == 5){
                      _showCongratsDialog('./assets/images/badge2.png');
                    }
                    if(totalActivityGoals == 10){
                      _showCongratsDialog('./assets/images/badge3.png');
                    }

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
                    deleteByGoalDescription(
                        weeklySavedGoalsModelList[index].id);
                    update(context);
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
    var response2 = await dbs2.getWeeklySavedGoalsByUserID();
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
