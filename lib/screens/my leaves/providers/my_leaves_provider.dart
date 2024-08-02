import 'dart:developer';

import 'package:attendance_management_system/screens/leaves/models/leave_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLeavesProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<LeaveRequestModel> myLeaves = [];
  bool isFetchingLeaves = false;

  // get total leaves of current user
  Future<void> getMyTotalLeaves() async {
    try {
      isFetchingLeaves = true;
      notifyListeners();
      final querySnapshot = await _firestore
          .collection('leave-requests')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<LeaveRequestModel> leaves = querySnapshot.docs
            .map((e) => LeaveRequestModel.fromMap(e.data()))
            .toList();
        myLeaves = leaves;
        log(myLeaves.toString());
        notifyListeners();
      } else {
        log('Leaves docs are empty');
        isFetchingLeaves = false;
        notifyListeners();
      }
      isFetchingLeaves = false;
      notifyListeners();
    } catch (e) {
      log('Error getting my total leaves: ${e.toString()}');
    }
  }
}
