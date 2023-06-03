import 'package:flutter/material.dart';
import 'addAdmin.dart';
import 'DisplayFeedbacks.dart';
import 'freezeStation.dart';
import 'login.dart';
import 'crud.dart';
import 'cancel.dart';
import 'FreezeAccount.dart';
import 'updateAdminProfile.dart';

void main() {
  runApp(Admin());
}

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    CRUD.deletePastTimes();
    CRUD.ticketsPastTime();
    CRUD.updateTimeNames();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 6, 179, 107),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          title: Text('Admin'),
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateAdminProfile()));
            },
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Admin'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => addAdmin()));
              },
            ),
            ListTile(
              leading: Icon(Icons.stop),
              title: Text('Freeze Station'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => freezeStation()));
              },
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Freeze Account'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FreezeAccount()));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Display Feedbacks'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DisplayFeedback()));
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel Tickets'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CancelPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign out'),
              onTap: () async {
                Crud().signOut();
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
