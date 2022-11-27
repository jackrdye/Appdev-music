import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/services/auth.dart';

class Login extends StatefulWidget {

  final Function toggleLoginView;
  const Login({ required this.toggleLoginView });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form (
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  // Welcome
                  Text(
                    "Hello Again!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                      "Welcome back you've been missed!"
                  ),
                  const SizedBox(
                    height: 75,
                  ),


                  // Email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (val) =>  val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            contentPadding: EdgeInsets.symmetric(horizontal: 10)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),


                  // Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: (val) =>  val!.isEmpty ? 'Enter a password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            contentPadding: EdgeInsets.symmetric(horizontal: 10)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),


                  // Sign in button

                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signIn(email, password);
                        if (result == null) {
                          setState(() => error = "Invalid Credentials");
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(child: Text("Sign in")),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3,),

                  // Register button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not registered?",
                        style: TextStyle(color: Colors.black),
                      ),
                      InkWell(
                        child: const Text(
                          " Register here",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          widget.toggleLoginView();
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 12,),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}