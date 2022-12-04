import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  String id;
  String name;
  String ownerId;
  List<Song> songs;
  List<String> collaboratorIds;

  Playlist({required this.id, required this.name, required this.ownerId, required this.songs, required this.collaboratorIds});

  // void getSongIds() =>  {
  //   var songIds = songs.map((song) => song.id).toList();
  //   // var ids = songIds.toList();
  //   // return ids;
  // };

  // Convert Model to json for database
  Map<String, dynamic> toJson() => {
    // 'id': id, do not include id in document as it is already the unique identifier 
    'name': name,
    'ownerId': ownerId,
    'songs': songs.map((song) => song.id).toList(), // convert Song models to just each song id for database
    'collaboratorIds': collaboratorIds,
  };
  
  

}

class Friend {
  String id;
  String name;
  
  Friend({required this.id, required this.name});

  // static List<Friend> JSONtoFriend(List<dynamic> friends) async {
  //   // Converts list stored in firestore into a list of friend objects
  //   friends.map((friendId) => {
  //     DocumentReference friendDoc = await FirebaseFirestore.instance.collection("Users").doc(friendId).get()
  //     return 
  //   });

  //   return 
  // }
}

class Song {
  String id;
  String name;
  String spotifyLink;
  String appleMusicLink;
  String youtubeMusicLink;

  Song({required this.id, required this.name, this.spotifyLink="", this.appleMusicLink="", this.youtubeMusicLink=""});

  Map<String, dynamic> toJson() => {
    'name': name, 
    'spotifyLink': spotifyLink, 
    'appleMusicLink': appleMusicLink, 
    'youtubeMusicLink': youtubeMusicLink, 
    
  };
}

class Profile {
  String id;
  String email;
  String username;
  String musicService;
  List<Friend> friends;
  List<Friend> friendRequests;
  List<PlaylistInfo> playlists;
  List sharedWithMe;

  Profile({required this.id, required this.email, required this.username, required this.musicService, required this.friends, required this.friendRequests, required this.playlists, required this.sharedWithMe});

  Map<String, dynamic> toJson() => {
    // 'id': id, do not include id in document as it is already the unique identifier 
    'email': email,
    'username': username,
    'musicService': musicService,
    'friends': friends,
    'playlists': playlists,
    'sharedWithMe': sharedWithMe,
  };

}
class PlaylistInfo {
  String id;
  String name;

  PlaylistInfo({required this.id, required this.name});
}