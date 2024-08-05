import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/view/widgets/dialog_username_fields.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/view/widgets/update_student_button.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/view/widgets/update_student_image_widget.dart';
import 'package:attendance_management_system/screens/register/models/app_user.dart';
import 'package:attendance_management_system/screens/register/view/widgets/email_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditStudentBottomSheetButton extends StatefulWidget {
  const EditStudentBottomSheetButton(
      {super.key,
      required this.student,
      required this.emailController,
      required this.firstNameController,
      required this.lastNameController});

  final AppUser student;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;

  @override
  State<EditStudentBottomSheetButton> createState() =>
      _EditStudentPopUpButtonState();
}

class _EditStudentPopUpButtonState extends State<EditStudentBottomSheetButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bottomSheetAnimationController;
  @override
  void initState() {
    super.initState();
    _bottomSheetAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _bottomSheetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.grey.shade50,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'Edit',
            onTap: () async {
              await _showEditStudentBottomSheet(context, widget.student);
            },
            child: const Text('Edit'),
          ),
          PopupMenuItem(
            value: 'Delete',
            child: const Text('Delete'),
            onTap: () async {
              await _showDeleteStudentDialog(context);
            },
          ),
        ];
      },
    );
  }

  // // update status dialog
  Future<void> _showEditStudentBottomSheet(
      BuildContext context, AppUser student) async {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      builder: (context) {
        return Consumer<AllStudentsPageProvider>(
          builder: (context, allStudentsPageProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetUsernameFields(
                    firstNameController: widget.firstNameController,
                    lastNameController: widget.lastNameController,
                    width: width),
                EmailField(emailController: widget.emailController),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: const UpdateStudentImageWidget(),
                ),
                UpdateStudentButton(
                  email: widget.emailController.text.isEmpty
                      ? student.email
                      : widget.emailController.text.trim(),
                  name: widget.firstNameController.text.isEmpty ||
                          widget.lastNameController.text.isEmpty
                      ? student.name
                      : '${widget.firstNameController.text} ${widget.lastNameController.text}',
                  currentEmail: student.email,
                  profilePicUrl: allStudentsPageProvider.imageUrl ??
                      student.profilePicUrl ?? defaultImageUrl,
                  uid: student.uid,
                ),
              ],
            );
          },
        );
      },
    ).then(
      (value) {
        widget.firstNameController.clear();
        widget.lastNameController.clear();
        widget.emailController.clear();
      },
    );
  }

  Future<void> _showDeleteStudentDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<AllStudentsPageProvider>(
          builder: (context, allStudentsPageProvider, child) {
            return AlertDialog(
              actions: !allStudentsPageProvider.isDeletingStudent
                  ? [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            //delelte record from to firestore
                            await allStudentsPageProvider
                                .deleteStudent(widget.student)
                                .then(
                                  (value) => Navigator.of(context).pop(),
                                );
                          },
                          child: const Text('Yes')),
                    ]
                  : null,
              title: const Text('⚠️ Delete User'),
              content: allStudentsPageProvider.isDeletingStudent
                  ? const SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                          child: CircularProgressIndicator(color: Colors.red)))
                  : const Text('Are you sure you want to delete this student?'),
            );
          },
        );
      },
    );
  }
}
