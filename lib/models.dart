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
  String spotifyLink;
  String appleMusicLink;
  String youtubeMusicLink;

  Song({required this.id, required this.name, this.spotifyLink="", this.appleMusicLink="", this.youtubeMusicLink=""});
}

class Profile {
  String id;
  String email;
  String username;
  String musicService;
  List<Friend> friends;
  List<Playlist> playlists;
  List sharedWithMe;

  Profile({required this.id, required this.email, required this.username, required this.musicService, required this.friends, required this.playlists, required this.sharedWithMe});

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