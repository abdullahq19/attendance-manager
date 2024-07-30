import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.passwordController,
      this.isAdmin = false,
      required this.confirmPasswordController,
      required this.formKey,
      required this.height,
      required this.width});

  final double width;
  final double height;
  final bool isAdmin;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AppCommonButton(
        width: width,
        height: height,
        onPressed: () async {
          await _signUpButtonPressed(context);
        },
        color: AppColors.appButtonBackgroundColor,
        child: Consumer<RegisterPageProvider>(
          builder: (context, provider, child) {
            return provider.isSigningUp
                ? Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: AppColors.appButtonTextColor,
                    ),
                  )
                : Text(AppTexts.signUpPageSignUpButtonText,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.appButtonTextColor));
          },
        ),
      ),
    );
  }

  Future<void> _signUpButtonPressed(
    BuildContext context,
  ) async {
    try {
      final registerPageProvider =
          Provider.of<RegisterPageProvider>(context, listen: false);
      // Vaidating all fields to ensure every information is valid
      if (passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        if (formKey.currentState!.validate()) {
          log('Validated');
          final isSignedUp = await registerPageProvider.registerUser(
              emailController.text,
              passwordController.text,
              "${firstNameController.text} ${lastNameController.text}",
              isAdmin,
              context);
          log('isSignedUp before evaluation: ${isSignedUp.toString()}');
          //NOTE: THIS DOES NOT WORK, AS AFTER SIGNING UP FIELDS DO NOT CLEAR
          if (isSignedUp) {
            firstNameController.clear();
            lastNameController.clear();
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
            formKey.currentState!.reset();
          }
        } else {
          formKey.currentState!.validate();
        }
      }
    } catch (e) {
      log('Sign Up button exception: ${e.toString()}');
    }
  }
}
