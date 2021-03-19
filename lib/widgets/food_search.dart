import 'dart:convert';
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodSearch extends SearchDelegate<String> {
  bool isSearching = false;

  // var recentSearchList = [];
  List<Food> foodList = [];
  List<Food> frequentFoodList = [];
  Food selection;
  String selectedDate;

  FoodSearch(String selectedDate) {
    this.selectedDate = selectedDate;
  }

  Future<bool> getFood() async {
    await getFrequentFood();
    foodList.clear();
    // recentSearchList.clear();
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

  Future<bool> getFrequentFood() async {
    frequentFoodList.clear();
    var db = new DBHelper();
    var response = await db.getUserFrequentFoods();
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
      frequentFoodList.add(food);
    }
    return true;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // getFrequentFood();
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
      );
    } else if (category == 'Meat, fish, and poultry') {
      return Icon(
        FontAwesomeIcons.drumstickBite,
      );
    } else if (category == 'Beverages') {
      return Icon(
        Icons.local_cafe,
      );
    } else if (category == 'Desserts' ||
        category == 'Candy, sugar, and sweets') {
      return Icon(
        FontAwesomeIcons.birthdayCake,
      );
    } else if (category == 'Grain products') {
      return Icon(
        FontAwesomeIcons.breadSlice,
      );
    } else if (category == 'Milk, cream, cheese, and related products') {
      return Icon(
        FontAwesomeIcons.cheese,
      );
    } else if (category == 'Fats, oils, and nuts') {
      return Icon(
        Icons.grain,
      );
    } else if (category == 'Eggs and related products') {
      return Icon(
        FontAwesomeIcons.egg,
      );
    } else if (category == 'Fruits and fruit products') {
      return Icon(
        FontAwesomeIcons.appleAlt,
      );
    } else if (category == 'Commercial entrees and dinners') {
      return Icon(
        Icons.dinner_dining,
      );
    } else if (category == 'Soups, gravy, and sauces') {
      return Icon(
        Icons.ramen_dining,
      );
    }
    print(category);
    // last is misc
    return Icon(
      Icons.food_bank,
    );
  }

  Color getColor(String category) {
    if (category == 'Vegetables and vegetable products') {
      return Colors.green[700];
    } else if (category == 'Meat, fish, and poultry') {
      return Colors.deepPurple[300];
    } else if (category == 'Beverages') {
      return Colors.teal[400];
    } else if (category == 'Desserts' ||
        category == 'Candy, sugar, and sweets') {
      return Colors.pink[300];
    } else if (category == 'Grain products') {
      return Colors.orange[300];
    } else if (category == 'Milk, cream, cheese, and related products') {
      return Colors.blue[600];
    } else if (category == 'Fats, oils, and nuts') {
      return Colors.brown[600];
    } else if (category == 'Eggs and related products') {
      return Colors.yellow[200];
    } else if (category == 'Fruits and fruit products') {
      return Colors.red;
    } else if (category == 'Commercial entrees and dinners') {
      return Colors.lightGreen[600];
    } else if (category == 'Soups, gravy, and sauces') {
      return Colors.deepOrange[400];
    }
    return Colors.indigo[400];
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query.isNotEmpty) {
    //   recentSearchList.add(query);
    //   recentSearchList = new List.from(recentSearchList.reversed);
    // }

    return FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    color: Theme.of(context).canvasColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 7),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 15,
                            height: double.infinity,
                            child: Text(''),
                            color:
                                getColor(foodList[index].nccFoodGroupCategory),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                          ),
                          getIcon(foodList[index].nccFoodGroupCategory),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              new MaterialPageRoute(
                                  builder: (_) =>
                                      FoodPage(foodList[index], selectedDate)),
                            )
                            .then((val) => {});
                        // close(context, null)
                      },
                      title: Text(
                        foodList[index].description,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    height: 0,
                    thickness: 1,
                  )
                ],
              );
            },
          );
        },
        future: getFood());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchResults;
    if(query.isNotEmpty) {
      searchResults = foodList;
    } else {
      searchResults = frequentFoodList;
    }
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: Theme.of(context).canvasColor,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 0, right: 7),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          height: double.infinity,
                          child: Text(''),
                          color: getColor(searchResults[index].nccFoodGroupCategory),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                        ),
                        getIcon(searchResults[index].nccFoodGroupCategory),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            new MaterialPageRoute(
                                builder: (_) =>
                                    FoodPage(searchResults[index], selectedDate)),
                          )
                          .then((val) => {});
                    },
                    title: Text(
                      searchResults[index].description,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[600],
                  height: 0,
                  thickness: 1,
                )
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
