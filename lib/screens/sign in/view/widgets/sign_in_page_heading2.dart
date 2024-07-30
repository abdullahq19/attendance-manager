import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class SignInPageHeading2 extends StatelessWidget {
  const SignInPageHeading2({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme(:titleMedium) = Theme.of(context).textTheme;
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05, top: height * 0.01),
          child: Text('Welcome back!, Sign in to get started 🚀',
              style: titleMedium?.copyWith(color: AppColors.hintTextColor)),
        ));
  }
}
