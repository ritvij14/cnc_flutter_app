import 'package:cnc_flutter_app/screens/articles_screen.dart';
import 'package:cnc_flutter_app/screens/home/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/home/goal_calendar_screen.dart';
import 'package:cnc_flutter_app/screens/welcome_screen_stepper.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'home/home_screen.dart';

// import 'ask/ask_page.dart';
// import 'home_page.dart';
// import 'profile/profile_page.dart';
// import 'welcome/welcome_screen.dart';

import 'package:flutter/cupertino.dart';
import '../settings/preferences.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_screen.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;
  // SpeedDialController _controller = SpeedDialController();


  List<Widget> screens = <Widget>[
    HomeScreen(),
    ArticlesScreen(),
    CalendarPage(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: Preferences.getTheme()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        children: [
          SpeedDialChild(
              child: Icon(Icons.food_bank),
            label: 'Log Food',
            onTap: (){
                showSearch(
                    context: context,
                    delegate: FoodSearch(DateTime.now().toString()));
                // Navigator.pushNamed(context, '/inputActivity');
            }
          ),
          SpeedDialChild(
              child: Icon(Icons.directions_run),
              label: 'Log Activity',
              onTap: (){
                Navigator.pushNamed(context, '/inputActivity');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.thermostat_outlined),
              label: 'Log Symptoms',
              onTap: (){
                Navigator.pushNamed(context, '/inputSymptom');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.question_answer),
              label: 'Log Questions',
              onTap: (){
                Navigator.pushNamed(context, '/inputActivity');
              }
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme
            .of(context)
            .primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Theme
                      .of(context)
                      .backgroundColor : Theme
                      .of(context)
                      .accentColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.library_books,
                  color: _selectedIndex == 1 ? Theme
                      .of(context)
                      .backgroundColor : Theme
                      .of(context)
                      .accentColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.verified,
                  color: _selectedIndex == 2 ? Theme
                      .of(context)
                      .backgroundColor : Theme
                      .of(context)
                      .accentColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3 ? Theme
                      .of(context)
                      .backgroundColor : Theme
                      .of(context)
                      .accentColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getCurrentScreen() {
    return screens[_selectedIndex];
  }
}