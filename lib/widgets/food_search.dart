import 'dart:convert';
import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:cnc_flutter_app/screens/food_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodSearch extends SearchDelegate<String> {
  bool isSearching = false;
  var recentSearchList = [];
  List<Food> foodList = [];
  Food selection;

  Future<bool> getFood() async {
    foodList.clear();
    var db = new DBHelper();
    var response = await db.searchFood(query);
    var data = json.decode(response.body);
    for (int i = 0; i < data.length; i++) {
      Food food = new Food();
      food.description = data[i]['description'];
      food.kcal = data[i]['kcal'];
      food.proteinInGrams = data[i]['proteinInGrams'];
      food.carbohydratesInGrams = data[i]['carbohydratesInGrams'];
      food.fatInGrams = data[i]['fatInGrams'];
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
        future: getFood());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResults = query.isEmpty ? recentSearchList : foodList;
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodPage(searchResults[index])));
              },
              title: Text(searchResults[index].description),
              subtitle: Text(
                  'Calories: ' + searchResults[index].kcal.toString()),
              trailing: Icon(Icons.food_bank),
            );
          },
        );
      },
      future: getFood(),
    );
    // }
  }
}