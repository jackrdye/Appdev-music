import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/screens/app/friends_page.dart';
import 'package:music_app/screens/app/home_page.dart';
import 'package:music_app/screens/app/library_page.dart';
import 'package:music_app/widgets/playlists/playlistList.dart';
import '../../models.dart'; // Import Playlist, Friend, Song, Profile

class App extends StatefulWidget {
  const App({super.key}); 

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  // State
  final userAuth = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  

  late List<Widget> _bottomNavPages = [];
  late DocumentReference profilee;
  late Profile profile;
  late List<Song> songs;
  late List<Playlist> playlists;
  @override
  void initState(){
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(userAuth.uid);
    Object user = getUserProfile(userDoc);
    
    songs = [Song(id: "songid1", name: "songname1"), Song(id: "songid2", name: "songname2"), 
      Song(id: "songid3", name: "songname3"), Song(id: "songid4", name: "songname4")];
    
    playlists = [Playlist(id: "playlistid1", name: "playlist1", ownerId: "ownerid1", songs: songs, collaboratorIds: [userAuth.uid]),
      Playlist(id: "playlistid2", name: "playlist2", ownerId: "ownerid2", songs: songs, collaboratorIds: [userAuth.uid]),
      Playlist(id: "playlistid3", name: "playlist3", ownerId: "ownerid3", songs: songs.sublist(0, 1), collaboratorIds: [userAuth.uid])];

    profile = Profile(id: userAuth.uid, email: userAuth.email!, username: userAuth.email!, musicService: "appleMusic", friends: [], friendRequests: [], playlists: playlists, sharedWithMe: []);
    print(profile.playlists);
    _bottomNavPages = [
      HomePage(user: userAuth, signOut: signOut),
      LibraryPage(playlists: profile.playlists),
      PlaylistList(playlists: profile.playlists)
      // PlaylistListItem(name: "songname")
      // PlaylistPage(playlists: user.snapshots().
      // .then((doc) => doc['playlists']),)
  ];
  }
  

  // Methods
  // UI Methods
  void _navigateBottomBar(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Auth Methods
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Profile Methods
  Object getUserProfile(DocumentReference userReference) async {
    DocumentSnapshot user = await userReference.get();
    print(user.data());
    return user.data();
  }

  void removePlaylistFromUser({required playlistId}) async {

  }


  // Playlist Methods
  void createNewPlaylist({required String name, required String ownerId}) async {
    // Get reference to Playlists
    DocumentReference playlistDoc = FirebaseFirestore.instance.collection('Playlists').doc(); //auto-generate new _id
    Playlist newPlaylist = Playlist(
      id: playlistDoc.id,
      name: name,
      ownerId: ownerId,
      songs: [],
      collaboratorIds: [ownerId]
    );
    // Convert to json and insert into Playlists collection
    final playlistJson = newPlaylist.toJson();
    await playlistDoc.set(playlistJson);

    // Add playlist to Users playlist array 
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(ownerId);
    userDoc.update({'playlists': FieldValue.arrayUnion([ownerId])});
  }

  void deletePlaylist({required String playlistId}) async {
    // Completely delete playlist from playlist collection
    DocumentReference playlistDoc = FirebaseFirestore.instance.collection('Playlists').doc(playlistId);
    playlistDoc.delete();
  }

  void editPlaylist({required String playlistId, required List<Song> newSongs}) async {
    DocumentReference playlistDoc = FirebaseFirestore.instance.collection("Playlists").doc(playlistId);
    playlistDoc.update({"songs": newSongs}); // replace old songs list with newSongs
  }


  // Friend Methods
  void sendFriendFriendRequest({required String userId, required String recipientId}) async {
    // Check recipient is not already a friend
    DocumentReference userDoc = FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference recipientDoc = FirebaseFirestore.instance.collection("Users").doc(recipientId);
    DocumentSnapshot profile = await userDoc.get(); // User profile 
    
    if (profile["friends"].contains(recipientId)) {
      print("They are already your friend");
    } else {
      recipientDoc.update({"friendRequestIds": FieldValue.arrayUnion([recipientId])});
    }
  }
  void acceptFriendRequest({required String userId, required String friendId}) async {
    // accept from friend requests list
    DocumentReference userDoc = FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference friendDoc = FirebaseFirestore.instance.collection("Users").doc(friendId);

    userDoc.update({"friends": FieldValue.arrayUnion([friendId])});
    friendDoc.update({"friends": FieldValue.arrayUnion([userId])});
  }
  void removeFriend({required String user1Id, required String user2Id}) async {
    // Remove 'friend' from both Users
    // Add permission for another user to update friends array of another user if they are contained in it 
    DocumentReference user1Doc = FirebaseFirestore.instance.collection("Users").doc(user1Id);
    DocumentReference user2Doc = FirebaseFirestore.instance.collection("Users").doc(user2Id); 

    user1Doc.update({"friends": FieldValue.arrayRemove([user2Id])}); // remove user2's Id from User 1's document
    user2Doc.update({"friends": FieldValue.arrayRemove([user1Id])}); // remove user1's Id from User 2's document
  }


  // Song Methods
  


  // UI 
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
      body: _bottomNavPages[_selectedIndex]
    );
  }
}