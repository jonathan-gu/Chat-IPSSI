import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServiceController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
          
        _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'pseudo': email
      }, SetOptions(merge: true));
          
          return userCredential;
    } on FirebaseAuthException catch (exception) {
      throw Exception(exception.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPasswordAndPseudo(String email, password, pseudo) async {
    if (pseudo == null || pseudo.isEmpty) {
      throw Exception('Veuillez entrer votre pseudo !');
    }
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'pseudo': pseudo
      },);

      return userCredential;
    } on FirebaseAuthException catch (exception) {
      throw Exception(exception.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
