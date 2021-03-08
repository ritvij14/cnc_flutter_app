import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/daily_summary_widget.dart';
import 'package:cnc_flutter_app/widgets/diet_tracking_widgets/weekly_calorie_widget.dart';
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

  List cardList = [DailySummaryWidget(), WeeklyCalorieWidget()];

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
    rebuildAllChildren(context);
    return Column(
      children: <Widget>[
        InkWell(
          // onTap: () {
          //   Navigator.pushNamed(context, '/dietTracking')
          //       .then((value) => rebuildAllChildren(context));
          // },
          child: CarouselSlider(
            options: CarouselOptions(
              height: 310,
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
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

// class Item1 extends StatelessWidget {
//   const Item1({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(10),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               // padding: EdgeInsets.only(left: 55),
//               child: new CircularPercentIndicator(
//                 radius: 150.0,
//                 animation: true,
//                 animationDuration: 1200,
//                 lineWidth: 15.0,
//                 percent: 0.4,
//                 center: new Column(
//                   children: [
//                     Padding(padding: EdgeInsets.all(20)),
//                     Text(
//                       "500",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 40.0),
//                     ),
//                     Center(
//                       child: Text(
//                         "CALORIES UNDER BUDGET",
//                         textAlign: TextAlign.center,
//                         style: new TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 13.0),
//                       ),
//                     ),
//                   ],
//                 ),
//                 circularStrokeCap: CircularStrokeCap.butt,
//                 // backgroundColor: Colors.yellow,
//                 progressColor: Colors.red,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.only(top: 10),
//               child: new Row(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   new CircularPercentIndicator(
//                     radius: 45.0,
//                     lineWidth: 4.0,
//                     percent: 0.10,
//                     center: new Text("10%"),
//                     footer: Text("Protein"),
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
//                     footer: Text("Carbs"),
//                     progressColor: Colors.orange,
//                   ),
//                   new Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   ),
//                   new CircularPercentIndicator(
//                     radius: 45.0,
//                     lineWidth: 4.0,
//                     percent: 0.60,
//                     footer: Text("Fat"),
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
//                     footer: Text("Sugar"),
//                     center: new Text("90%"),
//                     progressColor: Colors.red,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ));
//   }
// }

// class Item2 extends StatelessWidget {
//   const Item2({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   // padding: EdgeInsets.only(left: 55),
//                   child: new CircularPercentIndicator(
//                     radius: 150.0,
//                     animation: true,
//                     animationDuration: 1200,
//                     lineWidth: 15.0,
//                     percent: 0.4,
//                     center: new Column(
//                       children: [
//                         Padding(padding: EdgeInsets.all(20)),
//                         Text(
//                           "700",
//                           style: new TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 40.0),
//                         ),
//                         Center(
//                           child: Text(
//                             "CALORIES UNDER BUDGET",
//                             textAlign: TextAlign.center,
//                             style: new TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 13.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                     circularStrokeCap: CircularStrokeCap.butt,
//                     // backgroundColor: Colors.yellow,
//                     progressColor: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 new Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 10),
//                       child: new LinearPercentIndicator(
//                         width: MediaQuery.of(context).size.width - 50,
//                         animation: true,
//                         lineHeight: 20.0,
//                         animationDuration: 2000,
//                         percent: 0.9,
//                         center: Text("90.0%"),
//                         linearStrokeCap: LinearStrokeCap.roundAll,
//                         progressColor: Colors.greenAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 new Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 10),
//                       child: new LinearPercentIndicator(
//                         width: MediaQuery.of(context).size.width - 50,
//                         animation: true,
//                         lineHeight: 20.0,
//                         animationDuration: 2000,
//                         percent: 0.8,
//                         center: Text("80.0%"),
//                         linearStrokeCap: LinearStrokeCap.roundAll,
//                         progressColor: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }
