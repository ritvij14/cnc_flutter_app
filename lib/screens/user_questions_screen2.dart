import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_list_tile_widget.dart';
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
                    .then((value) => refresh());
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
                      return UserQuestionsListTile(widget.userQuestions[index]);
                    },
                  );
                },
                future: getQuestions(),
              ),
            ])));
  }

  Widget _buildSort() {
    return Container(
        width: 200.0,
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
                    refresh();
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

  getDate(String date) {
    DateTime stringDateTime = DateTime.parse(date);
    print(stringDateTime.toString());
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm');
    return stringDateTime;
  }

  void refresh() {
    setState(() {});
  }
}
