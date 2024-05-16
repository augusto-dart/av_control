import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AvTextField extends StatelessWidget {
  const AvTextField({
    super.key,
    required this.hintText,
    required this.controlName,
    this.requiredText = '',
    this.obscure = false,
  });

  final String controlName;
  final String hintText;
  final String requiredText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReactiveTextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        validationMessages: {
          'required': (error) => requiredText,
          'email': (error) => 'Informe um email válido!'
        },
        formControlName: controlName,
        obscureText: obscure,
      ),
    );
  }
}
