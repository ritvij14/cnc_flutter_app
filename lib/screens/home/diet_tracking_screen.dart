import 'dart:convert';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/material.dart';

import '../food_screen.dart';

class DietTrackingScreen extends StatefulWidget {
  @override
  _DietTrackingScreenState createState() => _DietTrackingScreenState();
}

class _DietTrackingScreenState extends State<DietTrackingScreen> {
  var db = new DBHelper();
  List<Food> foodList = [];

  getFood() async {
    var response = await db.getFood();
    var data = json.decode(response.body);
    for (int i = 0; i < data.length; i++) {
      // for (int i = 0; i < 10; i++) {
      Food food = new Food(
          data[i]['description'],
          data[i]['kcal'],
          data[i]['proteinInGrams'],
          data[i]['carbohydratesInGrams'],
          data[i]['fatInGrams']);
      foodList.add(food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodPage(foodList[index])));
              },
              title: Text(foodList[index].description),
              subtitle: Text('Calories: ' + foodList[index].kcal.toString()),
              trailing: Icon(Icons.food_bank),
            );
          },
        );
      },
      future: getFood(),
    );
  }
}
