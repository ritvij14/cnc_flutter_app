import 'package:flutter/material.dart';

class Destination {
const Destination(this.title, this.icon, this.color);
final String title;
final IconData icon;
final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.teal),
  Destination('Articles', Icons.article, Colors.cyan),
  Destination('Community', Icons.forum, Colors.orange),
  Destination('Tracker', Icons.assignment, Colors.red),
  Destination('Questions', Icons.person, Colors.blue),

];