import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clipboard/clipboard.dart';

// void main() => runApp(GoalCalendar());

class GoalCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
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
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.pink,
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
              color: Colors.blue[800],
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
            // ..._selectedEvents.map((event) => Padding(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 5, horizontal: 70),
            //       child: Container(
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Colors.white,
            //             border: Border.all(color: Colors.blue[800])),
            //         child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               event,
            //               style: TextStyle(
            //                   color: Colors.pinkAccent,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 16),
            //             )),
            //       ),
            //     )),
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
          final sweets = _events[index];

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(_events[_controller.selectedDay][index].toString()),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: 'Copy',
                  color: Colors.grey[400],
                  icon: Icons.content_copy,
                  onTap: () {
                    FlutterClipboard.copy(
                        _events[_controller.selectedDay][index].toString());
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
