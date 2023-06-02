import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riyadh_metro/Wallet.dart';
import 'package:riyadh_metro/book.dart';
import 'package:riyadh_metro/settings.dart';
import 'crud.dart';
import 'mapPage.dart';
import 'DisplayTicket.dart';

void main() async {
  runApp(ClientPage(
    clientName: "Abdulrahman Zyad",
    balance: 400000.00,
    availableTickets: const ["d"],
    walletID: "",
    pass: 0,
    date: const [],
    status: const [],
    stations: const [],
  ));
}

String printStatus(String s) {
  if (s == "true") return "Open";
  return "Closed";
}

Future<Map<String, dynamic>> getTicket(String id, Crud CRUD) async {
  return await CRUD.getTicketInfo(id);
}

class ClientPage extends StatefulWidget {
  final String clientName;
  double balance;
  List<dynamic> availableTickets;
  List<dynamic> stations;
  List<dynamic> date;
  List<dynamic> status;
  final String walletID;
  double pass;

  ClientPage(
      {super.key,
      required this.clientName,
      required this.balance,
      required this.availableTickets,
      required this.walletID,
      required this.pass,
      required this.stations,
      required this.date,
      required this.status});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {
    List tickIds;
    List stations;
    List date;
    List status;
    List<dynamic> availableTickets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Crud CRUD = Crud();
    CRUD.deletePastTimes();
    CRUD.ticketsPastTime();
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text("Welcome, ${widget.clientName.toTitleCase()}!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Center(
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    height: 200,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 179, 107),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.clientName.toTitleCase(),
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
                                widget.walletID,
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
                              "SAR ${widget.balance}",
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
                              "Pass Counter: ${widget.pass.toInt()}",
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
                                foregroundColor:
                                    Color.fromARGB(255, 6, 179, 107),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
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

              Center(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Tickets")
                        .where("UID",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List stationList = [];
                        List statusList = [];
                        List dateList = [];
                        List idList = [];

                        snapshot.data;

                        stationList.add(["Start_station"]);
                        statusList.add(["Status"]);
                        dateList.add(["Date"]);

                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          height: 380,
                          width: 680,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 6, 179, 107),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "Available Tickets",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: snapshot.data!.size,

                                  itemBuilder: (context, index) {
                                    Color chipColor;
                                    Color textColor;
                                    bool check =
                                        snapshot.data!.docs[index]["Status"];
                                    if (check) {
                                      chipColor = Colors.white;
                                      textColor = Colors.black;
                                    } else {
                                      chipColor = Colors.red;
                                      textColor = Colors.white;
                                    }
                                    return ListTile(
                                      title: Text(
                                          "${snapshot.data!.docs[index]["Start_station"]}"),
                                      subtitle: Text(
                                          "${snapshot.data!.docs[index]["Date"]}"),
                                      trailing: Chip(
                                        label: Text(
                                            printStatus(
                                                snapshot.data!.docs[index]["Status"].toString()),
                                            style: TextStyle(color: textColor)),
                                        backgroundColor: chipColor,
                                      ),
                                      textColor: Colors.white,
                                      onTap: () {
                                        final userDocument = FirebaseFirestore
                                            .instance
                                            .collection("Tickets")
                                            .get();

                                        final List<DocumentSnapshot> dd =
                                            snapshot.data!.docs;
                                        List temp = [];
                                        for (var element in dd) {
                                            temp.add(element.id);
                                          }
                                        
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => DisplayTicket(
                                              name: widget.clientName,
                                              id: "${temp[index]}",
                                              from:
                                                  "${snapshot.data!.docs[index]["Start_station"]}",
                                              time: snapshot.data!.docs[index]
                                                  ["Date"],
                                              status: snapshot.data!.docs[index]
                                                  ["Status"]),
                                        ));
                                      },
                                    );
                                  },

                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              
            ],
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
            ),
            GButton(
                icon: Icons.train,
                text: 'Book',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookPage(
                        clientName: widget.clientName,
                        balance: widget.balance,
                        walletID: widget.walletID,
                        pass: widget.pass,
                        timeCongestion: const [],
                        countCongestion: const [],
                      ),
                    ),
                  );
                }),
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
        ),
      ),
    );
  }
}