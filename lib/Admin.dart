import 'package:flutter/material.dart';
import 'addAdmin.dart';
import 'DisplayFeedbacks.dart';

void main() {
  runApp(Admin());
}

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 6, 179, 107),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          title: Center(child: Text('Admin')),
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
                // Handle Freeze Station functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Freeze Account'),
              onTap: () {
                // Handle Freeze Account functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Display Feedbacks'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DisplayFeedback()));
                // Handle Display Feedbacks functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel Tickets'),
              onTap: () {
                // Handle Cancel Tickets functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
