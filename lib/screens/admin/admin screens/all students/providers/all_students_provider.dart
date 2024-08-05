import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/leaves/models/leave_request_model.dart';
import 'package:attendance_management_system/screens/register/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AllStudentsPageProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  List<AppUser> students = [];
  List<LeaveRequestModel> studentLeaves = [];
  bool isFetchingStudents = false;
  bool isDeletingStudent = false;
  bool isUpdating = false;
  bool isPickingImage = false;
  bool isImagePicked = false;
  bool isUploadingImage = false;
  bool isImageUploaded = false;
  bool isFetchingNumberOfDays = false;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  File? image;
  static const String imageFolderName = 'UserProfileImages/';
  int presentDays = 0;
  int absentDays = 0;

  //HOMEPAGE PROVIDER COMMON FUNCTIONALITY START
  Future<void> pickImageToUpdateStudent() async {
    try {
      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      isPickingImage = true;
      notifyListeners();
      if (pickedImage != null) {
        image = File(pickedImage.path);
        isImagePicked = true;
        isPickingImage = false;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Uploads image from gallery to firebase storage
  Future<void> uploadImageToUpdateStudent(String currentEmail) async {
    try {
      if (image != null) {
        String imageName =
            'image${DateTime.now().millisecondsSinceEpoch}${math.Random().nextInt(100000)}.jpg';
        final ref = _storage.ref().child(imageFolderName + imageName);
        final uploadTask = ref.putFile(image!);
        uploadTask.snapshotEvents.listen((taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              isUploadingImage = true;
              notifyListeners();
              break;
            case TaskState.success:
              isImageUploaded = true;
              _imageUrl = await ref.getDownloadURL();
              notifyListeners();
              isImagePicked = false;
              await updateImageUrlToFirestore(_imageUrl!, currentEmail);
              isImageUploaded = false;
              isUploadingImage = false;
              notifyListeners();
              break;
            default:
              log('TaskState unknown');
          }
        });
      }
    } catch (e) {
      log('Error Uploading Image: ${e.toString()}');
    }
  }

  // Updates the profilePicUrl property of the current user
  Future<void> updateImageUrlToFirestore(
      String newImageUrl, String currentEmail) async {
    try {
      if (_auth.currentUser != null) {
        final snapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentEmail)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          String? oldImageUrl = doc.data()['profilePicUrl'];

          // Delete old image if it exists
          if (oldImageUrl != null) {
            try {
              await FirebaseStorage.instance.refFromURL(oldImageUrl).delete();
            } catch (e) {
              log('Error deleting old image: $e');
            }
          }

          final leavesCollection = await _firestore
              .collection('leave-requests')
              .where('email', isEqualTo: currentEmail)
              .get();

          if (leavesCollection.docs.isNotEmpty) {
            for (var leave in leavesCollection.docs) {
              leave.reference.update({"profilePicUrl": newImageUrl});
              var name = leave.data()['name'].toString();
              log(name);
            }
          }
        } else {
          log('No leaves for this user, so profile picture will not be updated');
        }

        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          doc.reference.update({"profilePicUrl": newImageUrl});
          notifyListeners();
        } else {
          log('Doc does not exists');
        }
      } else {
        log('User is not logged in');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  //HOMEPAEGE PROVIDER COMMON FUNCTIONALITY END

  //gets list of all currently registered users/students
  Future<void> getAllCurrentStudents() async {
    try {
      isFetchingStudents = true;
      notifyListeners();
      final usersCollection = await _firestore
          .collection('users')
          .where('email', isNotEqualTo: adminEmail)
          .get();

      if (usersCollection.docs.isNotEmpty) {
        final users =
            usersCollection.docs.map((e) => AppUser.fromMap(e.data())).toList();
        students = users;
        notifyListeners();
      }
      isFetchingStudents = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching list of users: ${e.toString()}');
    }
  }

  //updates student's info
  Future<void> updateStudentInfo(AppUser student, String currentEmail) async {
    try {
      isUpdating = true;
      notifyListeners();
      if (_auth.currentUser != null) {
        await Future.wait([uploadImageToUpdateStudent(currentEmail)]);
        notifyListeners();

        final usersCollection = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentEmail)
            .limit(1)
            .get();
        if (usersCollection.docs.isNotEmpty) {
          await usersCollection.docs.first.reference
              .update(student.toMap())
              .then(
            (value) async {
              await getAllCurrentStudents();
            },
          );
        }
        isUpdating = false;
        notifyListeners();
      }
    } catch (e) {
      log('Error updating user info: ${e.toString()}');
    }
  }

  // Permanently deletes the student/user from firestore
  Future<void> deleteStudent(AppUser student) async {
    try {
      if (_auth.currentUser != null) {
        isDeletingStudent = true;
        notifyListeners();
        final usersCollection = await _firestore
            .collection('users')
            .where('email', isEqualTo: student.email)
            .limit(1)
            .get();
        if (usersCollection.docs.isNotEmpty) {
          await usersCollection.docs.first.reference.delete().then(
            (value) async {
              await getAllCurrentStudents();
            },
          );

          log('Deleted => ${student.name}');
        } else {
          log('user does not exist');
        }
        isDeletingStudent = false;
        notifyListeners();
      }
    } catch (e) {
      log('Error updating user info: ${e.toString()}');
    }
  }

  Future<void> updateNumberOfDays(AppUser student) async {
    try {
      isFetchingNumberOfDays = true;
      notifyListeners();

      presentDays = 0;
      absentDays = 0;

      final year = currentdateTime.year.toString();
      final month = getMonthById(currentdateTime.month);

      // Get all days in the current month where attendance was marked
      final querySnapshot = await _firestore
          .collection('daily-attendance')
          .doc(year)
          .collection(month)
          .where('markedStudents', arrayContains: student.email)
          .get();

      for (var dayDoc in querySnapshot.docs) {
        final day = dayDoc.id;

        // Check the student's attendance status for this day
        final attendanceDoc = await _firestore
            .collection('attendance')
            .doc(student.email)
            .collection(year)
            .doc(month)
            .collection(day)
            .doc('attendance-status')
            .get();

        if (attendanceDoc.exists) {
          final status =
              attendanceDoc.data()?['status'].toString().toLowerCase();
          final timestamp = attendanceDoc.data()?['timestamp'] as Timestamp;
          final date = timestamp.toDate();

          if (date.isBefore(currentdateTime) && date.day.toString() == day) {
            if (status == 'present') {
              presentDays++;
            } else if (status == 'absent') {
              absentDays++;
            }
          }
        }
      }

      // fetching leaves for this student
      final leavesSnapshot = await _firestore
          .collection('leave-requests')
          .where('email', isEqualTo: student.email)
          .get();

      if (leavesSnapshot.docs.isNotEmpty) {
        List<LeaveRequestModel> leaves = leavesSnapshot.docs
            .map((e) => LeaveRequestModel.fromMap(e.data()))
            .toList();
        studentLeaves = leaves;
        notifyListeners();
      } else {
        log('Leaves docs are empty');
        studentLeaves = [];
        notifyListeners();
      }

      isFetchingNumberOfDays = false;
      notifyListeners();
    } catch (e) {
      log('Error updating number of days: ${e.toString()}');
      isFetchingNumberOfDays = false;
      notifyListeners();
    }
  }
}
