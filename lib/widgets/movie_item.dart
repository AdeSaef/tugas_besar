// lib/widgets/movie_item.dart
import 'package:flutter/material.dart';
import '../movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(movie.poster, width: 50, fit: BoxFit.cover),
      title: Text(movie.title),
      subtitle: Text(movie.year),
    );
  }
}
