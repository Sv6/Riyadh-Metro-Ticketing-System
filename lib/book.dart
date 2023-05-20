import 'package:flutter/material.dart';

import 'package:riyadh_metro/Wallet.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'crud.dart';
import 'mapPage.dart';
import 'settings.dart';
import 'client.dart';

void main() {
  runApp(BookPage(
      clientName: "clientName",
      balance: 0,
      destinations: ["destination", "jioadsfjo"],
      selectedDestination: "destination",
      availableTickets: ["d"],
      selectedTicket: "d"));
}

class BookPage extends StatefulWidget {
  final String clientName;
  final double balance;
  final List<String> destinations;
  final String selectedDestination;
  final List<String> availableTickets;
  final String selectedTicket;

  BookPage({
    required this.clientName,
    required this.balance,
    required this.destinations,
    required this.selectedDestination,
    required this.availableTickets,
    required this.selectedTicket,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final Crud CRUD = Crud();
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              () async {
                String uid = await CRUD.getId();
                Map<String, dynamic> data = await CRUD.getUserData(uid);
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: data["FULLNAME"],
                          balance: data["BALANCE"] * 1.0,
                          availableTickets: ['d'],
                          walletID: data["WALLETID"],
                          pass: data["PASS"],
                        ),
                      ),
                    )
                    .then(
                      (_) => Navigator.pop(context),
                    );
              };
            },
          ),
          title: Text("Welcome, ${widget.clientName}!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  height: 200,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 6, 179, 107),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "${widget.clientName}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "#1233",
                                style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "SAR${widget.balance}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pass Counter: 0",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.small(
                              backgroundColor: Colors.white,
                              foregroundColor: Color.fromARGB(255, 6, 179, 107),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => (walletPage(
                                          balance: widget.balance,
                                          clientName: widget.clientName,
                                          walletID: "",
                                          pass: 0,
                                        ))));
                              },
                              child: Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Balance:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Center(
                        child: Text(
                          "\$${widget.balance.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From:",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                DropdownButton<String>(
                                  value: widget.selectedDestination,
                                  onChanged: (String? value) {},
                                  items: widget.destinations
                                      .map((destination) =>
                                          DropdownMenuItem<String>(
                                            value: destination,
                                            child: Text(destination),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To:",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                DropdownButton<String>(
                                  value: widget.selectedDestination,
                                  onChanged: (String? value) {},
                                  items: widget.destinations
                                      .map((destination) =>
                                          DropdownMenuItem<String>(
                                            value: destination,
                                            child: Text(destination),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Available tickets:",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      widget.availableTickets.isEmpty
                          ? Text(
                              "You have no tickets.",
                              style: TextStyle(fontSize: 16.0),
                            )
                          : Column(
                              children: widget.availableTickets
                                  .map((ticket) => InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(ticket),
                                              Icon(Icons.arrow_forward),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                      SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Book now",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              onPressed: () async {
                String uid = await CRUD.getId();
                Map<String, dynamic> data = await CRUD.getUserData(uid);
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: data["FULLNAME"],
                          balance: data["BALANCE"] * 1.0,
                          availableTickets: ['d'],
                          walletID: data["WALLETID"],
                          pass: data["PASS"],
                        ),
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
            ),
            GButton(
                icon: Icons.map,
                text: 'Map',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => (mapPage())));
                }),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => (SettingsPage())));
              },
            )
          ],
          // maybe needed later for indexing -f
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
