import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routing Error'),
      ),
      body: Center(
        child: Text('The requested route was not found')
      )
    );
  }
}
