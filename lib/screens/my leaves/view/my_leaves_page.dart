import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/my%20leaves/providers/my_leaves_provider.dart';
import 'package:attendance_management_system/screens/my%20leaves/view/widgets/my_leaves_card_header_row.dart';
import 'package:attendance_management_system/screens/my%20leaves/view/widgets/my_leaves_card_info_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyLeavesPage extends StatefulWidget {
  const MyLeavesPage({super.key});

  static const String pageName = 'myLeavesPage';

  @override
  State<MyLeavesPage> createState() => _MyLeavesPageState();
}

class _MyLeavesPageState extends State<MyLeavesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<MyLeavesProvider>(context, listen: false)
            .getMyTotalLeaves();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text('My Leaves'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Consumer<MyLeavesProvider>(
          builder: (context, myLeavesProvider, child) {
            return ListView.builder(
              itemCount: myLeavesProvider.myLeaves.length,
              itemBuilder: (BuildContext context, int index) {
                if (myLeavesProvider.isFetchingLeaves) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.blue));
                } else {
                  final leave = myLeavesProvider.myLeaves[index];
                  String fromDate = DateFormat.yMMMd().format(leave.fromDate);
                  String toDate = DateFormat.yMMMd().format(leave.toDate);
                  return Container(
                    height: height * 0.13,
                    padding: EdgeInsets.only(top: width * 0.05),
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.005),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const MyLeavesCardHeaderRow(),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        MyLeavesCardInfoRow(
                          fromDate: fromDate,
                          toDate: toDate,
                          status: leave.status,
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
