import 'package:flutter/material.dart';
import 'profile_manager.dart';
import 'user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile? userProfile;

  EditProfileScreen(this.userProfile);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userProfile?.name ?? '';
    _emailController.text = widget.userProfile?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Update profile based on entered data
                final newProfile = UserProfile(
                  name: _nameController.text,
                  email: _emailController.text,
                );
                await ProfileManager().updateProfile(newProfile);
                
                // Pass updated profile back to previous screen
                Navigator.pop(context, newProfile);
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
