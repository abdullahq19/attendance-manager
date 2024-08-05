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
        Provider.of<AllStudentsPageProvider>(context, listen: false)
            .getAllCurrentStudents();
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
                  final student = allStudentsPageProvider
                      .students[index]; // List of User Model
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.005),
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: Text(
                        student.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.015, horizontal: width * 0.02),
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
