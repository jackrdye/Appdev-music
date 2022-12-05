import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/screens/app/friends_page.dart';
import 'package:music_app/screens/app/home_page.dart';
import 'package:music_app/screens/app/library_page.dart';
import 'package:music_app/screens/app/profile_page.dart';
import 'package:music_app/screens/auth/login_page.dart';
import 'package:music_app/widgets/playlists/playlistList.dart';
import '../../models.dart'; // Import Playlist, Friend, Song, Profile

class App extends StatefulWidget {
  // DocumentSnapshot<Object?>? userDocument;
  const App({super.key}); 

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  // State
  final userAuth = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  

  late List<Widget> _bottomNavPages = [];
  late DocumentReference userRef;
  late Profile profile;
  // late List<Song> songs;
  // late List<Playlist> playlists;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(userAuth.uid);
    // userRef = FirebaseFirestore.instance.collection("Users").doc(userAuth.uid);
    // profilee = getUserProfile(userRef);
    // print(profilee);
    // print(widget.userDocument!.data());

    // Object profileObject = getUserProfile(userRef);
    // print(profileObject);
    // Profile profile = Profile(
    //   email: profileObject['email'], 
    //   username: profileObject['username'], 
    //   musicService: profileObject['musicService'], 
    //   friends: profileObject['friends'], 
    //   friendRequests: profileObject['friendRequests'], 
    //   playlists: profileObject['playlists'], 
    //   sharedWithMe: profileObject['sharedWithMe']
    // )
    
    // songs = [Song(id: "songid1", name: "songname1"), Song(id: "songid2", name: "songname2"), 
    //   Song(id: "songid3", name: "songname3"), Song(id: "songid4", name: "songname4")];
    // for (var element in songs) {
    //   DocumentReference songDoc = FirebaseFirestore.instance.collection("Songs").doc();
    //   print(element.toJson());
    //   songDoc.set(element.toJson());
    // }
    
    // playlists = [Playlist(id: "playlistid1", name: "playlist1", ownerId: "ownerid1", songs: songs, collaboratorIds: [userAuth.uid]),
    //   Playlist(id: "playlistid2", name: "playlist2", ownerId: "ownerid2", songs: songs, collaboratorIds: [userAuth.uid]),
    //   Playlist(id: "playlistid3", name: "playlist3", ownerId: "ownerid3", songs: songs.sublist(0, 1), collaboratorIds: [userAuth.uid])];
    
    // for (var element in playlists) {
    //   DocumentReference playlistDoc = FirebaseFirestore.instance.collection("Playlists").doc();
    //   print(element.toJson());
    //   playlistDoc.set(element.toJson());
    // }

