import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/playlists/playlistList.dart';


class LibraryPage extends StatelessWidget {
  List<Playlist> playlists;
  LibraryPage({super.key, required this.playlists});

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
                // InkWell(
                //   onTap: () {
                //     print("edit");
                //     // Enable editing
                //     // Add
                //     // Delete
                //   },
                //   child: Icon(Icons.edit)
                // )
              ],
            ),
          ),
          Expanded(
            child: PlaylistList(playlists: playlists)
          ),
        ],
      ),
    );
  }
}