import 'package:flutter/material.dart';

class CommunicationsScreen extends StatefulWidget {
  @override
  _CommunicationsScreenState createState() => _CommunicationsScreenState();
}

class _CommunicationsScreenState extends State<CommunicationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communications"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.build,
              size: 50,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Under Construction",
              style: TextStyle(
                fontSize: 30
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
