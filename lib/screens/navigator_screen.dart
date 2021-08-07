import 'package:cnc_flutter_app/screens/chosen_weekly_goals.dart';
import 'package:cnc_flutter_app/screens/communication_screen.dart';
import 'package:cnc_flutter_app/screens/content/content_screen.dart';
import 'package:cnc_flutter_app/screens/home/goals_home_screen.dart';
import 'package:cnc_flutter_app/screens/user_questions_screen.dart';
import 'package:cnc_flutter_app/theme/app_themes.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';

import 'package:flutter/cupertino.dart';
import '../settings/preferences.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile/profile_screen.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;
  // SpeedDialController _controller = SpeedDialController();

  List<Widget> screens = <Widget>[
    HomeScreen(),
    ContentScreen(),
    UserQuestionsScreen(),
    ChosenWeeklyGoalsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    context
        .read<ThemeBloc>()
        .add(ThemeEvent(appTheme: Preferences.getTheme() ?? AppTheme.Default));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              tooltip: "Home",
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).backgroundColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(0);
              },
            ),
            IconButton(
              tooltip: "Content",
              icon: Icon(Icons.library_books,
                  color: _selectedIndex == 1
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).backgroundColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(1);
              },
            ),
            IconButton(
              tooltip: "Communication",
              icon: Icon(Icons.chat,
                  color: _selectedIndex == 2
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).backgroundColor),
              iconSize: 30,
              onPressed: () {
                _updateIndex(2);
              },
            ),
            IconButton(
              tooltip: "Goals",
              icon: Icon(Icons.verified,
                  color: _selectedIndex == 3
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).backgroundColor),
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
