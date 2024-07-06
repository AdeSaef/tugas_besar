import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart'; // Sesuaikan dengan path provider Anda
import 'movie_detail.dart'; // Sesuaikan dengan path layar detail film Anda
import 'profile/profile_manager.dart'; // Sesuaikan dengan path ProfileManager Anda
import 'profile/user_profile.dart'; // Sesuaikan dengan path Profile Anda

class NowPlayingMoviesScreen extends StatefulWidget {
  @override
  _NowPlayingMoviesScreenState createState() => _NowPlayingMoviesScreenState();
}

class _NowPlayingMoviesScreenState extends State<NowPlayingMoviesScreen> {
  bool _isLoading = false;
  late UserProfile userProfile; // Deklarasikan userProfile

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
    _loadUserProfile(); // Memuat userProfile saat initState
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

  Future<void> _loadUserProfile() async {
    userProfile = await ProfileManager().loadProfile() ?? UserProfile(name: '', email: '');
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
