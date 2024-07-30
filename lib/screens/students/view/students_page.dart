import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  static const pageName = 'StudentsPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: Text('Students Page'),),
    );
  }
}