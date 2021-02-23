import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';

// void main() => runApp(GoalCalendar());

void main() => runApp(GoalCalendar());

class GoalCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return CalendarPage();
    return MaterialApp(
      title: 'Goal Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[800],
      ),
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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

    _events2[_controller2.selectedDay] = [
    ];
    _events2[_controller2.selectedDay]
        .add("Goal 1");
    _events2[_controller2.selectedDay]
        .add("Goal 2");
    _events2[_controller2.selectedDay]
        .add("Goal 3");
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
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
        title: Text('Personal Goal Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor:  Theme.of(context).accentColor,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              onDaySelected: (date, events, holidays) {
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
              padding: EdgeInsets.all(15.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.bottomLeft,
              child: Text(
                'Weekly Goals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            _buildWeeklyView(),

            Container(
              padding: EdgeInsets.all(15.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.bottomLeft,
              child: Text(
                'Personal Goals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            _events[_controller.selectedDay] != null
                ? _buildListView()
                : SizedBox(height: 0),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(right: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showAddDialog,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _events[_controller.selectedDay].length,
        itemBuilder: (context, index) {

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_events[_controller.selectedDay][index].toString()),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                  caption: 'Copy',
                  color: Colors.grey[400],
                  icon: Icons.content_copy,
                  onTap: () {
                    FlutterClipboard.copy(
                        _events[_controller.selectedDay][index].toString());
                    _showSnackBar(context, 'Copied to Clipboard');
                  }),
            ],
            secondaryActions: <Widget>[
              IconSlideAction( caption: 'Share',
              color: Colors.indigo,
              icon: Icons.share,
              onTap: () {
                Share.share(_events[_controller.selectedDay][index].toString(),
                    subject: 'Check out my new goal on the Enact diet tracking app!');
              }),
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    _events[_controller.selectedDay].removeAt(index);
                    prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _selectedEvents = _events[_controller.selectedDay];
                      }
                      _showSnackBar(context, 'Deleted Goal');
                    });
                  }),
            ],
          );
        });
  }

  Widget _buildWeeklyView() {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _events2[_controller2.selectedDay].length,
        itemBuilder: (context, index) {

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_events2[_controller2.selectedDay][index].toString()),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                  caption: 'Copy',
                  color: Colors.grey[400],
                  icon: Icons.content_copy,
                  onTap: () {
                    FlutterClipboard.copy(
                        _events2[_controller2.selectedDay][index].toString());
                    _showSnackBar(context, 'Copied to Clipboard');
                  }),
            ],
            secondaryActions: <Widget>[
              IconSlideAction( caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () {
                    Share.share(_events2[_controller2.selectedDay][index].toString(),
                        subject: 'Check out my new goal on the Enact diet tracking app!');
                  }),
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    _events2[_controller2.selectedDay].removeAt(index);
                    prefs.setString("events", json.encode(encodeMap(_events2)));
                    _eventController2.clear();
                    setState(() {
                      if (_events2[_controller2.selectedDay] != null) {
                        _selectedEvents2 = _events2[_controller2.selectedDay];
                      }
                      _showSnackBar(context, 'Deleted Goal');
                    });
                  }),
            ],
          );
        });
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  Text("Add Goals\n\nType out your full goal then press save."),
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      if (_events[_controller.selectedDay] != null) {
        _selectedEvents = _events[_controller.selectedDay];
      }
    });
  }

  _showDeleteDialogs() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  "Delete Goals\n\nEnter the number of the goal in order to delete the goal."),
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Delete"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_controller.selectedDay] != null) {
                      String temp = _eventController.text;
                      int temp2 = int.parse(temp);
                      temp2 = temp2 - 1;
                      if (temp2 < _events[_controller.selectedDay].length) {
                        _events[_controller.selectedDay].removeAt(temp2);
                      }
                    }
                    prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      if (_events[_controller.selectedDay] != null) {
        _selectedEvents = _events[_controller.selectedDay];
      }
    });
  }
}
