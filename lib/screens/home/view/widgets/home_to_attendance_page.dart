import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:flutter/material.dart';

class HomeToAttendancePage extends StatelessWidget {
  const HomeToAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AttendancePage.pagename),
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        padding: EdgeInsets.all(width * 0.05),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Text(
              '🗓️',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              'Attendance',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: width * 0.4,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
