import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_absent_button.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_present_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final currentdateTime = DateTime.now();

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  static const String pagename = 'attendancePage';

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: SizedBox(
        width: width * 0.9,
        height: height * 0.35,
        child: Card(
          elevation: 5,
          color: Colors.grey.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, bottom: height * 0.02),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name: ${FirebaseAuth.instance.currentUser!.displayName}',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
              ),
              const MarkPresentButton(),
              const MarkAbsentButton(),
            ],
          ),
        ),
      )),
    );
  }
}
