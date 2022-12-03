import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/friends/friendsListItem.dart';

class FriendsList extends StatelessWidget {
  List<Friend> friends;
  FriendsList({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: friends.length,
        itemBuilder: ((context, index) {
          return FriendsListItem(friend: friends[index]);
        })
      ),
    );
  }
}