import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:flutter/material.dart';

class ReasonTextField extends StatelessWidget {
  const ReasonTextField({super.key, required this.reasonController});

  final TextEditingController reasonController;

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
        controller: reasonController,
        maxLines: 4,
        hintText: 'Reason for leave (Optional)',
        label: 'Reason');
  }
}
