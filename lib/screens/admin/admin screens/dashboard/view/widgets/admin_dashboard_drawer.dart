import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/home/view/widgets/drawer_username_text.dart';
import 'package:attendance_management_system/screens/home/view/widgets/profile_pic_widget.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardDrawer extends StatelessWidget {
  const AdminDashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Drawer(
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
                      padding:
                          WidgetStatePropertyAll(EdgeInsets.all(width * 0.03)),
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.textFieldFillColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () async {
                    final homePageProvider = context.read<HomePageProvider>();
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
    );
  }
}
