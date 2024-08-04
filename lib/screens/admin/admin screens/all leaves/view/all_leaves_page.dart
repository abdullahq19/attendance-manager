import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class AllLeavesPage extends StatelessWidget {
  const AllLeavesPage({super.key});

  static const String pageName = 'allLeavesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Leaves'),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Center(child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ListTile();
        },
      ),),
    );
  }
}
