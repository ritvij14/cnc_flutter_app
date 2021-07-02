class ArticleModel {
  late String articleName;
  late String articleSubject;
  late String articleType;
  var data;

  ArticleModel({required this.articleName, this.data});

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
