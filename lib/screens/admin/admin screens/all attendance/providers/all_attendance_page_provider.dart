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

      // Get all day documents for the current month
      final QuerySnapshot dayDocs = await _firestore
          .collection('daily-attendance')
          .doc(year)
          .collection(month)
          .get();

      for (var dayDoc in dayDocs.docs) {
        final day = dayDoc.id;
        final data = dayDoc.data() as Map<String, dynamic>;
        final List<String> markedEmails =
            List<String>.from(data['markedStudents'] ?? []);

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
            userData['attendanceStatus'] = attendanceDoc.data()?['status'];
            Timestamp timestamp =
                attendanceDoc.data()?['timestamp'] as Timestamp;
            userData['markedAt'] = timestamp.toDate();
            notifyListeners();
          }
          log(userData.toString());
          return MarkedStudents.fromMap(userData);
        }));
        log(studentsForDay.toString());

        attendanceByDate!['$year-$month-$day'] = studentsForDay;
        notifyListeners();
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
      final query = await _firestore
          .collection('attendance')
          .doc(student.email)
          .collection(student.markedAt!.year.toString())
          .doc(getMonthById(student.markedAt!.month))
          .collection(student.markedAt!.day.toString())
          .get();

      if (query.docs.isNotEmpty) {
        for (var doc in query.docs) {
          doc.reference.delete();
          isDeletingAttendanceRecord = false;
          notifyListeners();
        }
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
