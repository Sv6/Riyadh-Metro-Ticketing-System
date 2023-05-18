import 'package:flutter/material.dart';

import 'package:riyadh_metro/Wallet.dart';

void main() {
  runApp(BookPage(
      clientName: "clientName",
      balance: 0,
      destinations: ["destination", "jioadsfjo"],
      selectedDestination: "destination",
      availableTickets: ["d"],
      selectedTicket: "d"));
}

class BookPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Welcome, $clientName!"),
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
                      SafeArea(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.small(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => (walletPage(
                                        balance: balance,
                                        clientName: clientName,
                                        walletID: "",
                                        pass: 0,))));
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
                          "\$${balance.toStringAsFixed(2)}",
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
                                  value: selectedDestination,
                                  onChanged: (String? value) {},
                                  items: destinations
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
                                  value: selectedDestination,
                                  onChanged: (String? value) {},
                                  items: destinations
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
                      availableTickets.isEmpty
                          ? Text(
                              "You have no tickets.",
                              style: TextStyle(fontSize: 16.0),
                            )
                          : Column(
                              children: availableTickets
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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Booking",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
