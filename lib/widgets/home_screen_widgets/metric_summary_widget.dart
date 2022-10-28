import 'dart:convert';

import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MetricSummaryWidget extends StatefulWidget {
  @override
  _MetricSummaryWidgetState createState() => _MetricSummaryWidgetState();
}

class _MetricSummaryWidgetState extends State<MetricSummaryWidget> {
  var backgroundColor = Colors.white;
  MetricDBHelper db = new MetricDBHelper();
  bool showAll = false;
  List<FlSpot> spots = [
    FlSpot(0, 0),
  ];

  //0 = 10 days, 1 = 30 days, 2 = 1 year
  int chart = 0;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    backgroundColor = Theme.of(context).canvasColor;
    ;
    // const bgcol = Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black45;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(colors: [
          Theme.of(context).canvasColor,
          Theme.of(context).canvasColor,
        ]),
      ),
      // color: Colors.lightGreen,
      // height: 150.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Historical Weight Chart",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: new Text(
                  "Weight (lbs)",
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    if (chart == 2) {
                      chart = 0;
                    } else {
                      chart++;
                    }
                  });
                },
                child: (chart == 0)
                    ? Text(
                        '10 Days',
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                        ),
                      )
                    : (chart == 1)
                        ? Text(
                            '30 Days',
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                            ),
                          )
                        : Text(
                            "Year",
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              //   child: IconButton(
              //     onPressed: (){
              //       Navigator.pushNamed(context, '/metricTracking');
              //     },
              //       icon: Icon(Icons.arrow_right_sharp),
              //   ),
              // ),
            ],
          ),
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 30.0, left: 0.0, top: 24, bottom: 12),
                    child: LineChart(
                      (chart == 0)
                          ? tenDays()
                          : (chart == 1)
                              ? thirtyDays()
                              : year(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  LineChartData tenDays() {
    setSpots(10);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return DateFormat('MM/dd')
                    .format(DateTime.now().subtract(Duration(days: 10)));

              case 5:
                return DateFormat('MM/dd')
                    .format(DateTime.now().subtract(Duration(days: 5)));
              case 10:
                return DateFormat('MM/dd').format(DateTime.now());
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => TextStyle(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 50:
                return '50';
              case 110:
                return '110';
              case 170:
                return '170';
              case 230:
                return '230';
              case 290:
                return '290';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 50,
      maxY: 300,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData thirtyDays() {
    setSpots(30);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return DateFormat('MM/dd')
                    .format(DateTime.now().subtract(Duration(days: 30)));

              case 15:
                return DateFormat('MM/dd')
                    .format(DateTime.now().subtract(Duration(days: 15)));
              case 30:
                return DateFormat('MM/dd').format(DateTime.now());
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 50:
                return '50';
              case 110:
                return '110';
              case 170:
                return '170';
              case 230:
                return '230';
              case 290:
                return '290';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 30,
      minY: 50,
      maxY: 300,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData year() {
    setSpots(365);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return DateFormat('MM/yyyy')
                    .format(DateTime.now().subtract(Duration(days: 365)));

              case 180:
                return DateFormat('MM/yyyy')
                    .format(DateTime.now().subtract(Duration(days: 180)));
              case 360:
                return DateFormat('MM/yyyy').format(DateTime.now());
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 50:
                return '50';
              case 110:
                return '110';
              case 170:
                return '170';
              case 230:
                return '230';
              case 290:
                return '290';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 365,
      minY: 50,
      maxY: 300,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  void initState() {
    setState(() {
      setSpots(10);
    });
  }

  void refresh() {
    setState(() {});
  }

  Future<void> setSpots(int days) async {
    var sharedPref = await SharedPreferences.getInstance();
    int id = int.parse(sharedPref.getString('id')!);
    var response = await db.getMetricsForPastDays(id, days);
    List<MetricModel> metricModelList = (json.decode(response.body) as List)
        .map((data) => MetricModel.fromJson(data))
        .toList();

    List<FlSpot> spots = [];
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day - 1);

    for (MetricModel met in metricModelList) {
      if (days -
              (lastMidnight.difference(met.dateTime).inDays).toDouble() -
              1 >=
          0) {
        spots.add(FlSpot(
            days -
                (lastMidnight.difference(met.dateTime).inDays).toDouble() -
                1,
            met.weight.toDouble()));
      }
    }
    if (spots.length > 0) {
      this.spots = spots;
      refresh();
    }
  }
}
