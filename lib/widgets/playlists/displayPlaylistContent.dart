import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    return InkWell(
                      onTap: () async {
                        if( await canLaunchUrl(Uri.parse("https://open.spotify.com/track/6XNANAB7sFvkfho6bMCp7o"))) {
                          await launchUrl(
                            Uri.parse("https://open.spotify.com/track/6XNANAB7sFvkfho6bMCp7o"),
                          );
                        }
                      },
                      child: Column (
                        children: [
                          ListTile(
                            leading: Image.network (
                              'https://i.scdn.co/image/ab67616d0000b27360ec4df52c2d724bc53ffec5',
                              height: 50,
                              width: 50,
                            ),
                            trailing: InkWell(
                              onTap: (() {
                                // Play song
                                print("play ${playlist.songs[index].name}");

                              }),
                              child: Icon(Icons.play_circle)
                            ),
                            // style: TextStyle(color: Colors.green, fontSize: 15),
                            title: Text(playlist.songs[index].name,
                              style: TextStyle(fontSize: 16)),
                            subtitle: Text('Jaden'),
                          ),
                          Divider(height: 2, thickness: 1, color: Colors.grey[400],)
                        ],
                      )
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