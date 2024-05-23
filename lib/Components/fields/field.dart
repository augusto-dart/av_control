// ignore_for_file: must_be_immutable

import 'package:av_control/Components/fields/date_field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Components/fields/password_field.dart';
import 'package:av_control/Components/fields/text_field.dart';
import 'package:flutter/material.dart';

class AvField extends StatefulWidget {
  const AvField({
    super.key,
    required this.hintText,
    required this.controlName,
    this.requiredText = '',
    this.tipo = FieldType.text,
  });

  final String controlName;
  final String hintText;
  final String requiredText;
  final FieldType tipo;

  @override
  State<AvField> createState() => _AvFieldState();
}

class _AvFieldState extends State<AvField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: getField(),
    );
  }

  Widget getField() {
    switch (widget.tipo) {
      case FieldType.text:
        return AvTextField(
          controlName: widget.controlName,
          hintText: widget.hintText,
          requiredText: widget.requiredText,
        );
      case FieldType.password:
        return AvPasswordField(
          controlName: widget.controlName,
          hintText: widget.hintText,
          requiredText: widget.requiredText,
        );
      case FieldType.date:
        return AvDateField(
          controlName: widget.controlName,
          hintText: widget.hintText,
          requiredText: widget.requiredText,
        );
    }
  }
}
