import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }
}
