import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NutrientRatioScreen extends StatefulWidget {
  final int proteinPercent;
  final int carbohydratePercent;
  final int fatPercent;

  NutrientRatioScreen(
      this.carbohydratePercent, this.proteinPercent, this.fatPercent);

  @override
  _NutrientRatioScreenState createState() => _NutrientRatioScreenState(
      carbohydratePercent, proteinPercent, fatPercent);
}

class _NutrientRatioScreenState extends State<NutrientRatioScreen> {
  TextEditingController proteinCtl = new TextEditingController();
  TextEditingController carbohydrateCtl = new TextEditingController();
  TextEditingController fatCtl = new TextEditingController();

  int proteinPercent = 0;
  int carbohydratePercent = 0;
  int fatPercent = 0;

  int initialProteinPercent = 0;
  int initialCarbohydratePercent = 0;
  int initialFatPercent = 0;

  int ratioTotal = 100;
  bool wasChanged = false;
  bool valid = false;

  final carbohydrateKey = GlobalKey<FormState>();
  final proteinKey = GlobalKey<FormState>();
  final fatKey = GlobalKey<FormState>();

  _NutrientRatioScreenState(
      int carbohydratePercent, int proteinPercent, int fatPercent) {
    this.carbohydratePercent = carbohydratePercent;
    this.proteinPercent = proteinPercent;
    this.fatPercent = fatPercent;

    this.initialCarbohydratePercent = carbohydratePercent;
    this.initialProteinPercent = proteinPercent;
    this.initialFatPercent = fatPercent;

    ratioTotal =
        this.carbohydratePercent + this.proteinPercent + this.fatPercent;
    carbohydrateCtl.text = this.carbohydratePercent.toString();
    proteinCtl.text = this.proteinPercent.toString();
    fatCtl.text = this.fatPercent.toString();
  }

  // Future<bool> getUserData() async {
  //   var db = new DBHelper();
  //   var response = await db.getUserInfo("1");
  //   var data = json.decode(response.body);
  //
  //   proteinPercent = data['proteinPercent'];
  //   carbohydratePercent = data['carbohydratePercent'];
  //   fatPercent = data['fatPercent'];
  //
  //   proteinCtl.text = proteinPercent.toString();
  //   carbohydrateCtl.text = carbohydratePercent.toString();
  //   fatCtl.text = fatPercent.toString();
  //
  //   return true;
  // }

