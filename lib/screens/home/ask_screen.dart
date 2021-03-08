import 'package:cnc_flutter_app/screens/user_questions_screen.dart';
import 'package:cnc_flutter_app/widgets/common_questions_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskPage extends StatelessWidget {
  AskPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask'),
      ),
      body: GridView.count(
          crossAxisCount: 1,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 3.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            CommonQuestionsCard(),
            userQuestionsCard(context),
          ]
      ),
    );
  }

  Widget userQuestionsCard(BuildContext context) => Card(
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
          builder: (context) => UserQuestionsScreen(),
        ));},
      child: Container(
        color: Theme.of(context).accentColor,
        // decoration: BoxDecoration(
        // gradient: LinearGradient(
        // colors: [ Theme.of(context).primaryColor, Theme.of(context).accentColor],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        // ),
        // ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Questions',
              style: TextStyle(
                fontSize:25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Save and view your questions for your next appointment.',
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