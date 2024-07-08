import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'user_profile.dart';
import 'profile_manager.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initialize with placeholder values
  String nama = 'asep bengkel';
  String email = 'coba_coba@gmail.com';

  @override
  void initState() {
    super.initState();
    loadProfileData(); // Load profile data when screen initializes
  }

  // Method to load profile data from SharedPreferences
  void loadProfileData() async {
    UserProfile? userProfile = await ProfileManager().loadProfile();
    if (userProfile != null) {
      setState(() {
        nama = userProfile.name;
        email = userProfile.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Navigate to EditProfileScreen and wait for result
              final updatedProfile = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    UserProfile(name: nama, email: email),
                  ),
                ),
              );

              // Update UI with edited profile data if available
              if (updatedProfile != null) {
                setState(() {
                  nama = updatedProfile.name;
                  email = updatedProfile.email;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: $nama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
