import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/services/spotifyService.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayPlaylistContent extends StatefulWidget {
  PlaylistInfo playlistInfo;

  DisplayPlaylistContent({super.key, required this.playlistInfo});

  @override
  State<DisplayPlaylistContent> createState() => _DisplayPlaylistContentState();
}

class _DisplayPlaylistContentState extends State<DisplayPlaylistContent> {
  
  late PlaylistInfo playlistInfo;
  late TextEditingController controller;
  SpotifyService spotify = SpotifyService();

  @override
  void initState() {
    super.initState();
    playlistInfo = widget.playlistInfo;
    print(playlistInfo.id);
    controller = TextEditingController();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getPlaylistSongs() async {

  }

  void addSongToPlaylist({required dynamic data, required String playlistId}) async {

    DocumentReference songDoc = FirebaseFirestore.instance.collection('Songs').doc();
    Song newSong = Song.fromScrapedJSON(data, songDoc.id);
    final songJson = newSong.toJson();
    await songDoc.set(songJson);

    DocumentReference playlistDoc = FirebaseFirestore.instance.collection('Playlists').doc(playlistId);
    await playlistDoc.update({'songsInfo': FieldValue.arrayUnion([songJson])});
  }

  // void addSongToPlaylist(String name) async {
  //   QuerySnapshot songDoc = await FirebaseFirestore.instance.collection('Songs').where('name', isEqualTo: 1).get(); //auto-generate new _id
    
  //   // Convert to json and insert into Playlists collection
  //   final playlistJson = newPlaylist.toJson();
  //   await playlistDoc.set(playlistJson);

  //   // Add playlist to Users playlist array 
  //   DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(ownerId);
  //   userDoc.update({'playlists': FieldValue.arrayUnion([{"id": playlistDoc.id, "name": name}])});
  //   setState(() {
  //     playlistsInfo.add(PlaylistInfo(id: playlistDoc.id, name: name));
  //   });

  // }
  
  Future<Song> fetchSongByID(String songId) async {
    DocumentSnapshot song = await FirebaseFirestore.instance.collection("Songs").doc(songId).get();
    Song newSong = Song.fromJSON(song.data());
    return newSong;
  }

  // void fetchSongData(String songId) async {
  //   DocumentSnapshot song = await FirebaseFirestore.instance.collection("Songs").doc(songId).get();
  //   print(song.data());
  //   // Start some action play song etc.....

  //   // return song.data();
  // }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Playlists").doc(playlistInfo.id).snapshots(),
      builder: ((context, snapshot) {
        // print(playlistInfo.id);
        // print(snapshot.hasData);
        // print(snapshot.connectionState);
        // print(snapshot.data);
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Text("Loading");
        } else {
          if(!snapshot.data!.exists) {
            return Text("Doesn't Exist");
          }
          // final playlist = snapshot.data;
          // print(snapshot.data);
          // print(snapshot.data?.data());
          var playlistDoc = snapshot.data!.data()!;
          print('playlistDoc');
          print(playlistDoc);
          Playlist playlist = Playlist(
            id: playlistInfo.id, 
            name: playlistDoc['name'], 
            ownerId: playlistDoc['ownerId'], 
            songsInfo: List<Song>.from(playlistDoc['songsInfo']!.map((songsInfoJson) => Song.fromJSON(songsInfoJson)).toList()),
            collaboratorIds: List<String>.from(playlistDoc['collaboratorIds'].toList())
          );


          return Material(
            child: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width, 
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.grey[300]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(playlist.name, style: TextStyle(fontSize: 24),),
                          InkWell(
                              onTap: () {
                                print("add");
                                openTextField(context);
                                // Enable editing
                                // Add

                                // Delete
                              },
                              child: Icon(Icons.add)
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     print("edit");
                          //     // Enable editing
                          //     // Add
                          //
                          //     // Delete
                          //   },
                          //   child: Icon(Icons.edit)
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: playlist.songsInfo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              if( await canLaunchUrl(Uri.parse(playlist.songsInfo[index].spotifyLink))) {
                                await launchUrl(
                                  Uri.parse(playlist.songsInfo[index].spotifyLink),
                                );
                              }
                            },
                            child: Column (
                                    children: [
                                      ListTile(
                                        leading: Image.network (
                                          playlist.songsInfo[index].imageLink,
                                    height: 50,
                                    width: 50,
                                  ),
                                  trailing: InkWell(
                                          onTap: (() {
                                            // Play song
                                            print("play ${playlist.songsInfo[index].name}");
                                          // fetchSongData(playlist.songsInfo[index].id);

                                    }),
                                    child: Icon(Icons.play_circle)
                                  ),
                                  // style: TextStyle(color: Colors.green, fontSize: 15),
                                  title: Text(playlist.songsInfo[index].name,
                                    style: TextStyle(fontSize: 16)),
                                  subtitle: Text(playlist.songsInfo[index].artist),
                                ),
                                Divider(height: 2, thickness: 1, color: Colors.grey[400],)
                              ],
                            )
                          );
                        }
                      ),
                    ),
                  ]
                )
              )
            )
          );
        }
        return Text("Enndd");
      })
    
    );
  }

  Future openTextField(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Search for Track"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Enter track name"),
        controller: controller,
      ),
      actions: [
        TextButton(
            onPressed: () async {
              dynamic result = await spotify.fetchSong(controller.text);
              addSongToPlaylist(data: result, playlistId: playlistInfo.id);
              Navigator.of(context).pop();
            },
            child: Text("Add Song to Playlist")
        )
      ],
    )
  );

  // Future openTextField(context) => showDialog(
  //   context: context, 
  //   builder: (context) => AlertDialog(
  //     title: Text("Playlist Name"),
  //     content: TextField(
  //       autofocus: true,
  //       decoration: InputDecoration(hintText: "Enter the new playlist's name"),
  //       controller: controller,
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           createNewPlaylist(name: controller.text, ownerId: FirebaseAuth.instance.currentUser!.uid);
  //           Navigator.of(context).pop();
  //         }, 
  //         child: Text("Create")
  //       )
  //     ],
  //   )
  // );
}