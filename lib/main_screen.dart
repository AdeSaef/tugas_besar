import 'package:flutter/material.dart';
import 'popular_movie.dart';
import 'now_playing.dart';
import 'booking.dart';
import 'profile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    PopularMoviesScreen(),
    NowPlayingScreen(),
    TicketBookingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
