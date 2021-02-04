import 'package:flutter/material.dart';

import 'home_model.dart';

class Destination {
  Destination(this.title, this.icon, this.color, this.statefulWidget);
  String title;
  IconData icon;
  MaterialColor color;
  StatefulWidget statefulWidget;

}

List<Destination> allDestinations = <Destination>[
  Home(),
  Home(),
  Home(),
  Home(),
  Home(),

  // Destination('Home', Icons.home, Colors.teal),
  // Destination('Articles', Icons.article, Colors.cyan),
  // Destination('Community', Icons.forum, Colors.orange),
  // Destination('Tracker', Icons.assignment, Colors.red),
  // Destination('Questions', Icons.person, Colors.blue),
];
