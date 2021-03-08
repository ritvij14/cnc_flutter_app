import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
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
        userQuestions.add(userQuestion);
      }
    }
  }

  update(context) {
    setState(() {});
  }

  saveNewQuestion() async {
    var newUserQuestion = UserQuestion(
        id: 0, user_id: 1, question: _userQuestion, question_notes: "");
    await DBProvider.db.newUserQuestion(newUserQuestion);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Questions'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _showDialog,
            ),
          ],
        ),
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
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      userQuestions[index].question,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "OpenSans"),
                                    ),
                                  ],
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
            ])));
  }

  final TextEditingController _questionController = new TextEditingController();
  String _userQuestion;

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    // labelText: 'Type your question here:',
                    hintText: 'Type your question here.'),
                // controller: _questionController,
                validator: (String value) {
                  String input = value;
                  if (input == null) {
                    return 'Field Required';
                  }
                  return null;
                },
                onChanged: (String value) {
                  _userQuestion = value;
                },
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('SAVE'),
              onPressed: () {
                saveNewQuestion();

                Navigator.of(context, rootNavigator: true).pop();
              })
        ],
      ),
    );
  }
}
