import 'dart:developer';

import 'package:attendance_management_system/screens/leaves/models/leave_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllLeavesPageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  bool fetchingLeaves = false;
  bool isApproving = false;
  bool isDeletingLeaveRequests = false;
  List<LeaveRequestModel> leaves = [];

  Future<void> getAllStudentsLeaves() async {
    try {
      fetchingLeaves = true;
      notifyListeners();
      final leavesCollection =
          await _firestore.collection('leave-requests').get();

      if (leavesCollection.docs.isNotEmpty) {
        final leavesList = leavesCollection.docs
            .map((e) => LeaveRequestModel.fromMap(e.data()))
            .toList();
        leaves = leavesList;
        notifyListeners();
      }else{
        leaves = [];
        notifyListeners();
      }
      fetchingLeaves = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> respondToLeave(LeaveRequestModel leave, String operation) async {
    try {
      isApproving = true;
      notifyListeners();
      final leavesCollection = await _firestore
          .collection('leave-requests')
          .where('email', isEqualTo: leave.email)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();
      var leavesdata = leavesCollection.docs.map((e) => e.data()).toList();
      log('This is leaves docs to list ${leavesdata.toString()}');
      if (leavesCollection.docs.isNotEmpty) {
        await leavesCollection.docs.first.reference
            .update({"status": operation});
      } else {
        log('Leave Request doc does not exists or is not pending');
      }
      await getAllStudentsLeaves();
      isApproving = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  //deletes all the leaves requests in leave-request collection
  Future<void> deleteAllLeaveRequests() async {
    try {
      isDeletingLeaveRequests = true;
      final leavesCollection =
          await _firestore.collection('leave-requests').get();

      if (leavesCollection.docs.isNotEmpty) {
        for (var leaveDoc in leavesCollection.docs) {
          await leaveDoc.reference.delete();
        }
      } else {
        log('No leave requests found');
      }
      isDeletingLeaveRequests = false;
      await getAllStudentsLeaves();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
