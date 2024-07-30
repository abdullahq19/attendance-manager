import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

  static const String pagename = 'leavesPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('Leaves Page'),
      ),
    );
  }
}
