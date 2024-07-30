import 'package:flutter/material.dart';

class SignUpPageHeading1 extends StatelessWidget {
  const SignUpPageHeading1({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme(:displaySmall) = Theme.of(context).textTheme;
    final Size(:width) = MediaQuery.sizeOf(context);
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text('Create an Account',
              style: displaySmall?.copyWith(fontWeight: FontWeight.bold)),
        ));
  }
}
