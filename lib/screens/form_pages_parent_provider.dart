import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin FormPagesParentProvider on ChangeNotifier {
  bool isPasswordHidden = true;
  final auth = FirebaseAuth.instance;
  // hide/unhide password for password field
  void unhidePassword() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }
}
