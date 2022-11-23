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
  String id;
  String name;
  
  Friend({required this.id, required this.name});
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
  List<String> friendIds;
  List<String> playlistIds;
  List sharedWithMe;

  Profile({required this.id, required this.username, required this.musicService, required this.friendIds, required this.playlistIds, required this.sharedWithMe});
}



class App extends StatefulWidget {
  const App({super.key}); 

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // State
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  late List<Widget> _pages = [];
  @override
  void initState() {
    List<Playlist> playlists = [];
    List<Friend> friends = [];
    // Profile profile = Profile(id: user.uid, username: user.email!, musicService: "appleMusic", );

    _pages = [
      HomePage(user: user, signOut: signOut),
      LibraryPage(),
      FriendsPage()
  ];
  }

  // Methods
  void _navigateBottomBar(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
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