import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/friendRequestListItem.dart';
import 'package:music_app/widgets/friends/friendsListItem.dart';

class FriendsList extends StatelessWidget {
  List<Friend> friends;
  List<Friend> friendRequests;
  Function acceptFriendRequest;
  Function rejectFriendRequest;
  FriendsList({super.key, required this.friends, required this.friendRequests, required this.acceptFriendRequest, required this.rejectFriendRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: ((context, index) {
                return FriendsListItem(friend: friends[index]);
              })
            ),
          ),
          SizedBox(height: 0,),
          Container(
            width: MediaQuery.of(context).size.width, 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Friend Requests", style: TextStyle(fontSize: 24),),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friendRequests.length,
              itemBuilder: ((context, index) {
                return FriendRequestListItem(friendRequest: friendRequests[index], acceptFriendRequest: acceptFriendRequest, rejectFriendRequest: rejectFriendRequest,);
              })
            ),
          )
        ],
      ),
    );
  }
}