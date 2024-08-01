import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/students/view/students_page.dart';
import 'package:flutter/material.dart';

class HomeToStudentsPage extends StatelessWidget {
  const HomeToStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(StudentsPage.pageName),
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        padding: EdgeInsets.all(width * 0.05),
        decoration: BoxDecoration(
            color: AppColors.textFieldFillColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Text(
              '👨‍🎓',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              'Students',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: width * 0.45,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
