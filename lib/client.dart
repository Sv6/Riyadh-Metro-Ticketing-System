import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riyadh_metro/Wallet.dart';
import 'package:riyadh_metro/book.dart';
import 'package:riyadh_metro/settings.dart';
import 'crud.dart';

void main() async {
  runApp(ClientPage(
    clientName: "Abdulrahman Zyad",
    balance: 400000.00,
    availableTickets: ["d"],
    walletID: "",
    pass: 0,
  ));
}

class ClientPage extends StatefulWidget {
  final String clientName;
  double balance;
  final List<String> availableTickets;
  final String walletID;
  double pass;

  ClientPage(
      {required this.clientName,
      required this.balance,
      required this.availableTickets,
      required this.walletID,
      required this.pass});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text("Welcome, ${widget.clientName}!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: FutureBuilder(builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SafeArea(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      height: 200,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 6, 179, 107),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
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
                          ),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Text(
                                  "${widget.walletID}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
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
                                "Pass Counter: ${widget.pass}",
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
                                  foregroundColor: Colors.green,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => (walletPage(
                                                  balance: widget.balance,
                                                  clientName: widget.clientName,
                                                  walletID: widget.walletID,
                                                  pass: widget.pass,
                                                ))));
                                  },
                                  child: Icon(Icons.add)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: 400,
                    width: 680,
                    // temporary borders
                    color: Colors.blue,
                    child: Column(
                      children: const [Text("Available Tickets:")],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: GNav(
          backgroundColor: Colors.green,
          rippleColor: Colors.green, // tab button ripple color when pressed
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder:
              Border.all(color: Colors.green, width: 1), // tab button border
          tabBorder:
              Border.all(color: Colors.green, width: 1), // tab button border
          tabShadow: [
            BoxShadow(color: Colors.green.withOpacity(0.5), blurRadius: 8)
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
                          clientName: widget.clientName,
                          balance: widget.balance,
                          walletID: widget.walletID,
                          pass: widget.pass,),),);
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

//huihuinjhini