import 'package:flutter/material.dart';
import 'package:riyadh_metro/FeedbackPage.dart';
import 'package:riyadh_metro/login.dart';
import 'package:riyadh_metro/updateProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'DisplayTicket.dart';
import 'client.dart';
import 'crud.dart';
import 'mapPage.dart';
import "updateProfile.dart";

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
                        stations: [],
                          date: [],
                          status: [],
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (FeedbackPage())));
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
              onTap: () async {
                // Handle sign out option
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
