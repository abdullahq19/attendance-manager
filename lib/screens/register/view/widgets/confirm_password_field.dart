import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField(
      {super.key, required this.confirmPasswordController, required this.passwordController});

  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final registerPageProvider = Provider.of<RegisterPageProvider>(context);
    return MyTextFormField(
        controller: confirmPasswordController,
        hintText: 'johndoe1234',
        label: 'Confirm Password',
        validator: (confirmPassword) {
          if (confirmPassword == null || confirmPassword.isEmpty) {
            return 'Please enter a password';
          } else if (confirmPassword != passwordController.text) {
            return 'Passwords don\'t match';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.visiblePassword,
        suffix: GestureDetector(
          onTap: registerPageProvider.unhideConfirmPassword,
          child: registerPageProvider.isConfirmPasswordHidden
              ? const Icon(Icons.visibility_off_rounded)
              : const Icon(Icons.visibility_rounded),
        ),
        obscureText: registerPageProvider.isConfirmPasswordHidden);
  }
}
