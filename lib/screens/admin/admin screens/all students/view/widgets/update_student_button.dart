import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:attendance_management_system/screens/app_common_button.dart';
import 'package:attendance_management_system/screens/register/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateStudentButton extends StatelessWidget {
  const UpdateStudentButton(
      {super.key,
      required this.uid,
      required this.name,
      required this.email,
      required this.profilePicUrl,
      required this.currentEmail});

  final String uid;
  final String name;
  final String email;
  final String currentEmail;
  final String profilePicUrl;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<AllStudentsPageProvider>(
      builder: (context, allStudentsPageProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.04),
          child: AppCommonButton(
              color: Colors.blue.shade50,
              width: width * 0.9,
              height: height * 0.075,
              onPressed: () async {
                AppUser student = AppUser(
                    uid: uid,
                    name: name,
                    email: email,
                    profilePicUrl: profilePicUrl,
                    role: 'user');
                await allStudentsPageProvider
                    .updateStudentInfo(student, currentEmail)
                    .then((value) async {
                  Navigator.of(context).pop();
                  await allStudentsPageProvider.getAllCurrentStudents();
                });
              },
              child: allStudentsPageProvider.isUploadingImage ||
                      allStudentsPageProvider.isUpdating
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : Text('Update student info',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.blue))),
        );
      },
    );
  }
}
