// import 'dart:convert';
//
// import 'package:cnc_flutter_app/connections/db_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'account_menu_widget.dart';
// import 'account_pic_widget.dart';
//
// class AccountBody extends StatefulWidget {
//   AccountBody() {
//
//   }
//   @override
//   _AccountBodyState createState() => _AccountBodyState();
// }
//
// class _AccountBodyState extends State<AccountBody> {
//   _AccountBodyState() {
//     print('working');
//   }
//
//   int initialWeight;
//   int newWeight;
//   TextEditingController weightCtl = new TextEditingController();
//
//   int initialCarbs;
//   int newCarbs;
//
//   int initialFat;
//   int newFat;
//
//   int initialProtein;
//   int newProtein;
//
//   int nutrientTotal;
//   int nutrientRemaining;
//
//   String initialActivity;
//   String newActivity;
//
//   bool wasChanged() {
//     print(newWeight.toString()+'===='+initialWeight.toString());
//     if (newWeight != initialWeight) {
//       print('this');
//       return false;
//     }
//     print('this2');
//     return true;
//   }
//
//   Future<bool> setUserData() async {
//     var db = new DBHelper();
//     var response = await db.getUserInfo();
//     var data = json.decode(response.body);
//     initialProtein = data['proteinPercent'];
//     newProtein = initialProtein;
//     initialCarbs = data['carbohydratePercent'];
//     newCarbs = initialCarbs;
//     initialFat = data['fatPercent'];
//     newFat = initialFat;
//     initialActivity = data['activityLevel'].toString().replaceAll('-', ' ');
//     newActivity = initialActivity;
//     initialWeight = data['weight'];
//     newWeight = initialWeight;
//     weightCtl.text = newWeight.toString();
//     print(initialActivity);
//     print(initialWeight);
//     print(initialProtein);
//     print(initialCarbs);
//     print(initialFat);
//     // _weight = userWeight;
//     // _weightController.text = userWeight.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             // if (wasChanged) {
//             //   showAlertDialog(context);
//             // } else {
//             //   Navigator.of(context).pop();
//             // }
//           },
//         ),
//         title: Text('Update Personal Details'),
//       ),
//       body: FutureBuilder(
//         builder: (context, projectSnap) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     child: Text("Update your weight:",
//                         style: TextStyle(fontSize: 18)),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Weight(lbs)',
//                     hintText: 'Enter your weight in pounds(lbs).',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   controller: weightCtl,
//                   validator: (String value) {
//                     int weight = int.tryParse(value);
//                     if (weight == null) {
//                       return 'Field Required';
//                     } else if (weight <= 0) {
//                       return 'Weight must be greater than 0';
//                     }
//                     return null;
//                   },
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(3),
//                     FilteringTextInputFormatter.deny(new RegExp('[ -.]')),
//                   ],
//                   onChanged: (String value) {
//                     if (value.isNotEmpty) {
//                       newWeight = int.tryParse(value);
//                     } else {
//                       newWeight = initialWeight;
//                     }
//                     setState(() {});
//                   },
//                 ),
//                 SizedBox(height: 15),
//                 if (wasChanged()) ...[Text('changed')],
//                 if (!wasChanged()) ...[Text('not changed')]
//               ],
//             ),
//           );
//         },
//         future: setUserData(),
//       ),
//     );
//   }
// }
