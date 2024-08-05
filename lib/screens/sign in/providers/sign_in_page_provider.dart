import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/main.dart';
import 'package:attendance_management_system/screens/form_pages_parent_provider.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInPageProvider extends ChangeNotifier with FormPagesParentProvider {
  final _firestore = FirebaseFirestore.instance;
  bool isSigningIn = false;
  bool isSigningInWithGoogle = false;
  String? _errorText;
  String? get errorText => _errorText;

  // create a new user with email and password
  Future<void> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    try {
      final userCollection = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (userCollection.docs.isNotEmpty) {
        isSigningIn = true;
        notifyListeners();
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await homePageProvider.getCurrentUserProfilePicUrl();
          isSigningIn = false;
          notifyListeners();
          if (email == adminEmail && password == adminPassword) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Signed in as a Admin'),
                  duration: Duration(seconds: 2)));
              log('Signed in as a Admin');
              Navigator.of(context).pushReplacementNamed(initialRoute);
            }
          }
        });
      } else {
        log('Tried to sign in with a email that does not exist in users collection');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        _errorText = 'User disabled';
      } else if (e.code == 'user-not-found') {
        _errorText = 'User not found';
      } else if (e.code == 'invalid-email') {
        _errorText = 'Invalid email';
      } else if (e.code == 'invalid-credential') {
        _errorText = 'Wrong email or password';
      } else if (e.code == 'wrong-password') {
        _errorText = 'Wrong password';
      }
      isSigningIn = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    try {
      isSigningInWithGoogle = true;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // handling cancelling of google auth selection
      if (googleUser == null) {
        isSigningInWithGoogle = false;
        notifyListeners();
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final oAuthCredentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await auth.signInWithCredential(oAuthCredentials);
      await homePageProvider.getCurrentUserProfilePicUrl();
      isSigningInWithGoogle = false;
      notifyListeners();
      if (context.mounted) {
        Navigator.of(context).pushNamed(initialRoute);
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.toString()}');
    } catch (e) {
      log('Error during Google sign in: ${e.toString()}');
    } finally {
      isSigningIn = false;
      notifyListeners();
    }
  }
}
