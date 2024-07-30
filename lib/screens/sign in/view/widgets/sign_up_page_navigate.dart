import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/register/view/register_page.dart';
import 'package:flutter/material.dart';

class RegisterPageNavigateWidget extends StatelessWidget {
  const RegisterPageNavigateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width) = MediaQuery.sizeOf(context);
    final TextTheme(:bodyLarge) = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?',
            style: bodyLarge?.copyWith(fontWeight: FontWeight.w400)),
        SizedBox(width: width * 0.01),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, RegisterPage.pageName),
            child: Text('Sign up',
                style: bodyLarge?.copyWith(
                    color: AppColors.appButtonTextColor,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
