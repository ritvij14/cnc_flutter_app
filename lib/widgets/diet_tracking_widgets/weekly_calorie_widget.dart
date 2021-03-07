import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class WeeklyCalorieWidget extends StatefulWidget {
  @override
  _WeeklyCalorieWidgetState createState() => _WeeklyCalorieWidgetState();

  WeeklyCalorieWidget() {
  }
}

class _WeeklyCalorieWidgetState extends State<WeeklyCalorieWidget> {

  _WeeklyCalorieWidgetState() {
  }

  List<Food> foods = [];
  List<FoodLogEntry> foodLogEntries = [];
  final List<SalesData> data = [
    SalesData(xval: DateTime(2018, 0, 2), yval: 800),
    SalesData(xval: DateTime(2018, 0, 3), yval: 1200),
    SalesData(xval: DateTime(2018, 0, 4), yval: 1400),
    SalesData(xval: DateTime(2018, 0, 5), yval: 900),
    SalesData(xval: DateTime(2018, 0, 6), yval: 2000),
    SalesData(xval: DateTime(2018, 0, 7), yval: 1400),
    SalesData(xval: DateTime(2018, 0, 8), yval: 1400)
  ];

  // final List<SalesData> data2 = [
  //   // SalesData(xval: DateTime(2018, 0, 1), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 2), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 3), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 4), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 5), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 6), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 7), yval: 1200),
  //   SalesData(xval: DateTime(2018, 0, 8), yval: 1200),
  //   // SalesData(xval: DateTime(2018, 0, 9), yval: 1200),
  // ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  getFood() async {
    foodLogEntries.clear();
    var db = new DBHelper();
    DateTime selectedDate;
    // for(int i = 0; i < 7; i++) {
    //   selectedDate = DateTime.now().subtract(Duration(days: i));
    //   String key = selectedDate.toString().split(" ")[0];
    //   print(key);
    //   var response = await db.getFoodLog('1', key);
    //   var data = json.decode(response.body);
    //   // print(data[0]['entryTime'].runtimeType);
    //   // var x = TimeOfDay.fromDateTime(data[0]['entryTime']);
    //   // print(x);
    //   // print(data);
    //   for (int i = 0; i < data.length; i++) {
    //     FoodLogEntry foodLogEntry = new FoodLogEntry();
    //     foodLogEntry.id = data[i]['id'];
    //     foodLogEntry.entryTime = data[i]['entryTime'];
    //     foodLogEntry.date = data[i]['date'];
    //     foodLogEntry.portion = data[i]['portion'];
    //     // print(data[i]);
    //     // print(data[i]['entryTime']);
    //     Food food = new Food();
    //     String description = data[i]['food']['description'].toString();
    //     description = description.replaceAll('"', "");
    //     food.description = description;
    //     food.kcal = data[i]['food']['kcal'];
    //     food.proteinInGrams = data[i]['food']['proteinInGrams'];
    //     food.carbohydratesInGrams = data[i]['food']['carbohydratesInGrams'];
    //     food.fatInGrams = data[i]['food']['fatInGrams'];
    //     food.alcoholInGrams = data[i]['food']['alcoholInGrams'];
    //     food.saturatedFattyAcidsInGrams =
    //     data[i]['food']['saturatedFattyAcidsInGrams'];
    //     food.polyunsaturatedFattyAcidsInGrams =
    //     data[i]['food']['polyunsaturatedFattyAcidsInGrams'];
    //     food.monounsaturatedFattyAcidsInGrams =
    //     data[i]['food']['monounsaturatedFattyAcidsInGrams'];
    //     food.insolubleFiberInGrams = data[i]['food']['insolubleFiberInGrams'];
    //     food.solubleFiberInGrams = data[i]['food']['solubleFiberInGrams'];
    //     food.sugarInGrams = data[i]['food']['sugarInGrams'];
    //     food.calciumInMilligrams = data[i]['food']['calciumInMilligrams'];
    //     food.sodiumInMilligrams = data[i]['food']['sodiumInMilligrams'];
    //     food.vitaminDInMicrograms = data[i]['food']['vitaminDInMicrograms'];
    //     food.commonPortionSizeAmount =
    //     data[i]['food']['commonPortionSizeAmount'];
    //     food.commonPortionSizeGramWeight =
    //     data[i]['food']['commonPortionSizeGramWeight'];
    //     food.commonPortionSizeDescription =
    //     data[i]['food']['commonPortionSizeDescription'];
    //     food.commonPortionSizeUnit = data[i]['food']['commonPortionSizeUnit'];
    //     foodLogEntry.food = food;
    //     foodLogEntries.add(foodLogEntry);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(

