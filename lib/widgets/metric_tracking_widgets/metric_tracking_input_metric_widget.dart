import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../alerts.dart';

class MetricTrackingInputScreen extends StatefulWidget {
  final MetricModel metricModel = MetricModel.emptyConstructor();

  @override
  _MetricTrackingInputScreenState createState() =>
      _MetricTrackingInputScreenState();
}

class _MetricTrackingInputScreenState extends State<MetricTrackingInputScreen> {
  final db = MetricDBHelper();
  final dbHelper = DBHelper();
  bool isEnabled = false;
  TextEditingController dateCtl = TextEditingController(
      text: DateFormat('MM/dd/yyyy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Alerts().showAlert(context, false);
          },
        ),
        title: Text('New Metrics'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          // scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    controller: dateCtl,
                    onTap: () async {
                      DateTime? date = widget.metricModel.dateTime;
                      DateTime now = DateTime.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = await showDatePicker(
                        context: context,
                        initialDate: widget.metricModel.dateTime,
                        // TODO change date range
                        firstDate: DateTime(now.year, now.month, now.day - 100),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        dateCtl.text = DateFormat('MM/dd/yyyy').format(date);
                        widget.metricModel.dateTime = date;
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Weight required';
                      }
                      return null;
                    },
                    // initialValue: '',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    // decoration: InputDecoration(
                    //   hintText: "enter",
                    // ),
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        widget.metricModel.weight = int.parse(text);
                        isEnabled = true;
                      } else {
                        isEnabled = false;
                      }
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
                  onPressed: () async {
                    Alerts().showAlert(context, false);
                    // showAlert().then(
                    //     Navigator.pop(context, "Cancelled Weight Input")
                    // );
                  },
                ),
                if (isEnabled) ...[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      'SAVE ENTRY',
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    onPressed: () async {
                      if (widget.metricModel.weight != null) {
                        var sharedPref = await SharedPreferences.getInstance();
                        String id = sharedPref.getString('id')!;
                        dbHelper.updateWeight(widget.metricModel);
                        widget.metricModel.userId = int.parse(id);
                        var x = db.saveNewMetric(widget.metricModel);
                        Navigator.pop(
                            context,
                            'Saved Weight of ' +
                                widget.metricModel.weight.toString() +
                                'lbs');
                      }
                    },
                  ),
                ],
                if (!isEnabled) ...[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                    child: Text(
                      'SAVE ENTRY',
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ],
            ),
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: TextButton(
            //               child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
            //               onPressed: () async {
            //                 Alerts().showAlert(context, false);
            //                 // showAlert().then(
            //                 //     Navigator.pop(context, "Cancelled Weight Input")
            //                 // );
            //               },
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: TextButton(
            //               color: Theme.of(context).buttonColor,
            //               child: Text('SAVE ENTRY', style: TextStyle(color: Theme.of(context).highlightColor),),
            //               onPressed: () async {
            //                 if(widget.metricModel.weight != null) {
            //                   var sharedPref = await SharedPreferences.getInstance();
            //                   String id = sharedPref.getString('id');
            //                   dbHelper.updateWeight(widget.metricModel);
            //                   widget.metricModel.userId = int.parse(id);
            //                   var x = db.saveNewMetric(widget.metricModel);
            //                   Navigator.pop(context, 'Saved Weight of ' + widget
            //                       .metricModel.weight.toString() + 'lbs');
            //                 }
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // showAlert(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Cancel Input?"),
  //     content: Text("Are you sure you want to cancel this entry? Nothing will be saved."),
  //     actions: [
  //       TextButton(
  //         child: Text("Undo"),
  //         onPressed:  () {
  //         },
  //       ),
  //       TextButton(
  //         child: Text("Confirm"),
  //         onPressed:  () {
  //           Navigator.of(context).pop();
  //           Navigator.of(context).pop("Cancelled Input");
  //         },
  //       ),
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context){
  //       return alert;
  //     }
  //   );
  // }
}
