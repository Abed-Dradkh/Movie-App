import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignServices extends ChangeNotifier {
  final _gSignIn = GoogleSignIn();

  GoogleSignInAccount? _gUser;

  GoogleSignInAccount get user => _gUser!;

  Future gLogin() async {
    try {
      final googleUser = await _gSignIn.signIn();
      if (googleUser == null) return null;
      _gUser = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      
    }
  }

  Future gLogout() async {
    try {
      await _gSignIn.signOut();
      FirebaseAuth.instance.signOut();
    } catch (e) {
      
    }
  }

  Future emailLogin(String email, String name) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: name,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: name,
        );
      } else if (e.code == 'wrong-password') {
        
      }
    }
  }
}
