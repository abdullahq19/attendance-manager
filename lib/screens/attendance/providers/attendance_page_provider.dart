import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/attendance/view/attendance_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendancePageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isMarkingPresent = false;
  bool isMarkingAbsent = false;
  bool isMarkedForToday = false;

  Future<void> markAttendance(bool isAbsent) async {
    try {
      final attendanceRef = _firestore
          .collection('attendance')
          .doc(_auth.currentUser!.email)
          .collection(currentdateTime.year.toString())
          .doc(getMonth())
          .collection(currentdateTime.day.toString())
          .doc('attendance-status');

      // If an attendance record already exists for current day then set isMarkedForToday true so buttons can become disable
      final doc = await attendanceRef.get();
      if (doc.exists) {
        isMarkedForToday = true;
        notifyListeners();
        return;
      }
      isAbsent ? isMarkingAbsent = true : isMarkingPresent = true;
      notifyListeners();
      await attendanceRef.set({
        'status': isAbsent ? 'absent' : 'present',
        'timestamp': FieldValue.serverTimestamp(),
      });
      isAbsent ? isMarkingAbsent = false : isMarkingPresent = false;
      notifyListeners();
      await checkAttendanceStatus();
    } catch (e) {
      log('Error marking attendance: ${e.toString()}');
    }
  }

  // Checks whether the attendance for this day is marked or not and updates value based on it
  Future<void> checkAttendanceStatus() async {
    final attendanceRef = _firestore
        .collection('attendance')
        .doc(_auth.currentUser!.email)
        .collection(currentdateTime.year.toString())
        .doc(getMonth())
        .collection(currentdateTime.day.toString())
        .doc('attendance-status');

    // Check if attendance already marked
    final doc = await attendanceRef.get();
    if (doc.exists) {
      isMarkedForToday = true;
      notifyListeners();
    } else {
      isMarkedForToday = false;
      notifyListeners();
    }
  }
}
