import 'package:flutter/material.dart';
import 'package:music_app/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: ,
      // ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You're logged in as:"),

              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Text("Logout")),
                  ),
                ),
                onTap: ()  async {
                  dynamic result = await _auth.signOut();
                  if (result == null) {
                    print("Hello");
                  }
                },
              ),
            ],
          )
      ),
    );
  }
}
