import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/playlists/displayPlaylistContent.dart';
import 'dart:math' as math;

class PlaylistListItem extends StatelessWidget {
  PlaylistInfo playlistInfo;
  PlaylistListItem({super.key, required this.playlistInfo});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayPlaylistContent(playlistInfo: playlistInfo,)),
            );
          },
          
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.75),
              ),
              child: Center(
                  child: Text(
                      playlistInfo.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 24)),
              ),
            ),
            // leading: const Icon(Icons.list),
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(width: 2, color: Colors.black38),
            //   borderRadius: BorderRadius.circular(0),
            // ),
            // trailing: InkWell(
            //   onTap: (() {
            //     // Play song
            //     print("play ${playlist.name}");
            //   }),
            //   child: Icon(Icons.play_circle)
            // ),
            title: Text(playlistInfo.name, style: TextStyle(fontSize: 20),),
            trailing: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Icon(
                  Icons.shuffle_rounded,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        Divider(height: 15, thickness: 1, color: Colors.grey[400],)
      ],
    );
    // Center(
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => DisplayPlaylistContent(playlist: playlist,)),
    //       );
    //       // Display playlist contents/details 
    //     },
    //     child: Container(
    //       width: MediaQuery.of(context).size.width, 
    //       decoration: BoxDecoration(
    //         color: Colors.white54,
    //         border: Border.symmetric(horizontal: BorderSide(color: Colors.black54) ,),
    //         // borderRadius: BorderRadius.all(Radius.circular(8)),
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 15, vertical:15),
    //         child: Text(playlist.name, style: TextStyle(fontSize: 28),),
    //       ),
    //     ),
    //   ),
    // );

  }
}