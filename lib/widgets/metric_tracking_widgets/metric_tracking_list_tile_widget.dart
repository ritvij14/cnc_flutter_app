import 'package:cnc_flutter_app/models/metric_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MetricTrackingListTile extends StatefulWidget {
  final MetricModel metricModel;

  MetricTrackingListTile(this.metricModel);

  @override
  _MetricTrackingListTileState createState() => _MetricTrackingListTileState();
}

class _MetricTrackingListTileState extends State<MetricTrackingListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(MdiIcons.scale),
        title: Text('Weight: ' + widget.metricModel.weight.toString() + ' lbs'),
        trailing:
            Text(DateFormat('MM/dd/yyyy').format(widget.metricModel.dateTime)));
  }
}
