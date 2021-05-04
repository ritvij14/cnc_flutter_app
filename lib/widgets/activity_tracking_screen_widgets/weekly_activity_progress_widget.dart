import 'package:cnc_flutter_app/connections/fitness_activity_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeeklyActivityProgressWidget extends StatefulWidget {
  @override
  _WeeklyActivityProgressWidgetState createState() =>
      _WeeklyActivityProgressWidgetState();
}

class _WeeklyActivityProgressWidgetState
    extends State<WeeklyActivityProgressWidget> {
  ActivityDBHelper db = new ActivityDBHelper();

  int completedMinutes = 0;
  int requiredMinutes = 150;
  double percentComplete = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new CircularPercentIndicator(
          radius: 200.0,
          lineWidth: 20.0,
          animation: true,
          percent: percentComplete,
          center: new Text(
            "${(percentComplete * 100).toStringAsFixed(0)}%",
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          footer: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text(
              completedMinutes > requiredMinutes
                  ? "Completed Weekly Target!\n  " +
                      (completedMinutes - requiredMinutes).toString() +
                      " Minutes Over Target."
                  : (requiredMinutes - completedMinutes).toString() +
                      " Minutes Left",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.purple,
          header: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Weekly Activity Progress",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> getData() async {
    DateTime dateTime = DateTime.now();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    int intensity = 1;
    int userId = int.parse(id);
    var x = await db.getDaysActivityList(5, intensity, userId);
    int y = int.parse(x.body);
    return y;
  }

  @override
  // ignore: must_call_super
  void initState() {
    setData();
  }

  Future<void> setData() async {
    completedMinutes = await getData();
    percentComplete = completedMinutes / requiredMinutes;
    if (percentComplete > 1.0) {
      percentComplete = 1.0;
    }
    refresh();
  }

  refresh() {
    setState((){});
  }
}
