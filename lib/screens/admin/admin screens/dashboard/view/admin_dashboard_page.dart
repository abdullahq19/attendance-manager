import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/dashboard/view/widgets/admin_dashboard_drawer.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/dashboard/view/widgets/dashboard_to_all_attendance_page.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/dashboard/view/widgets/dashboard_to_all_leaves_page.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/dashboard/view/widgets/dashboard_to_all_students_page.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:attendance_management_system/screens/register/providers/register_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  static const String pageName = 'adminDashboard';

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<RegisterPageProvider>(context, listen: false)
            .getCurrentUsername();
        Provider.of<HomePageProvider>(context, listen: false).getCurrentUserProfilePicUrl();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Admin Dashboard'),
          centerTitle: true,
          backgroundColor: AppColors.white),
      drawer: const AdminDashboardDrawer(),
      backgroundColor: AppColors.white,
      body: const Center(
        child: Column(
          children: [
            DashboardToAllAttendancePageButton(),
            DashboardToAllLeavesPageButton(),
            DashboardToAllStudentsPageButton(),
          ],
        ),
      ),
    );
  }
}
