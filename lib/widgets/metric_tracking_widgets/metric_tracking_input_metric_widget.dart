import 'package:cnc_flutter_app/connections/db_helper.dart';
import 'package:cnc_flutter_app/connections/metric_db_helper.dart';
import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class MetricTrackingInputScreen extends StatefulWidget {
  MetricModel metricModel = new MetricModel.emptyConstructor();

  @override
  _MetricTrackingInputScreenState createState() => _MetricTrackingInputScreenState();
}

class _MetricTrackingInputScreenState extends State<MetricTrackingInputScreen> {

  final db = MetricDBHelper();
  final dbHelper = DBHelper();
  TextEditingController dateCtl = TextEditingController(text: DateFormat('MM/dd/yyyy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Metrics'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Date',
                style: TextStyle(
                    fontSize: 16
                ),),
              Container(
                width: 200,
                child: TextFormField(
                  enableInteractiveSelection: false,
                  controller: dateCtl,
                  onTap: () async {
                    DateTime date = widget.metricModel.dateTime;
                    DateTime now = DateTime.now();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                      context: context,
                      initialDate: widget.metricModel.dateTime,
                      firstDate: DateTime(now.year, now.month, now.day -1),
                      lastDate: DateTime.now(),
                    );
                    dateCtl.text = DateFormat('MM/dd/yyyy').format(date);
                    widget.metricModel.dateTime = date;
                  },

                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Weight',
                style: TextStyle(
                    fontSize: 16
                ),),
              Container(
                width: 200,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Weight required';
                    }
                    return null;
                  },
                  // initialValue: '',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // decoration: InputDecoration(
                  //   hintText: "enter",
                  // ),
                  onChanged: (text) {
                    widget.metricModel.weight = int.parse(text);
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      db.saveNewMetric(widget.metricModel);
                      dbHelper.updateWeight(widget.metricModel);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
