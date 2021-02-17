// import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/widgets/food_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

// import '../food_screen.dart';

class DietTrackingScreen extends StatefulWidget {
  @override
  _DietTrackingScreenState createState() => _DietTrackingScreenState();
}

class _DietTrackingScreenState extends State<DietTrackingScreen> {
  var db = new DBHelper();
  List<Food> foodList = [];

  // Widget _pageItems = FoodLog();
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  String widgetKeyFormat = "yyyy-MM-dd";
  Map<String, Widget> widgets = Map();

  // getFood() async {
  //   var response = await db.getFood();
  //   var data = json.decode(response.body);
  //   for (int i = 0; i < data.length; i++) {
  //     // for (int i = 0; i < 10; i++) {
  //     Food food = new Food();
  //     food.description = data[i]['description'];
  //     food.kcal = data[i]['kcal'];
  //     food.proteinInGrams = data[i]['proteinInGrams'];
  //     food.carbohydratesInGrams = data[i]['carbohydratesInGrams'];
  //     food.fatInGrams = data[i]['fatInGrams'];
  //     foodList.add(food);
  //   }
  // }

  // doStuff(selectedDate) {
  //   this.selectedDate = selectedDate;
  //   DateTime newDate = selectedDate;
  //   // print(newDate.month);
  //   // print(newDate.day);
  //   // print(newDate.year);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     builder: (context, projectSnap) {
  //       return ListView.builder(
  //         itemCount: foodList.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             onTap: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => FoodPage(foodList[index])));
  //             },
  //             title: Text(foodList[index].description),
  //             subtitle: Text('Calories: ' + foodList[index].kcal.toString()),
  //             trailing: Icon(Icons.food_bank),
  //           );
  //         },
  //       );
  //     },
  //     future: getFood(),
  //   );
  // }

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
            // doStuff(selectedDate);
            // pageItems = _widgetBuilder(selectedDate);
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
              "No items have been added for this date"), // add buttons etc here to add new items for date
        ),
      ),
    );
  }
}
