import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserQuestionsListTile extends StatefulWidget {
  UserQuestion userQuestion;

  UserQuestionsListTile(UserQuestion userQuestion) {
    this.userQuestion = userQuestion;
  }

  @override
  _UserQuestionsListTileState createState() => _UserQuestionsListTileState();
}

class _UserQuestionsListTileState extends State<UserQuestionsListTile> {

  refresh() {
    setState(() {});
  }

  deleteQuestion(userQuestionID) async {
    await DBProvider.db.deleteUserQuestion(userQuestionID);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      // leading: Icon(Icons.add),
      title: Text(
        widget.userQuestion.question,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: widget.userQuestion.question_notes == "" ? Align(alignment: Alignment.centerLeft, child: Text(getDate())) : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
         SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(widget.userQuestion.question_notes,
            maxLines: 3, overflow: TextOverflow.ellipsis)),
        SizedBox(height: 5),
      Align(alignment: Alignment.centerLeft, child: Text(getDate())),
      ]),
      trailing: GestureDetector(
        onTap: () {
          _deleteDialog(
              widget.userQuestion.question,
              widget.userQuestion.id);
        },
        child: Icon(
          Icons.delete,
          size: 20,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) => AddQuestionScreen(true, widget.userQuestion)),
            )
            .then((value) => refresh());
      },
    );
  }
  _deleteDialog(question, userQuestionID) async {
    await showDialog<String>(
        context: context,
        builder: (context) => new AlertDialog(
          title:
          Text("Are you sure you would like to delete this question?"),
          content: Text("\"" + question + "\""),
          actions: [
            new FlatButton(
                child: const Text('DELETE',
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  deleteQuestion(userQuestionID);
                  Navigator.of(context, rootNavigator: true).pop();
                }),
            new FlatButton(
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                })
          ],
        ));
  }
  // IconData getActivityIcon() {
  //   if (widget.activityModel.type.contains('Basketball') ||
  //       widget.activityModel.type == 'Jogging') {
  //     return Icons.directions_run;
  //   }
  //   if (widget.activityModel.type == 'Swimming') {
  //     return Icons.pool;
  //   }
  //   if (widget.activityModel.type == 'Cycling') {
  //     return Icons.directions_bike;
  //   }
  //   if (widget.activityModel.type == 'Hiking' ||
  //       widget.activityModel.type == 'Walking') {
  //     return Icons.directions_walk;
  //   }
  // }

  // IconData getActivityIcon() {
  //   if (widget.activityModel.intensity == 1) {
  //     return (MdiIcons.speedometerSlow);
  //   }
  //   if (widget.activityModel.intensity == 2) {
  //     return (MdiIcons.speedometerMedium);
  //   }
  //   return (MdiIcons.speedometer);
  // }
  getDate() {
    DateTime dTime = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(widget.userQuestion.date_created);
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm');
    return outputFormat.format(dTime).toString();
  }
}
