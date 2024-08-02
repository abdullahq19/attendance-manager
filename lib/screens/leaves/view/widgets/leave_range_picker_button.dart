import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveRangePickerButton extends StatelessWidget {
  const LeaveRangePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<LeavePageProvider>(
      builder: (context, leavePageProvider, child) {
        return SizedBox(
          width: width * 0.8,
          height: height * 0.07,
          child: AppCommonButton(
            width: width,
            color: leavePageProvider.sentLeaveRequestForToday
                ? Colors.grey.shade50
                : Colors.purple.shade50,
            onPressed: leavePageProvider.sentLeaveRequestForToday
                ? null
                : () async {
                    await leavePageProvider.pickDateRange(context);
                  },
            child: Text(
              leavePageProvider.dateRangeButtonText ?? 'Select Range',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: leavePageProvider.sentLeaveRequestForToday
                      ? Colors.grey
                      : Colors.purple),
            ),
          ),
        );
      },
    );
  }
}
