import 'dart:developer';
import 'dart:io';

import 'package:attendance_management_system/consts.dart';
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
  bool isFetchingStudents = false;
  bool isDeletingStudent = false;
  bool isUpdating = false;
  bool isPickingImage = false;
  bool isImagePicked = false;
  bool isUploadingImage = false;
  bool isImageUploaded = false;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  File? image;
  static const String imageFolderName = 'UserProfileImages/';
  String imageName = 'image${DateTime.now().millisecondsSinceEpoch}.jpg';

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
}
