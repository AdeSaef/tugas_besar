import 'package:shared_preferences/shared_preferences.dart';
import 'user_profile.dart';
import '../booking/booking.dart';
import 'dart:convert';

class ProfileManager {
  static const String _keyName = 'user_name';
  static const String _keyEmail = 'user_email';
  static const String _keyBookings = 'bookings';

  Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyName, profile.name);
    prefs.setString(_keyEmail, profile.email);
  }

  Future<UserProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);

    if (name != null && email != null) {
      return UserProfile(name: name, email: email);
    } else {
      return null;
    }
  }

  Future<void> updateProfile(UserProfile newProfile) async {
    await saveProfile(newProfile);
  }


  Future<void> saveBooking(Booking booking) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? bookings = prefs.getStringList(_keyBookings) ?? [];
    bookings.add(jsonEncode(booking.toJson()));
    await prefs.setStringList(_keyBookings, bookings);
    print('Booking saved: ${booking.toJson()}'); // Debug print
  }

  Future<List<Booking>> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? bookings = prefs.getStringList(_keyBookings);
    if (bookings == null) {
      print('No bookings found'); // Debug print
      return [];
    }
    return bookings.map((b) => Booking.fromJson(jsonDecode(b))).toList();
  }
}