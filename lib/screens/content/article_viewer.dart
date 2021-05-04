import 'dart:typed_data';

import 'package:cnc_flutter_app/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart' ;



class ArticleViewer extends StatefulWidget {
  ArticleModel articleModel;
  ArticleViewer(ArticleModel articleModel){
    this.articleModel = articleModel;
  }

  @override
  _ArticleViewerState createState() => _ArticleViewerState();
}

class Article {
}

class _ArticleViewerState extends State<ArticleViewer> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            Navigator.of(context).pop();

          },
        ),
        title: Text(widget.articleModel.articleName),
      ),
      body: Container(
        child: SfPdfViewer.memory(encodeToUint8List(widget.articleModel.data)),
      ),
    );
  }

  Uint8List encodeToUint8List(String data) {
    var x = Uint8List.fromList(data.codeUnits);
    PdfDocument doc = PdfDocument.fromBase64String(data);
    List<int> bytes = doc.save();
    return Uint8List.fromList(bytes);
  }
}