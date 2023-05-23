import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserCredential? user;

  UserProvider({
    this.user
  });

  getUserData() => this.user;

  setUserData(UserCredential user){
    this.user=user;
    notifyListeners();
  }
}