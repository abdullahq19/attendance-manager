import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/view/widgets/edit_students_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllStudentsPage extends StatefulWidget {
  const AllStudentsPage({super.key});

  static const String pageName = 'allStudentsPage';

  @override
  State<AllStudentsPage> createState() => _AllStudentsPageState();
}

class _AllStudentsPageState extends State<AllStudentsPage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final provider =
            Provider.of<AllStudentsPageProvider>(context, listen: false);
        provider.getAllCurrentStudents();
      },
    );

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Consumer<AllStudentsPageProvider>(
          builder: (context, allStudentsPageProvider, child) {
            if (allStudentsPageProvider.isFetchingStudents) {
              return const CircularProgressIndicator(
                color: Colors.green,
              );
            } else if (allStudentsPageProvider.students.isEmpty) {
              return const Center(
                child: Text('No students data available'),
              );
            } else {
              return ListView.builder(
                itemCount: allStudentsPageProvider.students.length,
                itemBuilder: (BuildContext context, int index) {
                  final student = allStudentsPageProvider.students[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.005),
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        splashColor: Colors.grey.shade50,
                        onLongPress: () async {
                          await Future.wait([
                            _showAttendanceDaysBottomSheet(),
                            allStudentsPageProvider
                                .getStudentAttendanceDaysRecords(student.email)
                          ]);
                        },
                        child: ListTile(
                          title: Text(
                            student.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.02),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                student.profilePicUrl ?? defaultImageUrl),
                            backgroundColor: AppColors.textFieldFillColor,
                            radius: width * 0.08,
                          ),
                          trailing: EditStudentBottomSheetButton(
                            student: student,
                            emailController: emailController,
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showAttendanceDaysBottomSheet() async {
    final Size(:height, :width) = MediaQuery.sizeOf(context);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return SizedBox(
          width: width,
          child: Consumer<AllStudentsPageProvider>(
            builder: (context, allAttendancePageProvider, child) {
              return allAttendancePageProvider.isFetchingNumberOfDays
                  ? const Center(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child:
                              CircularProgressIndicator(color: Colors.green)),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attendance Status',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Days present',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04),
                                  child: Text(
                                    '=',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      allAttendancePageProvider.presentDays
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Days absent',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: Text(
                                  '=',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    allAttendancePageProvider.absentDays
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Leaves',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04),
                                  child: Text(
                                    '=',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      allAttendancePageProvider
                                          .studentLeaves.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
