import 'dart:convert';
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodSearch extends SearchDelegate<String> {
  bool isSearching = false;
  var recentSearchList = [];
  List<Food> foodList = [];
  Food selection;
  String selectedDate;

  FoodSearch(String selectedDate) {
    this.selectedDate = selectedDate;
  }

  Future<bool> getFood() async {
    foodList.clear();
    recentSearchList.clear();
    var db = new DBHelper();
    var response = await db.searchFood(query);
    var data = json.decode(response.body);
    for (int i = 0; i < data.length; i++) {
      Food food = new Food();
      food.id = data[i]['id'];
      food.keylist = data[i]['keyList'];
      food.description = data[i]['description'];
      food.description = food.description.replaceAll('"', '');
      food.kcal = data[i]['kcal'];
      food.proteinInGrams = data[i]['proteinInGrams'];
      food.carbohydratesInGrams = data[i]['carbohydratesInGrams'];
      food.fatInGrams = data[i]['fatInGrams'];
      food.alcoholInGrams = data[i]['alcoholInGrams'];
      food.saturatedFattyAcidsInGrams = data[i]['saturatedFattyAcidsInGrams'];
      food.polyunsaturatedFattyAcidsInGrams =
          data[i]['polyunsaturatedFattyAcidsInGrams'];
      food.monounsaturatedFattyAcidsInGrams =
          data[i]['monounsaturatedFattyAcidsInGrams'];
      food.insolubleFiberInGrams = data[i]['insolubleFiberInGrams'];
      food.solubleFiberInGrams = data[i]['solubleFiberInGrams'];
      food.sugarInGrams = data[i]['sugarInGrams'];
      food.calciumInMilligrams = data[i]['calciumInMilligrams'];
      food.sodiumInMilligrams = data[i]['sodiumInMilligrams'];
      food.vitaminDInMicrograms = data[i]['vitaminDInMicrograms'];
      food.commonPortionSizeAmount = data[i]['commonPortionSizeAmount'];
      food.commonPortionSizeGramWeight = data[i]['commonPortionSizeGramWeight'];
      food.commonPortionSizeDescription =
          data[i]['commonPortionSizeDescription'];
      food.commonPortionSizeUnit = data[i]['commonPortionSizeUnit'];
      food.nccFoodGroupCategory = data[i]['nccFoodGroupCategory'];
      foodList.add(food);
    }
    return true;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //what actions will occur
    return [
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            query = '';
            // print(query);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icon showing on left
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  Icon getIcon(String category) {
    if (category == 'Vegetables and vegetable products') {
      return Icon(
        FontAwesomeIcons.carrot,
        color: Colors.green,
      );
    } else if (category == 'Meat, fish, and poultry') {
      return Icon(
        FontAwesomeIcons.drumstickBite,
        color: Colors.deepPurple,
      );
    } else if (category == 'Beverages') {
      return Icon(
        Icons.local_cafe,
        color: Colors.pink,
      );
    } else if (category == 'Desserts' ||
        category == 'Candy, sugar, and sweets') {
      return Icon(
        FontAwesomeIcons.birthdayCake,
        color: Colors.pinkAccent,
      );
    } else if (category == 'Grain products') {
      return Icon(
        FontAwesomeIcons.breadSlice,
        color: Colors.amber,
      );
    } else if (category == 'Milk, cream, cheese, and related products') {
      return Icon(
        FontAwesomeIcons.cheese,
        color: Colors.blue,
      );
    } else if (category == 'Fats, oils, and nuts') {
      return Icon(
        Icons.grain,
        color: Colors.brown,
      );
    } else if (category == 'Eggs and related products') {
      return Icon(
        FontAwesomeIcons.egg,
        color: Colors.yellow[100],
      );
    } else if (category == 'Fruits and fruit products') {
      return Icon(
        FontAwesomeIcons.appleAlt,
        color: Colors.red,
      );
    } else if (category == 'Commercial entrees and dinners') {
      return Icon(
        Icons.dinner_dining,
        color: Colors.lightGreenAccent,
      );
    } else if (category == 'Soups, gravy, and sauces') {
      return Icon(
        Icons.ramen_dining,
        color: Colors.deepOrangeAccent,
      );
    }
    print(category);
    // last is misc
    return Icon(
      Icons.food_bank,
      color: Colors.teal,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      recentSearchList.add(query);
      recentSearchList = new List.from(recentSearchList.reversed);
    }
    return FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              // return InkWell(
              //   splashColor: Colors.red,
              //   child: Card(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Container(
              //           width: 10,
              //           height: 50,
              //           child: Text(''),
              //           color: Colors.blue,
              //         ),
              //         Column(
              //           children: [
              //             Text('TEST'),
              //             Text('TEST'),
              //             Text('TEST'),
              //           ],
              //         ),
              //
              //       ],
              //     ),
              //
              //   ),
              // );
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            new MaterialPageRoute(
                                builder: (_) =>
                                    FoodPage(foodList[index], selectedDate)),
                          )
                          .then((val) => {getFood()});

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FoodPage(foodList[index], selectedDate)));
                    },

                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => FoodPage(searchResults[index], selectedDate)));
                    // },
                    title: Text(foodList[index].description),
                    // subtitle: Text(
                    //     'Calories: ' + searchResults[index].kcal.toString() + ' — ' + searchResults[index].commonPortionSizeAmount.toString() + ' ' + searchResults[index].commonPortionSizeDescription.toString()),
                    trailing: getIcon(foodList[index].nccFoodGroupCategory),
                  ),
                  Divider()
                ],
              );
            },
          );
        },
        future: getFood());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final searchResults = query.isEmpty ? recentSearchList : foodList;
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          new MaterialPageRoute(
                              builder: (_) =>
                                  FoodPage(foodList[index], selectedDate)),
                        )
                        .then((val) => {getFood()});

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FoodPage(foodList[index], selectedDate)));
                  },

                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => FoodPage(searchResults[index], selectedDate)));
                  // },
                  title: Text(foodList[index].description),
                  // subtitle: Text(
                  //     'Calories: ' + searchResults[index].kcal.toString() + ' — ' + searchResults[index].commonPortionSizeAmount.toString() + ' ' + searchResults[index].commonPortionSizeDescription.toString()),
                  trailing: getIcon(foodList[index].nccFoodGroupCategory),
                ),
                Divider()
              ],
            );
          },
        );
      },
      future: getFood(),
    );
    // }
  }
}
