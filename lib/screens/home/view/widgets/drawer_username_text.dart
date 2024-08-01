import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerUsernameText extends StatelessWidget {
  const DrawerUsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<RegisterPageProvider>(context).currentUsername;
    return Text(
      '$name',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
