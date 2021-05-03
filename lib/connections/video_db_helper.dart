import 'dart:convert';
import 'db_helper_base.dart';
import 'package:http/http.dart' as http;

class VideoDBHelper extends DBHelperBase{
  Future<http.Response> getAllVideos() async {
    var requestUrl = baseUrl + 'api/video/all';
    http.Response response =
    await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }
}