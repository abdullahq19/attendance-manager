import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class AllLeavesPage extends StatelessWidget {
  const AllLeavesPage({super.key});

  static const String pageName = 'allLeavesPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('All leaves page'),
      ),
    );
  }
}