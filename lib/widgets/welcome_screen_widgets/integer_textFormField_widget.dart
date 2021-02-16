import 'package:flutter/material.dart';


class IntegerTextFormWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int variable;

  const IntegerTextFormWidget({Key key, this.label, this.hint, this.controller, this.variable}) : super(key: key);




  @override
  _IntegerTextFormWidget  createState() => _IntegerTextFormWidget ();
}

class _IntegerTextFormWidget  extends State<IntegerTextFormWidget > {


  @override
  Widget build(BuildContext context) {
    return _buildIntTextFormField(widget.label,  widget.hint, widget.controller,  widget.variable);
  }

  Widget _buildIntTextFormField(String label, String hint,
      TextEditingController controller, int variable) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: controller,
      validator: (String value) {
        int input = int.tryParse(value);
        if (input == null) {
          return 'Field Required';
        } else if (input <= 0) {
          return label + ' must be greater than 0';
        }
        return null;
      },
      onSaved: (String value) {
        variable = int.tryParse(value);
      },
    );
  }
}
