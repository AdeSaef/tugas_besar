import 'package:flutter/material.dart';

class TicketBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket Booking')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Book your movie tickets here!'),
            // Tambahkan logika pemesanan tiket di sini.
          ],
        ),
      ),
    );
  }
}
