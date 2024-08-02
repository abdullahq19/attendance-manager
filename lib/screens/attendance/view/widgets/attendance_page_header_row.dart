import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendancePageHeaderRow extends StatelessWidget {
  const AttendancePageHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mark Attendance',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              )),
          Text(
            DateFormat.yMMMd().format(currentdateTime),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