        tooltipBehavior: TooltipBehavior(
            enable: true),
        primaryXAxis: CategoryAxis(
          isVisible: false,
            labelRotation: 45



        ),
        primaryYAxis: NumericAxis(

            plotBands: <PlotBand>[
              PlotBand(
                  // verticalTextPadding:'2%',
                  // horizontalTextPadding: '-37%',
                  // text: 'Goal',
                  // textAngle: 0,
                  start: 1200,
                  end: 1200,
                  textStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  borderColor: Colors.purple,
                  borderWidth: 4
              )
            ]
        ),
        // legend: Legend(isVisible: true),
        legend: Legend(
            isVisible: false,
            // Legend will be placed at the left
            position: LegendPosition.bottom
        ),

        title: ChartTitle(text: 'Calorie totals past over past week'),
        borderColor: Colors.brown,
        borderWidth: 4,
        plotAreaBorderColor: Colors.red,
        plotAreaBorderWidth: 3,
        // enableSideBySideSeriesPlacement: false,
        //Chart title.
        // legend: Legend(isVisible: true), // Enables the legend.
        // tooltipBehavior: ChartTooltipBehavior(enable: true), // Enables the tooltip.
        series: <LineSeries<SalesData, String>>[

          LineSeries<SalesData, String>(
            name: 'Calories Consumed',
            dataSource: data,
              xValueMapper: (SalesData sales, _) => sales.xval.toString().split(" ")[0],
              yValueMapper: (SalesData sales, _) => sales.yval,
            markerSettings: MarkerSettings(isVisible:true),
            enableTooltip: true,
              // dataLabelSettings: DataLabelSettings(isVisible: true) // Enables the data label.
          ),
          // LineSeries<SalesData, String>(
          //   name: 'Goal',
          //     dataSource: data2,
          //     xValueMapper: (SalesData sales, _) => sales.xval.toString().split(" ")[0],
          //     yValueMapper: (SalesData sales, _) => sales.yval,
          //
          //     // dataLabelSettings: DataLabelSettings(isVisible: true) // Enables the data label.
          // )
        ]
    );
    return SfSparkLineChart.custom(
        dataCount: 5,
        marker: SparkChartMarker(
            borderColor: Colors.orange,
            borderWidth: 5,
            displayMode: SparkChartMarkerDisplayMode.all
        ),
        xValueMapper: (index) => data[index].xval,
        yValueMapper: (index) => data[index].yval,
        labelDisplayMode: SparkChartLabelDisplayMode.all,
        plotBand: SparkChartPlotBand(
        start: 1200,
        end: 1200,
        color: Colors.black
    )
    );
    return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 55),
                  child: new CircularPercentIndicator(
                    radius: 150.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 15.0,
                    percent: 0.4,
                    center: new Column(
                      children: [
                        Padding(padding: EdgeInsets.all(20)),
                        Text(
                          "700",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.0),
                        ),
                        Center(
                          child: Text(
                            "CALORIES UNDER BUDGET",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    // backgroundColor: Colors.yellow,
                    progressColor: Colors.red,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: 0.9,
                        center: Text("90.0%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: 0.8,
                        center: Text("80.0%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class SalesData {
  SalesData({this.xval, this.yval});
  final DateTime xval;
  final double yval;
}
