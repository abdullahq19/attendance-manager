import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/students/models/marked_students.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllAttendancePageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  bool fetchingAttendance = false;
  Map<String, List<MarkedStudents>>? attendanceByDate = {};
  String selectedValue = 'present';
  bool isUpdatingAttendanceStatus = false;
  bool isDeletingAttendanceRecord = false;

  Future<void> getAttendanceRecords() async {
    try {
      fetchingAttendance = true;
      notifyListeners();

      final year = currentdateTime.year.toString();
      final month = getMonth();

      attendanceByDate = {};

      // Get all day documents for the current month
      final QuerySnapshot dayDocs = await _firestore
          .collection('daily-attendance')
          .doc(year)
          .collection(month)
          .get();

      for (var dayDoc in dayDocs.docs) {
        final day = dayDoc.id;
        log('day num => $day');
        final data = dayDoc.data() as Map<String, dynamic>;
        final List<String> markedEmails =
            List<String>.from(data['markedStudents'] ?? []);
        if (markedEmails.isEmpty) {
          continue;
        }

        List<MarkedStudents> studentsForDay =
            await Future.wait(markedEmails.map((email) async {
          // Fetch user info
          final userQuery = await _firestore
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

          Map<String, dynamic> userData = {};
          if (userQuery.docs.isNotEmpty) {
            userData = userQuery.docs.first.data();
            userData['email'] = email;
          } else {
            log('User document not found for email: $email');
            userData = {'email': email, 'error': 'User info not found'};
          }

          // Fetch attendance status
          final attendanceDoc = await _firestore
              .collection('attendance')
              .doc(email)
              .collection(year)
              .doc(month)
              .collection(day)
              .doc('attendance-status')
              .get();

          if (attendanceDoc.exists) {
            userData['attendanceStatus'] =
                attendanceDoc.data()?['status'] ?? 'Unknown';
            Timestamp? timestamp =
                attendanceDoc.data()?['timestamp'] as Timestamp?;
            userData['markedAt'] = timestamp?.toDate() ?? DateTime.now();
          } else {
            userData['attendanceStatus'] = 'Not marked';
            userData['markedAt'] = null;
          }
          return MarkedStudents.fromMap(userData);
        }));

        studentsForDay = studentsForDay
            .where((student) => student.markedAt != null)
            .toList();
        notifyListeners();

        if (studentsForDay.isNotEmpty) {
          attendanceByDate!['$year-$month-$day'] = studentsForDay;
          notifyListeners();
        }
      }

      fetchingAttendance = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching all attendance records: ${e.toString()}');
      fetchingAttendance = false;
      notifyListeners();
    }
  }

  // Updates radio button present/absent values on UI
  void updateRadioButtonValue(String value) {
    selectedValue = value;
    notifyListeners();
  }

  // handles radio button dialog dismiss
  void setRadioButtonValueToDefault() {
    selectedValue = 'present';
    notifyListeners();
  }

  // update student attendance status
  Future<void> updateAttendanceStatusOfStudent(
      BuildContext context, MarkedStudents student, DateTime date) async {
    try {
      isUpdatingAttendanceStatus = true;
      notifyListeners();
      final attendanceDoc = await _firestore
          .collection('attendance')
          .doc(student.email)
          .collection(student.markedAt!.year.toString())
          .doc(getMonthById(student.markedAt!.month))
          .collection(student.markedAt!.day.toString())
          .doc('attendance-status')
          .get();

      if (attendanceDoc.exists) {
        await attendanceDoc.reference.update({"status": selectedValue}).then(
          (value) => Navigator.of(context).pop(),
        );
        await getAttendanceRecords();
        isUpdatingAttendanceStatus = false;
        notifyListeners();
      } else {
        log('Attendance doc does not exists');
        isUpdatingAttendanceStatus = false;
        notifyListeners();
      }
    } catch (e) {
      log('Error updating the document: ${e.toString()}');
    }
  }

  // Delete student attendance record
  //NOTE: THIS FUNCTION DOES NOT WORK AS OF NOW
  Future<void> deleteAttendanceRecordOfStudent(
      BuildContext context, MarkedStudents student, DateTime date) async {
    try {
      isDeletingAttendanceRecord = true;
      notifyListeners();

      final dayDocRef = _firestore
          .collection('daily-attendance')
          .doc(student.markedAt!.year.toString())
          .collection(getMonthById(student.markedAt!.month))
          .doc(student.markedAt!.day.toString());

      await dayDocRef.update({
        "markedStudents": FieldValue.arrayRemove([student.email])
      });

      final attendanceStatusDoc = await _firestore
          .collection('attendance')
          .doc(student.email)
          .collection(student.markedAt!.year.toString())
          .doc(getMonthById(student.markedAt!.month))
          .collection(student.markedAt!.day.toString())
          .doc('attendance-status')
          .get();

      if (attendanceStatusDoc.exists) {
        await attendanceStatusDoc.reference.delete().then(
              (value) => Navigator.of(context).pop(),
            );
        notifyListeners();
        await getAttendanceRecords();
        isDeletingAttendanceRecord = false;
        notifyListeners();
      } else {
        log('Attendance doc does not exists');
        isDeletingAttendanceRecord = false;
        notifyListeners();
      }
    } catch (e) {
      log('Error updating the document: ${e.toString()}');
    }
  }
}
