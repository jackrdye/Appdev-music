import 'package:http/http.dart' as http;
import 'dart:convert';

class SpotifyService {

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
    dynamic headers = await spotifyAccess();
    String base_url = 'https://api.spotify.com/v1/';
    String search_url = base_url + 'search?query='+content+"&type=track&limit=1&market=HK";
    dynamic data = await http.get(
      Uri.parse(search_url),
      headers: headers,
    );
    data = json.decode(data.body);
    dynamic song_data = data['tracks']['items'][0];
    // Song newSong = Song.fromJSON(song_data);
    return song_data;
  }
}