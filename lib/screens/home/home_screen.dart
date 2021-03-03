import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/weekly_diet_chart_widget.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/activity_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/diet_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/symptom_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        children: [
          SpeedDialChild(
              child: Icon(Icons.food_bank),
              label: 'Log Food',
              onTap: (){
                showSearch(
                    context: context,
                    delegate: FoodSearch(DateTime.now().toString()));
                // Navigator.pushNamed(context, '/inputActivity');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.directions_run),
              label: 'Log Activity',
              onTap: (){
                Navigator.pushNamed(context, '/inputActivity');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.thermostat_outlined),
              label: 'Log Symptoms',
              onTap: (){
                Navigator.pushNamed(context, '/inputSymptom');
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.question_answer),
              label: 'Log Questions',
              onTap: (){
                Navigator.pushNamed(context, '/inputActivity');
              }
          ),
        ],
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: RaisedButton(
              //     child: Text('Goals'),
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/goals');
              //     },
              //   ),
              // ),
            ],
          )),
    );
  }
}
