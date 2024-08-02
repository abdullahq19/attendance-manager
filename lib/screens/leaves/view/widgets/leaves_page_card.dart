import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/leaves/view/widgets/leave_range_picker_button.dart';
import 'package:attendance_management_system/screens/leaves/view/widgets/request_leave_button.dart';
import 'package:attendance_management_system/screens/leaves/view/widgets/reason_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeavesPageCard extends StatefulWidget {
  const LeavesPageCard({super.key});

  @override
  State<LeavesPageCard> createState() => _LeavesPageCardState();
}

class _LeavesPageCardState extends State<LeavesPageCard> {
  late final TextEditingController reasonController;

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width * 0.9,
      height: height * 0.48,
      child: Card(
        elevation: 5,
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Request a leave',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    DateFormat.yMMMd().format(currentdateTime),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            ReasonTextField(reasonController: reasonController),
            const LeaveRangePickerButton(),
            RequestLeaveButton(
              reasonController: reasonController,
            ),
          ],
        ),
      ),
    );
  }
}
