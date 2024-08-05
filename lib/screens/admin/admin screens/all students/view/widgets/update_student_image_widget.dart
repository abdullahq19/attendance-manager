import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateStudentImageWidget extends StatelessWidget {
  const UpdateStudentImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<AllStudentsPageProvider>(
      builder: (context, allStudentsProvider, child) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: width * 0.9,
            height: height * 0.3,
            padding: allStudentsProvider.isImagePicked
                ? EdgeInsets.only(top: height * 0.01)
                : null,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(width * 0.05)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (allStudentsProvider.isImagePicked &&
                    !allStudentsProvider.isImageUploaded)
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          allStudentsProvider.image!,
                          fit: BoxFit.contain,
                        )),
                  ),
                SizedBox(height: height * 0.01),
                const Text('Upload an image'),
                SizedBox(height: height * 0.002),
                IconButton(
                    iconSize: width * 0.1,
                    onPressed: () async {
                      await allStudentsProvider.pickImageToUpdateStudent();
                    },
                    icon: const Icon(Icons.add_photo_alternate_rounded))
              ],
            ),
          ),
        );
      },
    );
  }
}
