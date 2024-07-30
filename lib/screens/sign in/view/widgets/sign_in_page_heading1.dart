import 'package:flutter/material.dart';

class SignInPageHeading1 extends StatelessWidget {
  const SignInPageHeading1({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme(:displaySmall) = Theme.of(context).textTheme;
    final Size(:width) = MediaQuery.sizeOf(context);
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text('Sign in',
              style: displaySmall?.copyWith(fontWeight: FontWeight.bold)),
        ));
  }
}
