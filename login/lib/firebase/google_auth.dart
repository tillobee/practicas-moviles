import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {

  GoogleSignIn? _googleSignIn;

  Future<UserCredential?> googleSignIn () async {
    try{
      _googleSignIn = GoogleSignIn();
      
      final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();
      
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
      
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e){
      return null;
    }
  }

  Future<void> googleSignOut() async {
    _googleSignIn=GoogleSignIn();
    try {
      await _googleSignIn?.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

}