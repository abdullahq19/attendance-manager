import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:flutter/material.dart';

class AppColors {
  // General Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static Color blue50 = Colors.blue.shade50;
  static Color appButtonBackgroundColor = Colors.green.shade100;
  static Color appButtonTextColor = Colors.green.shade900;
  static Color hintTextColor = Colors.grey.shade500;
  static Color textFieldFillColor = Colors.grey.shade200;

  //Admin Page Colors
  static Color adminPageTitleInstructionColor = Colors.grey.shade600;

  //Login Page Colors
  static Color facebookIconColor = Colors.blue.shade900;
}

class AppTexts {
  //Admin Page texts

  //Sign in Page Texts
  static const signInPageForgotPasswordText = 'Forgot Password?';
  static const signInPageSignInButtonText = 'Sign In';

  //Sign up Page Texts
  static const signUpPageSignUpButtonText = 'Sign up';
}

class AppTextontSizes {
  //Login Page texts font size
  static const double heading1 = 30;
}

// Path for Google logo image
const googleLogoImage = 'assets/images/google.png';
//Admin login credentials
const adminEmail = 'admin123@admin.com';
const adminPassword = 'Admin123';
const defaultImageUrl =
    'https://static.vecteezy.com/system/resources/thumbnails/005/129/844/small_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg';

//global function for getting month by month number
String getMonth() {
  return switch (currentdateTime.month) {
    1 => 'January',
    2 => 'February',
    3 => 'March',
    4 => 'April',
    5 => 'May',
    6 => 'June',
    7 => 'July',
    8 => 'August',
    9 => 'September',
    10 => 'October',
    11 => 'November',
    _ => 'December'
  };
}
