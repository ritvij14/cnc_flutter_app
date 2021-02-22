import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/models/food_log_entry_model.dart';
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
  String selectedDate;

  FoodPage(Food selection, String selectedDate) {
    this.selection = selection;
    this.selectedDate = selectedDate;
  }

  @override
  FoodProfile createState() => FoodProfile(selection, selectedDate);
}

class FoodProfile extends State<FoodPage> {
  Food currentFood;
  String selectedDate;

  bool showFat = false;
  bool showCarbs = false;

  DateTime entryTime = DateTime.now();
  double portion = 1;



  FoodProfile(Food selection, String selectedDate) {
    currentFood = selection;
    this.selectedDate = selectedDate;
  }


  saveNewEntry() async {
    var db = new DBHelper();
    var time = entryTime.toString().substring(0, 19);
    var combined = selectedDate + " " + time.split(" ")[1];
    var toSend = combined.replaceAll(" ", "%20");
    var response = await db.saveNewFoodLogEntry(toSend, 1, currentFood.id, portion);
  }

  @override
  Widget build(BuildContext context) {
    if (showFat && showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
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
                    currentFood.kcal.toString(),
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
                        currentFood.fatInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.fatInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Saturated fatty acids  ',
                  ),
                  trailing: Text(
                    currentFood.saturatedFattyAcidsInGrams.toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Polyunsaturated fatty acids  ',
                  ),
                  trailing: Text(
                    currentFood.polyunsaturatedFattyAcidsInGrams.toString() +
                        'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Monounsaturated fatty acids  ',
                  ),
                  trailing: Text(
                    currentFood.monounsaturatedFattyAcidsInGrams.toString() +
                        'g',
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
                        currentFood.carbohydratesInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.carbohydratesInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.insolubleFiberInGrams.toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.solubleFiberInGrams.toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.sugarInGrams.toString() + 'g',
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
                    currentFood.proteinInGrams.toString() + 'g',
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
                    currentFood.alcoholInGrams.toString() + 'g',
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
                    currentFood.calciumInMilligrams.toString() + 'mg',
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
                    currentFood.sodiumInMilligrams.toString() + 'mg',
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
                    currentFood.vitaminDInMicrograms.toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else if (showFat) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
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
                    currentFood.kcal.toString(),
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
                        currentFood.fatInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.fatInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                    currentFood.saturatedFattyAcidsInGrams.toString() + 'g',
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
                    currentFood.polyunsaturatedFattyAcidsInGrams.toString() +
                        'g',
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
                    currentFood.monounsaturatedFattyAcidsInGrams.toString() +
                        'g',
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
                        currentFood.carbohydratesInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.carbohydratesInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                    currentFood.proteinInGrams.toString() + 'g',
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
                    currentFood.alcoholInGrams.toString() + 'g',
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
                    currentFood.calciumInMilligrams.toString() + 'mg',
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
                    currentFood.sodiumInMilligrams.toString() + 'mg',
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
                    currentFood.vitaminDInMicrograms.toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else if (showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
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
                    currentFood.kcal.toString(),
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
                        currentFood.fatInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.fatInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                        currentFood.carbohydratesInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.carbohydratesInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Insoluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.insolubleFiberInGrams.toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Soluble Fiber  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.solubleFiberInGrams.toString() + 'g',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Ink(
                child: ListTile(
                  title: Text(
                    'Sugars  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    currentFood.sugarInGrams.toString() + 'g',
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
                    currentFood.proteinInGrams.toString() + 'g',
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
                    currentFood.alcoholInGrams.toString() + 'g',
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
                    currentFood.calciumInMilligrams.toString() + 'mg',
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
                    currentFood.sodiumInMilligrams.toString() + 'mg',
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
                    currentFood.vitaminDInMicrograms.toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
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
                    currentFood.kcal.toString(),
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
                        currentFood.fatInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.fatInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                        currentFood.carbohydratesInGrams.toString() + 'g',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), // icon-1
                      Icon(Icons.arrow_drop_down_circle_outlined), // icon-2
                    ],
                  ),
                  // trailing: Text(
                  //   currentFood.carbohydratesInGrams.toString() + 'g',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                    currentFood.proteinInGrams.toString() + 'g',
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
                    currentFood.alcoholInGrams.toString() + 'g',
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
                    currentFood.calciumInMilligrams.toString() + 'mg',
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
                    currentFood.sodiumInMilligrams.toString() + 'mg',
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
                    currentFood.vitaminDInMicrograms.toString() + 'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  saveNewEntry();
                  Navigator.pop(context, null);
                },
              ),
            ]),
          ));
    }
  }
}
