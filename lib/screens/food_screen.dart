import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

// void main() {
//   runApp(new MaterialApp(
//     home: new FoodPage(),
//   ));
// }

class FoodPage extends StatefulWidget {
  String selection;

  FoodPage(String selection) {
    this.selection = selection;
  }

  @override
  FoodProfile createState() => FoodProfile(selection);
}

class FoodProfile extends State<FoodPage> {
  Food currentFood;

  FoodProfile(String selection) {
    Food food1 =
        new Food('Baby food, apples and chicken', 65, 2.16, 10.87, 1.38);
    Food food2 = new Food('Baby food, apples and ham', 62, 2.6, 10.9, 0.9);
    Food food3 = new Food(
        'Baby food, animal crackers, cinnamon', 434.64, 6.32, 70.84, 14.387);
    Food food4 =
        new Food('Baby food, apples and sweet potato', 64, 0.3, 15.3, 0.22);
    Food food5 = new Food('Banana bread', 260.086, 3.77, 44.393, 7.968);

    if (selection == 'Baby food, apples and chicken') {
      currentFood = food1;
    } else if (selection == 'Baby food, apples and ham') {
      currentFood = food2;
    } else if (selection == 'Baby food, animal crackers, cinnamon') {
      currentFood = food3;
    } else if (selection == 'Baby food, apples and sweet potato') {
      currentFood = food4;
    } else if (selection == 'Banana bread') {
      currentFood = food5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrients per 100 grams'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Text('Calories: ' + currentFood.kcal.toString()),
            Text('Protein: ' + currentFood.protein.toString() + 'g'),
            Text(
                'Carbohydrates: ' + currentFood.carbohydrates.toString() + 'g'),
            Text('Fat: ' + currentFood.fat.toString() + 'g')
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
