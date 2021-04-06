import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'package:cnc_flutter_app/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'package:cnc_flutter_app/widgets/user_questions_screen_widgets/user_questions_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserQuestionsScreen extends StatefulWidget {
  List<UserQuestion> userQuestions = [];

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
    'Date Updated: old to new'
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
                        // leading: Icon(Icons.add),
                        title: Text(
                          widget.userQuestions[index].question,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: widget.userQuestions[index].question_notes == "" ||
                            widget.userQuestions[index].question_notes == null ||
                            widget.userQuestions[index].question_notes == " "
                            ? Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(""),
                          ),
                          SizedBox(height: 5),
                          Align(alignment: Alignment.centerLeft, child: Text(getDate(widget.userQuestions[index]))),
                        ])
                            : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          SizedBox(height: 5),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.userQuestions[index].question_notes,
                                  maxLines: 3, overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 5),
                          Align(alignment: Alignment.centerLeft, child: Text(getDate(widget.userQuestions[index]))),
                        ]),
                        trailing: GestureDetector(
                          onTap: () {
                            _deleteDialog(widget.userQuestions[index].question, widget.userQuestions[index].id);
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
                                builder: (_) => AddQuestionScreen(true, widget.userQuestions[index])),
                          )
                              .then((value) => refresh(context));
                        },
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
                  onChanged: (String value) {
                    dropDownSort = value;
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
        UserQuestion userQuestion = new UserQuestion();
        userQuestion.id = userQuestionsFromDB[i]['id'];
        userQuestion.question = userQuestionsFromDB[i]['question'];
        userQuestion.question_notes = userQuestionsFromDB[i]['question_notes'];
        userQuestion.date_created = userQuestionsFromDB[i]['date_created'];
        // getDate(userQuestionsFromDB[i]['date_created']);
        userQuestion.date_updated = userQuestionsFromDB[i]['date_updated'];
        widget.userQuestions.add(userQuestion);
      }
    }

    if (dropDownSort == 'Date Added: new to old') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.date_created)
          .compareTo(DateFormat.yMd().add_jm().parse(a.date_created)));
    } else if (dropDownSort == 'Date Added: old to new') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(a.date_created)
          .compareTo(DateFormat.yMd().add_jm().parse(b.date_created)));
    } else if (dropDownSort == 'Date Updated: new to old') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(b.date_updated)
          .compareTo(DateFormat.yMd().add_jm().parse(a.date_updated)));
    } else if (dropDownSort == 'Date Updated: old to new') {
      widget.userQuestions.sort((a, b) => DateFormat.yMd()
          .add_jm()
          .parse(a.date_updated)
          .compareTo(DateFormat.yMd().add_jm().parse(b.date_updated)));
    }

    // if (dropDownSort == 'Date Added: new to old') {
    //   widget.userQuestions.sort((a, b) => DateFormat("yyyy-MM-dd Hms")
    //       .parse(b.date_created)
    //       .compareTo(DateTime.parse(a.date_created)));
    // } else if (dropDownSort == 'Date Added: old to new') {
    //   widget.userQuestions.sort((a, b) => DateFormat("yyyy-MM-dd Hms")
    //       .parse(a.date_created)
    //       .compareTo(DateFormat("yyyy-MM-dd Hms").parse(b.date_created)));
    //
    // } else if (dropDownSort == 'Date Updated: new to old') {
    //   widget.userQuestions.sort((a, b) => DateFormat("yyyy-MM-dd Hms")
    //       .parse(b.date_created)
    //       .compareTo(DateFormat("yyyy-MM-dd Hms").parse(a.date_created)));
    // } else if (dropDownSort == 'Date Updated: old to new') {
    //   widget.userQuestions.sort((a, b) => DateFormat("yyyy-MM-dd Hms")
    //       .parse(a.date_created)
    //       .compareTo(DateFormat("yyyy-MM-dd Hms").parse(b.date_created)));
    //
    // }
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
                color: Colors.blue,
                onPressed: () {
                  deleteQuestion(userQuestionID);
                  Navigator.of(context, rootNavigator: true).pop();
                  // refresh();
                })
          ],
        ));
  }

  getDate(UserQuestion userQuestion) {
    DateTime dTime = DateFormat.yMd().add_jm()
        .parse(userQuestion.date_updated);
    var outputFormat = DateFormat.yMd().add_jm();
    // DateTime dTime = DateFormat("yyyy-MM-dd Hms")
    //     .parse(widget.userQuestion.date_updated);
    // var outputFormat = DateFormat('MM/dd/yyyy H:mma');
    return outputFormat.format(dTime).toString();
  }

  refresh(context) async{
    await getQuestions();
    setState(() {});
  }

  deleteQuestion(userQuestionID) async {
    await DBProvider.db.deleteUserQuestion(userQuestionID);
    setState(() {});
  }
}
