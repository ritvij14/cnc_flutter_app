import 'package:cnc_flutter_app/screens/common_questions_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CommonQuestionsCard extends StatelessWidget {
  CommonQuestionsCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      shadowColor: Colors.black.withOpacity(.60),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () {
          // Navigate to the PreferencePage
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CQHomePage(),
          ));},
        child: Container(
          color: Theme.of(context).accentColor,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [ Theme.of(context).primaryColor, Theme.of(context).accentColor],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Questions',
                style: TextStyle(
                  fontSize:25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Let us help you find the questions and answers you are looking for.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}