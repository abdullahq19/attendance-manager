import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/students/providers/student_page_provider.dart';
import 'package:attendance_management_system/validation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  static const pageName = 'StudentsPage';

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final studentProvider =
            Provider.of<StudentPageProvider>(context, listen: false);
        studentProvider.getStudentsMarkedTodayWithInfo();
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
        title: const Text('Students'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: Center(child: Consumer<StudentPageProvider>(
        builder: (context, studentPageProvider, child) {
          if (studentPageProvider.fetchingUserInfo) {
            return const CircularProgressIndicator(color: Colors.green);
          } else {
            final students = studentPageProvider.students;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final DateFormat formatter = DateFormat('h:mm a');
                final DateTime markedAt = students[index].markedAt!;
                final time = formatter.format(markedAt);
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.005),
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      students[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Marked at: $time',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    contentPadding: EdgeInsets.all(width * 0.02),
                    trailing: Container(
                      width: width * 0.25,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                          color: students[index].attendanceStatus == 'present'
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              students[index]
                                  .attendanceStatus
                                  .capitalizeInitial(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: students[index].attendanceStatus ==
                                              'present'
                                          ? Colors.green
                                          : AppColors.red))),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(students[index].profilePicUrl),
                      backgroundColor: AppColors.textFieldFillColor,
                      radius: width * 0.08,
                    ),
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
