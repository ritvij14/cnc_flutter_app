import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: ListView(
        children: [
          Text('Articles Screen')
        ],
      )
    );
  }
}
