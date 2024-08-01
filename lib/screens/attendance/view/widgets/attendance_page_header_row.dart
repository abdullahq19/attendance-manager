import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

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
                'Attendance',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              )),
          Text(
            '${currentdateTime.day}/${currentdateTime.month}/${currentdateTime.year}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
