import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:flutter/material.dart';

class SignInPageNavigateWidget extends StatelessWidget {
  const SignInPageNavigateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width) = MediaQuery.sizeOf(context);
    final TextTheme(:bodyLarge) = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?',
            style: bodyLarge?.copyWith(fontWeight: FontWeight.w400)),
        SizedBox(width: width * 0.01),
        GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(SignInPage.pageName),
            child: Text(
              'Sign in',
              style: bodyLarge?.copyWith(
                  color: AppColors.appButtonTextColor,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
