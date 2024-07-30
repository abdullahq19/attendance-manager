import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/form_pages_parent_provider.dart';
import 'package:attendance_management_system/screens/home/view/home_page.dart';
import 'package:attendance_management_system/screens/register/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPageProvider extends ChangeNotifier with FormPagesParentProvider {
  bool isConfirmPasswordHidden = true;
  bool isSigningUp = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String usersCollection = 'users';

// hide/unhide password for confirm password field
  void unhideConfirmPassword() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    notifyListeners();
  }

  //get user uid
  String getUserUID() {
    return auth.currentUser!.uid;
  }

  // create a new user with email and password
  Future<bool> registerUser(String email, String password, String name,
      bool isAdmin, BuildContext context) async {
    try {
      isSigningUp = true;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Navigator.of(context).pushNamed(HomePage.pageName);
        isSigningUp = false;
        notifyListeners();
        isAdmin = email == adminEmail && password == adminPassword;
        final uid = getUserUID();
        final newUser = AppUser(
            uid: uid,
            name: name,
            email: email,
            role: isAdmin ? 'admin' : 'user');
        final users = _firestore.collection(usersCollection);
        await users.add(newUser.toMap()).then((value) => showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
                onClosing: () => log('Bottom sheet closed'),
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Signed in as $name'),
                    ))));
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        isSigningUp = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        isSigningUp = false;
        notifyListeners();
      }
      return false;
    }
  }
}
