import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/MusicUser.dart';
import 'package:music_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  MusicUser _musicUserFromUser(User user) {
    return MusicUser(uid: user.uid);
  }

  Stream<MusicUser> get user {
    return _auth.authStateChanges()
        .map((User? user) => _musicUserFromUser(user!));
  }

  //sign in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user == null) {
        return null;
      }
      else {
        return _musicUserFromUser(user);
      }

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('new user', 'spotify');
      if(user == null) {
        return null;
      }
      else {
        return _musicUserFromUser(user);
      }

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}