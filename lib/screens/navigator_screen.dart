import 'package:cnc_flutter_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'ask_screen.dart';
// import 'ask/ask_page.dart';
// import 'home_page.dart';
// import 'profile/profile_page.dart';
// import 'welcome/welcome_screen.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition App'),
      ),
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor:  Theme.of(context).highlightColor,
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
      body: Stack(
        children: [
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
          _buildOffstageNavigator(3),
          _buildOffstageNavigator(4),
        ],
      ),
    );
  }
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          WelcomeScreen(),
          AskPage(),
          // HomePage(),
          // HomePage(),
          // ProfilePage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
