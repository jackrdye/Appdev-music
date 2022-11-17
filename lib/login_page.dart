import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
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
              SizedBox(
                height: 5,
              ),
              Text(
                "Welcome back you've been missed!"
              ),
              SizedBox(
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
                  child: TextField(
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


              // Sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Sign in")),
                ),
              ),


              // Register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not registered?",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    " Register here",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}