import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        suffixIcon: obscure ? Icon(MdiIcons.eye) : Icon(MdiIcons.eyeOff),
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
