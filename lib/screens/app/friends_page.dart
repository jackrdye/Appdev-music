import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/friendsList.dart';

class FriendsPage extends StatefulWidget {
  List<Friend> friends;
  FriendsPage({super.key, required this.friends});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  
  late TextEditingController _friendNameController;
  late List<Friend> friends;
  @override
  void initState() {
    super.initState();
    friends = widget.friends;
    _friendNameController = TextEditingController();
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
                Text("Friends", style: TextStyle(fontSize: 24),),
                InkWell(
                  onTap: () {
                    print("Add friend");
                    openFriendRequest(context);
                    
                  },
                  child: Icon(Icons.add)
                )
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

  Future openFriendRequest(context) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text("Send Friend Request"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Enter the friends username or email"),
        controller: _friendNameController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Send friend request 

            Navigator.of(context).pop();
          }, 
          child: Text("Send")
        )
      ],
    )
  );
}