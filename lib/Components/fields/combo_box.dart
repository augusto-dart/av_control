import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AvCombobox extends StatelessWidget {
  const AvCombobox({
    super.key,
    required this.label,
    required this.data,
    required this.controlName,
  });

  final String label;
  final List<DropdownMenuItem> data;
  final String controlName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReactiveDropdownField(
        items: data,
        formControlName: controlName,
        hint: Text(label),
      ),
    );
  }
}
