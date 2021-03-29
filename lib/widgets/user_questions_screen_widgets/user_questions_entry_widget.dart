import 'package:cnc_flutter_app/connections/database.dart' as DBHelper;
import 'package:cnc_flutter_app/connections/database.dart';
import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddQuestionScreen extends StatefulWidget {
  bool isEdit;
  UserQuestion currentQuestion;

  AddQuestionScreen(bool isEdit, UserQuestion currentQuestion) {
    this.isEdit = isEdit;
    this.currentQuestion = currentQuestion;
  }

  @override
  _AddQuestionScreen createState() =>
      new _AddQuestionScreen(isEdit, currentQuestion);
}

class _AddQuestionScreen extends State<AddQuestionScreen> {
  bool isUpdate;
  UserQuestion userQuestion;
  final TextEditingController _questionController = new TextEditingController();
  final TextEditingController _noteController = new TextEditingController();
  String _userQuestion;
  String _userNote = "";
  DateTime _createdDate;
  bool hasMadeEdit = false;

  _AddQuestionScreen(isEdit, currentQuestion) {
    isUpdate = isEdit;
    userQuestion = currentQuestion;
    if (userQuestion != null) {
      print("WILL UPDATE QUESTION+++++++++++++++++++++++++++++++           " +
          userQuestion.id.toString());
      _questionController.text = userQuestion.question;
      _noteController.text = userQuestion.question_notes;
      _userQuestion = userQuestion.question;
      _userNote = userQuestion.question_notes;
      _createdDate =
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(userQuestion.date_created);
    }
  }

  @override
  void initState() {
    if (userQuestion != null) {
      _createdDate =
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(userQuestion.date_created);
      _userQuestion = userQuestion.question;
      _questionController.text = userQuestion.question;
      if (_noteController.text != null || _noteController.text != "") {
        _noteController.text = userQuestion.question_notes;
        _userNote = userQuestion.question_notes;
      } else {
        _noteController.text = "";
        _userNote = "";
      }
    }
    return super.initState();
  }

  saveNewQuestion() async {
    var newUserQuestion = UserQuestion(
        id: 0,
        user_id: 1,
        question: _userQuestion,
        question_notes: _userNote,
        date_created: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
        date_updated: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()));
    await DBProvider.db.newUserQuestion(newUserQuestion);
    setState(() {});
  }

  updateQuestion() async {
    print("IN UPDATE:");
    userQuestion.question = _userQuestion;
    userQuestion.question_notes = _userNote;
    userQuestion.date_updated =
        DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    await DBProvider.db.updateUserQuestion(userQuestion);
    setState(() {});
  }

  void closePage() {
    Navigator.of(context).pop();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              if (hasMadeEdit) {
                print("IN HAS EDITED+++++++++++++++++++++++++++++++++++++++++++++++++++++");
                _editedFieldsAlert();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          title: isUpdate ? Text('Update Question') : Text('New Question'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            // child: Padding:
            child: Form(
                key: formKey,
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18),
                            maxLength: 256,
                            maxLengthEnforced: true,
                            maxLines: null,
                            minLines: 3,
                            decoration: InputDecoration.collapsed(
                                // labelText: 'Type your question here:',
                                hintText: 'Type your question here'),
                            controller: _questionController,
                            validator: (String value) {
                              String input = value;
                              if (input == null || input == "") {
                                return 'Field Required';
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              hasMadeEdit = true;
                              _userQuestion = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18),
                            maxLength: 1024,
                            maxLengthEnforced: true,
                            maxLines: null,
                            minLines: 6,
                            decoration: InputDecoration.collapsed(
                                // labelText: 'Type your question here:',
                                hintText:
                                    'Add some supplementary questions or\nadditional notes here'),
                            controller: _noteController,
                            validator: (String value) {
                              // String input = value;
                              // if (input == null || input == "") {
                              //   return 'Field Required';
                              // }
                              return null;
                            },
                            onChanged: (String value) {
                              hasMadeEdit = true;
                              _userNote = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, null);
                                  }),
                              isUpdate
                                  ? FlatButton(
                                      child: const Text('UPDATE',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.blue,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.grey[800],
                                      onPressed: hasMadeEdit
                                          ? () {
                                              updateQuestion();
                                              Navigator.pop(context, null);
                                            }
                                          : null)
                                  : FlatButton(
                                      child: const Text('SAVE',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.blue,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.grey[800],
                                      onPressed: hasMadeEdit
                                          ? () {
                                              saveNewQuestion();
                                              Navigator.pop(context, null);
                                            }
                                          : null)
                            ])
                      ],
                    )))));
  }

  _editedFieldsAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unsaved changes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to save your changes for question "'+ _userQuestion +'"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop();
                closePage();
              },
            ),
            TextButton(
                child: Text('SAVE'),
                onPressed: () {
                  if (isUpdate) {
                    updateQuestion();
                  } else {
                    saveNewQuestion();
                  }
                  Navigator.of(context).pop();
                  closePage();
                }),
          ],
        );
      },
    );
  }

  _emptyFieldsAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Question Forms is empty'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You have left the question text field empty. If you would like to save a new questions please fill out the question text field. If you would like to return to your questions please select the \'CANCEL\' button.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
