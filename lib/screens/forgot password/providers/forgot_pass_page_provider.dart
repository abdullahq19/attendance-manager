import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPageProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _emailSent = false;
  bool sendingEmail = false;
  bool get emailSent => _emailSent;

  // sends a email verification code to the given email address
  Future<void> forgotPass(String email, BuildContext context) async {
    try {
      _emailSent = false;
      sendingEmail = true;
      notifyListeners();
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isEmpty) {
        sendingEmail = false;
        log('Email is not verified');
        notifyListeners();
        return;
      }
      await _auth.sendPasswordResetEmail(email: email).then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email Sent'), duration: Duration(seconds: 2),)));
      _emailSent = true;
      sendingEmail = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
