import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/firebase_options.dart';
import 'package:attendance_management_system/routes/routes.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20attendance/providers/all_attendance_page_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20leaves/providers/all_leaves_page_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/dashboard/view/admin_dashboard_page.dart';
import 'package:attendance_management_system/screens/attendance/providers/attendance_page_provider.dart';
import 'package:attendance_management_system/screens/forgot%20password/providers/forgot_pass_page_provider.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/home/view/home_page.dart';
import 'package:attendance_management_system/screens/leaves/providers/leave_page_provider.dart';
import 'package:attendance_management_system/screens/my%20leaves/providers/my_leaves_provider.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:attendance_management_system/screens/sign%20in/providers/sign_in_page_provider.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:attendance_management_system/screens/students/providers/student_page_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String initialRoute = SignInPage.pageName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user == null) {
      log('User is not signed in');
      initialRoute = SignInPage.pageName;
    } else {
      log('User signed in => uid: ${user.uid}');
      initialRoute = user.email == adminEmail
          ? AdminDashboardPage.pageName
          : HomePage.pageName;
    }
  });
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SignInPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RegisterPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ForgotPassPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AttendancePageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => StudentPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LeavePageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MyLeavesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AllAttendancePageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AllStudentsPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AllLeavesPageProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: initialRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInPage(),
    );
  }
}
