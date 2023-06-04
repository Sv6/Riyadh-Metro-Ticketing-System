import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riyadh_metro/settings.dart';
import 'crud.dart';
import 'client.dart';
import 'book.dart';

void main() {
  runApp(mapPage());
}

class mapPage extends StatefulWidget {
  const mapPage({super.key});

  @override
  State<mapPage> createState() => _myAppState();
}

class _myAppState extends State<mapPage> {
  final Crud CRUD = Crud();
  int _selectedIndex = 2;

  @override
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
                      fullscreenDialog: true
                    ),
                  )
                  .then(
                    (_) => Navigator.pop(context),
                  );
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.all(50),
          maxScale: 4,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.jpg'),
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        bottomNavigationBar: GNav(
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          rippleColor: Color.fromARGB(
              255, 6, 179, 107),
          haptic: true, 
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), 
          tabBorder: Border.all(
              color: Color.fromARGB(255, 6, 179, 107),
              width: 1), 
          tabShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 6, 179, 107).withOpacity(0.5),
                blurRadius: 8)
          ], 
          curve: Curves.easeOutExpo, 
          duration: Duration(milliseconds: 900), 
          gap: 8, 
          color: Colors.grey[800],
          activeColor: Colors.white, 
          iconSize: 24, 
          tabBackgroundColor:
              Colors.white.withOpacity(0.1), 
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), 

          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
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
                        fullscreenDialog: true
                      ),
                    )
                    .then(
                      (_) => Navigator.pop(context),
                    );
              },
            ),
            GButton(
                icon: Icons.train,
                text: 'Book',
                onPressed: () async {
                  String uid = await CRUD.getId();
                  Map<String, dynamic> data = await CRUD.getUserData(uid);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookPage(
                        clientName: data["FULLNAME"],
                        balance: data["BALANCE"] * 1.0,
                        walletID: data["WALLETID"],
                        pass: data["PASS"],
                        timeCongestion: const [],
                        countCongestion: const [],
                      ),
                    ),
                  );
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
          
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
