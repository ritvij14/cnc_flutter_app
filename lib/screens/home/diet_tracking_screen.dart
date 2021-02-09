import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/material.dart';

import '../food_screen.dart';

class DietTrackingScreen extends StatefulWidget {
  @override
  _DietTrackingScreenState createState() => _DietTrackingScreenState();
}

class _DietTrackingScreenState extends State<DietTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    List<Food> foodList = [];
    Food food1 =
        new Food('Baby food, apples and chicken', 65, 2.16, 10.87, 1.38);
    Food food2 = new Food('Baby food, apples and ham', 62, 2.6, 10.9, 0.9);
    Food food3 = new Food(
        'Baby food, animal crackers, cinnamon', 434.64, 6.32, 70.84, 14.387);
    Food food4 =
        new Food('Baby food, apples and sweet potato', 64, 0.3, 15.3, 0.22);
    Food food5 = new Food('Banana bread', 260.086, 3.77, 44.393, 7.968);
    foodList.add(food1);
    foodList.add(food2);
    foodList.add(food3);
    foodList.add(food4);
    foodList.add(food5);
    foodList.add(food1);
    foodList.add(food2);
    foodList.add(food3);
    foodList.add(food4);
    foodList.add(food5);
    return MaterialApp(
      title: 'Diet Log',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Diet Log'),
        ),
        body: ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FoodPage(foodList[index].description)));
              },
              title: Text(foodList[index].description),
              subtitle: Text('Calories: ' + foodList[index].kcal.toString()),
              trailing: Icon(Icons.food_bank),
            );
          },
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Diet Log'),
    //     // actions: <Widget>[
    //     //   IconButton(
    //     //       icon: Icon(Icons.search),
    //     //       onPressed: () {
    //     //         showSearch(context: context, delegate: SearchScreen());
    //     //       })
    //     // ],
    //   )
    //   ,
    //   body: Text('Diet Tracking Screen'),
    // );
  }
}
