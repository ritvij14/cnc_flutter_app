import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:cnc_flutter_app/screens/home/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'ask_screen.dart';
import 'home_screen.dart';
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

  List<Widget> screens = <Widget>[
    HomeScreen(),
    HomeScreen(),
    DietTrackingScreen(),
    WelcomeScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        selectedItemColor: Theme
            .of(context)
            .highlightColor,
        unselectedItemColor: Colors.white.withOpacity(.60),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.question_answer),
            label: "ASK",
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.food_bank,
            ),
            label: "DIET",
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.search,
            ),
            label: "SEARCH",
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.person,
            ),
            label: "PROFILE",
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
