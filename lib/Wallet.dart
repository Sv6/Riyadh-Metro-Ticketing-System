import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(walletPage(
    clientName: "Sultan",
    balance: 0,
    walletID: "123",
  ));
}

class walletPage extends StatelessWidget {
  final String clientName;
  final String walletID;
  double balance;

  walletPage(
      {required this.balance,
      required this.clientName,
      required this.walletID});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text("Wallet"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: Column(
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
                            "$clientName",
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
                        "SAR$balance",
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

                ],
              ),
            ),
            Column(
              children: [
                Text("Enter the amount you want to add"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 200.0,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                )
                              )
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Add"))
                    ],
                  ),
                )
              ],

            ),
            Text("Choose Your Pass Plan"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.pink,
                  ),
                  height: 250,
                  width: 100,

                  child: TextButton(
                    onPressed: () {},
                  child: Text("10"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.purple,
                  ),
                  height: 250,
                  width: 100,

                  child: TextButton(
                    onPressed: () {},
                    child: Text("20"),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.yellow,
                  ),
                  height: 250,
                  width: 100,

                  child: TextButton(
                    onPressed: () {},
                    child: Text("20"),
                  ),
                ),
              ],
            )
          ],
        ),
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
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.train,
              text: 'Book',
            ),
            GButton(
              icon: Icons.map,
              text: 'Map',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ],
        ),
      ),
    );
  }
}
//fnsjdfsd