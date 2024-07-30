import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/sign%20in/providers/sign_in_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.center,
      child: AppCommonButton(
        width: width * 0.9,
        height: height * 0.07,
        onPressed: () async {
          await _handleSignInButtonPressed(context);
        },
        color: AppColors.appButtonBackgroundColor,
        child: Consumer<SignInPageProvider>(
          builder: (context, provider, child) {
            return provider.isSigningIn
                ? Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: AppColors.appButtonTextColor,
                    ),
                  )
                : Text(AppTexts.signInPageSignInButtonText,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.appButtonTextColor));
          },
        ),
      ),
    );
  }

  Future<void> _handleSignInButtonPressed(
    BuildContext context,
  ) async {
    try {
      final signInPageProvider =
          Provider.of<SignInPageProvider>(context, listen: false);
      if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
        log('one of the fields is not empty');
        if (formKey.currentState!.validate()) {
          log('validation return true');
          await signInPageProvider
              .signInWithEmailPassword(emailController.text, passwordController.text, context)
              .then((value) {
            emailController.clear();
            passwordController.clear();
          });
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
