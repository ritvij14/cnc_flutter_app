import 'dart:convert';

import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_input_symptoms_widget.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class SymptomTrackingScreen extends StatefulWidget {
  List<SymptomModel> symptomModelList = [];

  @override
  _SymptomTrackingScreenState createState() => _SymptomTrackingScreenState();
}

class _SymptomTrackingScreenState extends State<SymptomTrackingScreen> {
  var db = new SymptomDBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, projectSnap) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Symptom Tracker'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                SymptomTrackingInputScreen()));
                    await getSymptoms();
                    refresh();
                  },
                )
              ],
            ),
              body: StickyGroupedListView<SymptomModel, DateTime>(
                  floatingHeader: true,
                  itemScrollController: GroupedItemScrollController(),
                  scrollDirection: Axis.vertical,
                  elements: widget.symptomModelList,
                  order: StickyGroupedListOrder.ASC,
                  groupBy: (SymptomModel element) => DateTime(
                      element.dateTime.year,
                      element.dateTime.month,
                      element.dateTime.day),
                  groupComparator: (DateTime value1, DateTime value2) =>
                      value2.compareTo(value1),
                  itemComparator: (SymptomModel element1, SymptomModel element2) =>
                      element1.dateTime.compareTo(element2.dateTime),
                  // floatingHeader: true,
                  groupSeparatorBuilder: (SymptomModel element) => Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          border: Border.all(
                            color: Colors.blue[300],
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${element.dateTime.month}/${element.dateTime.day}/${element.dateTime.year}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (_, SymptomModel element) {
                    return Container(
                      child: SymptomTrackingListTile(element),
                    );
                  }));
        },
      future: getSymptoms(),
    );
  }

        getSymptoms()
    async {
      var sharedPref = await SharedPreferences.getInstance();
      String id = sharedPref.getString('id');
      var response = await db.getSymptoms(int.parse(id));
      List<SymptomModel> newSymptomModelList =
      (json.decode(response.body) as List)
          .map((data) => SymptomModel.fromJson(data))
          .toList();
      widget.symptomModelList = newSymptomModelList;
    }

    void refresh() {
      setState(() {});
    }
  }
