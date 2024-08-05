import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
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

  final _picker = ImagePicker();
  bool isPickingImage = false;
  bool isImagePicked = false;
  bool isUploadingImage = false;
  bool isImageUploaded = false;
  File? image;
  String? imageUrl;

  // Sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
    imageUrl = null;
    image = null;
    notifyListeners();
  }

  // picks image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      log('THIS IS IMAGE FILE: $image');
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
              imageUrl = await ref.getDownloadURL();
              notifyListeners();
              isUploadingImage = false;
              isImagePicked = false;
              await updateImageUrlToFirestore(imageUrl!);
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
              .where('email', isEqualTo: _auth.currentUser!.email)
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
          log('snapshot.docs.toString() => ${snapshot.docs.toString()}');
          final doc = snapshot.docs.first;
          await doc.reference.update({"profilePicUrl": newImageUrl});
          final docsnap = await doc.reference.get();
          log('Name at every iteration of update pic url: ${docsnap.data()?['name']}');
          log('pic url at every iteration: ${docsnap.data()?['profilePicUrl']}');
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
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: _auth.currentUser!.email)
        .limit(1)
        .get();

    final doc = snapshot.docs.first;
    log(_auth.currentUser!.email!);
    if (doc.exists) {
      final user = await doc.reference.get();
      if (user.data()!.containsKey('profilePicUrl')) {
        imageUrl = await user.data()!['profilePicUrl'];
        log('getCurrentUserProfilePicUrl: $imageUrl');
        notifyListeners();
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
