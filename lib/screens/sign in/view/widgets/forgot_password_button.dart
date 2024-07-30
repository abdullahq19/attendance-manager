import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/forgot%20password/view/forgot_password_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme(:bodyLarge) = Theme.of(context).textTheme;
    final Size(:width) = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06),
      child: GestureDetector(
        onTap: () =>
            Navigator.of(context).pushNamed(ForgotPasswordPage.pageName),
        child: Text(
          'Forgot Password?',
          style: bodyLarge?.copyWith(color: AppColors.hintTextColor),
        ),
      ),
    );
  }
}
