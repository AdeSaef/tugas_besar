import 'package:flutter/material.dart';
import 'movie.dart';
import 'tmdb.dart';

class MovieProvider with ChangeNotifier {
  final TMDBService _tmdbService = TMDBService();
  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  Future<void> fetchPopularMovies() async {
    final results = await _tmdbService.fetchPopularMovies();
    _popularMovies = results.map((data) => Movie.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> fetchNowPlayingMovies() async {
    final results = await _tmdbService.fetchNowPlayingMovies();
    _nowPlayingMovies = results.map((data) => Movie.fromJson(data)).toList();
    notifyListeners();
  }
}
