// popular_movie.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie_detail.dart';
import 'profile/profile_manager.dart';
import 'profile/user_profile.dart';

class PopularMoviesScreen extends StatefulWidget {
  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  bool _isLoading = false;
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
    _loadUserProfile();
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

  Future<void> _loadUserProfile() async {
    userProfile = await ProfileManager().loadProfile() ?? UserProfile(name: '', email: '');
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
                      builder: (context) => MovieDetailScreen(movie: movie, userProfile: userProfile),
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
