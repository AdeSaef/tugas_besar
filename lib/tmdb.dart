import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBService {
  static const _apiKey = '8ba44ff8b93ad7bb28794120061571b0';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Popular Movies Response: $jsonResponse');
      return jsonResponse['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<dynamic>> fetchNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Now Playing Movies Response: $jsonResponse');
      return jsonResponse['results'];
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }
}
