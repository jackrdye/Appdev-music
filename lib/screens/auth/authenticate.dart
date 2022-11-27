import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/app/app.dart';
import 'package:music_app/screens/auth/register.dart';
import 'package:music_app/screens/auth/login.dart';
import 'package:music_app/services/auth.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({super.key});
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogin = true;
  void toggleLoginView() {
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin) {
      return Login(toggleLoginView: toggleLoginView);
    }
    else {
      return Register(toggleLoginView: toggleLoginView);
    }
  }
}