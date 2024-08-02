import 'package:attendance_management_system/screens/attendance/view/widgets/attendance_page_header_row.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_absent_button.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_present_button.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/username_text.dart';
import 'package:flutter/material.dart';

class AttendancePageCard extends StatelessWidget {
  const AttendancePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: width * 0.9,
        height: height * 0.35,
        child: Card(
          elevation: 5,
          color: Colors.grey.shade50,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AttendancePageHeaderRow(),
              UsernameText(),
              MarkPresentButton(),
              MarkAbsentButton(),
            ],
          ),
        ),
      ),
    );
  }
}
