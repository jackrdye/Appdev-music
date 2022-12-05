import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/friendsList.dart';

class FriendsPage extends StatefulWidget {
  List<Friend> friends;
  List<Friend> friendRequests;
  FriendsPage({super.key, required this.friends, required this.friendRequests});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  
  late TextEditingController _friendNameController;
  late List<Friend> friends;
  late List<Friend> friendRequests;
  @override
  void initState() {
    super.initState();
    friends = widget.friends;
    friendRequests = widget.friendRequests;
    _friendNameController = TextEditingController();
  }

  // Friend Methods
  void sendFriendFriendRequest({required String userId, required String recipientUsernameOrEmail}) async {
    var recipientId = null;
    final queryRecipientUsernameSnapshot = await FirebaseFirestore.instance.collection("Users").where("username", isEqualTo: recipientUsernameOrEmail).limit(1).get();
    for (DocumentSnapshot document in queryRecipientUsernameSnapshot.docs) {
      print(document.data());
      recipientId = document.id;
    }
    final queryRecipientEmailSnapshot = await FirebaseFirestore.instance.collection("Users").where("email", isEqualTo: recipientUsernameOrEmail).limit(1).get();
    for (DocumentSnapshot document in queryRecipientEmailSnapshot.docs) {
      print(document.data());
      recipientId = document.id;
    }
    if (recipientId != null) {
      // Check recipient is not already a friend
      DocumentReference userDoc = FirebaseFirestore.instance.collection("Users").doc(userId);
      DocumentReference recipientDoc = FirebaseFirestore.instance.collection("Users").doc(recipientId);
      DocumentSnapshot profile = await userDoc.get(); // User profile 

      if (profile["friends"].contains(recipientId)) {
        print("They are already your friend");
      } else {
        print("Sending request");
        recipientDoc.update({"friendRequestIds": FieldValue.arrayUnion([userId])});
      }
    }
  }

  void acceptFriendRequest({required String userId, required Friend friendRequest}) async {
    String friendId = friendRequest.id;
    // accept from friend requests list
    DocumentReference userDoc = FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference friendDoc = FirebaseFirestore.instance.collection("Users").doc(friendId);
    DocumentSnapshot snap = await userDoc.get();
    String username = snap.get("username");
    

    userDoc.update({"friends": FieldValue.arrayUnion([friendRequest.toJson()]), "friendRequests": FieldValue.arrayRemove([friendRequest.toJson()])});
    friendDoc.update({"friends": FieldValue.arrayUnion([{"id": userId, "name": username}])});
    setState(() {
      friends.add(friendRequest);
      friendRequests.removeWhere((element) => element.id == friendRequest.id);
    });
  }

  void rejectFriendRequest({required String userId, required Friend friendRequest}) async {
    String friendId = friendRequest.id;
    // accept from friend requests list
    DocumentReference userDoc = FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference friendDoc = FirebaseFirestore.instance.collection("Users").doc(friendId);

    userDoc.update({"friendRequests": FieldValue.arrayRemove([friendRequest.toJson()])});
    // friendDoc.update({"friendRequests": FieldValue.arrayRemove([])});
    setState(() {
      friendRequests.removeWhere((element) => element.id == friendRequest.id);
    });
  }

  void removeFriend({required String user1Id, required String user2Id}) async {
    // Remove 'friend' from both Users
    // Add permission for another user to update friends array of another user if they are contained in it 
    DocumentReference user1Doc = FirebaseFirestore.instance.collection("Users").doc(user1Id);
    DocumentReference user2Doc = FirebaseFirestore.instance.collection("Users").doc(user2Id); 

    user1Doc.update({"friends": FieldValue.arrayRemove([user2Id])}); // remove user2's Id from User 1's document
    user2Doc.update({"friends": FieldValue.arrayRemove([user1Id])}); // remove user1's Id from User 2's document
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
                    openSendFriendRequest(context);
                    
                  },
                  child: Icon(Icons.add)
                )
              ],
            ),
          ),
          Expanded(
            child: FriendsList(friends: friends, friendRequests: friendRequests, acceptFriendRequest: acceptFriendRequest, rejectFriendRequest: rejectFriendRequest,)
          ),
        ],
      ),
    );
  }

  Future openSendFriendRequest(context) => showDialog(
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
            sendFriendFriendRequest(userId: FirebaseAuth.instance.currentUser!.uid, recipientUsernameOrEmail: _friendNameController.text);
            Navigator.of(context).pop();
          }, 
          child: Text("Send")
        )
      ],
    )
  );
}