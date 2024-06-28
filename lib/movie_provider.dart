import 'package:flutter/material.dart';
import 'movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [
    Movie(
      id: '1',
      title: 'Inception',
      year: '2010',
      poster: 'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
    ),
    Movie(
      id: '2',
      title: 'The Dark Knight',
      year: '2008',
      poster: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    ),
    Movie(
      id: '3',
      title: 'Interstellar',
      year: '2014',
      poster: 'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
    ),
    Movie(
      id: '4',
      title: 'Avengers: Endgame',
      year: '2019',
      poster: 'https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg',
    ),
    Movie(
      id: '5',
      title: 'Joker',
      year: '2019',
      poster: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
    ),
    Movie(
      id: '6',
      title: 'The Matrix',
      year: '1999',
      poster: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    ),
  ];

  List<Movie> get movies => _movies;

  void addMovie(Movie movie) {
    _movies.add(movie);
    notifyListeners();
  }

  void updateMovie(String id, Movie updatedMovie) {
    final index = _movies.indexWhere((movie) => movie.id == id);
    if (index != -1) {
      _movies[index] = updatedMovie;
      notifyListeners();
    }
  }

  void deleteMovie(String id) {
    _movies.removeWhere((movie) => movie.id == id);
    notifyListeners();
  }
}
