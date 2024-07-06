import 'package:flutter/material.dart';
import 'movie.dart'; // Sesuaikan dengan path model Anda

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

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
              onPressed: () {},
              icon: Icon(Icons.event, color: Colors.black), // Icon tiket
              label: Text('Booking', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Warna kuning
              ),
            ),
          ],
        ),
      ),
    );
  }
}
