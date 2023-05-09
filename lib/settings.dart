import 'package:flutter/material.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 24),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person,
                size: 40,
                color: Color.fromARGB(255, 6, 179, 107),
              ),
              title: Text(
                'Update Profile',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Handle update profile option
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                size: 40,
                color: Color.fromARGB(255, 6, 179, 107),
              ),
              title: Text(
                'Send Feedback',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Handle send feedback option
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 40,
                color: Color.fromARGB(255, 6, 179, 107),
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Handle sign out option
              },
            ),
          ],
        ),
      ),
    );
  }
}
