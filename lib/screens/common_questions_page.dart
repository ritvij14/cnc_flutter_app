import 'package:flutter/material.dart';

class CQHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Questions'),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Temp Common Questions',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
