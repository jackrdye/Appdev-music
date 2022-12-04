import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';

class DisplayPlaylistContent extends StatefulWidget {
  PlaylistInfo playlistInfo;

  DisplayPlaylistContent({super.key, required this.playlistInfo});

  @override
  State<DisplayPlaylistContent> createState() => _DisplayPlaylistContentState();
}

class _DisplayPlaylistContentState extends State<DisplayPlaylistContent> {
  
  late PlaylistInfo playlistInfo;
  @override
  void initState() {
    super.initState();
    playlistInfo = widget.playlistInfo;
    print(playlistInfo.id);
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

  // void fetchSongData(String songId) async {
  //   DocumentSnapshot song = await FirebaseFirestore.instance.collection("Songs").doc(songId).get();
  //   print(song.data());
  //   // Start some action play song etc.....

  //   // return song.data();
  // }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Playlists").doc(playlistInfo.id).get(),
      builder: ((context, snapshot) {
        print(playlistInfo.id);
        print(snapshot.hasData);
        print(snapshot.connectionState);
        print(snapshot.data);
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
          print(snapshot.data);
          print(snapshot.data?.data());
          var playlistDoc = snapshot.data!.data()!;
          print(playlistDoc);
          Playlist playlist = Playlist(
            id: playlistInfo.id, 
            name: playlistDoc['name'], 
            ownerId: playlistDoc['ownerId'], 
            songsInfo: List<SongInfo>.from(playlistDoc['songsInfo']!.map((songsInfoJson) => SongInfo.fromJson(songsInfoJson)).toList()), 
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
                              print("edit");
                              // Enable editing
                              // Add

                              // Delete
                            },
                            child: Icon(Icons.edit)
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: playlist.songsInfo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                trailing: InkWell(
                                  onTap: (() {
                                    // Play song
                                    print("play ${playlist.songsInfo[index].name}");
                                    // fetchSongData(playlist.songsInfo[index].id);

                                  }),
                                  child: Icon(Icons.play_circle)
                                ),
                                // style: TextStyle(color: Colors.green, fontSize: 15),
                                title: Text(playlist.songsInfo[index].name)
                              ),
                              Divider(color: Colors.grey[400],)
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
        return Text("Enndd");
      })
    
    );
  }

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