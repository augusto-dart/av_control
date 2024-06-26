import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AvTextField extends StatelessWidget {
  const AvTextField({
    super.key,
    required this.controlName,
    required this.hintText,
    required this.requiredText,
  });

  final String controlName;
  final String hintText;
  final String requiredText;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      validationMessages: {
        'required': (error) => requiredText,
        'email': (error) => 'Informe um email válido!'
      },
      formControlName: controlName,
    );
  }
}
