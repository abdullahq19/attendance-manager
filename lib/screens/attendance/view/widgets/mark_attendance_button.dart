import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkAttendanceButton extends StatelessWidget {
  const MarkAttendanceButton({super.key, required this.isAbsent});

  final bool isAbsent;

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
            onPressed: attendancePageProvider.isMarkedForToday
                ? null
                : () async {
                    await attendancePageProvider.markAttendance(isAbsent);
                  },
            color: isAbsent ? Colors.red.shade50 : AppColors.blue50,
            child: _onAttendanceMarkedButtonPressed(
                attendancePageProvider, context),
          ),
        );
      },
    );
  }

  // Gets the child widget of the MarkAttendanceButton
  _onAttendanceMarkedButtonPressed(
      AttendancePageProvider attendancePageProvider, BuildContext context) {
    return attendancePageProvider.isMarkingPresent
        ? const CircularProgressIndicator(color: Colors.blue)
        : attendancePageProvider.isMarkingAbsent
            ? const CircularProgressIndicator(
                color: AppColors.red,
              )
            : attendancePageProvider.isMarkedForToday
                ? Text(isAbsent ? 'Mark Absent' : 'Mark Present',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.grey))
                : Text(isAbsent ? 'Mark Absent' : 'Mark Present',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: isAbsent ? AppColors.red : Colors.blue));
  }
}
