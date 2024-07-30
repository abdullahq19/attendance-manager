import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.emailController, this.focusNode});

  final TextEditingController emailController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
        controller: emailController,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        validator: (email) {
          if (email == null || email.isEmpty) {
            return 'Please enter a email';
          } else {
            return email.validateEmail();
          }
        },
        hintText: 'johndoe@example.com',
        label: 'Email');
  }
}
