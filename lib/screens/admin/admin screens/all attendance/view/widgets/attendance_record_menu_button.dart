import 'package:attendance_management_system/screens/admin/admin%20screens/all%20attendance/providers/all_attendance_page_provider.dart';
import 'package:attendance_management_system/screens/students/models/marked_students.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceRecordMenuButton extends StatelessWidget {
  const AttendanceRecordMenuButton(
      {super.key, required this.student, required this.date});

  final MarkedStudents student;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.grey.shade50,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'Update',
            onTap: () async {
              await _showUpdateAttendanceDialog(context);
            },
            child: const Text('Update'),
          ),
          PopupMenuItem(
            value: 'Delete',
            child: const Text('Delete'),
            onTap: () async {
              await _showDeleteAttendanceRecordDialog(context);
            },
          ),
        ];
      },
    );
  }

  // update status dialog
  Future<void> _showUpdateAttendanceDialog(BuildContext context) async {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    await showDialog(
        context: context,
        builder: (context) {
          return Consumer<AllAttendancePageProvider>(
            builder: (context, allAttendancePageProvider, child) {
              return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        //update value to firestore
                        await allAttendancePageProvider
                            .updateAttendanceStatusOfStudent(
                                context, student, date);
                      },
                      child: const Text('OK')),
                ],
                title: const Text('Update Record'),
                content: allAttendancePageProvider.isUpdatingAttendanceStatus
                    ? SizedBox(
                        height: height * 0.16,
                        width: width * 0.05,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.sizeOf(context).height * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10)),
                            child: RadioListTile(
                              fillColor:
                                  const WidgetStatePropertyAll(Colors.green),
                              title: Text(
                                'Present',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                              ),
                              value: 'present',
                              groupValue:
                                  allAttendancePageProvider.selectedValue,
                              onChanged: (value) {
                                allAttendancePageProvider
                                    .updateRadioButtonValue(value!);
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(10)),
                            child: RadioListTile(
                              fillColor:
                                  const WidgetStatePropertyAll(Colors.red),
                              title: Text(
                                'Absent',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                              ),
                              value: 'absent',
                              groupValue:
                                  allAttendancePageProvider.selectedValue,
                              onChanged: (value) {
                                allAttendancePageProvider
                                    .updateRadioButtonValue(value!);
                              },
                            ),
                          ),
                        ],
                      ),
              );
            },
          );
        }).then(
      (_) => context
          .read<AllAttendancePageProvider>()
          .setRadioButtonValueToDefault(),
    );
  }

  Future<void> _showDeleteAttendanceRecordDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<AllAttendancePageProvider>(
          builder: (context, allAttendancePageProvider, child) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No')),
                TextButton(
                    onPressed: () async {
                      //delelte record from to firestore
                      await allAttendancePageProvider
                          .deleteAttendanceRecordOfStudent(
                              context, student, date);
                    },
                    child: const Text('Yes')),
              ],
              title: const Text('Delete Attendance'),
              content: allAttendancePageProvider.isDeletingAttendanceRecord
                  ? const SizedBox(width: 100, height: 100,child: Center(child: CircularProgressIndicator(color: Colors.red)))
                  : const Text('Do you want to delete this attendance record?'),
            );
          },
        );
      },
    );
  }
}
