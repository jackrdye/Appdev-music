import 'package:http/http.dart' as http;
import 'dart:convert';

class Playlist {
  String id;
  String name;
  String ownerId;
  List<Song> songs;
  List<String> collaboratorIds;

  Playlist({required this.id, required this.name, required this.ownerId, required this.songs, required this.collaboratorIds});

  // Convert Model to json for database
  Map<String, dynamic> toJson() => {
    // 'id': id, do not include id in document as it is already the unique identifier 
    'name': name,
    'ownerId': ownerId,
    'songs': songs,
    'collaboratorIds': collaboratorIds,
  };
}

class Friend {
  String id;
  String name;
  
  Friend({required this.id, required this.name});
}

class Song {
  String id;
  String name;
  String artist;
  String imageLink;
  String spotifyLink;
  String appleMusicLink;
  String youtubeMusicLink;

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
  List<Playlist> playlists;
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