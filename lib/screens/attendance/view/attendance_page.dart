import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/attendance_page_card.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  static const String pagename = 'attendancePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('Attendance',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back))),
      backgroundColor: AppColors.white,
      body: const AttendancePageCard(),
    );
  }
}
