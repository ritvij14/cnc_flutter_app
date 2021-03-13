import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/diet_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      floatingActionButton: SpeedDial(

        icon: Icons.add,
        backgroundColor: Theme.of(context).accentColor,
        children: [
          SpeedDialChild(
              child: Icon(Icons.food_bank),
              label: 'Log Food',
              onTap: () {
                showSearch(
                        context: context,
                        delegate: FoodSearch(DateTime.now().toString()))
                    .then((value) => rebuildAllChildren(context));
              }),

          // Navigator.pushNamed(context, '/inputActivity');
          SpeedDialChild(
              child: Icon(Icons.directions_run),
              label: 'Log Activity',
              onTap: () {
                Navigator.pushNamed(context, '/inputActivity');
              }),
          SpeedDialChild(
              child: Icon(Icons.thermostat_outlined),
              label: 'Log Symptoms',
              onTap: () {
                Navigator.pushNamed(context, '/inputSymptom');
              }),
          SpeedDialChild(
              child: Icon(Icons.question_answer),
              label: 'Log Questions',
              onTap: () {
                Navigator.pushNamed(context, '/questions');
              }),
          SpeedDialChild(
              child: Icon(MdiIcons.scale),
              label: 'Log Metrics',
              onTap: () {
                Navigator.pushNamed(context, '/inputMetrics');
              }),
          // SpeedDialChild(
          //     child: Icon(MdiIcons.abTesting),
          //     label: 'Test',
          //     onTap: () {
          //       Navigator.pushNamed(context, '/tests');
          //     }),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ListView(
            children: [
              DietSummaryWidget(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ExpansionTile(
                    title: Text('Daily Diet Summary'),
                    subtitle: Text('4 items totaling 1000 calories.'),
                    children: <Widget>[
                      Text('Food 1'),
                      Text('Food 2'),
                      Text('Food 3'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/dietTracking');
                          },
                          child: Text("Full Summary")),
                    ],
                  ),
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Daily Activity Summary'),
                  subtitle: Text('2 activities totaling 125 mets.'),
                  children: <Widget>[
                    Text('Activity 1'),
                    Text('Activity 2'),
                    Text('Activity 3'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/fitnessTracking');
                        },
                        child: Text("Full Summary")),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Daily Weight Summary'),
                  subtitle: Text('No weight added today!'),
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/metricTracking');
                        },
                        child: Text("Full Summary")),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Daily Symptom Summary'),
                  subtitle: Text('No symptoms added today!'),
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/symptomTracking');
                        },
                        child: Text("Full Summary")),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,60, 0, 0),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: WeeklyCalorieWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: MetricSummaryWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ActivitySummaryWidget(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SymptomSummaryWidget(),
              // ),
              // Container(
              //   height: 50,
              // ),
            ],
          )),
    );
  }
}
