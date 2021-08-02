import 'dart:convert';
import 'package:cnc_flutter_app/connections/video_db_helper.dart';
import 'package:cnc_flutter_app/models/video_model.dart';
import 'package:cnc_flutter_app/screens/content/article_viewer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cnc_flutter_app/connections/article_db_helper.dart';
import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<String> videos = ['Video 1', 'Video 2'];
  List<String> dummyArticles = ['Article 1', 'Article 2', 'Article 3'];

  List<ArticleModel> articleList = [];
  List<ArticleModel> CancerResearchArtList = [];
  List<VideoModel> CancerResearchVidList = [];
  List<VideoModel> videoList = [];
  var db = new ArticleDBHelper();
  var videoDb = new VideoDBHelper();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child:
                Text('Recently Added Videos', style: TextStyle(fontSize: 24)),
          ),
          Container(
            height: 200,
            child: FutureBuilder(
              builder: (context, projectSnap) {
                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).buttonColor),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: videoList.length < 3 ? videoList.length : 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                _launchURL(videoList[index].videoUrl);
                              },
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
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
                                                    videoList[index]
                                                        .videoSubject
                                                        .toUpperCase()))),
                                        child: getIcon("video")),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, bottom: 3, left: 8, right: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            videoList[index].videoName,
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
                                          child: videoList[index]
                                                      .videoSubject
                                                      .toUpperCase() ==
                                                  "OTHER"
                                              ? Text(
                                                  videoList[index].videoType +
                                                      " video",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )
                                              : Text(
                                                  videoList[index].videoType +
                                                      " video on " +
                                                      videoList[index]
                                                          .videoSubject,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ]))));
                    },
                  );
                }
              },
              future: getVideos(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child:
                Text('Recently Added Articles', style: TextStyle(fontSize: 24)),
          ),
          Container(
            height: 200,
            child: FutureBuilder(
              builder: (context, projectSnap) {
                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).buttonColor),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articleList.length < 3 ? articleList.length : 3,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                // print(articleList[index].data);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ArticleViewer(articleList[index])));
                              },
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
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
                                          child: articleList[index]
                                                      .articleSubject
                                                      .toUpperCase() ==
                                                  "OTHER"
                                              ? Text(
                                                  articleList[index]
                                                          .articleType +
                                                      " article",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )
                                              : Text(
                                                  articleList[index]
                                                          .articleType +
                                                      " article on " +
                                                      articleList[index]
                                                          .articleSubject,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ]))));
                    },
                    // childCount: articleList.length,
                  );
                }
              },
              future: getArticles(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text('All Videos', style: TextStyle(fontSize: 24)),
          ),
          FutureBuilder(
            builder: (context, projectSnap) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).buttonColor),
                  ),
                );
              } else {
                return Container(
                    child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: videoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              _launchURL(videoList[index].videoUrl);
                            },
                            child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          1, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(children: <Widget>[
                                  Container(
                                      height: 55,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: getColor(videoList[index]
                                                  .videoSubject
                                                  .toUpperCase()))),
                                      child: getIcon("video")),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 3, left: 8, right: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          videoList[index].videoName,
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
                                        child: videoList[index]
                                                    .videoSubject
                                                    .toUpperCase() ==
                                                "OTHER"
                                            ? Text(
                                                videoList[index].videoType +
                                                    " video",
                                                style: TextStyle(fontSize: 14),
                                              )
                                            : Text(
                                                videoList[index].videoType +
                                                    " video on " +
                                                    videoList[index]
                                                        .videoSubject,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                      ),
                                    ),
                                  ),
                                ]))));
                  },
                ));
              }
            },
            future: getVideos(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text('All Articles', style: TextStyle(fontSize: 24)),
          ),
          FutureBuilder(
            builder: (context, projectSnap) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).buttonColor),
                  ),
                );
              } else {
                return Container(
                    child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: articleList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ArticleViewer(articleList[index])));
                            },
                            child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          1, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(children: <Widget>[
                                  Container(
                                      height: 55,
                                      width: double.infinity,
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
                                        child: articleList[index]
                                                    .articleSubject
                                                    .toUpperCase() ==
                                                "OTHER"
                                            ? Text(
                                                articleList[index].articleType +
                                                    " article",
                                                style: TextStyle(fontSize: 14),
                                              )
                                            : Text(
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
                ));
              }
            },
            future: getArticles(),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  getArticles() async {
    var response = await db.getAllArticles();
    List<ArticleModel> newArticleList = (json.decode(response.body) as List)
        .map((data) => ArticleModel.fromJson(data))
        .toList();
    articleList = newArticleList.reversed.toList();
    isLoading = false;
    // getCancerResearchArt();
  }

  getVideos() async {
    var response = await videoDb.getAllVideos();
    List<VideoModel> newVideoList = (json.decode(response.body) as List)
        .map((data) => VideoModel.fromJson(data))
        .toList();
    videoList = newVideoList.reversed.toList();
    isLoading = false;
    // getCancerResearchVid();
  }

  getCancerResearchVid() {
    CancerResearchVidList.clear();
    for (VideoModel video in videoList) {
      if (video.videoSubject == "Cancer Research") {
        CancerResearchVidList.add(video);
      }
    }
  }

  getCancerResearchArt() {
    CancerResearchArtList.clear();
    for (ArticleModel article in articleList) {
      if (article.articleSubject == "Cancer Research") {
        CancerResearchArtList.add(article);
      }
    }
  }

  Icon getIcon(String type) {
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
        size: 45,
      );
    } else if (type == "STRESS MANAGEMENT") {
      return Icon(
        FontAwesomeIcons.spa,
        // Icons.psychology,
        color: Colors.white,
        size: 45,
      );
    } else if (type == "RECIPES") {
      return Icon(
        Icons.local_dining,
        color: Colors.white,
        size: 50,
      );
    } else if (type == "LEARNING ACTIVITIES") {
      return Icon(
        Icons.lightbulb,
        color: Colors.white,
        size: 50,
      );
    } else if (type == "video") {
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
    if (type == "DIET/NUTRITION") {
      return [Colors.limeAccent, Colors.green];
    } else if (type == "FITNESS/EXERCISE") {
      return [Colors.limeAccent, Colors.orange[600]!];
    } else if (type == "SYMPTOM MANAGEMENT") {
      return [Colors.red[300]!, Colors.purple[600]!];
    } else if (type == "CANCER RESEARCH") {
      return [Colors.lightBlue[300]!, Colors.blue[800]!];
    } else if (type == "LEARNING ACTIVITIES") {
      return [Colors.blue[400]!, Colors.deepPurple[300]!];
    } else if (type == "RECIPES") {
      return [Colors.red[400]!, Colors.orange[400]!];
    } else if (type == "STRESS MANAGEMENT") {
      return [Colors.green[200]!, Colors.teal[500]!];
    } else {
      return [Colors.tealAccent[400]!, Colors.blue[400]!];
    }
  }
}
