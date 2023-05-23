import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:login/kays.dart' as keys;

class GitAuth {
  
  Future<UserCredential?> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitSignIn = GitHubSignIn(
      clientId: keys.GIT_CLIENT_ID, 
      clientSecret: keys.GIT_CLIENT_SECRET, 
      redirectUrl: 'https://pmsnapp-3970e.firebaseapp.com/__/auth/handler'
    );

    final result = await gitSignIn.signIn(context);

    switch(result.status){
      case GitHubSignInResultStatus.ok:{
        try {
          final gitAuthCredential = GithubAuthProvider.credential(result.token!);
          return await FirebaseAuth.instance.signInWithCredential(gitAuthCredential);
        } on FirebaseAuthException catch (e) {
          if(e.code=='account-exists-with-different-credential'){    
            return null;
          }else{
            throw e;
          }
        }
      } break;

      case GitHubSignInResultStatus.cancelled:{
        return null;
      }

      case GitHubSignInResultStatus.failed:{
        return null;
      }

    }
    
  }

   Future<void> gitEmailSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

}