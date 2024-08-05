import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/leaves/models/leave_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeavePageProvider extends ChangeNotifier {
  DateTimeRange? dateTimeRange;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? dateRangeButtonText;
  bool sendingLeaveRequest = false;
  bool sentLeaveRequestForToday = false;
  LeaveRequestModel? currentLeaveRequest;

  // Picks a range of days to take leave FROM and TO date
  Future<void> pickDateRange(BuildContext context) async {
    try {
      final newRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)),
      );
      if (newRange != null) {
        dateTimeRange = newRange;
        dateRangeButtonText =
            '${DateFormat.yMMMd().format(dateTimeRange!.start)} - ${DateFormat.yMMMd().format(dateTimeRange!.end)}';
        notifyListeners();
        log('${dateTimeRange!.duration.inDays}');
      }
    } catch (e) {
      log('Error picking date range ${e.toString()}');
    }
  }

  // adds a leave request to leaves collection
  Future<void> requestLeave(String reason) async {
    try {
      //If user is null then stop the function
      if (_auth.currentUser == null) {
        return;
      }
      sendingLeaveRequest = true;
      notifyListeners();
      //getting the current user info from users collection
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .limit(1)
          .get();
      Map<String, dynamic> currentUser = querySnapshot.docs.first.data();
      String name = currentUser['name'];
      String profilePicUrl = currentUser['profilePicUrl'] ?? defaultImageUrl;

      LeaveRequestModel leaveRequest = LeaveRequestModel(
          email: _auth.currentUser!.email!,
          name: name,
          profilePicUrl: profilePicUrl,
          fromDate: dateTimeRange!.start,
          toDate: dateTimeRange!.end,
          reason: reason,
          status: 'pending',
          requestedAt: DateTime.now());

      //Adding a leave request
      await _firestore.collection('leave-requests').add(leaveRequest.toMap());

      // checking the requested leave and updating flags
      await checkLeaveRequestForToday();
      sendingLeaveRequest = false;
      sentLeaveRequestForToday = true;
      notifyListeners();
      log('send leave request from $name');
    } catch (e) {
      log('Error sending leave request ${e.toString()}');
    }
  }

  // Checks whether a leave request for today is sent or not
  Future<void> checkLeaveRequestForToday() async {
    try {
      final querySnapshot = await _firestore
          .collection('leave-requests')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .where('fromDate',
              isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .where('toDate',
              isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        currentLeaveRequest =
            LeaveRequestModel.fromMap(querySnapshot.docs.first.data());
        sentLeaveRequestForToday = true;
        notifyListeners();
      } else {
        currentLeaveRequest = null;
        sendingLeaveRequest = false;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      log('Error Checking Leave Request info: ${e.toString()}');
    }
  }
}
