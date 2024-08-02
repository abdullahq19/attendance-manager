import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/students/models/marked_students.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentPageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  bool fetchingUserInfo = false;
  List<MarkedStudents> students = [];

  // Gets all the students info that marked attendance today
  Future<void> getStudentsMarkedTodayWithInfo() async {
    try {
      final year = currentdateTime.year.toString();
      final month = getMonth();
      final day = currentdateTime.day.toString();

      DocumentSnapshot summaryDoc = await _firestore
          .collection('daily-attendance')
          .doc(year)
          .collection(month)
          .doc(day)
          .get();

      if (summaryDoc.exists) {
        fetchingUserInfo = true;
        notifyListeners();
        Map<String, dynamic> data = summaryDoc.data() as Map<String, dynamic>;
        List<String> markedEmails =
            List<String>.from(data['markedStudents'] ?? []);

        students = await Future.wait(markedEmails.map((email) async {
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
          } else {
            userData['attendanceStatus'] = 'Not marked';
            userData['markedAt'] = null;
          }

          return MarkedStudents.fromMap(userData);
        }));
        fetchingUserInfo = false;
        log(students.toString());
        notifyListeners();
      } else {
        students = [];
        log('No attendance summary found for today');
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching students marked today: ${e.toString()}');
    }
  }
}
