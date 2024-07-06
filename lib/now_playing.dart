import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart'; // Sesuaikan dengan path provider Anda
import 'movie.dart'; // Sesuaikan dengan path model Anda
import 'movie_detail.dart'; // Sesuaikan dengan path layar detail film Anda

class NowPlayingMoviesScreen extends StatefulWidget {
  @override
  _NowPlayingMoviesScreenState createState() => _NowPlayingMoviesScreenState();
}

class _NowPlayingMoviesScreenState extends State<NowPlayingMoviesScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
  }

  Future<void> _fetchNowPlayingMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<MovieProvider>(context, listen: false).fetchNowPlayingMovies();
    } catch (error) {
      // Handle error
      print('Error fetching now playing movies: $error');
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
    final nowPlayingMovies = movieProvider.nowPlayingMovies;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nowPlayingMovies.length,
            itemBuilder: (ctx, index) {
              final movie = nowPlayingMovies[index];
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
