import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_absent_button.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/mark_present_button.dart';
import 'package:attendance_management_system/screens/attendance/view/widgets/username_text.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Provider.of<RegisterPageProvider>(context, listen: false)
        .getCurrentUsername();
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
              const UsernameText(),
              const MarkPresentButton(),
              const MarkAbsentButton(),
            ],
          ),
        ),
      )),
    );
  }
}
