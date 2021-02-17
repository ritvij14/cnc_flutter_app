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

  FoodPage(Food selection) {
    this.selection = selection;
    this.selection.fiberInGrams = 0;
    this.selection.solubleFiberInGrams = 0;
    this.selection.insolubleFiberInGrams = 0;
    this.selection.calciumInMilligrams = 0;
    this.selection.sodiumInMilligrams = 0;
    this.selection.saturatedFattyAcidsInGrams = 0;
    this.selection.polyunsaturatedFattyAcidsInGrams = 0;
    this.selection.monounsaturatedFattyAcidsInGrams = 0;
    this.selection.sugarInGrams = 0;
    this.selection.alcoholInGrams = 0;
    this.selection.vitaminDInMicrograms = 0;
  }

  @override
  FoodProfile createState() => FoodProfile(selection);
}

class FoodProfile extends State<FoodPage> {
  Food currentFood;

  FoodProfile(Food selection) {
    currentFood = selection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currentFood.description),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.grey.withOpacity(0.3);
                }),
                // headingRowHeight: 2,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Calories Per Serving                      ',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      currentFood.kcal.toString(),
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text(
                          'Total Protein                                     ')),
                      DataCell(
                          Text(currentFood.proteinInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Carbohydrates')),
                      DataCell(Text(
                          currentFood.carbohydratesInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Total Fat')),
                      DataCell(Text(currentFood.fatInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Alcohol')),
                      DataCell(
                          Text(currentFood.alcoholInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text('Total Saturated Fatty Acids')),
                      DataCell(Text(
                          currentFood.saturatedFattyAcidsInGrams.toString() +
                              ' g')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Polyunsaturated Fatty Acids')),
                      DataCell(Text(currentFood.polyunsaturatedFattyAcidsInGrams
                          .toString() +
                          ' g')),
                    ],
                  ),
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text('Total Monounsaturated Fatty Acids')),
                      DataCell(Text(currentFood.monounsaturatedFattyAcidsInGrams
                          .toString() +
                          ' g')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Insoluble Fiber ')),
                      DataCell(Text(
                          currentFood.insolubleFiberInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text('Total Soluble Fiber')),
                      DataCell(Text(
                          currentFood.solubleFiberInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Sugars')),
                      DataCell(
                          Text(currentFood.sugarInGrams.toString() + ' g')),
                    ],
                  ),
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text('Total Calcium')),
                      DataCell(Text(
                          currentFood.calciumInMilligrams.toString() + ' mg')),
                    ],
                  ),
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(0.3);
                        }),
                    cells: <DataCell>[
                      DataCell(Text('Total Sodium')),
                      DataCell(Text(
                          currentFood.sodiumInMilligrams.toString() + ' mg')),
                    ],
                  ),
                  DataRow(
                    // color: MaterialStateProperty.resolveWith<Color>(
                    //     (Set<MaterialState> states) {
                    //   return Colors.grey.withOpacity(0.3);
                    // }),
                    cells: <DataCell>[
                      DataCell(Text('Total Vitamin D')),
                      DataCell(Text(
                          currentFood.vitaminDInMicrograms.toString() +
                              ' mcg')),
                    ],
                  ),

                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 5, right: 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         "Macronutrients",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //             fontFamily: "OpenSans"),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   child: DataTable(
            //     headingRowHeight: 2,
            //     columns: const <DataColumn>[
            //       DataColumn(
            //         label: Text(
            //           '',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           '',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //         ),
            //       ),
            //     ],
            //     rows: <DataRow>[
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text(
            //               'Total Protein                                     ')),
            //           DataCell(
            //               Text(currentFood.proteinInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Carbohydrates')),
            //           DataCell(Text(
            //               currentFood.carbohydratesInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         cells: <DataCell>[
            //           DataCell(Text('Total Fat')),
            //           DataCell(Text(currentFood.fatInGrams.toString() + ' g')),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(left: 5, right: 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text(
            //         "Micronutrients",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //             fontFamily: "OpenSans"),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   child: DataTable(
            //     headingRowHeight: 2,
            //     columns: const <DataColumn>[
            //       DataColumn(
            //         label: Text(
            //           '',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //         ),
            //       ),
            //       DataColumn(
            //         label: Text(
            //           '',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //         ),
            //       ),
            //     ],
            //     rows: <DataRow>[
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Alcohol')),
            //           DataCell(
            //               Text(currentFood.alcoholInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Saturated Fatty Acids')),
            //           DataCell(Text(
            //               currentFood.saturatedFattyAcidsInGrams.toString() +
            //                   ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Polyunsaturated Fatty Acids')),
            //           DataCell(Text(currentFood.polyunsaturatedFattyAcidsInGrams
            //                   .toString() +
            //               ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Monounsaturated Fatty Acids')),
            //           DataCell(Text(currentFood.monounsaturatedFattyAcidsInGrams
            //                   .toString() +
            //               ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Insoluble Fiber ')),
            //           DataCell(Text(
            //               currentFood.insolubleFiberInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Soluble Fiber')),
            //           DataCell(Text(
            //               currentFood.solubleFiberInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Sugars')),
            //           DataCell(
            //               Text(currentFood.sugarInGrams.toString() + ' g')),
            //         ],
            //       ),
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Calcium')),
            //           DataCell(Text(
            //               currentFood.calciumInMilligrams.toString() + ' mg')),
            //         ],
            //       ),
            //       DataRow(
            //         color: MaterialStateProperty.resolveWith<Color>(
            //             (Set<MaterialState> states) {
            //           return Colors.grey.withOpacity(0.3);
            //         }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Sodium')),
            //           DataCell(Text(
            //               currentFood.sodiumInMilligrams.toString() + ' mg')),
            //         ],
            //       ),
            //       DataRow(
            //         // color: MaterialStateProperty.resolveWith<Color>(
            //         //     (Set<MaterialState> states) {
            //         //   return Colors.grey.withOpacity(0.3);
            //         // }),
            //         cells: <DataCell>[
            //           DataCell(Text('Total Vitamin D')),
            //           DataCell(Text(
            //               currentFood.vitaminDInMicrograms.toString() +
            //                   ' mcg')),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ]),
        ));
  }
}
