import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

class AvDateField extends StatelessWidget {
  const AvDateField({
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
    return ReactiveDateTimePicker(
      dateFormat: DateFormat('dd/MM/yyyy'),
      type: ReactiveDatePickerFieldType.date,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      validationMessages: {
        'required': (error) => requiredText,
      },
      formControlName: controlName,
      locale: const Locale('pt', 'BR'),
    );
  }
}
