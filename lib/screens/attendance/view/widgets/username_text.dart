import 'dart:developer';

import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    final name = Provider.of<RegisterPageProvider>(context).currentUsername;
    log(name!);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, bottom: height * 0.02),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Name: $name',
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}
