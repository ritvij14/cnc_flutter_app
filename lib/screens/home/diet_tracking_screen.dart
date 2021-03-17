
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/widgets/food_log_widget.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';


class DietTrackingScreen extends StatefulWidget {
  @override
  _DietTrackingScreenState createState() => _DietTrackingScreenState();
}

class _DietTrackingScreenState extends State<DietTrackingScreen> {
  update(BuildContext context) {
    setState(() {

    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
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
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: FoodSearch(key))
                        .then((value) => rebuildAllChildren(context));
                  },
                  child: Icon(
                    Icons.add,
                    // size: 26.0,
                  ),
                )),
          ]),
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

}
