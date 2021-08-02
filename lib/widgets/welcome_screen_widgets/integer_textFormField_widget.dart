import 'package:flutter/material.dart';

class IntegerTextFormWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int variable;

  const IntegerTextFormWidget(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.variable})
      : super(key: key);

  @override
  _IntegerTextFormWidget createState() => _IntegerTextFormWidget();
}

class _IntegerTextFormWidget extends State<IntegerTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildIntTextFormField(
        widget.label, widget.hint, widget.controller, widget.variable);
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
      validator: (value) {
        if (value == null) return 'Field Required';
        int input = int.tryParse(value)!;
        if (input <= 0) {
          return label + ' must be greater than 0';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) variable = int.tryParse(value)!;
      },
    );
  }
}
