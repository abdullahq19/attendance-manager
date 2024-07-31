import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:attendance_management_system/screens/register/view/widgets/confirm_password_field.dart';
import 'package:attendance_management_system/screens/register/view/widgets/email_field.dart';
import 'package:attendance_management_system/screens/register/view/widgets/google_sign_in_button.dart';
import 'package:attendance_management_system/screens/register/view/widgets/password_field.dart';
import 'package:attendance_management_system/screens/register/view/widgets/sign_in_page_navigate.dart';
import 'package:attendance_management_system/screens/register/view/widgets/sign_up_button.dart';
import 'package:attendance_management_system/screens/register/view/widgets/sign_up_page_heading1.dart';
import 'package:attendance_management_system/screens/register/view/widgets/sign_up_page_heading2.dart';
import 'package:attendance_management_system/screens/register/view/widgets/user_name_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const pageName = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final ScrollController _pageScrollController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _pageScrollController = ScrollController();
  }

  @override
  void dispose() {
    firstNameController
      ..clear()
      ..dispose();
    lastNameController
      ..clear()
      ..dispose();
    emailController
      ..clear()
      ..dispose();
    passwordController
      ..clear()
      ..dispose();
    confirmPasswordController
      ..clear()
      ..dispose();
    _pageScrollController.dispose();
    _formKey.currentState!.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerPageProvider = Provider.of<RegisterPageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _pageScrollController,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildSignUpFormUI(registerPageProvider),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSignUpFormUI(RegisterPageProvider registerPageProvider) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return [
      SizedBox(height: height * 0.1),
      const SignUpPageHeading1(),
      const SignUpPageHeading2(),
      SizedBox(height: height * 0.02),
      UserNamefields(
          firstNameController: firstNameController,
          lastNameController: lastNameController),
      EmailField(
        emailController: emailController,
      ),
      PasswordField(
        passwordController: passwordController,
        isSignUpPasswordField: true,
      ),
      ConfirmPasswordField(
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController),
      SizedBox(
        height: height * 0.02,
      ),
      SignUpButton(
        formKey: _formKey,
        firstNameController: firstNameController,
        lastNameController: lastNameController,
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        width: width * 0.9,
        height: height * 0.07,
      ),
      SizedBox(height: height * 0.03),
      const GoogleSignInButton(
        text: 'Sign up with Google',
        isSigningUp: true,
      ),
      SizedBox(height: height * 0.05),
      const SignInPageNavigateWidget(),
      SizedBox(height: height * 0.04)
    ];
  }
}
