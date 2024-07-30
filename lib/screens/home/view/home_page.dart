import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/leaves/view/leaves_page.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:attendance_management_system/screens/students/view/students_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String pageName = 'homePage';

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    final homePageProvider = Provider.of<HomePageProvider>(context);
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
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: width * 0.2,
                  backgroundColor: AppColors.white,
                  backgroundImage: const NetworkImage(
                      'https://static.vecteezy.com/system/resources/thumbnails/005/129/844/small_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg'),
                ),
                IconButton.filled(
                    color: AppColors.white,
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.grey)),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      //todo image upload to storage
                                    },
                                    child: const Text('OK')),
                              ],
                              title: const Text('Upload a profile picture'),
                              content: Container(
                                width: width * 0.9,
                                height: height * 0.3,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.circular(width * 0.05)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Upload an image'),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.add_photo_alternate_rounded))
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                    icon: const Icon(Icons.camera_alt_rounded)),
              ],
            ),
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
