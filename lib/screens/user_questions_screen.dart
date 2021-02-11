import 'package:flutter/material.dart';

class UserQuestionsPage extends StatefulWidget {
  @override
  _UserQuestionsPage createState() => new _UserQuestionsPage();
}

class _UserQuestionsPage extends State<UserQuestionsPage> {
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
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                  // labelText: 'Type your question here:',
                    hintText: 'Type your question here.'
                ),
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
                Navigator.of(context, rootNavigator: true).pop();;
              })
        ],
      ),
    );
  }
}