import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {

  final List<Article> articles;
  final ValueChanged<Article> onTap;

  ArticlesScreen({@required this.articles, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var article in this.articles)
            ListTile(
              title: Text(article.title),
              subtitle: Text(article.author),
              onTap: ()=> this.onTap(article),
            )
        ],
      )
    );
  }
}
