
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancerHistoryWidget extends StatefulWidget {
  final int yearLastDiag;
  final int monthLastDiag;
  final List<String> cancerStages;
  final String dropDownColon;
  final String dropDownRectum;
  final bool colon;
  final bool rectum;
  final TextEditingController monthController;
  final TextEditingController yearController;

  const CancerHistoryWidget({Key key, this.yearLastDiag, this.monthLastDiag, this.cancerStages, this.dropDownColon, this.dropDownRectum, this.colon, this.rectum, this.monthController, this.yearController}) : super(key: key);


  @override
  _CancerHistoryWidget createState() => _CancerHistoryWidget();
}

class _CancerHistoryWidget extends State<CancerHistoryWidget> {


  int _diagYear;
  int _diagMonth;

  String dropDownColon;
  String dropDownRectum;
  String dropDownSurgery;

  bool _colon;
  bool _rectum;


  List<String> _cancerStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  Widget cancerHistory;

  Widget _buildCancerHistoryYN(String cancer) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: cancer == "rectum" ? widget.rectum : widget.colon,
            onChanged: (value) {
              setState(() {
                cancer == "rectum" ? _rectum = value : _colon = value;
              });
            },
          ),
        ),
      ),
      Expanded(
        child: ListTile(
          title: const Text('no'),
          leading: Radio(
            value: false,
            groupValue: cancer == "rectum" ? widget.rectum : widget.colon,
            onChanged: (value) {
              setState(() {
                cancer == "rectum" ? _rectum = value : _colon = value;
                // Navigator.of(context, rootNavigator: true).pop();
                // _buildCancerHistory();
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildColonDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Colon Cancer Stage',
          border: OutlineInputBorder(),
          hintText: "Colon Cancer Stage"),
      value: widget.dropDownColon,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownColon = value;
        });
      },
      items: widget.cancerStages
          .map((colStage) =>
          DropdownMenuItem(value: colStage, child: Text("$colStage")))
          .toList(),
    );
  }

  Widget _buildRectumDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Rectum Cancer Stage',
          border: OutlineInputBorder(),
          hintText: "Rectum Cancer Stage"),
      value: widget.dropDownRectum,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownRectum = value;
        });
      },
      items:widget.cancerStages
          .map((recStage) =>
          DropdownMenuItem(value: recStage, child: Text("$recStage")))
          .toList(),
    );
  }


  Widget _buildLastDiagMonth() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Month(optional)',
        hintText: 'MM',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: widget.monthController,
      validator: (String value) {
        int month = int.tryParse(value);
        if (month == null) {
          return null;
        }
        else if (month <= 0) {
          return 'Month must be greater than 0';
        } else if (month >= 13) {
          return 'Month cannot be greater than 12';
        }
        return null;
      },
      onSaved: (String value) {
        _diagMonth = int.tryParse(value);
      },
    );
  }


  Widget _buildLastDiagYear() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Year',
        hintText: 'YYYY',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: widget.yearController,
      validator: (String value) {
        int year = int.tryParse(value);
        if (year == null || year <= 0) {
          return 'Year must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _diagYear = int.tryParse(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Do you have colon cancer?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildCancerHistoryYN("colon"),
          _colon == true ? _buildColonDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Do you have rectum cancer?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildCancerHistoryYN("rectum"),
          _rectum == true ? _buildRectumDropdown() : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? SizedBox(height: 20)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                  'When was your last cancer (any type of cancer) diagnosis?',
                  style: TextStyle(fontSize: 16)),
            ),
          )
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? SizedBox(height: 10)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? _buildLastDiagMonth()
              : SizedBox(height: 10),
          _rectum == true || _colon == true
              ? SizedBox(height: 10)
              : SizedBox(height: 0),
          _rectum == true || _colon == true
              ? _buildLastDiagYear()
              : SizedBox(height: 10),
        ],
      ),
    );
  }
}