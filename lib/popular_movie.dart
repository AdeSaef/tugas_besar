import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart'; // Sesuaikan dengan path provider Anda
import 'movie.dart'; // Sesuaikan dengan path model Anda
import 'movie_detail.dart'; // Sesuaikan dengan path layar detail film Anda

class PopularMoviesScreen extends StatefulWidget {
  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
  }

  Future<void> _fetchPopularMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<MovieProvider>(context, listen: false).fetchPopularMovies();
    } catch (error) {
      // Handle error
      print('Error fetching popular movies: $error');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final popularMovies = movieProvider.popularMovies;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularMovies.length,
            itemBuilder: (ctx, index) {
              final movie = popularMovies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            movie.posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        movie.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
