import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/playlists/playlistList.dart';


class LibraryPage extends StatefulWidget {
  List<PlaylistInfo> playlistsInfo;
  LibraryPage({super.key, required this.playlistsInfo});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late TextEditingController controller;

  late List<PlaylistInfo> playlistsInfo;
  @override
  void initState() {
    super.initState();
    playlistsInfo = widget.playlistsInfo;
    controller = TextEditingController();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void createNewPlaylist({required String name, required String ownerId}) async {
    // Get reference to Playlists
    DocumentReference playlistDoc = FirebaseFirestore.instance.collection('Playlists').doc(); //auto-generate new _id
    Playlist newPlaylist = Playlist(
      id: playlistDoc.id,
      name: name,
      ownerId: ownerId,
      songsInfo: [],
      collaboratorIds: [ownerId]
    );
    // Convert to json and insert into Playlists collection
    final playlistJson = newPlaylist.toJson();
    await playlistDoc.set(playlistJson);

    // Add playlist to Users playlist array 
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(ownerId);
    userDoc.update({'playlists': FieldValue.arrayUnion([{"id": playlistDoc.id, "name": name}])});
    setState(() {
      playlistsInfo.add(PlaylistInfo(id: playlistDoc.id, name: name));
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                Text("Library", style: TextStyle(fontSize: 24),),
                InkWell(
                  onTap: () {
                    print("Library: add");
                    openTextField(context);
                    // Enable editing
                    // Add
                    // Delete
                  },
                  child: Icon(Icons.add)
                )
              ],
            ),
          ),
          Expanded(
            child: PlaylistList(playlistsInfo: playlistsInfo)
          ),
        ],
      ),
    );
  }

  Future openTextField(context) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Playlist Name"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Enter the new playlist's name"),
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            createNewPlaylist(name: controller.text, ownerId: FirebaseAuth.instance.currentUser!.uid);
            Navigator.of(context).pop();
          }, 
          child: Text("Create")
        )
      ],
    )
  );
}