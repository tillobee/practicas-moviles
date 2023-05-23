import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/preferences.dart';

class InitFirebase {
  static Future<FirebaseApp> initFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if(user!=null){
      //cambiar bandera de loggedIn de Preferences segun corresponda, la abndera ayuda a hacer skip de la pantalla del login si es igual a true
      Preferences.isLogged=true;
    }

    return firebaseApp;
  }
}