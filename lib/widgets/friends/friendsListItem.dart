import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/displayFriendContent.dart';
import 'package:music_app/widgets/playlists/displayPlaylistContent.dart';

class FriendsListItem extends StatelessWidget {
  Friend friend;
  FriendsListItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayFriendContent(friend: friend,)),
            );
          },
          
          child: ListTile(
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
            title: Text(friend.name, style: TextStyle(fontSize: 28),)
          ),
        ),
        Divider(color: Colors.grey[400],)
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