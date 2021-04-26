import 'dart:convert';

import 'package:cnc_flutter_app/connections/symptom_db_helper.dart';
import 'package:cnc_flutter_app/models/symptom_model.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_input_symptoms_widget.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomTrackingScreen extends StatefulWidget {
  List<SymptomModel> symptomModelList = [];

  @override
  _SymptomTrackingScreenState createState() => _SymptomTrackingScreenState();
}

class _SymptomTrackingScreenState extends State<SymptomTrackingScreen> {

  var db = new SymptomDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(context, new MaterialPageRoute(builder:(context) => SymptomTrackingInputScreen()));
              refresh();

            },
          )
        ],
      ),
        body: FutureBuilder(
          builder: (context, projectSnap){
            return ListView.builder(
              itemCount: widget.symptomModelList.length,
              itemBuilder: (context, index){
                return SymptomTrackingListTile(widget.symptomModelList[index]);
              },
            );
          },
          future: getSymptoms(),
        ),
    );
  }
  getSymptoms() async {
    widget.symptomModelList.clear();
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    var response = await db.getSymptoms(int.parse(id));
    List<SymptomModel> newSymptomModelList = (json.decode(response.body) as List).map((data) => SymptomModel.fromJson(data)).toList();
    widget.symptomModelList = newSymptomModelList;
  }

  void refresh() {
    setState(() {});
  }
}
