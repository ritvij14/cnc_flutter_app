
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/widgets/food_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';


class DietTrackingScreen extends StatefulWidget {
  @override
  _DietTrackingScreenState createState() => _DietTrackingScreenState();
}

class _DietTrackingScreenState extends State<DietTrackingScreen> {
  var db = new DBHelper();
  List<Food> foodList = [];

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 8));
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  String widgetKeyFormat = "yyyy-MM-dd";
  Map<String, Widget> widgets = Map();


  @override
  Widget build(BuildContext context) {
    String key = selectedDate.toString().split(" ")[0];
    widgets.putIfAbsent(key, () => FoodLog(key));

    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Tracking"),
      ),
      body: ScrollingDayCalendar(
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        onDateChange: (direction, DateTime selectedDate) {
          setState(() {
            this.selectedDate = selectedDate;
          });
        },
        dateStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        // pageItems: _pageItems,
        displayDateFormat: "MM/dd/yyyy",
        dateBackgroundColor: Theme.of(context).accentColor,
        forwardIcon: Icons.arrow_forward,
        backwardIcon: Icons.arrow_back,
        pageChangeDuration: Duration(
          milliseconds: 400,
        ),
        widgets: widgets,
        widgetKeyFormat: widgetKeyFormat,
        noItemsWidget: Center(
          child: Text(
              ""), // add buttons etc here to add new items for date
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: new AppBar(
  //       title: new Text("Circular Percent Indicators"),
  //     ),
  //     body: Center(
  //       child: ListView(
  //           children: <Widget>[
  //             new CircularPercentIndicator(
  //               radius: 100.0,
  //               lineWidth: 10.0,
  //               percent: 0.8,
  //               header: new Text("Icon header"),
  //               center: new Icon(
  //                 Icons.person_pin,
  //                 size: 50.0,
  //                 color: Colors.blue,
  //               ),
  //               backgroundColor: Colors.grey,
  //               progressColor: Colors.blue,
  //             ),
  //             new CircularPercentIndicator(
  //               radius: 130.0,
  //               animation: true,
  //               animationDuration: 1200,
  //               lineWidth: 15.0,
  //               percent: 0.4,
  //               center: new Text(
  //                 "40 hours",
  //                 style:
  //                 new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  //               ),
  //               circularStrokeCap: CircularStrokeCap.butt,
  //               backgroundColor: Colors.yellow,
  //               progressColor: Colors.red,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(15.0),
  //               child: new CircularPercentIndicator(
  //                 radius: 60.0,
  //                 lineWidth: 5.0,
  //                 percent: 1.0,
  //                 center: new Text("100%"),
  //                 progressColor: Colors.green,
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(15.0),
  //               child: new Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   new CircularPercentIndicator(
  //                     radius: 45.0,
  //                     lineWidth: 4.0,
  //                     percent: 0.10,
  //                     center: new Text("10%"),
  //                     progressColor: Colors.red,
  //                   ),
  //                   new Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 10.0),
  //                   ),
  //                   new CircularPercentIndicator(
  //                     radius: 45.0,
  //                     lineWidth: 4.0,
  //                     percent: 0.30,
  //                     center: new Text("30%"),
  //                     progressColor: Colors.orange,
  //                   ),
  //                   new Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 10.0),
  //                   ),
  //                   new CircularPercentIndicator(
  //                     radius: 45.0,
  //                     lineWidth: 4.0,
  //                     percent: 0.60,
  //                     center: new Text("60%"),
  //                     progressColor: Colors.yellow,
  //                   ),
  //                   new Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 10.0),
  //                   ),
  //                   new CircularPercentIndicator(
  //                     radius: 45.0,
  //                     lineWidth: 4.0,
  //                     percent: 0.90,
  //                     center: new Text("90%"),
  //                     progressColor: Colors.green,
  //                   )
  //                 ],
  //               ),
  //             ),
  //
  //             Padding(
  //               padding: EdgeInsets.all(15.0),
  //               child: new LinearPercentIndicator(
  //                 width: MediaQuery.of(context).size.width - 50,
  //                 animation: true,
  //                 lineHeight: 20.0,
  //                 animationDuration: 2000,
  //                 percent: 0.9,
  //                 center: Text("90.0%"),
  //                 linearStrokeCap: LinearStrokeCap.roundAll,
  //                 progressColor: Colors.greenAccent,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(15.0),
  //               child: new LinearPercentIndicator(
  //                 width: MediaQuery.of(context).size.width - 50,
  //                 animation: true,
  //                 lineHeight: 20.0,
  //                 animationDuration: 2500,
  //                 percent: 0.8,
  //                 center: Text("80.0%"),
  //                 linearStrokeCap: LinearStrokeCap.roundAll,
  //                 progressColor: Colors.green,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(15.0),
  //               child: Column(
  //                 children: <Widget>[
  //                   new LinearPercentIndicator(
  //                     width: 100.0,
  //                     lineHeight: 8.0,
  //                     percent: 0.2,
  //                     progressColor: Colors.red,
  //                   ),
  //                   new LinearPercentIndicator(
  //                     width: 100.0,
  //                     lineHeight: 8.0,
  //                     percent: 0.5,
  //                     progressColor: Colors.orange,
  //                   ),
  //                   new LinearPercentIndicator(
  //                     width: 100.0,
  //                     lineHeight: 8.0,
  //                     percent: 0.9,
  //                     progressColor: Colors.blue,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ]),
  //     ),
  //   );
  // }
}
