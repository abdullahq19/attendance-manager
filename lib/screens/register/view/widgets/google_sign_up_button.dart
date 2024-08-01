import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<RegisterPageProvider>(
      builder: (context, registerPageProvider, child) {
        return Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () async {
              await registerPageProvider.signUpWithGoogle(context);
            },
            child: Container(
                width: width * 0.9,
                height: height * 0.07,
                padding: EdgeInsets.all(width * 0.03),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(color: AppColors.grey, blurRadius: 2)
                    ]),
                child: registerPageProvider.isSigningUpWithGoogle
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.blue))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(googleLogoImage),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            'Sign up with Google',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      )),
          ),
        );
      },
    );
  }
}
