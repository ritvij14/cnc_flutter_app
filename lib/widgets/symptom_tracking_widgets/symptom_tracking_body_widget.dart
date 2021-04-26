import 'dart:convert';

import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SymptomTrackingBody extends StatefulWidget {

  @override
  _SymptomTrackingBodyState createState() => _SymptomTrackingBodyState();
}

class _SymptomTrackingBodyState extends State<SymptomTrackingBody> {
  List<SymptomModel> symptomModelList = [];

  var db = new SymptomDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, projectSnap){
          return ListView.builder(
            itemCount: symptomModelList.length,
            itemBuilder: (context, index){
              return SymptomTrackingListTile(symptomModelList[index]);
            },
          );
        },
        future: test(),
      ),
    );
  }

  getSymptoms() async {
    symptomModelList.clear();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getSymptoms(int.parse(id));
    List<SymptomModel> newSymptomModelList = (json.decode(response.body) as List).map((data) => SymptomModel.fromJson(data)).toList();
    symptomModelList = newSymptomModelList;
  }

  test() {
  }


}
