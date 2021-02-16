import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GIIssuesCheckboxWidget extends StatefulWidget {
  final Map<String, bool> frequentIssues;

  const GIIssuesCheckboxWidget({Key key, this.frequentIssues}) : super(key: key);


  @override
  _GIIssuesCheckboxWidget createState() => _GIIssuesCheckboxWidget();
}

class _GIIssuesCheckboxWidget extends State<GIIssuesCheckboxWidget> {
  Map<String, bool> checkedFrequentIssues;

  Widget _buildGICheckBoxes(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: widget.frequentIssues.keys.map((String key) {
        return new CheckboxListTile(
          contentPadding: EdgeInsets.all(0),
          title: new Text(key),
          value: widget.frequentIssues[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              checkedFrequentIssues[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Frequent Gastrointestinal Issues',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('(at least once every week within the last 2 months)',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildGICheckBoxes(context),
        ]));
  }
}
