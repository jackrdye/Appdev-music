import 'package:flutter/cupertino.dart';
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
      child: ListView.builder(
        itemCount: playlistsInfo.length,
        itemBuilder: ((context, index) {
          return PlaylistListItem(playlistInfo: playlistsInfo[index]);
        })
      ),
    );
  }
}