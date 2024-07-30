import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:attendance_management_system/screens/error/view/error_page.dart';
import 'package:attendance_management_system/screens/forgot%20password/view/forgot_password_page.dart';
import 'package:attendance_management_system/screens/home/view/home_page.dart';
import 'package:attendance_management_system/screens/leaves/view/leaves_page.dart';
import 'package:attendance_management_system/screens/register/view/register_page.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:attendance_management_system/screens/students/view/students_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      SignInPage.pageName =>
        MaterialPageRoute(builder: (context) => const SignInPage()),
      HomePage.pageName =>
        MaterialPageRoute(builder: (context) => const HomePage()),
      RegisterPage.pageName =>
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      ForgotPasswordPage.pageName =>
        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
      AttendancePage.pagename =>
        MaterialPageRoute(builder: (context) => const AttendancePage()),
      LeavesPage.pagename =>
        MaterialPageRoute(builder: (context) => const LeavesPage()),
      StudentsPage.pageName =>
        MaterialPageRoute(builder: (context) => const StudentsPage()),
      _ => MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        )
    };
  }
}
