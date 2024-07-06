import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'booking/booking.dart';
import 'dart:convert';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  Future<List<Booking>> _loadBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookings = prefs.getStringList('bookings') ?? [];
    print('Total bookings found: ${bookings.length}'); // Debug print
    return bookings.map((booking) {
      try {
        return Booking.fromJson(jsonDecode(booking));
      } catch (e) {
        print('Error decoding JSON: $e');
        return Booking(
          userName: '', // Provide default values for required parameters
          userEmail: '',
          movieTitle: '',
          moviePoster: '',
        );
      }
    }).toList();
  }

  Future<void> _deleteBooking(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookings = prefs.getStringList('bookings') ?? [];
    if (bookings.isNotEmpty && index >= 0 && index < bookings.length) {
      bookings.removeAt(index);
      await prefs.setStringList('bookings', bookings);
      setState(() {}); // Perbarui UI setelah penghapusan
    }
  }

  Future<void> _createBooking(String movieTitle, String moviePoster) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName') ?? 'Default Name';
    String? userEmail = prefs.getString('userEmail') ?? 'default@example.com';

    Booking newBooking = Booking(
      userName: userName,
      userEmail: userEmail,
      movieTitle: movieTitle,
      moviePoster: moviePoster,
    );

    List<String>? bookings = prefs.getStringList('bookings') ?? [];
    bookings.add(jsonEncode(newBooking.toJson()));
    await prefs.setStringList('bookings', bookings);
    setState(() {}); // Perbarui UI setelah penambahan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pemesanan'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: _loadBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading bookings: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found.'));
          } else {
            // Debug print untuk menampilkan data yang berhasil dimuat
            print('Bookings loaded successfully: ${snapshot.data}');

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Booking booking = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      booking.moviePoster,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(booking.movieTitle),
                    subtitle:
                        Text('${booking.userName} - ${booking.userEmail}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _deleteBooking(index);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
