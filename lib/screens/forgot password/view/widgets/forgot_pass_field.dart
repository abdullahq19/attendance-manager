import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';

class ForgotPasswordField extends StatelessWidget {
  const ForgotPasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
        validator: (email) {
          if (email == null || email.isEmpty) {
            return 'Please enter a email';
          } else {
            return email.validateEmailForForgotPasswordField();
          }
        },
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        hintText: 'Enter your email',
        label: 'Email');
  }
}
