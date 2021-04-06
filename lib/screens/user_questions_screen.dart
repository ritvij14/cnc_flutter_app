import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'file:///C:/Users/sarah/AndroidStudioProjects/cnc_flutter_app/lib/widgets/user_questions_screen_widgets/user_questions_entry_widget.dart';
import 'package:flutter/material.dart';

class UserQuestionsScreen extends StatefulWidget {
  @override
  _UserQuestionsScreen createState() => new _UserQuestionsScreen();
}

class _UserQuestionsScreen extends State<UserQuestionsScreen> {
  // var db = new DBProvider();

  List<UserQuestion> userQuestions = [];

  getQuestions() async {
    userQuestions.clear();
    DBProvider dbp = DBHelper.DBProvider.instance;
    var userQuestionsFromDB = await dbp.getAllUserQuestions(1);
    if (userQuestionsFromDB != null) {
      for (int i = 0; i < userQuestionsFromDB.length; i++) {
        UserQuestion userQuestion = new UserQuestion();
        userQuestion.id = userQuestionsFromDB[i]['id'];
        userQuestion.question = userQuestionsFromDB[i]['question'];
        userQuestion.question_notes = userQuestionsFromDB[i]['question_notes'];
        userQuestion.date_created = userQuestionsFromDB[i]['date_created'];
        userQuestion.date_updated = userQuestionsFromDB[i]['date_updated'];
        userQuestions.add(userQuestion);
      }
    }
  }

  update(context) async{
    await getQuestions();
    setState(() {});
  }

  // saveNewQuestion() async {
  //   var newUserQuestion = UserQuestion(
  //       id: 0, user_id: 1, question: _userQuestion, question_notes: "");
  //   await DBProvider.db.newUserQuestion(newUserQuestion);
  //   setState(() {});
  // }

  deleteQuestion(userQuestionID) async {
    await DBProvider.db.deleteUserQuestion(userQuestionID);
    setState(() {});
  }

  var showAll = true;
  final length = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Questions'),
          actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (_) => AddQuestionScreen(false, null)),
                ).then((value) => update(context));
              },
              child: Icon(
                Icons.add,
                // size: 26.0,
              ),
            )),
      ]),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          // child: Padding:
          child: Column(children: [
            FutureBuilder(
              builder: (context, projectSnap) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userQuestions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).highlightColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        // onTap: () {
                        //   showInfoDialog(context, foodLogEntries[index].food,
                        //       foodLogEntries[index].portion);
                        // },
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      userQuestions[index].question,
                                      maxLines: null,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Theme.of(context).shadowColor,
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: "OpenSans"),
                                    ),
                                  ),
                                ],
                              ),
                              userQuestions[index].question_notes != null &&
                                      userQuestions[index].question_notes != ""
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                          SizedBox(height: 10),
                                          Divider(
                                            color: Colors.grey[600],
                                            height: 0,
                                            thickness: 1,
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  child: Text(
                                                "Notes:",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 18,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: "OpenSans"),
                                              ))),
                                          SizedBox(height: 10),
                                        ])
                                  : SizedBox(),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Flexible(
                                    //     child: Text.rich(TextSpan(
                                    //   children: <InlineSpan>[
                                    //     TextSpan(
                                    //       text: userQuestions[index]
                                    //                       .question_notes
                                    //                       .length >
                                    //                   length &&
                                    //               !showAll
                                    //           ? userQuestions[index]
                                    //               .question_notes
                                    //               .substring(0, length) + ". . ."
                                    //           : userQuestions[index]
                                    //               .question_notes,
                                    //       style: TextStyle(
                                    //           color:
                                    //               Theme.of(context).shadowColor,
                                    //           fontSize: 18,
                                    //           // fontWeight: FontWeight.bold,
                                    //           fontFamily: "OpenSans"),
                                    //     ),
                                    //     userQuestions[index]
                                    //                 .question_notes
                                    //                 .length >
                                    //             length
                                    //         ? WidgetSpan(
                                    //             child: GestureDetector(
                                    //                 onTap: () {
                                    //                   setState(() {
                                    //                     showAll = !showAll;
                                    //                   });
                                    //                 },
                                    //                 // child: Align(
                                    //                 //   alignment:
                                    //                 //       Alignment.centerRight,
                                    //                 //   child: Container(
                                    //                     child: Text(
                                    //                       showAll
                                    //                           ? ' read less'
                                    //                           : ' read more!',
                                    //                       style: TextStyle(
                                    //                           color:
                                    //                               Colors.blue,
                                    //                           fontSize: 18, fontFamily: "OpenSans"),
                                    //                     ),
                                    //                   ),
                                    //                )
                                    //         : TextSpan(),
                                    //   ],
                                    // ))),
                                    Flexible(
                                      child: Text(
                                        userQuestions[index].question_notes,
                                        maxLines: 5,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Theme.of(context).shadowColor,
                                            fontSize: 18,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: "OpenSans"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (_) =>
                                                    AddQuestionScreen(true,
                                                        userQuestions[index])),
                                          ).then((value) => update(context));
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _deleteDialog(
                                              userQuestions[index].question,
                                              userQuestions[index].id);
                                          print("delete pressed");
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0,
                    );
                  },
                );
              },
              future: getQuestions(),
            ),
          ])),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showAddDialog();
      //   },
      //   child: Icon(Icons.add, color: Theme.of(context).highlightColor),
      //   backgroundColor: Theme.of(context).buttonColor,
      // ),
    );
  }

  // final TextEditingController _questionController = new TextEditingController();
  // String _userQuestion;

  // _showAddDialog() async {
  //   await showDialog<String>(
  //     context: context,
  //     builder: (context) => new AlertDialog(
  //       contentPadding: const EdgeInsets.all(16.0),
  //       content: new Row(
  //         children: <Widget>[
  //           new Expanded(
  //               child: Container(
  //             padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey),
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //             child: TextFormField(
  //               maxLength: 256,
  //               maxLengthEnforced: true,
  //               maxLines: 3,
  //               decoration: InputDecoration.collapsed(
  //                   // labelText: 'Type your question here:',
  //                   hintText: 'Type your question here.'),
  //               // controller: _questionController,
  //               validator: (String value) {
  //                 String input = value;
  //                 if (input == null) {
  //                   return 'Field Required';
  //                 }
  //                 return null;
  //               },
  //               onChanged: (String value) {
  //                 _userQuestion = value;
  //               },
  //             ),
  //           ))
  //         ],
  //       ),
  //       actions: <Widget>[
  //         new FlatButton(
  //             child: const Text('SAVE', style: TextStyle(color: Colors.white)),
  //             color: Colors.blue,
  //             onPressed: () {
  //               saveNewQuestion();
  //               Navigator.of(context, rootNavigator: true).pop();
  //             }),
  //         new FlatButton(
  //             child: const Text(
  //               'CANCEL',
  //               style: TextStyle(color: Colors.grey),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context, rootNavigator: true).pop();
  //             })
  //       ],
  //     ),
  //   );
  // }

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
}
