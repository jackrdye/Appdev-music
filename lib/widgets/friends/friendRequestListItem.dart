import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/displayFriendContent.dart';
import 'package:music_app/widgets/playlists/displayPlaylistContent.dart';

class FriendRequestListItem extends StatelessWidget {
  Friend friendRequest;
  Function rejectFriendRequest;
  Function acceptFriendRequest;

  FriendRequestListItem({super.key, required this.friendRequest, required this.rejectFriendRequest, required this.acceptFriendRequest});


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(right: 25, left: 20),
          title: Text(friendRequest.name, style: TextStyle(fontSize: 28),),
          trailing: Wrap(
            spacing: 18,
            children: [
              InkWell(
                onTap: (() {
                  acceptFriendRequest(userId: FirebaseAuth.instance.currentUser!.uid, friendRequest: friendRequest);
                }),
                child: Icon(Icons.add, size: 30,),
              ),
              InkWell(
                onTap: (() {
                  rejectFriendRequest(userId: FirebaseAuth.instance.currentUser!.uid, friendRequest: friendRequest);
                }),
                child: Icon(Icons.cancel_outlined, size: 30,),
              )
            ],
          ),
        ),
        Divider(color: Colors.grey[400],)
      ],
    );
  }
}