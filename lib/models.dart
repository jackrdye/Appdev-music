import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Playlist {
  String id;
  String name;
  String ownerId;
  List<SongInfo> songsInfo;
  List<String> collaboratorIds;

  Playlist({required this.id, required this.name, required this.ownerId, required this.songsInfo, required this.collaboratorIds});

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
    'songsInfo': songsInfo.map((song) => {'id': song.id, 'name': song.name, 'imgLink': song.imgLink}).toList(), // convert Song models to just each song id for database
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
  factory Friend.fromJson(dynamic json) {
    return Friend(id: json['id'] as String, name: json['name'] as String);
  }
}

class Song {
  String id;
  String name;
  String artist;
  String imageLink;
  String spotifyLink;
  String appleMusicLink;
  String youtubeMusicLink;

  // Song({required this.id, required this.name, this.spotifyLink="", this.appleMusicLink="", this.youtubeMusicLink=""});

  Map<String, dynamic> toJson() => {
    'name': name, 
    'spotifyLink': spotifyLink, 
    'appleMusicLink': appleMusicLink, 
    'youtubeMusicLink': youtubeMusicLink, 
    
  };
  Song({required this.id, required this.name, this.artist="", this.imageLink="", this.spotifyLink="", this.appleMusicLink="", this.youtubeMusicLink=""});

  factory Song.fromJSON(Map<String, dynamic> json) {
    return Song(
      id: "1",
      name: json['name'],
      spotifyLink: json['external_urls']['spotify'],
      artist: json['artists'][0]['name'],
      imageLink: json['album']['images'][0]['url'],
    );
  }
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
    'friendRequests': friendRequests,
    'friends': friends,
    'playlistsInfo': playlists,
    'sharedWithMe': sharedWithMe,
  };

  Future spotifyAccess() async {
    String clientID = 'd8f3a9af98514ded9e50c366ed7a50db';
    String clientSecret = '36922a8ab95b47f8aac8659cd7190b64';
    String auth_url = 'https://accounts.spotify.com/api/token';

    dynamic response = await http.post(
      Uri.parse(auth_url),
      body: <String, String> {
        'grant_type': 'client_credentials',
        'client_id': clientID,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      dynamic result = json.decode(response.body);
      final token = result['access_token'];
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      return headers;
    }
    return null;
  }

  Future fetchSong(String content) async {
    dynamic headers = spotifyAccess();
    String base_url = 'https://api.spotify.com/v1/';
    String search_url = base_url + 'search?query='+content+"&type=track&limit=1&market=HK";
    dynamic data = await http.get(
        Uri.parse(search_url),
        headers: headers,
    );
    data = json.decode(data.body);
    dynamic song_data = data['tracks']['items'][0];
    Song newSong = Song.fromJSON(song_data);
    return newSong;
  }

}
class PlaylistInfo {
  String id;
  String name;

  PlaylistInfo({required this.id, required this.name});

  factory PlaylistInfo.fromJson(dynamic json) {
    return PlaylistInfo(id: json['id'] as String, name: json['name'] as String);
  }
}


class SongInfo {
  String id;
  String name;
  String imgLink;

  SongInfo({required this.id, required this.name, this.imgLink=""});

  factory SongInfo.fromJson(dynamic json) {
    return SongInfo(id: json['id'] as String, name: json['name'] as String, imgLink:  json["imgLink"]!=null ? json["imgLink"] as String : "");
  }
  
}


