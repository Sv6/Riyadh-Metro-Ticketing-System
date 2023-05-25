import 'package:flutter/material.dart';

import 'package:riyadh_metro/Wallet.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'crud.dart';
import 'mapPage.dart';
import 'settings.dart';
import 'client.dart';
import 'ViewList.dart';

void main() {
  runApp(
    BookPage(
      clientName: "",
      balance: 0,
      walletID: "",
      pass: 0,
      countCongestion: [],
      timeCongestion: [],
    ),
  );
}

// ignore: non_constant_identifier_names
Future<List<String>> initializeStationList(Crud CRUD) async {
  List stations = await CRUD.retrieveStations();
  List<String> a = stations.map((e) => e.toString()).toList();
  return a;
}

List<String> initializeTimeList() {
  List<String> a = [];

  DateTime timenow = DateTime.now();
  int hournow = timenow.hour;
  bool firstHour = true;

  for (int i = hournow; i < 24 + hournow; i++) {
    String s = "";
    int k = i % 24;

    // if (i < 24) {
    //   s = "today ";
    // } else {
    //   s = "tomorrow ";
    // }

    if (i < 10) {
      s = "$s 0$k:";
    } else {
      s = "$s $k:";
    }
    if (firstHour) {
      firstHour = false;
      if (timenow.minute < 30) a.add("${s}30");
    } else {
      a.add("${s}00");
      a.add("${s}30");
    }
  }
  return a;
}

class BookPage extends StatefulWidget {
  final String clientName;
  double balance;
  final String walletID;
  double pass;
  List timeCongestion;
  List countCongestion;

  BookPage({
    required this.clientName,
    required this.balance,
    required this.walletID,
    required this.pass,
    required this.timeCongestion,
    required this.countCongestion,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final Crud CRUD = Crud();

  int _selectedIndex = 1;
  List<String> times = initializeTimeList();
  List<String> stations = [];
  List timeCongestion = [];
  List countCongestion = [];
  late String selectedFrom = "Granada mall";
  late String selectedTime = times[0];

  @override
  initState() {
    String selectedFrom;
    String selectedTime;
    List timeCongestion;
    List countCongestion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ///////////// fix
              () async {
                String uid = await CRUD.getId();
                Map<String, dynamic> data = await CRUD.getUserData(uid);
                ViewList vL = ViewList(selectedFrom, selectedTime);
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: data["FULLNAME"],
                          balance: data["BALANCE"] * 1.0,
                          availableTickets: ['d'],
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
              };
            },
          ),
          title: Text("Welcome, ${widget.clientName.toTitleCase()}!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: FutureBuilder(
            future: Future.wait([initializeStationList(CRUD)]),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                stations = snapshot.data[0];
              } else {
                print("error");
              }
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: SafeArea(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                                height: 200,
                                width: 340,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 6, 179, 107),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${widget.clientName.toTitleCase()}",
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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 8, 0),
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
                                            foregroundColor: Colors.green,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          (walletPage(
                                                            balance:
                                                                widget.balance,
                                                            clientName: widget
                                                                .clientName,
                                                            walletID:
                                                                widget.walletID,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From:",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      DropdownButtonFormField<String>(
                                        hint: Text("choose station"),
                                        menuMaxHeight: 250,
                                        value: selectedFrom,
                                        onChanged: (String? value) async {
                                          Map<String, dynamic> data = await CRUD
                                              .getStationInfo(selectedFrom);

                                          setState(() {
                                            selectedFrom = value.toString();
                                            timeCongestion = data['time_count']
                                                .keys
                                                .toList();
                                            countCongestion = data['time_count']
                                                .values
                                                .toList();
                                          });
                                        },
                                        items: stations
                                            .map((value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time:",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      DropdownButtonFormField<String>(
                                        hint: Text("choose time"),
                                        menuMaxHeight: 250,
                                        value: selectedTime,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedTime = value.toString();
                                            print(selectedTime);
                                          });
                                        },
                                        items: times
                                            .map((time) =>
                                                DropdownMenuItem<String>(
                                                  value: time,
                                                  child: Text(time),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color.fromARGB(255, 6, 179, 107),
                                    ),
                                    height: 50,
                                    width: 150,
                                    child: TextButton(
                                      child: Text(
                                        "Purchase Ticket",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      onPressed: () async {
                                        String uid = await CRUD.getId();
                                        String tickID =
                                            CRUD.createTicketID(selectedFrom);
                                        CRUD.insertTicket(tickID, selectedFrom,
                                            selectedTime, true, uid);
                                        setState(() {
                                          widget.balance = widget.balance - 10;
                                          CRUD.setCounter(
                                              selectedFrom, selectedTime);
                                        });
                                        CRUD.InsertTicket(tickID);
                                        CRUD.updateBalance(-10);
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color.fromARGB(255, 6, 179, 107),
                                    ),
                                    height: 50,
                                    width: 150,
                                    child: TextButton(
                                      child: Text(
                                        "Use Pass",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      onPressed: () async {
                                        String uid = await CRUD.getId();
                                        String tickID =
                                            CRUD.createTicketID(selectedFrom);
                                        CRUD.insertTicket(tickID, selectedFrom,
                                            selectedTime, true, uid);
                                        setState(() {
                                          widget.pass = widget.pass - 1;
                                          CRUD.setCounter(
                                              selectedFrom, selectedTime);
                                        });
                                        CRUD.InsertTicket(tickID);
                                        CRUD.updatePass(-1);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                                height: 450,
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
                                          "Current Congestion",
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
                                        itemCount: timeCongestion
                                            .length, // Replace 'tickets.length' with the actual number of tickets

                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(timeCongestion[index]
                                                .toString()),
                                            subtitle: Text("congestion:"),
                                            trailing: Text(
                                                "${countCongestion[index]}"
                                                    .toString()),
                                            textColor: Colors.white,
                                          );
                                        },

                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
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
                          availableTickets: ['TICKETS'],
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
