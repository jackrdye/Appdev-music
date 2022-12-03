import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';
import 'package:music_app/widgets/playlists/playlistListItem.dart';


class PlaylistList extends StatelessWidget {
  List<Playlist> playlists;
  PlaylistList({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        itemCount: playlists.length,
        itemBuilder: ((context, index) {
          return PlaylistListItem(playlist: playlists[index]);
        })
      ),
    );
  }
}