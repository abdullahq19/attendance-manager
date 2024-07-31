import 'dart:developer';

import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/home/view/widgets/profile_pic_widget.dart';
import 'package:attendance_management_system/screens/leaves/view/leaves_page.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:attendance_management_system/screens/students/view/students_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String pageName = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomePageProvider>(context, listen: false)
          .getCurrentUserProfilePicUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Home Page Build Called');
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfilePicWidget(),
            SizedBox(height: height * 0.05),
            SizedBox(
              width: width * 0.7,
              child: TextButton(
                  style: ButtonStyle(
                      padding:
                          WidgetStatePropertyAll(EdgeInsets.all(width * 0.03)),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.textFieldFillColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    //Navigate to leaves page
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'L E A V E S',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.7,
              child: TextButton(
                  style: ButtonStyle(
                      padding:
                          WidgetStatePropertyAll(EdgeInsets.all(width * 0.03)),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.textFieldFillColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    //Navigate to leaves page
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'S T U D E N T S',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.4,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: const Align(
                  alignment: Alignment.bottomCenter, child: Divider()),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: width * 0.7,
                child: TextButton(
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.all(width * 0.03)),
                        backgroundColor: WidgetStatePropertyAll(
                            AppColors.textFieldFillColor),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      final homePageProvider =
                          Provider.of<HomePageProvider>(context, listen: false);
                      await homePageProvider.signOut().then((value) =>
                          Navigator.of(context)
                              .pushReplacementNamed(SignInPage.pageName));
                    },
                    child: Text('S I G N O U T',
                        style: Theme.of(context).textTheme.labelLarge)),
              ),
            )
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(AttendancePage.pagename),
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
                    '🗓️',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Text(
                    'Attendance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: width * 0.4,
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(LeavesPage.pagename),
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
                    '📝',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Text(
                    'Leaves',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: width * 0.48,
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          GestureDetector(
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
          ),
        ],
      )),
    );
  }
}
