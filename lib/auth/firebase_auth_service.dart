import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
// Remove unused package: package_info
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter for current user
  User? get currentUser => _auth.currentUser;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Future for sign-up with email and password (with error handling)
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the created user
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      handleFirebaseAuthError(e);
      return null;
    } catch (e) {
      // Handle other exceptions
      print("An unexpected error occurred: $e");
      return null;
    }
  }

  // Future for sign-in with email and password (with error handling)
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the signed-in user
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      handleFirebaseAuthError(e);
      return null;
    } catch (e) {
      // Handle other exceptions
      print("An unexpected error occurred: $e");
      return null;
    }
  }

  // Function to handle FirebaseAuth exceptions
  void handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case "weak-password":
        print("The password is too weak.");
        break;
      case "email-already-in-use":
        print("The email address is already in use by another user.");
        break;
      case "invalid-email":
        print("The email address is invalid.");
        break;
      case "user-not-found":
        print("The user account does not exist.");
        break;
      case "wrong-password":
        print("The password is incorrect.");
        break;
      default:
        print("An unknown error occurred: ${e.code}");
    }
  }
}
