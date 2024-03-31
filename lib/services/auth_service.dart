import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // Instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // User Sign in
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Incase user doesnt have docs, this will be added or merged
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    }
    // Catching the exception
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // User Sign Out
  Future signOut() async {
    return await _firebaseAuth.signOut();
  }

  String onlyUser(String user) {
    int i = 0;
    String val = '';
    while (user[i] != '@') {
      val += user[i];
      i++;
    }
    return val.toUpperCase();
  }

  // User Registration
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // After an user is created, Create a new document for users in users collection
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      // _fireStore.collection('users').add({});

      return userCredential;
    }
    // Catching the exception
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
