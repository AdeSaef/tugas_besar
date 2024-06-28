import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie_form_screen.dart';
import 'movie.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieFormScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.movies[index];
              return ListTile(
                leading: Image.network(movie.poster),
                title: Text(movie.title),
                subtitle: Text(movie.year),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieFormScreen(movie: movie),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<MovieProvider>(context, listen: false)
                            .deleteMovie(movie.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
