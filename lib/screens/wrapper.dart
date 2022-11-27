import 'package:flutter/material.dart';
import 'package:music_app/screens/app/home.dart';
import 'package:music_app/screens/app/home_page.dart';
import 'package:provider/provider.dart';
import 'package:music_app/models/MusicUser.dart';
import 'package:music_app/screens/auth/authenticate.dart';
import 'package:music_app/screens/app/app.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MusicUser?>(context);
    print(user);

    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}
