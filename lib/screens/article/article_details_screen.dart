import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  ArticleDetailsScreen({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        leading: IconButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            if (article != null) ...[
              Text(article.title),
              Text(article.author),
              Text(article.body),
            ]
          ],
        ),
      ),
    );
  }
}
