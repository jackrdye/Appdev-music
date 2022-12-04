import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/models.dart';
import 'package:music_app/screens/auth/check_auth.dart';
import 'package:music_app/screens/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future createUser({required String email, required String password}) async {
    try {
      // Try create user in firebase Authentication
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User userAuth = result.user!; // ensure not null
      String uid = userAuth.uid;

      // Create user in firestore
      final docUser = FirebaseFirestore.instance.collection('Users').doc(uid);
      // playlistDoc = FirebaseFirestore.instance.collection('Playlist').doc();
      
      // playlist.set()

      final user = Profile(
        id: uid, 
        email: email, 
        username: email, 
        musicService: '', 
        friends: [], 
        friendRequests: [],
        playlists: [], 
        sharedWithMe: []
      );

      final userJson = user.toJson();
      await docUser.set(userJson);
      
      
    } on FirebaseAuthException catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Create an account",
                  style: GoogleFonts.bebasNeue(
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: 75,),


                // Email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
          
          
                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
          
          
                // Register button
          
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Register")),
                    ),
                  ),
                  onTap: () => {
                    createUser(email: _emailController.text.trim(), password: _passwordController.text),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckAuth()),
                    )
                  },
                ),


                // Already have an accont
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?"
                    ),
                    InkWell(
                      child: Text(
                        " Login here",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () => {
                        Navigator.pop(context)
                      },
                    ),

                  ],
                )



              ],
            ),
          )
        )
      ),
    );
  }
}


