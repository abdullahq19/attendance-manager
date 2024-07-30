import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:attendance_management_system/screens/sign%20in/providers/sign_in_page_provider.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {super.key,
      required this.isSignUpPasswordField,
      required this.passwordController});

  final TextEditingController passwordController;
  final bool isSignUpPasswordField;

  @override
  Widget build(BuildContext context) {
    final provider = isSignUpPasswordField
        ? Provider.of<RegisterPageProvider>(context)
        : Provider.of<SignInPageProvider>(context);
    return MyTextFormField(
        controller: passwordController,
        hintText: 'johndoe1234',
        label: 'Password',
        validator: (password) {
          if (password == null || password.isEmpty) {
            return 'Please enter a password';
          } else {
            return password.validatePassword();
          }
        },
        keyboardType: TextInputType.visiblePassword,
        suffix: GestureDetector(
          onTap: provider.unhidePassword,
          child: provider.isPasswordHidden
              ? const Icon(Icons.visibility_off_rounded)
              : const Icon(Icons.visibility_rounded),
        ),
        obscureText: provider.isPasswordHidden);
  }
}
