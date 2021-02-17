// import 'dart:convert';
import 'dart:math';

import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
// import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:cnc_flutter_app/widgets/food_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodLog extends StatelessWidget {
  List<Food> breakfast = [];
  List<Food> lunch = [];
  List<Food> dinner = [];
  List<Food> snacks = [];
  String selectedDate;

  FoodLog(String key) {
    this.selectedDate = key;
  }

  getBreakfast() {}

  getLunch() {}

  getDinner() {}

  getSnacks() {}

  generateFood() async {
    var rng = new Random();
    if (breakfast.length == 0 &&
        lunch.length == 0 &&
        dinner.length == 0 &&
        snacks.length == 0) {
      for (int i = 0; i < 4; i++) {
        int numberOfFoods = rng.nextInt(5) + 1;
        for (var j = 0; j < numberOfFoods; j++) {
          Food food = new Food();
          food.description = 'Example Food ' + i.toString() + j.toString();
          food.kcal = rng.nextInt(250).toDouble();
          food.proteinInGrams = rng.nextInt(30).toDouble();
          food.carbohydratesInGrams = rng.nextInt(30).toDouble();
          food.fatInGrams = rng.nextInt(30).toDouble();
          if (i == 0) {
            breakfast.add(food);
          } else if (i == 1) {
            lunch.add(food);
          } else if (i == 2) {
            dinner.add(food);
          } else {
            snacks.add(food);
          }
        }
      }
    }

    var db = new DBHelper();
    var response = await db.searchFood('');
    // var data = json.decode(response.body);
    // // for (int i = 0; i < data.length; i++) {
    // for (int i = 0; i < 10; i++) {
    //   Food food = new Food();
    //   String description = data[i]['description'].toString();
    //   description = description.replaceAll('"', "");
    //   food.description = description;
    //   food.kcal = data[i]['kcal'];
    //   food.proteinInGrams = data[i]['proteinInGrams'];
    //   food.carbohydratesInGrams = data[i]['carbohydratesInGrams'];
    //   food.fatInGrams = data[i]['fatInGrams'];
    //   breakfast.add(food);
    // }
  }

  @override
  Widget build(BuildContext context) {
    generateFood();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      // child: Padding:
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Breakfast",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "OpenSans"),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    showSearch(context: context, delegate: FoodSearch());
                  }),
            ],
          ),
        ),
        // Row(
        //
        //   children: <Widget>[
        //     Text(
        //       "Breakfast",
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16,
        //           fontFamily: "OpenSans"),
        //     ),
        //   ],
        // ),

        // Card(
        //     child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Text("Breakfast", style: TextStyle(fontSize: 14.0)))),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // padding: EdgeInsets.all(16),
              itemCount: breakfast.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              breakfast[index].description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    breakfast[index]
                                            .carbohydratesInGrams
                                            .toString() +
                                        "C",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    breakfast[index].proteinInGrams.toString() +
                                        "P",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    breakfast[index].fatInGrams.toString() +
                                        "F",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // print("Pressed");
                                      // List<TrackedFood> foodToDelete = [food];
                                      // var user = Provider.of<User>(context);
                                      // var db = DatabaseService(uid: user.uid);
                                      // db.deleteAFood(
                                      //     foodToDelete, currentMeal.mealName);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            child: Text(
                              // breakfast[index].serving + " " + breakfast[index].unit,
                              "1.0 serving(s) ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: getBreakfast(),
        ),
        // FlatButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => FoodSearch(breakfast)));
        //   },
        //   child: Text(
        //     "Add More",
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Lunch",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "OpenSans"),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    showSearch(context: context, delegate: FoodSearch());
                  }),
            ],
          ),
        ),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: lunch.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              lunch[index].description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    lunch[index]
                                            .carbohydratesInGrams
                                            .toString() +
                                        "C",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    lunch[index].proteinInGrams.toString() +
                                        "P",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    lunch[index].fatInGrams.toString() + "F",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // print("Pressed");
                                      // List<TrackedFood> foodToDelete = [food];
                                      // var user = Provider.of<User>(context);
                                      // var db = DatabaseService(uid: user.uid);
                                      // db.deleteAFood(
                                      //     foodToDelete, currentMeal.mealName);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            child: Text(
                              // breakfast[index].serving + " " + breakfast[index].unit,
                              "1.0 serving(s) ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: getLunch(),
        ),
        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Dinner",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "OpenSans"),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    showSearch(context: context, delegate: FoodSearch());
                  }),
            ],
          ),
        ),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dinner.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              dinner[index].description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    dinner[index]
                                            .carbohydratesInGrams
                                            .toString() +
                                        "C",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    dinner[index].proteinInGrams.toString() +
                                        "P",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    dinner[index].fatInGrams.toString() + "F",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // print("Pressed");
                                      // List<TrackedFood> foodToDelete = [food];
                                      // var user = Provider.of<User>(context);
                                      // var db = DatabaseService(uid: user.uid);
                                      // db.deleteAFood(
                                      //     foodToDelete, currentMeal.mealName);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            child: Text(
                              // breakfast[index].serving + " " + breakfast[index].unit,
                              "1.0 serving(s) ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: getDinner(),
        ),

        Container(
          padding: EdgeInsets.only(left: 5, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Snacks",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "OpenSans"),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    showSearch(context: context, delegate: FoodSearch());
                  }),
            ],
          ),
        ),
        FutureBuilder(
          builder: (context, projectSnap) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snacks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              snacks[index].description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    snacks[index]
                                            .carbohydratesInGrams
                                            .toString() +
                                        "C",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    snacks[index].proteinInGrams.toString() +
                                        "P",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  Text(
                                    snacks[index].fatInGrams.toString() + "F",
                                    style: TextStyle(
                                        fontFamily: "OpenSans", fontSize: 10),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // print("Pressed");
                                      // List<TrackedFood> foodToDelete = [food];
                                      // var user = Provider.of<User>(context);
                                      // var db = DatabaseService(uid: user.uid);
                                      // db.deleteAFood(
                                      //     foodToDelete, currentMeal.mealName);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            child: Text(
                              // breakfast[index].serving + " " + breakfast[index].unit,
                              "1.0 serving(s) ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: getSnacks(),
        ),
      ]),
    );
  }

  // @override
  // Widget build2(BuildContext context) {
  //   generateFood();
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: Column(children: <Widget>[Expanded()]),
  //   );
  // }
}
