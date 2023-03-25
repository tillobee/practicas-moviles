/* import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<> createUserWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
    } catch(e){
      print(e);
    }
     

  }
} */