import 'package:flutter/material.dart';

import 'package:riyadh_metro/Wallet.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'crud.dart';
import 'mapPage.dart';
import 'settings.dart';
import 'client.dart';

void main() {
  runApp(
    BookPage(
      clientName: "",
      balance: 0,
      walletID: "",
      pass: 0,
      countCongestion: const [],
      timeCongestion: const [],
    ),
  );
}

String? first;

Future<List<String>> initializeStationList(Crud CRUD) async {
  List stations = await CRUD.ListStations();
  List<String> a = stations.map((e) => e.toString()).toList();
  first = a[0];

  return a;
}

List<String> initializeTimeList() {
  List<String> a = [];

  DateTime timenow = DateTime.now();
  int hournow = timenow.hour;
  bool firstHour = true;
  // i updated here
  for (int i = hournow; i < 24 + hournow; i++) {
    String s = "";
    int k = i % 24;

    if (i < 24) {
      s = "Today";
    } else {
      s = "Tomorrow";
    }

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
    super.key,
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
  late String? selectedFrom = first;
  late String selectedDropDownValue;

  @override
  initState() {
    super.initState();
  }

  late String selectedTime = times[0];

  @override
  Widget build(BuildContext context) {
    initializeStationList(CRUD);

    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
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
                    ),
                  )
                  .then(
                    (_) => Navigator.pop(context),
                  );
              () async {
                String uid = await CRUD.getId();
                Map<String, dynamic> data = await CRUD.getUserData(uid);
                // ViewList vL = ViewList(selectedFrom, selectedTime);
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
                      ),
                    )
                    .then(
                      (_) => Navigator.pop(context),
                    );
              };
            },
          ),
          title: Text("Book Ticket"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: FutureBuilder(
            future: Future.wait([initializeStationList(CRUD)]),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                stations = snapshot.data[0];
              } else {}

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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 8, 0),
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
                                          setState(() {
                                            selectedFrom = value.toString();
                                            selectedFrom = value.toString();
                                          });

                                          Map<String, dynamic> data =
                                              await CRUD.getStationInfo(
                                                  selectedFrom as String);

                                          setState(() {
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

                                        if (widget.balance > 10) {
                                          String tickID = CRUD.createTicketID(
                                              selectedFrom as String);
                                          CRUD.insertTicket(
                                              tickID,
                                              selectedFrom,
                                              selectedTime,
                                              true,
                                              uid);
                                          setState(() {
                                            widget.balance =
                                                widget.balance - 10;
                                          });
                                          CRUD.setCounter(
                                              selectedFrom as String,
                                              selectedTime);
                                          CRUD.InsertTicket(tickID);
                                          CRUD.updateBalance(-10);
                                        } else {
                                          if (context.mounted) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Text(
                                                    "insufficient  balance"),
                                                content: Text(
                                                    "Charge your balance to buy this ticket"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("OK")),
                                                ],
                                              ),
                                            );
                                          }
                                        }

                                        //look, i dont know HOW  DID IT WORK
                                        //BUT DONT YOU DARE TOUCH IT -f

                                        Map<String, dynamic> test =
                                            await CRUD.getStationInfo(
                                                selectedFrom as String);

                                        Map<String, dynamic> data =
                                            await CRUD.getStationInfo(
                                                selectedFrom as String);

                                        setState(() {
                                          timeCongestion =
                                              data['time_count'].keys.toList();
                                          countCongestion = data['time_count']
                                              .values
                                              .toList();
                                        });
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
                                        if (widget.pass >= 1) {
                                          String tickID = CRUD.createTicketID(
                                              selectedFrom as String);
                                          CRUD.insertTicket(
                                              tickID,
                                              selectedFrom,
                                              selectedTime,
                                              true,
                                              uid);
                                          setState(() {
                                            widget.pass = widget.pass - 1;
                                            CRUD.setCounter(
                                                selectedFrom as String,
                                                selectedTime);
                                          });
                                          CRUD.InsertTicket(tickID);
                                          CRUD.updatePass(-1);
                                        } else {
                                          if (context.mounted) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title:
                                                    Text("insufficient Pass"),
                                                content: Text(
                                                    "Charge your pass to buy this ticket"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("OK")),
                                                ],
                                              ),
                                            );
                                          }
                                        }

                                        Map<String, dynamic> test =
                                            await CRUD.getStationInfo(
                                                selectedFrom as String);

                                        Map<String, dynamic> data =
                                            await CRUD.getStationInfo(
                                                selectedFrom as String);

                                        setState(() {
                                          timeCongestion =
                                              data['time_count'].keys.toList();
                                          countCongestion = data['time_count']
                                              .values
                                              .toList();
                                        });
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
                                  color: Color(0xFF06B36B),
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
                                        itemCount: timeCongestion.length,
                                        itemBuilder: (context, index) {
                                          double congestionValue =
                                              countCongestion[index];

                                          Color chipColor;
                                          if (congestionValue >= 25) {
                                            chipColor = Colors.red;
                                          } else if (congestionValue >= 15) {
                                            chipColor = Colors.orange;
                                          } else if (congestionValue >= 5) {
                                            chipColor = Colors.yellow;
                                          } else {
                                            chipColor =
                                                Colors.grey.withOpacity(0.5);
                                          }
                                          return ListTile(
                                            title: Text(timeCongestion[index]
                                                .toString()),
                                            trailing: Chip(
                                              label: Text(
                                                  "${countCongestion[index]}"
                                                      .toString()),
                                              backgroundColor: chipColor,
                                            ),
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
          rippleColor: Color.fromARGB(255, 6, 179, 107),
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder:
              Border.all(color: Color.fromARGB(255, 6, 179, 107), width: 1),
          tabBorder:
              Border.all(color: Color.fromARGB(255, 6, 179, 107), width: 1),
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
          tabBackgroundColor: Colors.white.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
