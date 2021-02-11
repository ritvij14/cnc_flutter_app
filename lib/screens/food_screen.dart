import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// void main() {
//   runApp(new MaterialApp(
//     home: new FoodPage(),
//   ));
// }

class FoodPage extends StatefulWidget {
  Food selection;

  FoodPage(Food selection) {
    this.selection = selection;
  }

  @override
  FoodProfile createState() => FoodProfile(selection);
}

class FoodProfile extends State<FoodPage> {
  Food currentFood;

  FoodProfile(Food selection) {
    currentFood = selection;
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
  }
}
