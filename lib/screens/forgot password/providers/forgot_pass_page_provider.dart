import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPageProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool _emailSent = false;
  bool get emailSent => _emailSent;

  // sends a email verification code to the given email address
  Future<void> forgotPass(String email) async {
    try {
      _emailSent = false;
      await _auth.sendPasswordResetEmail(email: email);
      _emailSent = true;
    } catch (e) {
      log(e.toString());
    }
  }
}
