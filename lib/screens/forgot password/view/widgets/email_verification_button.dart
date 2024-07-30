import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/forgot%20password/providers/forgot_pass_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendEmailVerificationButton extends StatelessWidget {
  const SendEmailVerificationButton(
      {super.key,
      required this.width,
      required this.height,
      required this.emailController});

  final double width;
  final double height;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordPageProvider =
        Provider.of<ForgotPassPageProvider>(context);
    return Align(
      alignment: Alignment.center,
      child: AppCommonButton(
        onPressed: () async {
          await forgotPasswordPageProvider.forgotPass(emailController.text);
          emailController.clear();
        },
        width: width,
        color: AppColors.appButtonBackgroundColor,
        height: height,
        child: Text(
          'Send email',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
