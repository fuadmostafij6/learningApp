

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlehelper {
  static final googlesignin = GoogleSignIn();

  GoogleSignInAccount? user;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FireBaseStore =  FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final googleCurrentUser = firebaseAuth.currentUser;

    if (googleCurrentUser != null) {
      googlesignin.signOut();
      await firebaseAuth.signOut();
      final googleUser = await googlesignin.signIn();
      if (googleUser != null) {
        user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    }
    else{
      final googleUser = await googlesignin.signIn();
      if (googleUser != null) {
        user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    }
    //await googlesignin.disconnect();
    //  await FirebaseAuth.instance.signOut();


  }
}