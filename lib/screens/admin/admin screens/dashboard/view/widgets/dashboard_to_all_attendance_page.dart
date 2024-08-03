import 'package:attendance_management_system/screens/admin/admin%20screens/all%20attendance/view/all_attendance_page.dart';
import 'package:flutter/material.dart';

class DashboardToAllAttendancePageButton extends StatelessWidget {
  const DashboardToAllAttendancePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AllAttendancePage.pageName),
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        padding: EdgeInsets.all(width * 0.05),
        margin: EdgeInsets.symmetric(vertical: height * 0.005),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🗓️  All Attendance',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
