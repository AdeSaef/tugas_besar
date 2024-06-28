import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MovieListScreen(),
      ),
    );
  }
}
