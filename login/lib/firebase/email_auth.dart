import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      userCredential.user!.sendEmailVerification();
      return true;
    } catch(e){
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      final userCredential =  await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      if(userCredential.user!.emailVerified){
        return true;
      } return false;
    } catch (e) {
      return false;
    }
  }
}