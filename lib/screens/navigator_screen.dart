import 'package:cnc_flutter_app/screens/articles_screen.dart';
import 'package:cnc_flutter_app/screens/home/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/home/goal_calendar_screen.dart';
import 'package:cnc_flutter_app/screens/welcome_screen_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';

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
  SpeedDialController _controller = SpeedDialController();

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
      // appBar: AppBar(
      //   title: Text('Nutrition App'),
      // ),
      body: getCurrentScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _buildFloatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: SpeedDial(
      //     icon: Icons.add,
      //     backgroundColor: Theme.of(context).accentColor,
      //     children: [
      //       SpeedDialChild(
      //         child: Icon(Icons.food_bank)
      //       ),
      //     ],
      //   ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: IconButton(
                icon: Icon(Icons.home,
                    color: _selectedIndex == 0
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).accentColor),
                iconSize: 30,
                onPressed: () {
                  _updateIndex(0);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: IconButton(
                icon: Icon(Icons.library_books,
                    color: _selectedIndex == 1
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).accentColor),
                iconSize: 30,
                onPressed: () {
                  _updateIndex(1);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: IconButton(
                icon: Icon(Icons.verified,
                    color: _selectedIndex == 2
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).accentColor),
                iconSize: 30,
                onPressed: () {
                  _updateIndex(2);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: IconButton(
                icon: Icon(Icons.person,
                    color: _selectedIndex == 3
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).accentColor),
                iconSize: 30,
                onPressed: () {
                  _updateIndex(3);
                },
              ),
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

  Widget _buildFloatingActionButton() {
    final TextStyle customStyle =
        TextStyle(inherit: false, color: Colors.black);
    final icons = [
      SpeedDialAction(
        //backgroundColor: Colors.green,
        //foregroundColor: Colors.yellow,
        child: Icon(Icons.food_bank),
        label: Text('Log Diet', style: customStyle),
      ),
      SpeedDialAction(
        child: Icon(Icons.directions_run),
        label: Text('Log Activity', style: customStyle),
      ),
      SpeedDialAction(
        child: Icon(Icons.list),
        label: Text('Log Symptoms', style: customStyle),
      ),
      SpeedDialAction(
        child: Icon(Icons.question_answer),
        label: Text('Log Questions', style: customStyle),
      ),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(Icons.add, key: UniqueKey()),
      screenColor: Colors.black.withOpacity(0.3),
      //childOnUnfold: Icon(Icons.add),
      useRotateAnimation: false,
      onAction: _onSpeedDialAction,
      controller: _controller,
      isDismissible: true,
      //backgroundColor: Colors.yellow,
      //foregroundColor: Colors.blue,
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    if (selectedActionIndex == 1) {
      Navigator.pushNamed(context, '/inputActivity');
    }
    print('$selectedActionIndex Selected');
  }
}
