import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';

class DisplayPlaylistContent extends StatelessWidget {
  Playlist playlist;

  DisplayPlaylistContent({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
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
                  itemCount: playlist.songs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          trailing: InkWell(
                            onTap: (() {
                              // Play song
                              print("play ${playlist.songs[index].name}");

                            }),
                            child: Icon(Icons.play_circle)
                          ),
                          // style: TextStyle(color: Colors.green, fontSize: 15),
                          title: Text(playlist.songs[index].name)
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
}