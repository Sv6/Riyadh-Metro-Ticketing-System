import 'package:flutter/material.dart';
void main() {
  runApp(Bookpage(clientName: "clientName", balance: 0, destinations: ["destination", "jioadsfjo"], selectedDestination: "destination", availableTickets: ["d"], selectedTicket: "d"));
}

class Bookpage extends StatelessWidget {
  final String clientName;
  final double balance;
  final List<String> destinations;
  final String selectedDestination;
  final List<String> availableTickets;
  final String selectedTicket;

  Bookpage({
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
          title: Text("Welcome, $clientName!"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                    .map(
                                        (destination) => DropdownMenuItem<String>(
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
                                    .map(
                                        (destination) => DropdownMenuItem<String>(
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