    profile = Profile(id: userAuth.uid, email: userAuth.email!, username: userAuth.email!, musicService: "appleMusic", friends: [Friend(id: "hi", name: "Dhruv")], friendRequests: [], playlists: [], sharedWithMe: []);
    // userDoc.set(profile.toJson());
    // print(profile.playlists);
    _bottomNavPages = [
      // HomePage(user: userAuth, signOut: signOut),
      LibraryPage(playlistsInfo: profile.playlists),
      FriendsPage(friends: profile.friends,),
      ProfilePage(profile: profile,),
      ProfilePage(profile: profile,)
      // PlaylistListItem(name: "songname")
      // PlaylistPage(playlists: user.snapshots().
      // .then((doc) => doc['playlists']),)
    ];
  }
  // State handlers
  void updateBottomNavPages() {
    _bottomNavPages = [
      // HomePage(user: userAuth, signOut: signOut),
      LibraryPage(playlistsInfo: profile.playlists),
      FriendsPage(friends: List<Friend>.from(profile.friends.map((friend) => Friend.fromJson(friend))) ),
      ProfilePage(profile: profile,),
      ProfilePage(profile: profile,)
    ];
  }

  // Call to lazily load friends and playlists data
  // void loadPlaylistsAndFriends(List<String> friendIds, List<String> playlistIds) async {
  //   List<Future<DocumentSnapshot>> friendFutures = [];
  //   List<Future<DocumentSnapshot>> playlistFutures = [];
  //   for (String id in friendIds) {
  //     friendFutures.add(FirebaseFirestore.instance.collection("Users").doc(id).get());
  //   }
  //   for (String id in playlistIds) {
  //     playlistFutures.add(FirebaseFirestore.instance.collection("Playlist").doc(id).get());
  //   }

  //   await Future.wait(friendFutures);
  //   await Future.wait(playlistFutures);

  //   await Future.wait([

  //   ])

  //   profile.playlists = playlistFutures.map((playlistDoc) {
  //     playlistDoc = playlistDoc.data();
  //     return Playlist(id: playlistDoc., name: name, ownerId: ownerId, songs: songs, collaboratorIds: collaboratorIds)
  //   }).toList();

  //   List<Friend> friendsList = friendIds.map((id) async {
  //     DocumentSnapshot friend = await FirebaseFirestore.instance.collection("Users").doc(id).get();
  //     Object friendDoc = friend.data();
      
  //     Friend friend = Friend(id: id, name: friendDoc["email"]);
  //     return friend;
  //   }).toList();
  //   // List<Playlist> playlistList = playlistIds.map((id) {
  //   // });
  //   // profile.friends = 
  //   loaded = true;
    
  // }

  // List<DocumentSnapshot> loadPlaylists(List<String> playlistIds) async {
  //   List<Playlist> playlists1 = [];
  //   List<DocumentSnapshot> playlistSnapshots = [];
  //   List<Future<DocumentSnapshot>> playlistSnapshotsFutures = [];
  //   for (String playlistId in playlistIds) {
  //     print(playlistId);
  //     playlistSnapshotsFutures.add(FirebaseFirestore.instance.collection("Playlist").doc(playlistId).get());
  //   }
  //   await Future.wait(playlistSnapshotsFutures).then((List<DocumentSnapshot> playlistSnapshotss) {
  //     playlistSnapshots = playlistSnapshotss;
  //     print(playlistSnapshots);
  //     print(playlistSnapshots[0]);

  //     return playlistSnapshots;
  //   });
  //   return playlistSnapshots;
  // }



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
  Object getUserProfile(DocumentReference userRef) async {
    DocumentSnapshot user = await userRef.get();
    print(user.data());
    return user.data();
  }

  void removePlaylistFromUser({required playlistId}) async {

  }


  // Playlist Methods

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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").doc(userAuth.uid).snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        // FirebaseFirestore.instance.collection("Users").doc(userAuth.uid).update({"friendRequests": [], "playlists": [{"name": "Jack", "id": "IAcNMC58mDl2KK6yEHyB"}, {"name": "Create", "id": "6ExQC36AVKkYSL6mIET2"}], "musicService": "Spotify", "email": "jackdye2002@gmail.com", "friends": [], "sharedWithMe": [], "username": "jack"});
        var userDoc = snapshot.data!.data()!;
        print(userDoc);
        // loadPlaylists(List<String>.from(userDoc['playlists'] as List));
        print(userDoc["friends"]);
        for (var friend in userDoc["friends"]) {
          print(friend);
          print(friend["id"].runtimeType);
        }
        for (var playlist in userDoc["playlists"]) {
          print(playlist);
          print(playlist["id"].runtimeType);
        }

        profile = Profile(
          id: userAuth.uid, 
          email: userDoc['email']!, 
          username: userDoc['username']!, 
          musicService: userDoc['musicService']!, 
          friends: List<Friend>.from(userDoc['friends']!.map((friendJson) => Friend.fromJson(friendJson)).toList()), //[{id: , name: }]
          friendRequests: List<Friend>.from(userDoc['friendRequests']!.map((friendJson) => Friend.fromJson(friendJson)).toList()), 
          playlists: List<PlaylistInfo>.from(userDoc['playlists']!.map((playlistJson) => PlaylistInfo.fromJson(playlistJson)).toList()), //[{id: , name: }]
          sharedWithMe: userDoc['sharedWithMe']!
        );
        // loadPlaylistsAndFriends();
        updateBottomNavPages();


        return Scaffold(
          appBar: AppBar(
              toolbarHeight: 100,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.username != null ? profile.username : profile.email}\'s Sync',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Email: ${profile.email}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5)
                    ),
                    child: Text(
                      "SYNC",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              // title: Text('Sync'),
              // title: Text("Sync"),
              // actions: [IconButton(onPressed: (){
              //   setState(() {
              //     _selectedIndex = 2;
              //   });
              // }, icon: Icon(Icons.person, size: 28))],
            ),
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
                  iconSize: 26,
                  tabs: const [
                    GButton(
                      icon: Icons.library_music_outlined, 
                      text: "Library",
                      ),
                    GButton(
                      icon: Icons.people_alt, 
                    text: "Friends",
                    ),
                    GButton(
                      icon: Icons.settings, 
                      text: "Settings",
                    ),
                  ]
                ),
              ),
            ),
          ),
          body: _bottomNavPages[_selectedIndex]
        );
      })
    );
  }
}