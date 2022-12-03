import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/friendsList.dart';


class FriendsPage extends StatelessWidget {
  List<Friend> friends;
  FriendsPage({super.key, required this.friends});

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
                Text("Friends", style: TextStyle(fontSize: 24),),
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
            child: FriendsList(friends: friends)
          ),
        ],
      ),
    );
  }
}