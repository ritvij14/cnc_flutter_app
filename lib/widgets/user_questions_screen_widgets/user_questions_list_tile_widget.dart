import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'package:cnc_flutter_app/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserQuestionsListTile extends StatefulWidget {
  final UserQuestion userQuestion;

  UserQuestionsListTile(this.userQuestion);

  @override
  _UserQuestionsListTileState createState() => _UserQuestionsListTileState();
}

class _UserQuestionsListTileState extends State<UserQuestionsListTile> {
  refresh() {
    setState(() {});
  }

  deleteQuestion(userQuestionID) async {
    await DBProvider.db.deleteUserQuestion(userQuestionID);
    refresh();
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
      subtitle: widget.userQuestion.questionNotes == ""
          /* ||
              widget.userQuestion.questionNotes == null ||
              widget.userQuestion.questionNotes == " "*/
          ? Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(""),
              ),
              SizedBox(height: 5),
              Align(alignment: Alignment.centerLeft, child: Text(getDate())),
            ])
          : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.userQuestion.questionNotes,
                      maxLines: 3, overflow: TextOverflow.ellipsis)),
              SizedBox(height: 5),
              Align(alignment: Alignment.centerLeft, child: Text(getDate())),
            ]),
      trailing: GestureDetector(
        onTap: () {
          _deleteDialog(widget.userQuestion.question, widget.userQuestion.id);
          // refresh();
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
              title: Text("Delete Question?"),
              content: Text("\"" + question + "\""),
              actions: [
                new FlatButton(
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      // refresh();
                    }),
                new FlatButton(
                    child: const Text('DELETE',
                        style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).buttonColor,
                    onPressed: () {
                      deleteQuestion(userQuestionID);
                      Navigator.of(context, rootNavigator: true).pop();
                      // refresh();
                    })
              ],
            ));
  }

  getDate() {
    DateTime dTime =
        DateFormat.yMd().add_jm().parse(widget.userQuestion.dateUpdated);
    var outputFormat = DateFormat.yMd().add_jm();
    // DateTime dTime = DateFormat("yyyy-MM-dd Hms")
    //     .parse(widget.userQuestion.date_updated);
    // var outputFormat = DateFormat('MM/dd/yyyy H:mma');
    return outputFormat.format(dTime).toString();
  }
}
