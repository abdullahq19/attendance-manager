import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/admin/admin%20screens/all%20students/providers/all_students_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isMarkingPresent = false;
  bool isMarkingAbsent = false;
  bool isMarkedForToday = false;

  // Mark attendance as present or absent
  Future<void> markAttendance(bool isAbsent, BuildContext context) async {
    try {
      final userEmail = _auth.currentUser!.email;
      final year = currentdateTime.year.toString();
      final month = getMonth();
      final day = currentdateTime.day.toString();

      // Reference to individual student's attendance
      final attendanceRef = _firestore
          .collection('attendance')
          .doc(userEmail)
          .collection(year)
          .doc(month)
          .collection(day)
          .doc('attendance-status');

      // Reference to daily attendance
      final summaryRef = _firestore
          .collection('daily-attendance')
          .doc(year)
          .collection(month)
          .doc(day);

      // Check if attendance already marked
      final doc = await attendanceRef.get();
      if (doc.exists) {
        isMarkedForToday = true;
        notifyListeners();
        return;
      }

      isAbsent ? isMarkingAbsent = true : isMarkingPresent = true;
      notifyListeners();

      // Use a batch to update both documents atomically
      WriteBatch batch = _firestore.batch();

      // Update individual attendance
      batch.set(attendanceRef, {
        'status': isAbsent ? 'absent' : 'present',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update daily summary
      batch.set(
          summaryRef,
          {
            'markedStudents': FieldValue.arrayUnion([userEmail])
          },
          SetOptions(merge: true));

      await batch.commit();

      isAbsent ? isMarkingAbsent = false : isMarkingPresent = false;
      notifyListeners();
      await checkAttendanceStatus();
      if(context.mounted) Provider.of<AllStudentsPageProvider>(context).getStudentAttendanceDaysRecords(userEmail!);
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

    final querySnapshot = await _firestore
        .collection('leave-requests')
        .where('email', isEqualTo: _auth.currentUser!.email)
        .where('fromDate',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .where('toDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .limit(1)
        .get();

    // checks if user has requested a leave, if yes then attendance for today is marked and mark attendance button is disabled
    if (querySnapshot.docs.isNotEmpty) {
      isMarkedForToday = true;
      notifyListeners();
      return;
    }

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

  void setIsMarkedForTodayTrue() {
    isMarkedForToday = true;
    notifyListeners();
  }
}
