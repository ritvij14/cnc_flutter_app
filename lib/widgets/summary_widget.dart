import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200.0,
      child: InkWell(
        child: Text('Placeholder for user summary.'),
        onTap: () {
          Navigator.pushNamed(context, '/summary');
        },
      ),
    );
  }
}
