import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';

class MyLeavesCardInfoRow extends StatelessWidget {
  const MyLeavesCardInfoRow(
      {super.key,
      required this.fromDate,
      required this.toDate,
      required this.status});

  final String fromDate;
  final String toDate;
  final String status;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          fromDate,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          toDate,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Container(
          width: width * 0.28,
          height: height * 0.05,
          decoration: BoxDecoration(
            color: status == 'pending'
                ? Colors.orange.shade50
                : status == 'approved'
                    ? Colors.green.shade50
                    : Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              status.capitalizeInitial(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: status == 'pending'
                      ? Colors.orange
                      : status == 'approved'
                          ? Colors.green
                          : Colors.red),
            ),
          ),
        )
      ],
    );
  }
}
