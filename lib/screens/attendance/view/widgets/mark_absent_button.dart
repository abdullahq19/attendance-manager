import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkAbsentButton extends StatelessWidget {
  const MarkAbsentButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<AttendancePageProvider>(
      builder: (context, attendancePageProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.005),
          child: AppCommonButton(
            width: width * 0.9,
            height: height * 0.07,
            onPressed: attendancePageProvider.isMarkedForToday
                ? null
                : () async {
                    await attendancePageProvider.markAttendance(true, context);
                  },
            color: Colors.red.shade50,
            child: _onAttendanceMarkedButtonPressed(
                attendancePageProvider, context),
          ),
        );
      },
    );
  }

  // Gets the child widget of the MarkAbsentButton
  Widget _onAttendanceMarkedButtonPressed(
      AttendancePageProvider attendancePageProvider, BuildContext context) {
    return attendancePageProvider.isMarkingAbsent
        ? const CircularProgressIndicator(color: Colors.red)
        : Text('Mark Absent',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: attendancePageProvider.isMarkedForToday
                    ? AppColors.grey
                    : Colors.red));
  }
}
