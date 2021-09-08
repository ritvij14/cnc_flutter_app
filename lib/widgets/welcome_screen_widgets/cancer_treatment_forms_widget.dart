import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancerTreatmentWidget extends StatefulWidget {
  final bool surgery;
  final bool chemo;
  final bool radiation;
  final Map<String, bool> surgeryType;

  const CancerTreatmentWidget(
      {Key? key,
      required this.surgery,
      required this.chemo,
      required this.radiation,
      required this.surgeryType})
      : super(key: key);

  @override
  _CancerTreatmentWidget createState() => _CancerTreatmentWidget();
}

class _CancerTreatmentWidget extends State<CancerTreatmentWidget> {
  late bool _surgery;
  late bool _chemo;
  late bool _radiation;

  late Map<String, bool> selectedSurgeryType;

  Widget _buildTreatmentYN(String treatment) {
    return Row(children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('yes'),
          leading: Radio(
            value: true,
            groupValue: treatment == "surgery"
                ? widget.surgery
                : treatment == "chemo"
                    ? widget.chemo
                    : widget.radiation,
            onChanged: (bool? value) {
              if (value != null)
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
                ? widget.surgery
                : treatment == "chemo"
                    ? widget.chemo
                    : widget.radiation,
            onChanged: (bool? value) {
              if (value != null)
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
      children: widget.surgeryType.keys.map((String key) {
        return new CheckboxListTile(
          title: new Text(key),
          value: widget.surgeryType[key],
          activeColor: Theme.of(context).buttonColor,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            if (value != null)
              setState(() {
                selectedSurgeryType[key] = value;
              });
          },
        );
      }).toList(),
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
              child: Text('Have you had cancer surgery?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("surgery"),
          _surgery == true
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('What procedure did you have?',
                        style: TextStyle(fontSize: 16)),
                  ),
                )
              : SizedBox(height: 0),
          _surgery == true ? _buildSurgeryDropdown() : SizedBox(height: 0),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had radiation therapy?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("radiation"),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text('Have you had chemotherapy?',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
          _buildTreatmentYN("chemo"),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
