import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class AllStudentsPage extends StatelessWidget {
  const AllStudentsPage({super.key});

  static const String pageName = 'allStudentsPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('All students page'),
      ),
    );
  }
}