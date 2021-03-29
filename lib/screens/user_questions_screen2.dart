import 'dart:convert';
import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_list_tile_widget.dart';
import 'package:flutter/material.dart';

class UserQuestionsScreen extends StatefulWidget {
  List<UserQuestion> userQuestions = [];

  @override
  _UserQuestionsScreenState createState() => _UserQuestionsScreenState();
}

class _UserQuestionsScreenState extends State<UserQuestionsScreen> {
  DBProvider dbp = DBHelper.DBProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Questions'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
               await Navigator.push(context, new MaterialPageRoute(builder:(context) => AddQuestionScreen(false, null)));
               refresh();
            },
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          return ListView.builder(
            itemCount: widget.userQuestions.length,
            itemBuilder: (context, index) {
              return UserQuestionsListTile(widget.userQuestions[index]);
            },
          );
        },
        future: getQuestions(),
      ),
    );
  }

  // List<ActivityTrackingListTile> buildFitnessTrackingListTileWidgets(
  //     List<ActivityModel> fitnessActivityModelList) {
  //   List<ActivityTrackingListTile> fitnessTrackingListTileList = [];
  //   for (ActivityModel fitnessActivity in widget.activityModelList) {
  //     ActivityTrackingListTile fitnessTrackingListTile =
  //     new ActivityTrackingListTile(fitnessActivity);
  //     fitnessTrackingListTileList.add(fitnessTrackingListTile);
  //   }
  //   return fitnessTrackingListTileList;
  // }


  getQuestions() async {
    widget.userQuestions.clear();
    var userQuestionsFromDB = await dbp.getAllUserQuestions(1);
    if (userQuestionsFromDB != null) {
      for (int i = 0; i < userQuestionsFromDB.length; i++) {
        UserQuestion userQuestion = new UserQuestion();
        userQuestion.id = userQuestionsFromDB[i]['id'];
        userQuestion.question = userQuestionsFromDB[i]['question'];
        userQuestion.question_notes = userQuestionsFromDB[i]['question_notes'];
        userQuestion.date_created = userQuestionsFromDB[i]['date_created'];
        userQuestion.date_updated = userQuestionsFromDB[i]['date_updated'];
        widget.userQuestions.add(userQuestion);
      }
    }
  }

  void refresh() {
    setState(() {});
  }
}
