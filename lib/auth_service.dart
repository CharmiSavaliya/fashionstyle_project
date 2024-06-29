import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("FirebaseAuthException: ${e.message}");
      } else {
        log("An error occurred: ${e.toString()}");
      }
      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final userData = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userData.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("FirebaseAuthException: ${e.message}");
      } else {
        log("An error occurred: ${e.toString()}");
      }
      return null;
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("FirebaseAuthException: ${e.message}");
      } else {
        log("An error occurred: ${e.toString()}");
      }
    }
  }
}
