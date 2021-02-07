import 'dart:html';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      // body: Body(),
    );
  }
}