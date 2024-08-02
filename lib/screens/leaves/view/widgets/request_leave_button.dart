import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestLeaveButton extends StatelessWidget {
  const RequestLeaveButton({super.key, required this.reasonController});

  final TextEditingController reasonController;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<LeavePageProvider>(
      builder: (context, leavePageProvider, child) {
        return Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: SizedBox(
            width: width * 0.8,
            height: height * 0.07,
            child: AppCommonButton(
                color: leavePageProvider.dateTimeRange == null ||
                        leavePageProvider.sentLeaveRequestForToday
                    ? AppColors.textFieldFillColor
                    : Colors.indigo.shade50,
                width: width,
                onPressed: leavePageProvider.dateTimeRange == null ||
                        leavePageProvider.sentLeaveRequestForToday
                    ? null
                    : () async {
                        await leavePageProvider
                            .requestLeave(reasonController.text.trim());
                      },
                child: leavePageProvider.sendingLeaveRequest
                    ? const CircularProgressIndicator(color: Colors.indigo)
                    : Text('Request leave',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: leavePageProvider.dateTimeRange == null ||
                                    leavePageProvider.sentLeaveRequestForToday
                                ? Colors.grey
                                : Colors.indigo))),
          ),
        );
      },
    );
  }
}
