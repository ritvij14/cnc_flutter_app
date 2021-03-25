
class ArticleModel {
  String articleName;
  var data;

  ArticleModel({this.articleName, this.data});

  factory ArticleModel.fromJson(dynamic json) {
    ArticleModel articleModel = ArticleModel.emptyConstructor();
    articleModel.articleName = json['articleName'];
    articleModel.data = json['data'];
    return articleModel;
  }

  ArticleModel.emptyConstructor() {}
}


