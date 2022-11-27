import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_app/services/auth.dart';
import 'package:music_app/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:music_app/models/MusicUser.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MusicUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_,err) => null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}