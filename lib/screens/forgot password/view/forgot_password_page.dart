import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/forgot%20password/view/widgets/email_verification_button.dart';
import 'package:attendance_management_system/screens/forgot%20password/view/widgets/forgot_pass_field.dart';
import 'package:attendance_management_system/screens/forgot%20password/view/widgets/go_back_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String pageName = 'forgotPasswordPage';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController confirmPasswordEmailController;

  @override
  void initState() {
    super.initState();
    confirmPasswordEmailController = TextEditingController();
  }

  @override
  void dispose() {
    confirmPasswordEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Forgot your password?',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: height * 0.01,
            ),
            Align(
                alignment: Alignment.center,
                child: Text('Enter your email below to verify password reset',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.hintTextColor))),
            SizedBox(
              height: height * 0.02,
            ),
            ForgotPasswordField(
              controller: confirmPasswordEmailController,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            SendEmailVerificationButton(
                height: height * 0.07,
                width: width * 0.9,
                emailController: confirmPasswordEmailController),
                SizedBox(height: height * 0.01,),
            GoBackButton(height: height * 0.07,width: width * 0.9,),
          ],
        ),
      ),
    );
  }
}
