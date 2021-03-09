import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/diet_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/weekly_calorie_widget.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/activity_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/metric_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/symptom_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/summary_widget.dart';
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
              Stack(children: [
                DietSummaryWidget(),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ButtonTheme(
                    minWidth: 70,
                    height: 20,
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/dietTracking')
                            .then((value) => rebuildAllChildren(context));
                        setState(() {});
                      },
                      child: Text(
                        "Food Log",
                        style:
                            TextStyle(color: Theme.of(context).highlightColor),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(0.0),
                //   child: DietSummaryWidget(),
                // ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WeeklyCalorieWidget(),
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
                child: MetricSummaryWidget(),
              ),
              Container(
                height: 50,
              ),
            ],
          )),
    );
  }
}
