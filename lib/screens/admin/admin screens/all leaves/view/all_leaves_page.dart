import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20leaves/providers/all_leaves_page_provider.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20leaves/view/widgets/leaves_header_list_tile.dart';
import 'package:attendance_management_system/screens/my%20leaves/view/widgets/my_leaves_card_header_row.dart';
import 'package:attendance_management_system/screens/my%20leaves/view/widgets/my_leaves_card_info_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllLeavesPage extends StatefulWidget {
  const AllLeavesPage({super.key});

  static const String pageName = 'allLeavesPage';

  @override
  State<AllLeavesPage> createState() => _AllLeavesPageState();
}

class _AllLeavesPageState extends State<AllLeavesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<AllLeavesPageProvider>(context, listen: false)
            .getAllStudentsLeaves();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<AllLeavesPageProvider>(
      builder: (context, allLeavesPageProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Leaves Requests'),
            centerTitle: true,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.015),
                child: IconButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete Leave Requests'),
                            content: const Text(
                                'Do you want to delete all leave requests?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () async {
                                    await allLeavesPageProvider
                                        .deleteAllLeaveRequests()
                                        .then(
                                          (value) =>
                                              Navigator.of(context).pop(),
                                        );
                                  },
                                  child: const Text('Yes')),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_rounded)),
              )
            ],
          ),
          backgroundColor: AppColors.white,
          body: Center(
            child: allLeavesPageProvider.fetchingLeaves
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : ListView.builder(
                    itemCount: allLeavesPageProvider.leaves.length,
                    itemBuilder: (BuildContext context, int index) {
                      final leave = allLeavesPageProvider.leaves[index];
                      String fromDate =
                          DateFormat.yMMMd().format(leave.fromDate);
                      String toDate = DateFormat.yMMMd().format(leave.toDate);
                      return Container(
                        height: height * 0.22,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.005),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onLongPress:
                                leave.reason!.isEmpty || leave.reason == null
                                    ? null
                                    : () async {
                                        _showReasonForLeaveDialog(
                                            leave.reason!, width);
                                      },
                            child: Padding(
                              padding: EdgeInsets.only(top: width * 0.05),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.02,
                                        bottom: height * 0.02),
                                    child: SizedBox(
                                      width: width,
                                      child: LeavesHeaderListTile(
                                        leave: leave,
                                      ),
                                    ),
                                  ),
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
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  // show bottom sheet for leave reason text
  Future<void> _showReasonForLeaveDialog(String reason, double width) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: width * 0.75, bottom: width * 0.04),
                child: Text(
                  'Reason',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(reason)
            ],
          ),
        );
      },
    );
  }
}
