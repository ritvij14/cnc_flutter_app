import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/screens/home/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SummaryWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Track Diet'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/dietTracking');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Track Physical Activity'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fitnessTracking');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Track Symptoms'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fitnessTracking');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Goals'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/goals');
                  },
                ),
              ),
            ],
          )),
    );
  }
}
