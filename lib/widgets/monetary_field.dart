import 'package:flutter/material.dart';

class MonetaryField extends StatelessWidget {
  final String hint;
  final String prefix;
  final TextEditingController controller;
  final Function onChanged;

  MonetaryField({this.hint, this.prefix, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
        prefixText: prefix,
      ),
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
