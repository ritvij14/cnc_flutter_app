import 'dart:convert';
import 'package:cnc_flutter_app/screens/content/article_viewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:cnc_flutter_app/connections/article_db_helper.dart';
import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<String> videos = ['Video 1', 'Video 2', 'Video 3'];
  List<String> dummyArticles = ['Article 1', 'Article 2', 'Article 3'];
  var _url =
      'https://www.youtube.com/channel/UCL6SGPPfesMz17QhaQK8Sgw/featured';

  List<ArticleModel> articleList = [];
  var db = new ArticleDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Content'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text('Recently Added'),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5),
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey,
                        child: InkWell(
                          onTap: () {
                            _launchURL();
                          },
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text('Videos'),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5),
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey,
                        child: InkWell(
                          onTap: () {
                            _launchURL();
                          },
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text('Articles'),
            ),
            Container(
              height: 200,
              child: FutureBuilder(
                builder: (context, projectSnap) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 200,
                            height: 200,
                            color: Colors.lightBlueAccent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleViewer(articleList[index])));
                              },
                            )),
                      );
                    },
                  );
                },
                future: getArticles(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text('Other'),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5),
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey,
                        child: InkWell(
                          onTap: () {
                            _launchURL();
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  _launchURL() async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  getArticles() async {
    var response = await db.getAllArticles();
    List<ArticleModel> newArticleList = (json.decode(response.body) as List)
        .map((data) => ArticleModel.fromJson(data))
        .toList();
    articleList = newArticleList;
  }
}
