import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveRangePickerButton extends StatelessWidget {
  const LeaveRangePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer2<LeavePageProvider, AttendancePageProvider>(
      builder: (context, leavePageProvider, attendancePageProvider, child) {
        return SizedBox(
          width: width * 0.8,
          height: height * 0.07,
          child: AppCommonButton(
            width: width,
            color: leavePageProvider.sentLeaveRequestForToday ||
                    attendancePageProvider.isMarkedForToday
                ? Colors.grey.shade50
                : Colors.purple.shade50,
            onPressed: leavePageProvider.sentLeaveRequestForToday ||
                    attendancePageProvider.isMarkedForToday
                ? null
                : () async {
                    await leavePageProvider.pickDateRange(context);
                  },
            child: Text(
              leavePageProvider.dateRangeButtonText ?? 'Select Range',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: leavePageProvider.sentLeaveRequestForToday ||
                          attendancePageProvider.isMarkedForToday
                      ? Colors.grey
                      : Colors.purple),
            ),
          ),
        );
      },
    );
  }
}
