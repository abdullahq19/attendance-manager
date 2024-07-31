import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePageProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  static const String imageFolderName = 'UserProfileImages/';
  String imageName = 'image${DateTime.now().millisecondsSinceEpoch}.jpg';

  final _picker = ImagePicker();
  bool isPickingImage = false;
  bool isImagePicked = false;
  bool isUploadingImage = false;
  bool isImageUploaded = false;
  File? image;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  // Sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // picks image from gallery
  Future<void> pickImageFromGallery() async {
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
  Future<void> uploadImageToFirebaseStorage() async {
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
              log(imageUrl!);
              isUploadingImage = false;
              isImagePicked = false;
              await updateImageUrlToFirestore(_imageUrl!);
              isImageUploaded = false;
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
  Future<void> updateImageUrlToFirestore(String newImageUrl) async {
    try {
      if (_auth.currentUser != null) {
        final snapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: _auth.currentUser!.email)
            .limit(1)
            .get();
        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          doc.reference.update({"profilePicUrl": newImageUrl});
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

  // Get current user profile picture url
  Future<void> getCurrentUserProfilePicUrl() async {
    var snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: _auth.currentUser!.email)
        .limit(1)
        .get();

    final doc = snapshot.docs.first;
    log(_auth.currentUser!.email!);
    if (doc.exists) {
      var user = await doc.reference.get();
      if (user.data()!.containsKey('profilePicUrl')) {
        _imageUrl = await user.data()!['profilePicUrl'];
        log("Got profile pic url: $imageUrl");
      }
    } else {
      log('Doc does not exists');
    }
  }

  void clearImage() {
    isImagePicked = false;
    notifyListeners();
  }
}
