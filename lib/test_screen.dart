import 'package:cnc_flutter_app/widgets/home_screen_widgets/metric_summary_widget.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            MetricSummaryWidget(),
          ],
        ),
      ),
    );
  }
}
