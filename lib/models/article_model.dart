class ArticleModel {
  String articleName;
  String articleSubject;
  String articleType;
  var data;

  ArticleModel({this.articleName, this.data});

  factory ArticleModel.fromJson(dynamic json) {
    ArticleModel articleModel = ArticleModel.emptyConstructor();
    articleModel.articleName = json['articleName'];
    articleModel.articleSubject = json['articleSubject'];
    articleModel.articleType = json['articleType'];
    articleModel.data = json['data'];
    return articleModel;
  }

  ArticleModel.emptyConstructor() {}
}