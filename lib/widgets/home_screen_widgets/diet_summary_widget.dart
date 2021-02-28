import 'package:flutter/material.dart';

class DietSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 150.0,
      child: InkWell(
        child: Text('Placeholder for Diet Summary.'),
        onTap: () {
          Navigator.pushNamed(context, '/dietTracking');
        },
      ),
    );
  }
}
