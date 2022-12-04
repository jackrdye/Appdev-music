import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/auth/check_auth.dart';

class HomePage extends StatefulWidget {
  final User user;
  final VoidCallback signOut;

  const HomePage({super.key, required this.user, required this.signOut}
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            Text("You're logged in as: ${widget.user.email}"),

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
                  onTap: ()  {
                    widget.signOut();
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CheckAuth()),
                        );
                  },
                ),
          ],
        )
      ),
    );
  }
}