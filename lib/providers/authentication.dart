import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthMethods with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp(
      {required String email,

        required String password,

      }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } catch (e) {
      return e;
    }
  }
  Future<UserCredential>signinWithgoogle()async{
    final GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return e;
    }
  }

  logOut() async {
    await _auth.signOut();
  }
}
