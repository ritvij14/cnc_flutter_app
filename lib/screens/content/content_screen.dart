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
                                print(articleList[index].data);
                                String x = 'JVBERi0xLjcNCiWDkvr+DQoxIDAgb2JqDQo8PA0KL1R5cGUgL0NhdGFsb2cNCi9QYWdlcyAyIDAgUg0KPj4NCmVuZG9iag0KMiAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0tpZHMgWzMgMCBSXQ0KL0NvdW50IDENCi9SZXNvdXJjZXMgPDw+Pg0KDQovTWVkaWFCb3ggWzAgMCA1OTUgODQyXQ0KPj4NCmVuZG9iag0KMyAwIG9iag0KPDwNCi9Db3VudCAxDQovVHlwZSAvUGFnZXMNCi9LaWRzIFs0IDAgUl0NCi9QYXJlbnQgMiAwIFINCj4+DQplbmRvYmoNCjQgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KPj4NCmVuZG9iag0KeHJlZg0KMCA1DQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTcgMDAwMDAgbg0KMDAwMDAwMDA3MiAwMDAwMCBuDQowMDAwMDAwMTgwIDAwMDAwIG4NCjAwMDAwMDAyNTkgMDAwMDAgbg0KdHJhaWxlcg0KPDwNCi9Sb290IDEgMCBSDQovU2l6ZSA1DQo+Pg0KDQpzdGFydHhyZWYNCjMxMg0KJSVFT0Y=';

                                // PdfDocument document = PdfDocument.fromBase64String(
                                //     'JVBERi0xLjcNCiWDkvr+DQoxIDAgb2JqDQo8PA0KL1R5cGUgL0NhdGFsb2cNCi9QYWdlcyAyIDAgUg0KPj4NCmVuZG9iag0KMiAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0tpZHMgWzMgMCBSXQ0KL0NvdW50IDENCi9SZXNvdXJjZXMgPDw+Pg0KDQovTWVkaWFCb3ggWzAgMCA1OTUgODQyXQ0KPj4NCmVuZG9iag0KMyAwIG9iag0KPDwNCi9Db3VudCAxDQovVHlwZSAvUGFnZXMNCi9LaWRzIFs0IDAgUl0NCi9QYXJlbnQgMiAwIFINCj4+DQplbmRvYmoNCjQgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KPj4NCmVuZG9iag0KeHJlZg0KMCA1DQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTcgMDAwMDAgbg0KMDAwMDAwMDA3MiAwMDAwMCBuDQowMDAwMDAwMTgwIDAwMDAwIG4NCjAwMDAwMDAyNTkgMDAwMDAgbg0KdHJhaWxlcg0KPDwNCi9Sb290IDEgMCBSDQovU2l6ZSA1DQo+Pg0KDQpzdGFydHhyZWYNCjMxMg0KJSVFT0Y=');
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
