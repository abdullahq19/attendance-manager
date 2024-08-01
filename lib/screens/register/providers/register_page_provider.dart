import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/form_pages_parent_provider.dart';
import 'package:attendance_management_system/screens/home/view/home_page.dart';
import 'package:attendance_management_system/screens/register/models/app_user.dart';
import 'package:attendance_management_system/screens/sign%20in/view/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPageProvider extends ChangeNotifier with FormPagesParentProvider {
  bool isConfirmPasswordHidden = true;
  bool isSigningUp = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String usersCollection = 'users';
  String? currentUsername = '';

// hide/unhide password for confirm password field
  void unhideConfirmPassword() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    notifyListeners();
  }

  // Sign Up with Google Account
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      isSigningUp = true;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // handling cancelling of google auth selection
      if (googleUser == null) {
        isSigningUp = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final oAuthCredentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final googleCredentials =
          await auth.signInWithCredential(oAuthCredentials);

      if (googleCredentials.additionalUserInfo!.isNewUser) {
        final user = googleCredentials.user;
        final userCollection = _firestore.collection('users')
          ..doc(googleCredentials.user!.email);
        final newGoogleUser = AppUser(
            uid: user!.uid,
            name: user.displayName!,
            email: user.email!,
            role: 'user');
        await userCollection.add(newGoogleUser.toMap());
        if (context.mounted) {
          Navigator.of(context).pushNamed(HomePage.pageName);
        }
      } else {
        if (context.mounted) Navigator.of(context).pushNamed(HomePage.pageName);
        log('Not a new user');
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.toString()}');
    } catch (e) {
      log('Error during Google sign in: ${e.toString()}');
    } finally {
      isSigningUp = false;
      notifyListeners();
    }
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
        Navigator.of(context).pushNamed(SignInPage.pageName);
        isSigningUp = false;
        notifyListeners();
        isAdmin = email == adminEmail && password == adminPassword;
        final newUser = AppUser(
            uid: auth.currentUser!.uid,
            name: name,
            email: email,
            role: isAdmin ? 'admin' : 'user');
        final users = _firestore.collection(usersCollection);
        await users.add(newUser.toMap());
        currentUsername == null ? newUser.name : auth.currentUser!.displayName;
        notifyListeners();
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

  // Gets current username from firestore if its null (only used if email is not verified)
  Future<void> getCurrentUsername() async {
    try {
      var querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: auth.currentUser!.email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var username = await querySnapshot.docs.first.data()['name'] as String;
        currentUsername = username;
        notifyListeners();
      } else {
        log('Doc empty for username');
      }
    } catch (e) {
      log('Error fetching username: ${e.toString()}');
    }
  }
}
