import 'package:flutter/material.dart';

class WeightFormWidget extends StatefulWidget {
  final TextEditingController controller;

  const WeightFormWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _WeightFormWidget createState() => _WeightFormWidget();
}

class _WeightFormWidget extends State<WeightFormWidget> {
  int _weight = 0;

  @override
  Widget build(BuildContext context) {
    return _buildWeight(widget.controller);
  }

  Widget _buildWeight(TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Weight(lbs)',
        hintText: 'Enter your weight in pounds(lbs).',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: controller,
      validator: (value) {
        if (value == null) return 'Field Required';
        int weight = int.tryParse(value)!;
        if (weight <= 0) {
          return 'Weight must be greater than 0';
        }
      },
      onSaved: (value) {
        if (value != null) _weight = int.tryParse(value)!;
      },
    );
  }
}
