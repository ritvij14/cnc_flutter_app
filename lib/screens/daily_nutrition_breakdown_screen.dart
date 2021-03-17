import 'dart:convert';

import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
import 'package:cnc_flutter_app/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

class DailyNutritionBreakdown extends StatefulWidget {
  List<FoodLogEntry> dailyFoodLogEntryList;

  DailyNutritionBreakdown(List<FoodLogEntry> dailyFoodLogEntryList) {
    this.dailyFoodLogEntryList = dailyFoodLogEntryList;
  }

  @override
  _DailyNutritionBreakdown createState() =>
      _DailyNutritionBreakdown(dailyFoodLogEntryList);
}

class _DailyNutritionBreakdown extends State<DailyNutritionBreakdown> {
  List<FoodLogEntry> dailyFoodLogEntryList;

  double kcal = 0;
  double proteinInGrams = 0;
  double fatInGrams = 0;
  double carbohydratesInGrams = 0;
  double solubleFiberInGrams = 0;
  double insolubleFiberInGrams = 0;
  double calciumInMilligrams = 0;
  double sodiumInMilligrams = 0;
  double saturatedFattyAcidsInGrams = 0;
  double polyunsaturatedFattyAcidsInGrams = 0;
  double monounsaturatedFattyAcidsInGrams = 0;
  double sugarInGrams = 0;
  double alcoholInGrams = 0;
  double vitaminDInMicrograms = 0;
  bool showFat = false;
  bool showCarbs = false;

  _DailyNutritionBreakdown(List<FoodLogEntry> dailyFoodLogEntryList) {
    this.dailyFoodLogEntryList = dailyFoodLogEntryList;

    for (FoodLogEntry foodLogEntry in dailyFoodLogEntryList) {
      double portion = foodLogEntry.portion;
      Food food = foodLogEntry.food;
      kcal += (food.kcal * portion);
      proteinInGrams += (food.proteinInGrams * portion);
      fatInGrams += (food.fatInGrams * portion);
      carbohydratesInGrams += (food.carbohydratesInGrams * portion);
      solubleFiberInGrams += (food.solubleFiberInGrams * portion);
      insolubleFiberInGrams += (food.insolubleFiberInGrams * portion);
      calciumInMilligrams += (food.calciumInMilligrams * portion);
      sodiumInMilligrams += (food.sodiumInMilligrams * portion);
      saturatedFattyAcidsInGrams += (food.saturatedFattyAcidsInGrams * portion);
      polyunsaturatedFattyAcidsInGrams +=
          (food.polyunsaturatedFattyAcidsInGrams * portion);
      monounsaturatedFattyAcidsInGrams +=
          (food.monounsaturatedFattyAcidsInGrams * portion);
      sugarInGrams += (food.sugarInGrams * portion);
      alcoholInGrams += (food.alcoholInGrams * portion);
      vitaminDInMicrograms += (food.vitaminDInMicrograms * portion);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showFat && showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Daily Nutrients'),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    kcal.round().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        fatInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Saturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    saturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Polyunsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    polyunsaturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Monounsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    monounsaturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        carbohydratesInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    insolubleFiberInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    solubleFiberInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sugarInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    proteinInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    alcoholInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    calciumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sodiumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    vitaminDInMicrograms.round().toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else if (showFat) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Daily Nutrients'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    kcal.round().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        fatInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Saturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    saturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Polyunsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    polyunsaturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Monounsaturated fatty acids  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    monounsaturatedFattyAcidsInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        carbohydratesInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    proteinInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    alcoholInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    calciumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sodiumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    vitaminDInMicrograms.round().toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else if (showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Daily Nutrients'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    kcal.round().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        fatInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        carbohydratesInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    insolubleFiberInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    solubleFiberInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sugarInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    proteinInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    alcoholInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    calciumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sodiumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    vitaminDInMicrograms.round().toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Daily Nutrients'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Ink(
                color: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  title: Text(
                    'Calories: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  // subtitle: Text(
                  //   currentFood.commonPortionSizeDescription
                  //       .replaceAll('"', ''),
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  trailing: Text(
                    kcal.round().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showFat = !showFat;
                    setState(() {});
                  },
                  title: Text(
                    'Fat ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        fatInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  onTap: () {
                    showCarbs = !showCarbs;
                    setState(() {});
                  },
                  title: Text(
                    'Carbohydrates ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'Tap for more information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        carbohydratesInGrams.round().toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Protein ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    proteinInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Alcohol ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    alcoholInGrams.round().toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Calcium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    calciumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sodium ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    sodiumInMilligrams.round().toString() + 'mg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Vitamin D ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    vitaminDInMicrograms.round().toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    }
  }
}
