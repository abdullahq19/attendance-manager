import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/home/view/widgets/drawer_username_text.dart';
import 'package:attendance_management_system/screens/home/view/widgets/home_to_attendance_page.dart';
import 'package:attendance_management_system/screens/home/view/widgets/home_to_leaves_page.dart';
import 'package:attendance_management_system/screens/home/view/widgets/home_to_students_page.dart';
import 'package:attendance_management_system/screens/home/view/widgets/profile_pic_widget.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:attendance_management_system/screens/my%20leaves/view/my_leaves_page.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
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
    // Disables the MarkAttendanceButton funcionality if attendance already marked for current day
    Provider.of<AttendancePageProvider>(context, listen: false)
        .checkAttendanceStatus();

    // Gets current user's name from firestore if email is not verified
    Provider.of<RegisterPageProvider>(context, listen: false)
        .getCurrentUsername();

    // Checks if a leave request for current user exists
    Provider.of<LeavePageProvider>(context, listen: false)
        .checkLeaveRequestForToday();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Fetches the current user profile pic from firestore if exists
      Provider.of<HomePageProvider>(context, listen: false)
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
            SizedBox(
              height: height * 0.03,
            ),
            const DrawerUsernameText(),
            SizedBox(height: height * 0.03),
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
                  onPressed: () =>
                      Navigator.of(context).pushNamed(MyLeavesPage.pageName),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'M Y  L E A V E S',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.01,
            ),
  
            SizedBox(
              height: height * 0.4,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: const Align(
                  alignment: Alignment.bottomCenter, child: Divider()),
            ),
            SizedBox(height: height * 0.03),
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
          const HomeToAttendancePage(),
          SizedBox(
            height: height * 0.01,
          ),
          const HomeToLeavesPage(),
          SizedBox(
            height: height * 0.01,
          ),
          const HomeToStudentsPage(),
        ],
      )),
    );
  }
}
