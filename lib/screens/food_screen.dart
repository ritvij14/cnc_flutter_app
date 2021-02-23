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

  // TimeOfDay timeOfDay = TimeOfDay.now();

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
    time = time.split(" ")[1];
    var dateTime = selectedDate + " " + time;
    var response = await db.saveNewFoodLogEntry(
        dateTime, selectedDate, 1, currentFood.id, portion);
  }

  // _pickTime() async {
  //   TimeOfDay t = await showTimePicker(
  //       context: context,
  //       initialTime: timeOfDay,
  //     initialEntryMode: TimePickerEntryMode.input,
  //     helpText: 'Time of Meal'
  //     // cancelText: 'testing'
  //
  //   );
  //   if(t != null)
  //     setState(() {
  //       timeOfDay = t;
  //       print('Time of Day in food = ' + timeOfDay.toString());
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    if (showFat && showCarbs) {
      return Scaffold(
          appBar: AppBar(
            title: Text(currentFood.description),
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
                    (currentFood.kcal * portion).toStringAsFixed(2),
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
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
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
                    (currentFood.saturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.polyunsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
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
                    (currentFood.monounsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
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
                    'Tap to hide additional information ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Text(
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
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
                    (currentFood.insolubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.solubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.sugarInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Serving Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                            " " +
                            currentFood.commonPortionSizeUnit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Number of Servings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 125,
                        child: TextFormField(
                          initialValue: portion.toStringAsFixed(2),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "# of servings",
                          ),
                          onChanged: (text) {
                            portion = double.parse(text);
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ],
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
                    (currentFood.kcal * portion).toStringAsFixed(2),
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
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
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
                    (currentFood.saturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.polyunsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
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
                    (currentFood.monounsaturatedFattyAcidsInGrams * portion)
                            .toStringAsFixed(2) +
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
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
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
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Serving Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                            " " +
                            currentFood.commonPortionSizeUnit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Number of Servings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 125,
                        child: TextFormField(
                          initialValue: portion.toStringAsFixed(2),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "# of servings",
                          ),
                          onChanged: (text) {
                            portion = double.parse(text);
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ],
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
                    (currentFood.kcal * portion).toStringAsFixed(2),
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
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
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
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
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
                    (currentFood.insolubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.solubleFiberInGrams * portion)
                            .toStringAsFixed(2) +
                        'g',
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
                    (currentFood.sugarInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Serving Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                            " " +
                            currentFood.commonPortionSizeUnit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Number of Servings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 125,
                        child: TextFormField(
                          initialValue: portion.toStringAsFixed(2),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "# of servings",
                          ),
                          onChanged: (text) {
                            portion = double.parse(text);
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ],
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
                  // subtitle: Text(
                  //   currentFood.commonPortionSizeDescription
                  //       .replaceAll('"', ''),
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  trailing: Text(
                    (currentFood.kcal * portion).toStringAsFixed(2),
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
                        (currentFood.fatInGrams * portion).toStringAsFixed(2) +
                            'g',
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
                        (currentFood.carbohydratesInGrams * portion)
                                .toStringAsFixed(2) +
                            'g',
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
                    (currentFood.proteinInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.alcoholInGrams * portion).toStringAsFixed(2) +
                        'g',
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
                    (currentFood.calciumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.sodiumInMilligrams * portion)
                            .toStringAsFixed(2) +
                        'mg',
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
                    (currentFood.vitaminDInMicrograms * portion)
                            .toStringAsFixed(2) +
                        'mcg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Serving Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        currentFood.commonPortionSizeAmount.toStringAsFixed(2) +
                            " " +
                            currentFood.commonPortionSizeUnit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Number of Servings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 125,
                        child: TextFormField(
                          initialValue: portion.toStringAsFixed(2),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "# of servings",
                          ),
                          onChanged: (text) {
                            if (text.isEmpty) {
                              portion = 1;
                            } else {
                              portion = double.parse(text);
                            }
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),

              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  saveNewEntry();
                  Navigator.pop(context, null);
                },
              ),
              // ListTile(
              //   title: Text("Time: ${timeOfDay.hour}:${timeOfDay.minute}"),
              //   trailing: Icon(Icons.keyboard_arrow_down),
              //   onTap: _pickTime,
              // ),
            ]),
          ));
    }
  }
}