  void closePage() {
    Navigator.of(context).pop();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = TextButton(
      child: Text("CONFIRM", style: TextStyle(color: Colors.white)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        closePage();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to cancel this update?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void updateRatios() async {
    bool a = carbohydrateKey.currentState!.validate();
    bool b = proteinKey.currentState!.validate();
    bool c = fatKey.currentState!.validate();

    if (a && b && c) {
      var db = new DBHelper();
      await db.saveRatios(fatPercent, proteinPercent, carbohydratePercent);
      Navigator.pop(context, null);
      valid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carbohydratePercent == initialCarbohydratePercent &&
        proteinPercent == initialProteinPercent &&
        fatPercent == initialFatPercent) {
      wasChanged = false;
    }
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: Icon(Icons.clear),
    //       onPressed: () {
    //         if (wasChanged) {
    //           showAlertDialog(context);
    //         } else {
    //           Navigator.of(context).pop();
    //         }
    //       },
    //     ),
    //     title: Text('Macronutrient Distribution Breakdown'),
    //   ),
    //   body:
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: "You have ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ((carbohydratePercent != null
                                          ? carbohydratePercent
                                          : 0) +
                                      (proteinPercent != null
                                          ? proteinPercent
                                          : 0) +
                                      (fatPercent != null ? fatPercent : 0))
                                  .toString() +
                              "%",
                          style: TextStyle(
                              color: ((carbohydratePercent != null
                                              ? carbohydratePercent
                                              : 0) +
                                          (proteinPercent != null
                                              ? proteinPercent
                                              : 0) +
                                          (fatPercent != null
                                              ? fatPercent
                                              : 0)) !=
                                      100
                                  ? Colors.red
                                  : Colors.green)),
                      TextSpan(
                          text: " of 100% assigned: ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: (((carbohydratePercent != null
                                              ? carbohydratePercent
                                              : 0) +
                                          (proteinPercent != null
                                              ? proteinPercent
                                              : 0) +
                                          (fatPercent != null
                                              ? fatPercent
                                              : 0)) -
                                      100)
                                  .abs()
                                  .toString() +
                              "%",
                          style: TextStyle(
                              color: (((carbohydratePercent != null
                                                      ? carbohydratePercent
                                                      : 0) +
                                                  (proteinPercent != null
                                                      ? proteinPercent
                                                      : 0) +
                                                  (fatPercent != null
                                                      ? fatPercent
                                                      : 0)) -
                                              100)
                                          .abs() !=
                                      0
                                  ? Colors.red
                                  : Colors.green)),
                      (((carbohydratePercent != null
                                          ? carbohydratePercent
                                          : 0) +
                                      (proteinPercent != null
                                          ? proteinPercent
                                          : 0) +
                                      (fatPercent != null ? fatPercent : 0)) -
                                  100) >=
                              1
                          ? TextSpan(
                              text: " over\n",
                              style: TextStyle(color: Colors.black))
                          : TextSpan(
                              text: " remaining\n",
                              style: TextStyle(color: Colors.black))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Carbohydrates %",
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  key: carbohydrateKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter desired carbohydrate percent.',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    controller: carbohydrateCtl,
                    validator: (String? value) {
                      if (value == null) return 'Field Required';
                      int carbs = int.tryParse(value)!;
                      if (carbohydratePercent + proteinPercent + fatPercent !=
                          100) {
                        return 'Values must add up to 100';
                      } else if (carbs <= 0) {
                        return 'Value must be greater than 0';
                      } else if (carbs >= 99) {
                        return 'Value must be less than 99';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        carbohydratePercent = int.tryParse(value)!;
                        if (carbohydratePercent != initialCarbohydratePercent) {
                          wasChanged = true;
                        }
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Protein %",
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  key: proteinKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter desired Protein percent.',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    controller: proteinCtl,
                    validator: (String? value) {
                      if (value == null) return 'Field Required';
                      int protein = int.tryParse(value)!;
                      if (proteinPercent + carbohydratePercent + fatPercent !=
                          100) {
                        return 'Values must add up to 100';
                      } else if (protein <= 0) {
                        return 'Value must be greater than 0';
                      } else if (protein >= 99) {
                        return 'Value must be less than 99';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        proteinPercent = int.tryParse(value)!;
                        if (proteinPercent != initialProteinPercent) {
                          wasChanged = true;
                        }
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Fat %",
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  key: fatKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter desired Fat percent.',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    controller: fatCtl,
                    validator: (String? value) {
                      if (value == null) return 'Field Required';
                      int fat = int.tryParse(value)!;
                      if (fatPercent + carbohydratePercent + proteinPercent !=
                          100) {
                        return 'Values must add up to 100';
                      } else if (fat <= 0) {
                        return 'Value must be greater than 0';
                      } else if (fat >= 99) {
                        return 'Value must be less than 99';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        fatPercent = int.tryParse(value)!;
                        if (fatPercent != initialFatPercent) {
                          wasChanged = true;
                        }
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('CANCEL',
                            style: TextStyle(color: Colors.grey)),
                        onPressed: () {
                          if (wasChanged) {
                            showAlertDialog(context);
                          } else {
                            Navigator.pop(context, null);
                          }
                        },
                      ),
                      if (wasChanged) ...[
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          // padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            updateRatios();
                            // if (valid) {
                            //   Navigator.pop(context, null);
                            // }
                          },
                        ),
                      ],
                      if (!wasChanged) ...[
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => {}),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      // ),
    );
  }
}
