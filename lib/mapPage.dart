import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riyadh_metro/login.dart';
import 'package:riyadh_metro/settings.dart';

import 'book.dart';

void main() {
  runApp(mapPage());
}

class mapPage extends StatefulWidget {
  @override
  State<mapPage> createState() => _myAppState();
}

class _myAppState extends State<mapPage> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map",
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text('Map'),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.all(50),
          minScale: 0.1,
          maxScale: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.jpg'),
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        bottomNavigationBar: GNav(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          rippleColor: Color.fromARGB(
              255, 6, 179, 107), // tab button ripple color when pressed
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), // tab button border
          tabBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), // tab button border
          tabShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 6, 179, 107).withOpacity(0.5),
                blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 900), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              Colors.white.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
                icon: Icons.train,
                text: 'Book',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookPage(
                          clientName: " ",
                          balance: 100,
                          destinations: ["destination", "jioadsfjo"],
                          selectedDestination: "destination",
                          availableTickets: ["d"],
                          selectedTicket: "67")));
                }),
            GButton(
              icon: Icons.map,
              text: 'Map',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (SettingsPage())));
              },
            )
          ],
        ),
      ),
    );
  }
}
