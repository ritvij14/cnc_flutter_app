import 'package:cnc_flutter_app/widgets/home_screen_widgets/activity_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/diet_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/symptom_summary_widget.dart';
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
      appBar: AppBar(
        title: Text('Home'),
      ),
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
                child: DietSummaryWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivitySummaryWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SymptomSummaryWidget(),
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
