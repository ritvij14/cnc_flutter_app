import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyCalorieWidget extends StatefulWidget {
  @override
  _WeeklyCalorieWidgetState createState() => _WeeklyCalorieWidgetState();
}

class _WeeklyCalorieWidgetState extends State<WeeklyCalorieWidget> {
  List<FoodLogEntry> foodLogEntries = [];
  List<DailyCalorieTotal> data = [];
  Map map = Map<String, double>();

  getFood() async {
    var db = new DBHelper();
    DateTime selectedDate;
    for (int i = 7; i >= 0; i--) {
      foodLogEntries.clear();
      selectedDate = DateTime.now().subtract(Duration(days: i));
      String key = selectedDate.toString().split(" ")[0];
      var response = await db.getFoodLog('1', key);
      var data = json.decode(response.body);
      double kcal = 0;
      map.putIfAbsent(key, () => kcal);
      for (int i = 0; i < data.length; i++) {
        FoodLogEntry foodLogEntry = new FoodLogEntry();
        foodLogEntry.id = data[i]['id'];
        foodLogEntry.entryTime = data[i]['entryTime'];
        foodLogEntry.date = data[i]['date'];
        foodLogEntry.portion = data[i]['portion'];
        Food food = new Food();
        String description = data[i]['food']['description'].toString();
        description = description.replaceAll('"', "");
        food.description = description;
        food.kcal = data[i]['food']['kcal'];
        food.proteinInGrams = data[i]['food']['proteinInGrams'];
        food.carbohydratesInGrams = data[i]['food']['carbohydratesInGrams'];
        food.fatInGrams = data[i]['food']['fatInGrams'];
        food.alcoholInGrams = data[i]['food']['alcoholInGrams'];
        food.saturatedFattyAcidsInGrams =
            data[i]['food']['saturatedFattyAcidsInGrams'];
        food.polyunsaturatedFattyAcidsInGrams =
            data[i]['food']['polyunsaturatedFattyAcidsInGrams'];
        food.monounsaturatedFattyAcidsInGrams =
            data[i]['food']['monounsaturatedFattyAcidsInGrams'];
        food.insolubleFiberInGrams = data[i]['food']['insolubleFiberInGrams'];
        food.solubleFiberInGrams = data[i]['food']['solubleFiberInGrams'];
        food.sugarInGrams = data[i]['food']['sugarInGrams'];
        food.calciumInMilligrams = data[i]['food']['calciumInMilligrams'];
        food.sodiumInMilligrams = data[i]['food']['sodiumInMilligrams'];
        food.vitaminDInMicrograms = data[i]['food']['vitaminDInMicrograms'];
        food.commonPortionSizeAmount =
            data[i]['food']['commonPortionSizeAmount'];
        food.commonPortionSizeGramWeight =
            data[i]['food']['commonPortionSizeGramWeight'];
        food.commonPortionSizeDescription =
            data[i]['food']['commonPortionSizeDescription'];
        food.commonPortionSizeUnit = data[i]['food']['commonPortionSizeUnit'];
        foodLogEntry.food = food;
        foodLogEntries.add(foodLogEntry);
      }
      for (FoodLogEntry foodLogEntry in foodLogEntries) {
        double portion = foodLogEntry.portion;
        Food food = foodLogEntry.food;
        kcal += (food.kcal * portion);
      }
      map.update(key, (v) => kcal);
    }
    for (String key in map.keys) {
      data.add(DailyCalorieTotal(date: key, calorieTotal: map[key]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return SfCartesianChart(

            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: CategoryAxis(isVisible: false, labelRotation: 45),
            primaryYAxis: NumericAxis(isVisible: false, plotBands: <PlotBand>[
              PlotBand(
                  // verticalTextPadding:'2%',
                  // horizontalTextPadding: '-37%',
                  // text: 'Goal',
                  // textAngle: 0,
                  start: 1200,
                  end: 1200,
                  textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  borderColor: Colors.purple,
                  borderWidth: 4)
            ]),
            // legend: Legend(isVisible: true),
            legend: Legend(
                isVisible: false,
                // Legend will be placed at the left
                position: LegendPosition.bottom),
            title: ChartTitle(text: 'Calorie totals past over past week'),
            borderColor: Theme.of(context).canvasColor,
            backgroundColor: Theme.of(context).accentColor,
            // borderWidth: 4,
            // plotAreaBorderColor: Colors.red,
            // plotAreaBorderWidth: 3,
            // enableSideBySideSeriesPlacement: false,
            //Chart title.
            // legend: Legend(isVisible: true), // Enables the legend.
            // tooltipBehavior: ChartTooltipBehavior(enable: true), // Enables the tooltip.
            series: <LineSeries<DailyCalorieTotal, String>>[
              LineSeries<DailyCalorieTotal, String>(
                name: 'Calories Consumed',
                dataSource: data,
                xValueMapper: (DailyCalorieTotal dailyCalorieTotal, _) =>
                    dailyCalorieTotal.date,
                yValueMapper: (DailyCalorieTotal dailyCalorieTotal, _) =>
                    dailyCalorieTotal.calorieTotal,
                markerSettings: MarkerSettings(isVisible: true),
                enableTooltip: true,
                // dataLabelSettings: DataLabelSettings(isVisible: true) // Enables the data label.
              ),
            ]);
      },
      future: getFood(),
    );
  }
}

class DailyCalorieTotal {
  DailyCalorieTotal({this.date, this.calorieTotal});

  final String date;
  final double calorieTotal;
}
