import 'db_helper_base.dart';
import 'package:http/http.dart' as http;

class ArticleDBHelper extends DBHelperBase {
  Future<http.Response> getAllArticles() async {
    var requestUrl = baseUrl + 'api/article/all';
    http.Response response = await http.get(Uri.parse(requestUrl), headers: {});
    return response;
  }
}
