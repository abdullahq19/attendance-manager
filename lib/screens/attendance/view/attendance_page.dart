import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  static const String pagename = 'attendancePage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Attendance Page'),),
    );
  }
}