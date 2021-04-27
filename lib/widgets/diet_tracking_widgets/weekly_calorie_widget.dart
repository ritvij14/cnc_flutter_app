import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeeklyCalorieWidget extends StatefulWidget {
  @override
  _WeeklyCalorieWidgetState createState() => _WeeklyCalorieWidgetState();
}

class _WeeklyCalorieWidgetState extends State<WeeklyCalorieWidget> {
  List<FoodLogEntry> foodLogEntries = [];
  Map map = Map<String, double>();
  var weekDays = ['', '', '', '', '', '', ''];
  double dailyCalorieLimit = 1200;

  List<double> yValues = [0, 0, 0, 0, 0, 0, 0];

  getFood() async {
    var db = new DBHelper();
    DateTime selectedDate;
    for (int i = 6; i >= 0; i--) {
      foodLogEntries.clear();
      selectedDate = DateTime.now().subtract(Duration(days: i));
      String key = selectedDate.toString().split(" ")[0];
      var response = await db.getFoodLog(key);
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
    weekDays.clear();
    yValues.clear();
    for (String key in map.keys) {
      String newKey = key.split('-')[1] + '-' + key.split('-')[2];
      double v = double.parse(map[key].toStringAsFixed(2));
      weekDays.add(newKey);
      yValues.add(v);
    }

    var x = await db.getUserInfo();
    var userData = json.decode(x.body);

    if(userData['weight'] <= 174) {
      dailyCalorieLimit = 1200;
    } else if(userData['weight'] > 174 && userData['weight'] <= 219) {
      dailyCalorieLimit = 1500;
    } else if(userData['weight'] > 219 && userData['weight'] <= 249) {
      dailyCalorieLimit = 1800;
    } else {
      dailyCalorieLimit = 2000;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children:  <Widget>[
                // Text(
                //   'Average Line',
                //   style: TextStyle(
                //       color: Colors.green,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                // ),
                Text(
                  'Calorie totals last 7 days ',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                // Text(
                //   ' and ',
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                // ),
                // Text(
                //   'Indicators',
                //   style: TextStyle(
                //       color: Colors.blue,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                // ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 14.0, right: 14.0),
              child: SizedBox(
                width: double.infinity,
                height:233,
                child: LineChart(
                  LineChartData(
                    clipData: FlClipData.all(),
                    maxY: 3000,
                    lineTouchData: LineTouchData(
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((spotIndex) {
                          final FlSpot spot = barData.spots[spotIndex];
                          // if (spot.x == 0 || spot.x == 6) {
                          //   return null;
                          // }
                          return TouchedSpotIndicatorData(
                            FlLine(color: Theme.of(context).accentColor, strokeWidth: 4),
                            FlDotData(
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                    radius: 8,
                                    color: Colors.white,
                                    strokeWidth: 5,
                                    strokeColor: Theme.of(context).buttonColor);
                                if (index % 2 == 0) {
                                  return FlDotCirclePainter(
                                      radius: 8,
                                      color: Colors.white,
                                      strokeWidth: 5,
                                      strokeColor: Colors.deepOrange);
                                } else {
                                  return FlDotSquarePainter(
                                    size: 16,
                                    color: Colors.white,
                                    strokeWidth: 5,
                                    strokeColor: Colors.deepOrange,
                                  );
                                }
                              },
                            ),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor:Theme.of(context).accentColor,
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              final flSpot = barSpot;
                              // if (flSpot.x == 0 || flSpot.x == 6) {
                              //   return null;
                              // }

                              return LineTooltipItem(
                                '${weekDays[flSpot.x.toInt()]} \n${flSpot.y.round()} calories',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          }),
                      // touchCallback: (LineTouchResponse lineTouch) {
                      //   if (lineTouch.lineBarSpots.length == 1 &&
                      //       lineTouch.touchInput is! FlLongPressEnd &&
                      //       lineTouch.touchInput is! FlPanEnd) {
                      //     final value = lineTouch.lineBarSpots[0].x;
                      //
                      //     // if (value == 0 || value == 6) {
                      //       // setState(() {
                      //       //   touchedValue = -1;
                      //       // });
                      //       // return null;
                      //     // }
                      //
                      //     // setState(() {
                      //     //   touchedValue = value;
                      //     // });
                      //   // } else {
                      //     // setState(() {
                      //     //   touchedValue = -1;
                      //     // });
                      //   }
                      // }
                    ),
                    extraLinesData: ExtraLinesData(horizontalLines: [
                      HorizontalLine(
                        label: HorizontalLineLabel(
                            show: true,
                            style: TextStyle(color: Theme.of(context).hintColor,fontSize: 14),
                            labelResolver: (line) =>
                                '${dailyCalorieLimit.round()}'),
                        y: dailyCalorieLimit,
                        color: Colors.lightGreen.withOpacity(0.8),
                        strokeWidth: 3,
                        dashArray: [20, 2],
                      ),
                    ]),
                    lineBarsData: [
                      LineChartBarData(
                        isStepLineChart: true,
                        spots: yValues.asMap().entries.map((e) {
                          return FlSpot(e.key.toDouble(), e.value);
                        }).toList(),
                        isCurved: false,
                        barWidth: 4,
                        colors: [
                          Theme.of(context).buttonColor,
                        ],
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [
                            Theme.of(context).buttonColor.withOpacity(0.5),
                            Theme.of(context).buttonColor.withOpacity(0.0),
                          ],
                          gradientColorStops: [0.5, 1.0],
                          gradientFrom: const Offset(0, 0),
                          gradientTo: const Offset(0, 1),
                          spotsLine: BarAreaSpotsLine(
                            show: true,
                            flLineStyle: FlLine(
                              color: Theme.of(context).buttonColor,
                              strokeWidth: 2,
                            ),
                            checkToShowSpotLine: (spot) {
                              return true;
                              if (spot.x == 0 || spot.x == 6) {
                                return false;
                              }

                              return true;
                            },
                          ),
                        ),
                        dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                  radius: 6,
                                  color: Colors.white,
                                  strokeWidth: 3,
                                  strokeColor: Colors.lightGreen);
                              if (index % 2 == 0) {
                                return FlDotCirclePainter(
                                    radius: 6,
                                    color: Colors.white,
                                    strokeWidth: 3,
                                    strokeColor: Colors.deepOrange);
                              } else {
                                return FlDotSquarePainter(
                                  size: 12,
                                  color: Colors.white,
                                  strokeWidth: 3,
                                  strokeColor: Colors.deepOrange,
                                );
                              }
                            },
                            checkToShowDot: (spot, barData) {
                              return true;
                              return spot.x != 0 && spot.x != 6;
                            }),
                      ),
                    ],
                    minY: 0,
                    gridData: FlGridData(
                      show: false,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        if (value == 0) {
                          return FlLine(
                            color:Theme.of(context).accentColor,
                            strokeWidth: 2,
                          );
                        } else {
                          return FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        }
                      },
                      getDrawingVerticalLine: (value) {
                        if (value == 0) {
                          return FlLine(
                            color: Theme.of(context).hintColor,
                            strokeWidth: 2,
                          );
                        } else {
                          return FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        }
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        // getTitles: (value) {
                        //   switch (value.toInt()) {
                        //     case 0:
                        //       return '';
                        //     case 1:
                        //       return '1k calories';
                        //     case 2:
                        //       return '2k calories';
                        //     case 3:
                        //       return '3k calories';
                        //   }
                        //
                        //   return '';
                        // },
                        getTextStyles: (value) =>
                             TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
                      ),
                      bottomTitles: SideTitles(
                        margin: 12,
                        rotateAngle: 70,
                        showTitles: true,
                        getTitles: (value) {
                          return weekDays[value.toInt()];
                        },
                        getTextStyles: (value) {
                          final isTouched = value == touchedValue;
                          return TextStyle(
                            fontSize: 14,
                            color: isTouched
                                ? Theme.of(context).hintColor
                                : Theme.of(context).hintColor.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      future: getFood(),
    );
  }

  double touchedValue;

  @override
  void initState() {
    touchedValue = -1;
    super.initState();
  }
}
