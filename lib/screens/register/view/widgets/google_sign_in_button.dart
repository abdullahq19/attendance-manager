import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:attendance_management_system/screens/sign%20in/providers/sign_in_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton(
      {super.key, required this.text, required this.isSigningUp});

  final String text;
  final bool isSigningUp;

  @override
  Widget build(BuildContext context) {
    final signInPageProvider = Provider.of<SignInPageProvider>(context);
    final registerPageProvider = Provider.of<RegisterPageProvider>(context);
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          isSigningUp
              ? await registerPageProvider.signUpWithGoogle(context)
              : await signInPageProvider.signInWithGoogle(context);
        },
        child: Container(
            width: width * 0.9,
            height: height * 0.07,
            padding: EdgeInsets.all(width * 0.03),
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 2)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(googleLogoImage),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            )),
      ),
    );
  }
}
