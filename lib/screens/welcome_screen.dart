import 'dart:core';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _age;
  int _height;
  int _weight;
  int _yearsLastDiag;
  int _counter = 0;

  String dropDownActivity;
  String dropDownColon;
  String dropDownRectum;
  String dropDownSurgery;

  bool _colon = false;
  bool _rectum = false;
  bool _surgery = false;
  bool _chemo = false;
  bool _radiation = false;

  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];

  Map<String, bool> surgeryType = {
    'Colectomy': false,
    'Ileostomy': false,
    'Polypectomy': false,
    'Other': false,
  };

  List<String> _colonStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': false,
    'Appetite Loss': false,
    'Bloating': false,
    'Constipation': false,
    "Diarrhea": false,
    'Nausea/Vomiting': false,
    'Stoma Problems': false,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Age',
        hintText: 'Enter your age in years.',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int age = int.tryParse(value);
        if (age == null) {
          return 'Field Required';
        } else if (age <= 0) {
          return 'Age must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _age = int.tryParse(value);
      },
    );
  }

  Widget _buildHeight() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Height(in)',
        hintText: 'Enter your height in inches.',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int height = int.tryParse(value);
        if (height == null) {
          return 'Field Required';
        } else if (height <= 0) {
          return 'Height must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _height = int.tryParse(value);
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Weight(lbs)',
        hintText: 'Enter your weight in pounds(lbs).',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int weight = int.tryParse(value);
        if (weight == null) {
          return 'Field Required';
        } else if (weight <= 0) {
          return 'Weight must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        _weight = int.tryParse(value);
      },
    );
  }

  // Widget _buildHeight2() {
  //   return Row(
  //     children: <Widget>[
  //       Expanded(
  //         child: Container(
  //           child: TextFormField(
  //             decoration: InputDecoration(
  //               labelText: 'feet',
  //               hintText: 'feet',
  //               border: OutlineInputBorder(),
  //             ),
  //             keyboardType: TextInputType.number,
  //             validator: (String value) {
  //               int weight = int.tryParse(value);
  //               if (weight == null || weight <= 0) {
  //                 return 'Weight must be greater than 0';
  //               }
  //               return null;
  //             },
  //             onSaved: (String value) {
  //               _weight = int.tryParse(value);
  //             },
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: Text('ft'),
  //       ),
  //       Expanded(
  //         child: SizedBox(width: 1),
  //       ),
  //       Expanded(
  //         child: Container(
  //           child: TextFormField(
  //             decoration: InputDecoration(
  //               labelText: 'inches',
  //               hintText: 'inches',
  //               border: OutlineInputBorder(),
  //             ),
  //             keyboardType: TextInputType.number,
  //             validator: (String value) {
  //               int weight = int.tryParse(value);
  //               if (weight == null || weight <= 0) {
  //                 return 'Weight must be greater than 0';
  //               }
  //               return null;
  //             },
  //             onSaved: (String value) {
  //               _weight = int.tryParse(value);
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildActivity() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Usual Activity Level',
          border: OutlineInputBorder(),
          hintText: "Usual Activity Level"),
      value: dropDownActivity,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String Value) {
        setState(() {
          dropDownActivity = Value;
        });
      },
      items: _activity
          .map((actLevel) =>
              DropdownMenuItem(value: actLevel, child: Text("$actLevel")))
          .toList(),
    );
  }

  Widget _buildGICheckBoxes() {
    return ListView(
      shrinkWrap: true,
      children: frequentIssues.keys.map((String key) {
        return new CheckboxListTile(
          title: new Text(key),
          value: frequentIssues[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              frequentIssues[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildGIIssues() {
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
          _buildGICheckBoxes(),
        ]));
  }

  // _buildGIIssues2() async {
  //   await showDialog<String>(
  //     context: context,
  //     child: new AlertDialog(
  //       title: Text(
  //           'Frequent GI Issues (at least once every week within the last 2 months)'),
  //       contentPadding: const EdgeInsets.all(16.0),
  //       content: new Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Container(
  //               // decoration: BoxDecoration(border: Border.all(color: Colors.grey),
  //               //   borderRadius: BorderRadius.circular(5),),
  //               child: ListView(
  //                 shrinkWrap: true,
  //                 children: frequentIssues.keys.map((String key) {
  //                   return new CheckboxListTile(
  //                     title: new Text(key),
  //                     value: frequentIssues[key],
  //                     activeColor: Colors.green,
  //                     checkColor: Colors.white,
  //                     onChanged: (bool value) {
  //                       setState(() {
  //                         frequentIssues[key] = value;
  //                         Navigator.of(context, rootNavigator: true).pop();
  //                         _buildGIIssues2();
  //                       });
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //       actions: <Widget>[
  //         new FlatButton(
  //             child: const Text('SAVE'),
  //             onPressed: () {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               ;
  //             })
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCancerHistoryYN(String cancer) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: cancer == "rectum" ? _rectum : _colon,
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
      Expanded(
        child: ListTile(
          title: const Text('no'),
          leading: Radio(
            value: false,
            groupValue: cancer == "rectum" ? _rectum : _colon,
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
      value: dropDownColon,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownColon = value;
        });
      },
      items: _colonStages
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
      value: dropDownRectum,
      validator: (value) => value == null ? 'Field Required' : null,
      onChanged: (String value) {
        setState(() {
          dropDownRectum = value;
        });
      },
      items: _colonStages
          .map((recStage) =>
              DropdownMenuItem(value: recStage, child: Text("$recStage")))
          .toList(),
    );
  }

  Widget _buildDiagnosis() {
    return TextFormField(
      decoration: InputDecoration(
        // labelText: 'Last Cancer Diagnosis(years)',
        hintText: 'Years since last cancer diagnosis',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int years = int.tryParse(value);
        if (years == null) {
          return 'Field Required';
        }
        return null;
      },
      onSaved: (String value) {
        _yearsLastDiag = int.tryParse(value);
      },
    );
  }

  // _buildCancerHistory() async {
  //   await showDialog<String>(
  //     context: context,
  //     child: new AlertDialog(
  //       title: Text('Cancer History'),
  //       // contentPadding: const EdgeInsets.all(16.0),
  //       content: SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Container(
  //                 child: Text(
  //                   'Do you have colon cancer?',
  //                 ),
  //               ),
  //             ),
  //             _buildCancerHistoryYN("colon"),
  //             _colon == true ? _buildColonDropdown() : SizedBox(height: 0),
  //             SizedBox(height: 20),
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Container(
  //                 child: Text('Do you have rectum cancer?'),
  //               ),
  //             ),
  //             _buildCancerHistoryYN("rectum"),
  //             _rectum == true ? _buildRectumDropdown() : SizedBox(height: 0),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       ),
  //       actions: <Widget>[
  //         new FlatButton(
  //             child: const Text('SAVE'),
  //             onPressed: () {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               ;
  //             })
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCancerHistory() {
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
              child: Text(
                'Cancer History',style: TextStyle(fontSize: 18)
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Do you have colon cancer?',style: TextStyle(fontSize: 16)
              ),
            ),
          ),
          _buildCancerHistoryYN("colon"),
          _colon == true ? _buildColonDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Do you have rectum cancer?',style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildCancerHistoryYN("rectum"),
          _rectum == true ? _buildRectumDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          _rectum == true || _colon == true
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                        'How many years has it been since your last cancer (any type of cancer) diagnosis?',style: TextStyle(fontSize: 16)),
                  ),
                )
              : SizedBox(height: 0),
          SizedBox(height: 10),
          _rectum == true || _colon == true
              ? _buildDiagnosis()
              : SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTreatmentYN(String treatment) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: treatment == "surgery"
                ? _surgery
                : treatment == "chemo"
                    ? _chemo
                    : _radiation,
            onChanged: (value) {
              setState(() {
                treatment == "surgery"
                    ? _surgery = value
                    : treatment == "chemo"
                        ? _chemo = value
                        : _radiation = value;
                // Navigator.of(context, rootNavigator: true).pop();
                // _buildCancerHistory();
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
            groupValue: treatment == "surgery"
                ? _surgery
                : treatment == "chemo"
                    ? _chemo
                    : _radiation,
            onChanged: (value) {
              setState(() {
                treatment == "surgery"
                    ? _surgery = value
                    : treatment == "chemo"
                        ? _chemo = value
                        : _radiation = value;
                // Navigator.of(context, rootNavigator: true).pop();
                // _buildCancerHistory();
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildSurgeryDropdown() {
    return ListView(
      shrinkWrap: true,
      children: surgeryType.keys.map((String key) {
        return new CheckboxListTile(
          title: new Text(key),
          value: surgeryType[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              surgeryType[key] = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildCancerTreatment() {
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
              child: Text('Cancer Treatment', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Have you had cancer surgery?',style: TextStyle(fontSize: 16)
              ),
            ),
          ),
          _buildTreatmentYN("surgery"),
          _surgery == true ? _buildSurgeryDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had radiation therapy?',style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("radiation"),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had chemotherapy?',style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("chemo"),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _emptyFieldsAlert() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Empty Form Fields'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You have left some required fields empty. Please be sure to fill the indicated fields.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Welcome!", style: TextStyle(fontSize: 25)),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text("Please fill out the following forms:", style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 10),
                _buildAge(),
                SizedBox(height: 10),
                _buildHeight(),
                SizedBox(height: 10),
                _buildWeight(),
                SizedBox(height: 10),
                _buildActivity(),
                SizedBox(height: 10),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Container(
                //     child: FlatButton(
                //       // textTheme: ThemeData.inputDecorationTheme,
                //       shape: RoundedRectangleBorder(
                //           side: BorderSide(
                //               color: Colors.grey,
                //               // width: 1,
                //               style: BorderStyle.solid),
                //           borderRadius: BorderRadius.circular(5)),
                //       child: Text("Frequent GI Issues",
                //           style: TextStyle(color: Colors.grey[600])),
                //       onPressed: _buildGIIssues,
                //     ),
                //   ),
                // ),
                _buildGIIssues(),
                SizedBox(height: 10),
                _buildCancerHistory(),
                SizedBox(height: 10),
                _buildCancerTreatment(),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Theme.of(context).highlightColor),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      _emptyFieldsAlert();
                    }

                    _formKey.currentState.save();

                    print(_age);

                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
