import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/leaves/view/widgets/leaves_page_card.dart';
import 'package:flutter/material.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

  static const String pagename = 'leavesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text('Leave'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: const Center(
          child:
              Align(alignment: Alignment.topCenter, child: LeavesPageCard())),
    );
  }
}
