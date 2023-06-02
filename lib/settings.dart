import 'package:flutter/material.dart';
import 'package:riyadh_metro/FeedbackPage.dart';
import 'package:riyadh_metro/login.dart';
import 'package:riyadh_metro/updateProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'client.dart';
import 'crud.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Crud CRUD = Crud();
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
            onPressed: () async {
              String uid = await CRUD.getId();
              Map<String, dynamic> data = await CRUD.getUserData(uid);
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => ClientPage(
                        clientName: data["FULLNAME"],
                        balance: data["BALANCE"] * 1.0,
                        availableTickets: data["TICKETS"],
                        walletID: data["WALLETID"],
                        pass: data["PASS"],
                        stations: const [],
                        date: const [],
                        status: const [],
                      ),
                    ),
                  )
                  .then(
                    (_) => Navigator.pop(context),
                  );
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (UpdateProfile())));
                
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (FeedbackPage())));
                
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
              onTap: () async {
                final SignOut = await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (LoginPage())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
