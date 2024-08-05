import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20leaves/providers/all_leaves_page_provider.dart';
import 'package:attendance_management_system/screens/leaves/models/leave_request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeavesHeaderListTile extends StatelessWidget {
  const LeavesHeaderListTile({super.key, required this.leave});

  final LeaveRequestModel leave;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<AllLeavesPageProvider>(
        builder: (context, allLeavesPageProvider, child) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(leave.profilePicUrl),
          backgroundColor: AppColors.textFieldFillColor,
          radius: width * 0.05,
        ),
        title: Text(
          leave.name,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
        trailing: leave.status == 'approved' || leave.status == 'rejected'
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width * 0.13,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12)),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Colors.red.shade100,
                            onTap: () async {
                              // reject leave function
                              await context
                                  .read<AllLeavesPageProvider>()
                                  .respondToLeave(leave, 'rejected');
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.red,
                            ))),
                  ),
                  SizedBox(width: width * 0.025),
                  Container(
                    width: width * 0.13,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12)),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Colors.green.shade100,
                            onTap: () async {
                              // approve leave function
                              await context
                                  .read<AllLeavesPageProvider>()
                                  .respondToLeave(leave, 'approved');
                            },
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.green,
                            ))),
                  ),
                ],
              ),
      );
    });
  }
}
