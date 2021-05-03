import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/weekly_activity_progress_widget.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/daily_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/weekly_calorie_widget.dart';
import 'package:cnc_flutter_app/widgets/home_screen_widgets/metric_summary_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DietSummaryWidget extends StatefulWidget {
  @override
  _DietSummaryWidgetState createState() => _DietSummaryWidgetState();
}

class _DietSummaryWidgetState extends State<DietSummaryWidget> {
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  int _currentIndex = 0;

  List cardList = [DailySummaryWidget(), WeeklyActivityProgressWidget(), WeeklyCalorieWidget(), MetricSummaryWidget()];

  List<Food> foods = [];
  List<FoodLogEntry> foodLogEntries = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    return Column(
      children: <Widget>[
        InkWell(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 340,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: cardList
                .map((item) => Container(
                      child: item,
                    ))
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(cardList, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Theme.of(context).buttonColor : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
