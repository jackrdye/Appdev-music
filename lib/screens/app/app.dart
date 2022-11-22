import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/screens/app/friends_page.dart';
import 'package:music_app/screens/app/home_page.dart';
import 'package:music_app/screens/app/library_page.dart';

class Playlist {
  String id;
  String name;
  String ownerId;
  List<Song> songs;
  List<Profile> collaborators;

  Playlist({required this.id, required this.name, required this.ownerId, required this.songs, required this.collaborators});
}

class Friend {
  

}

class Song {
  String id;
  String name;
  String spotifyLink;
  String appleMusicLink;
  String youtubeMusicLink;

  Song({required this.id, required this.name, this.spotifyLink="", this.appleMusicLink="", this.youtubeMusicLink=""});
}

class Profile {
  String id;
  String username;
  String musicService;
  List<Friend> friends;
  List<Playlist> playlists;
  List sharedWithMe;

  Profile({required this.id, required this.username, required this.musicService, required this.friends, required this.playlists, required this.sharedWithMe});
}



class App extends StatefulWidget {
  const App({super.key}); 

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final user = FirebaseAuth.instance.currentUser!;
 
  int _selectedIndex = 0;

  void _navigateBottomBar(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    }

  late List<Widget> _pages = [];
  @override
  void initState() {
    _pages = [
      HomePage(user: user, signOut: signOut),
      LibraryPage(),
      FriendsPage()
  ];
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: GNav(
              onTabChange: (index) {
                _navigateBottomBar(index);
              },
              selectedIndex: _selectedIndex,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              gap: 5,
              tabs: const [
                GButton(
                  icon: Icons.home, 
                  text: "Home",
                ),
                GButton(
                  icon: Icons.library_music_outlined, 
                  text: "Library",
                  ),
                GButton(
                  icon: Icons.people_alt, 
                text: "Friends",
                )
              ]
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex]
    );
  }
}