import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20attendance/providers/all_attendance_page_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20attendance/view/widgets/attendance_record_menu_button.dart';
import 'package:attendance_management_system/screens/students/models/marked_students.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllAttendancePage extends StatefulWidget {
  const AllAttendancePage({super.key});

  static const String pageName = 'allAttendancePage';

  @override
  State<AllAttendancePage> createState() => _AllAttendancePageState();
}

class _AllAttendancePageState extends State<AllAttendancePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<AllAttendancePageProvider>(context, listen: false)
            .getAttendanceRecords();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text('Attendance Record'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: Center(child: Consumer<AllAttendancePageProvider>(
        builder: (context, allAttendancePageProvider, child) {
          if (allAttendancePageProvider.fetchingAttendance) {
            return const CircularProgressIndicator(color: Colors.green);
          } else if (allAttendancePageProvider.attendanceByDate!.isEmpty) {
            return const Center(child: Text('No records to show'));
          } else {
            return ListView.builder(
              itemCount: allAttendancePageProvider.attendanceByDate!.length,
              itemBuilder: (context, index) {
                String date = allAttendancePageProvider.attendanceByDate!.keys
                    .elementAt(index);
                List<MarkedStudents> students =
                    allAttendancePageProvider.attendanceByDate![date]!;
                DateTime studentMarkedAt = students.length == 1
                    ? students[0].markedAt!
                    : students[index].markedAt!;
                if (students.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.005),
                    child: ExpansionTile(
                        iconColor: Colors.green,
                        collapsedTextColor: Colors.black,
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey.shade100,
                        tilePadding: EdgeInsets.symmetric(
                            horizontal: width * 0.07, vertical: height * 0.01),
                        collapsedBackgroundColor: Colors.grey.shade100,
                        expansionAnimationStyle: AnimationStyle(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 500),
                            reverseCurve: Curves.easeInOut,
                            reverseDuration: const Duration(milliseconds: 500)),
                        title:
                            Text(DateFormat.yMMMMd().format(studentMarkedAt)),
                        children: students
                            .map((student) => Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.005),
                                  height: height * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ListTile(
                                    title: Text(
                                      student.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Marked at: ${DateFormat('hh:mm a').format(student.markedAt!)}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: width * 0.02),
                                    trailing: SizedBox(
                                      width: width * 0.35,
                                      height: height * 0.08,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width * 0.22,
                                            height: height * 0.05,
                                            decoration: BoxDecoration(
                                                color:
                                                    student.attendanceStatus ==
                                                            'present'
                                                        ? Colors.green.shade50
                                                        : Colors.red.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    student.attendanceStatus
                                                        .capitalizeInitial(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color: student
                                                                        .attendanceStatus ==
                                                                    'present'
                                                                ? Colors.green
                                                                : AppColors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                          ),
                                          AttendanceRecordMenuButton(
                                            student: student,
                                            date: student.markedAt!,
                                          ),
                                        ],
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(student.profilePicUrl),
                                      backgroundColor:
                                          AppColors.textFieldFillColor,
                                      radius: width * 0.05,
                                    ),
                                  ),
                                ))
                            .toList()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
        },
      )),
    );
  }
}
