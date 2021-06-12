import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool? _isSignIn = false;

  GoogleSignInProvider() {
    _isSignIn = false;
  }

  //Getter
  bool get isSignIn => _isSignIn!;

  //Setter
  set isSignIn(bool isSingIn) {
    _isSignIn = isSignIn;
    notifyListeners();
  }

  Future login() async {
    isSignIn = false;
    final user = await googleSignIn.signIn();

    if (user == null) {
      isSignIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credencial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credencial);
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
  }
}
