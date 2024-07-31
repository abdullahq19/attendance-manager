import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/register/view/widgets/divider_row.dart';
import 'package:attendance_management_system/screens/register/view/widgets/email_field.dart';
import 'package:attendance_management_system/screens/register/view/widgets/google_sign_in_button.dart';
import 'package:attendance_management_system/screens/register/view/widgets/password_field.dart';
import 'package:attendance_management_system/screens/sign%20in/view/widgets/forgot_password_button.dart';
import 'package:attendance_management_system/screens/sign%20in/view/widgets/sign_in_button.dart';
import 'package:attendance_management_system/screens/sign%20in/view/widgets/sign_in_page_heading1.dart';
import 'package:attendance_management_system/screens/sign%20in/view/widgets/sign_in_page_heading2.dart';
import 'package:attendance_management_system/screens/sign%20in/view/widgets/sign_up_page_navigate.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const pageName = 'signInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController
      ..clear()
      ..dispose();
    passwordController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildSignInFormUI(),
          ),
        ),
      )),
    );
  }

  List<Widget> _buildSignInFormUI() {
    final Size(:height) = MediaQuery.sizeOf(context);
    return [
      SizedBox(height: height * 0.1),
      const SignInPageHeading1(),
      const SignInPageHeading2(),
      SizedBox(height: height * 0.04),
      EmailField(
        emailController: emailController,
      ),
      PasswordField(
          passwordController: passwordController, isSignUpPasswordField: false),
      const ForgotPasswordTextButton(),
      SizedBox(
        height: height * 0.05,
      ),
      SignInButton(
        emailController: emailController,
        passwordController: passwordController,
        formKey: _formKey,
      ),
      SizedBox(height: height * 0.05),
      const DividerRow(),
      SizedBox(height: height * 0.05),
      const GoogleSignInButton(
        text: 'Sign in with Google',
        isSigningUp: false,
      ),
      SizedBox(height: height * 0.05),
      const RegisterPageNavigateWidget(),
    ];
  }
}
