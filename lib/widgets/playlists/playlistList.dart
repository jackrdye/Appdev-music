import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/playlists/playlistListItem.dart';


class PlaylistList extends StatelessWidget {
  List<PlaylistInfo> playlistsInfo;
  PlaylistList({super.key, required this.playlistsInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: playlistsInfo.length,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        itemBuilder: ((context, index) {
          return PlaylistListItem(playlistInfo: playlistsInfo[index]);
        })
      ),
    );
  }
}