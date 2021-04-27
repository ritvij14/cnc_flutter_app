import 'dart:convert';
import 'package:cnc_flutter_app/screens/content/article_viewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<String> videos = ['Video 1', 'Video 2'];
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
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              _launchURL();
                            },
                            child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          1, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(children: <Widget>[
                                  Container(
                                      height: 70,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: getColor("video"))),
                                      child: getIcon("video")),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 3, left: 8, right: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "Video Title Placeholder",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 0, bottom: 5, left: 8, right: 8),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        child: Text(
                                          "Video Description Placeholder",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                            )
                        )
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
                          child: GestureDetector(
                              onTap: () {
                                // print(articleList[index].data);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleViewer(articleList[index])));
                              },
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(children: <Widget>[
                                    Container(
                                        height: 70,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: getColor(
                                                    articleList[index]
                                                        .articleSubject
                                                        .toUpperCase()))),
                                        child: getIcon(articleList[index]
                                            .articleSubject
                                            .toUpperCase())),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, bottom: 3, left: 8, right: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            articleList[index].articleName,
                                            // "Diet and Smoking Research study adfsd asv darbsgdf sghsdbs",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0, bottom: 5, left: 8, right: 8),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          child: Text(
                                            articleList[index].articleType +
                                                " article on " +
                                                articleList[index]
                                                    .articleSubject,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]))));
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

  Icon getIcon(String type) {
    // if (type == "DIET" || type == "DIET/NUTRITION") {
    //   return Icon(
    //     Icons.food_bank,
    //     color: Colors.white,
    //     size: 60,
    //     // color: getColor(type),
    //   );
    // } else if (type == "EXERCISE") {
    //   return Icon(
    //     Icons.directions_run,
    //     color: Colors.white,
    //     size: 50,
    //     // color: getColor(type),
    //   );
    // } else {
    //   return Icon(
    //     Icons.description,
    //     color: Colors.white,
    //     size: 50,
    //     // color: getColor(type),
    //   );
    // }
    if (type == "DIET/NUTRITION" || type == "DIET") {
      return Icon(
        Icons.food_bank,
        color: Colors.white,
        size: 55,
      );
    } else if (type == "FITNESS/EXERCISE" || type == "EXERCISE") {
      return Icon(
        Icons.directions_run,
        color: Colors.white,
        size: 50,
      );
    } else if (type == "SYMPTOM MANAGEMENT") {
      return Icon(
        Icons.thermostat_outlined,
        color: Colors.white,
        size: 50,
      );
    } else if (type == "CANCER RESEARCH") {
      return Icon(
        FontAwesomeIcons.ribbon,
        color: Colors.white,
        size: 50,
      );
    }else if (type == "video") {
      return Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 50,
      );
    } else {
      return Icon(
        Icons.description,
        color: Colors.white,
        size: 50,
      );
    }
  }

  List<Color> getColor(String type) {
    if (type == "DIET/NUTRITION" || type == "DIET") {
      return [Colors.lime, Colors.tealAccent[700]];
    } else if (type == "FITNESS/EXERCISE" || type == "EXERCISE") {
      return [Colors.limeAccent, Colors.deepOrange];
      // [Colors.orange, Colors.pinkAccent];
    } else if (type == "SYMPTOM MANAGEMENT") {
      return [Colors.purpleAccent[100], Colors.indigo[400]];
    } else if (type == "CANCER RESEARCH") {
      return [Colors.lightBlue[300], Colors.blue[800]];
    } else if (type == "video") {
      return [Colors.purpleAccent , Colors.redAccent[700]];
    }
    else {

      return [Colors.green[200], Colors.teal[500]];
    }
  }
}