import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'screens/overview_screen.dart';
// import 'screens/splash_screen.dart';
// import '/screens/auth_screen.dart';
// import '/screens/overview_screen.dart';
// import 'package:device_preview/device_preview.dart';
import 'login_page.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}