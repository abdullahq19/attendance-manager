import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:attendance_management_system/screens/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReasonTextField extends StatelessWidget {
  const ReasonTextField({super.key, required this.reasonController});

  final TextEditingController reasonController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LeavePageProvider, AttendancePageProvider>(
      builder: (context, leavePageProvider, attendancePageProvider, child) {
        return MyTextFormField(
            readOnly: leavePageProvider.sentLeaveRequestForToday ||
                    attendancePageProvider.isMarkedForToday
                ? true
                : false,
            controller: reasonController,
            maxLines: 4,
            hintText: 'Reason for leave (Optional)',
            label: 'Reason');
      },
    );
  }
}
