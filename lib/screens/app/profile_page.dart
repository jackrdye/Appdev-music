import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/screens/auth/check_auth.dart';

class ProfilePage extends StatefulWidget {
  Profile profile;
  ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late String _usernameController;
  late String _musicServiceValue;

  late Profile profile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
    // _emailController = TextEditingController(text: profile.email);
    _usernameController = profile.username;
    _musicServiceValue = profile.musicService;

  }
  @override
  void dispose() {
    // _usernameController.dispose();
    super.dispose();
  }

  void updateUserProfile(String username, String musicService) async {
    print(username);
    print(musicService);
    await FirebaseFirestore.instance.collection("Users").doc(profile.id).update({"username": username, "musicService": musicService});
  }



  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Email: "),
            Text(profile.email)
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return TextFormField(
      initialValue: profile.username,
      decoration: InputDecoration(labelText: "Username", labelStyle: TextStyle(color: Colors.black54, fontSize: 19)),
      onChanged: (String value) {
        _usernameController = value;
      },
      
      
    );
  }

  Widget _buildMusicService() {
    return DropdownButtonFormField(
      
      items: const [
        DropdownMenuItem(child: Text("Spotify"), value: "Spotify",),
        DropdownMenuItem(child: Text("Apple Music"), value: "Apple Music")
      ], 
      value: _musicServiceValue,
      onChanged: (String? musicService) {
        if (musicService is String) {
          setState(() {
            _musicServiceValue = musicService;
          });
        }
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmail(),
              SizedBox(height: 30,),
              _buildUsername(),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft, 
                child: Text("Music Service", style: TextStyle(color: Colors.black54, fontSize: 15),)),
              _buildMusicService(),
              SizedBox(
                height: 50,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(child: Text("Confirm Changes", style: TextStyle(color: Colors.white),)),
                  ),
                ),
                onTap: ()  {
                  confirmChange(context);
                },
              ),

              SizedBox(height: 25,),

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
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CheckAuth()),
                          );
                    },
                  ),

            ],
          ),
        ),
      ),
    );
  }

  Future confirmChange(context) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Confirm Changes"),
      content: Text("Do you wish to update your profile?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: Text("No")
        ),
        TextButton(
          onPressed: () {
            updateUserProfile(_usernameController, _musicServiceValue);
            Navigator.of(context).pop();
          }, 
          child: Text("Yes")
        )
      ],
    )
  );

    // return SafeArea(
    //   child: Column(
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width, 
    //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    //         decoration: BoxDecoration(
    //           color: Colors.grey[300]
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text("Profile", style: TextStyle(fontSize: 24),),
    //             InkWell(
    //               onTap: () {
    //                 // openTextField(context);
                    
    //               },
    //               child: Icon(Icons.add)
    //             )
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 50),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 25),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     border: Border.all(color: Colors.black),
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   child: TextField(
    //                     controller: _usernameController,
    //                     decoration: const InputDecoration(
    //                       border: InputBorder.none,
    //                       hintText: "username",
    //                       contentPadding: EdgeInsets.symmetric(horizontal: 10)
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(height: 10),
    //             ],
    //           ),
    //         )
    //       ),
    //     ],
    //   ),
    // );
  
}