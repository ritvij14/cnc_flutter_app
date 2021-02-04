import 'package:cnc_flutter_app/models/destination_model.dart';
import 'package:cnc_flutter_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/src/widgets/icon_data.dart';

class Home implements Destination{
  @override
  MaterialColor color = Colors.blue;

  @override
  IconData icon = Icons.home;

  @override
  String title = 'Home';

  @override
  StatefulWidget statefulWidget = HomeScreen();
}
