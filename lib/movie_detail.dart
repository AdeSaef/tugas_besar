import 'package:flutter/material.dart';
import 'movie.dart'; 
import 'profile/profile_manager.dart'; 
import 'profile/user_profile.dart';
import 'booking/booking.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final UserProfile userProfile;

  MovieDetailScreen({required this.movie, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(movie.posterPath),
            SizedBox(height: 16.0),
            Text('Deskripsi: ${movie.overview}'),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  
                  print('User Name: ${userProfile.name}');
                  print('User Email: ${userProfile.email}');
                  print('Movie Title: ${movie.title}');
                  print('Movie Poster: ${movie.posterPath}');

                  
                  Booking newBooking = Booking(
                    movieTitle: movie.title,
                    userName: userProfile.name,
                    userEmail: userProfile.email,
                    moviePoster: movie.posterPath,
                  );

                  
                  print('New Booking: ${newBooking.toJson()}');

                  await ProfileManager().saveBooking(newBooking);

                  
                  print('Booking berhasil disimpan!');

                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking berhasil disimpan!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (error) {
                  
                  print('Error saat booking: $error');
                }
              },
              icon: Icon(Icons.event, color: Colors.black), 
              label: Text('Booking', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
