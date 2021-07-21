import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'package:cnc_flutter_app/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'package:cnc_flutter_app/widgets/user_questions_screen_widgets/user_questions_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserQuestionsScreen extends StatefulWidget {
  final List<UserQuestion> userQuestions = [];

  @override
  _UserQuestionsScreenState createState() => _UserQuestionsScreenState();
}

class _UserQuestionsScreenState extends State<UserQuestionsScreen> {
  DBProvider dbp = DBHelper.DBProvider.instance;
  String dropDownSort = 'Date Added: old to new';

  List<String> _sorts = [
    'Date Added: new to old',
    'Date Added: old to new',
    'Date Updated: new to old',
    'Date Updated: old to new',
    'Answered to unanswered',
    'Unanswered to answered'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Questions'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.of(context)
                    .push(
                      new MaterialPageRoute(
                          builder: (_) => AddQuestionScreen(false, null)),
                    )
                    .then((value) => refresh(context));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Align(
                      alignment: Alignment.topRight, child: _buildSort())),
              // Container(
              //     padding:
              //         EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 0),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: <Widget>[
              //           // Text('Sort by: '),
              //           _buildSort(),
              //         ])),
              FutureBuilder(
                builder: (context, projectSnap) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.userQuestions.length,
                    itemBuilder: (context, index) {
                      // return UserQuestionsListTile(widget.userQuestions[index]);
                      return ListTile(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        leading: widget.userQuestions[index].isAnswered == 0
                            ? Icon(Icons.help_outline, color: Colors.red)
                            : Icon(Icons.done_outline, color: Colors.green),
                        title: Text(
                          widget.userQuestions[index].question,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: widget.userQuestions[index].questionNotes ==
                                    "" ||
                                widget.userQuestions[index].questionNotes == " "
                            ? Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(""),
                                ),
                                SizedBox(height: 5),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        getDate(widget.userQuestions[index]))),
                              ])
                            : Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                                SizedBox(height: 5),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        widget
                                            .userQuestions[index].questionNotes,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                                SizedBox(height: 5),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        getDate(widget.userQuestions[index]))),
                              ]),
                        trailing: PopupMenuButton(
                          // tooltip: 'Menu',
                          color: Theme.of(context).canvasColor,
                          onSelected: (value) {
                            if (value == 0) {
                              Navigator.of(context)
                                  .push(
                                    new MaterialPageRoute(
                                        builder: (_) => AddQuestionScreen(
                                            true, widget.userQuestions[index])),
                                  )
                                  .then((value) => refresh(context));
                            } else if (value == 1) {
                              _deleteDialog(
                                  widget.userQuestions[index].question,
                                  widget.userQuestions[index].id);
                            } else if (value == 2) {
                              updateAnswered(widget.userQuestions[index]);
                            }
                          },
                          child: Icon(
                            Icons.more_vert,
                            // size: 28.0,
                            color: Colors.grey,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Text(
                                    "Edit",
                                  ),
                                ],
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Text(
                                    "Delete",
                                  ),
                                ],
                              ),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  widget.userQuestions[index].isAnswered == 0
                                      ? Text(
                                          "Mark as answered",
                                        )
                                      : Text(
                                          "Mark as unanswered",
                                        ),
                                ],
                              ),
                              value: 2,
                            ),
                          ],
                        ),

                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(
                        //         new MaterialPageRoute(
                        //             builder: (_) => AddQuestionScreen(
                        //                 true, widget.userQuestions[index])),
                        //       )
                        //       .then((value) => refresh(context));
                        // },
                      );
                    },
                  );
                },
                future: getQuestions(),
              ),
            ])));
  }

  Widget _buildSort() {
    return Container(
        width: double.infinity,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                      // labelText: 'Sort by',
                      // border: OutlineInputBorder(),
                      // hintText: "Sort by",
                      ),
                  value: dropDownSort,
                  validator: (value) => value == null ? 'Field Required' : null,
                  onChanged: (String? value) {
                    if (value != null) dropDownSort = value;
                    refresh(context);
                  },
                  items: _sorts
                      .map((sort) =>
                          DropdownMenuItem(value: sort, child: Text("$sort")))
                      .toList(),
                ))));
  }

  getQuestions() async {
    widget.userQuestions.clear();
    var userQuestionsFromDB = await dbp.getAllUserQuestions(1);
    if (userQuestionsFromDB != null) {
      for (int i = 0; i < userQuestionsFromDB.length; i++) {
        UserQuestion userQuestion =
            UserQuestion.fromMap(userQuestionsFromDB[i]);
        /*userQuestion.id = userQuestionsFromDB[i]['id'];
        userQuestion.question = userQuestionsFromDB[i]['question'];
        userQuestion.question_notes = userQuestionsFromDB[i]['question_notes'];
        userQuestion.date_created = userQuestionsFromDB[i]['date_created'];
        // getDate(userQuestionsFromDB[i]['date_created']);
        userQuestion.date_updated = userQuestionsFromDB[i]['date_updated'];
        userQuestion.is_answered = userQuestionsFromDB[i]['is_answered'];*/
        widget.userQuestions.add(userQuestion);
      }
    }

    if (dropDownSort == 'Date Added: new to old') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.dateCreated)
          .compareTo(DateFormat.yMd().add_jm().parse(a.dateCreated)));
    } else if (dropDownSort == 'Date Added: old to new') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(a.dateCreated)
          .compareTo(DateFormat.yMd().add_jm().parse(b.dateCreated)));
    } else if (dropDownSort == 'Date Updated: new to old') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.dateUpdated)
          .compareTo(DateFormat.yMd().add_jm().parse(a.dateUpdated)));
    } else if (dropDownSort == 'Date Updated: old to new') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(a.dateUpdated)
          .compareTo(DateFormat.yMd().add_jm().parse(b.dateUpdated)));
    } else if (dropDownSort == 'Answered to unanswered') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.dateUpdated)
          .compareTo(DateFormat.yMd().add_jm().parse(a.dateUpdated)));
      widget.userQuestions.sort(
          (a, b) => b.isAnswered.toString().compareTo(a.isAnswered.toString()));
    } else if (dropDownSort == 'Unanswered to answered') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.dateUpdated)
          .compareTo(DateFormat.yMd().add_jm().parse(a.dateUpdated)));
      widget.userQuestions.sort(
          (a, b) => a.isAnswered.toString().compareTo(b.isAnswered.toString()));
    }
  }

  _deleteDialog(question, userQuestionID) async {
    await showDialog<String>(
        context: context,
        builder: (context) => new AlertDialog(
              title: Text("Delete Entry"),
              content: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Are you sure you would like to delete this question?:\n\n',
                    ),
                    TextSpan(
                        text: "\"" + question + "\"",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '\n\nThis action cannot be undone.')
                  ],
                ),
              ),
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

  getDate(UserQuestion userQuestion) {
    if (userQuestion.dateUpdated != userQuestion.dateCreated) {
      DateTime dTime =
          DateFormat.yMd().add_jm().parse(userQuestion.dateUpdated);
      var outputFormat = DateFormat.yMd().add_jm();
      return "Last updated: " + outputFormat.format(dTime).toString();
    } else {
      DateTime dTime =
          DateFormat.yMd().add_jm().parse(userQuestion.dateCreated);
      var outputFormat = DateFormat.yMd().add_jm();
      return outputFormat.format(dTime).toString();
    }
  }

  refresh(context) async {
    await getQuestions();
    setState(() {});
  }

  deleteQuestion(userQuestionID) async {
    await DBProvider.db.deleteUserQuestion(userQuestionID);
    setState(() {});
  }

  updateAnswered(userQuestion) async {
    userQuestion.dateUpdated = DateFormat.yMd().add_jm().format(DateTime.now());
    if (userQuestion.isAnswered == 0) {
      userQuestion.isAnswered = 1;
    } else {
      userQuestion.isAnswered = 0;
    }

    await DBProvider.db.updateIsAnswered(userQuestion);
    setState(() {});
  }
}
