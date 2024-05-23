import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AvPasswordField extends StatefulWidget {
  const AvPasswordField({
    super.key,
    required this.controlName,
    required this.hintText,
    required this.requiredText,
  });

  final String controlName;
  final String hintText;
  final String requiredText;

  @override
  State<AvPasswordField> createState() => _AvPasswordFieldState();
}

class _AvPasswordFieldState extends State<AvPasswordField> {
  late bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.remove_red_eye),
      ),
      validationMessages: {
        'required': (error) => widget.requiredText,
        'email': (error) => 'Informe um email válido!'
      },
      formControlName: widget.controlName,
      obscureText: obscure,
      onTap: (control) {
        setState(() {
          obscure = !obscure;
        });
      },
    );
  }
}
