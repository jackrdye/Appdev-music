import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/models/MusicUser.dart';
import 'package:music_app/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleLoginView;
  const Register({ required this.toggleLoginView });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                          child: TextFormField(
                            validator: (val) =>  val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
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
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            obscureText: true,
                            validator: (val) =>  val!.isEmpty ? 'Enter a password' : null,
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
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.register(email, password);
                            if (result == null) {
                              setState(() => error = "Please supply a valid email address");
                            }
                          }
                        },
                      ),


                      // Already have an account
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
                            onTap: () {
                              widget.toggleLoginView();
                            },
                          ),

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
              )
          )
      ),
    );
  }
}