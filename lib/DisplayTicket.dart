import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

void main() {
  runApp(DisplayTicket());
}

class DisplayTicket extends StatelessWidget {
  const DisplayTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Display Ticket",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ticket"),
          leading: BackButton(color: Colors.white, onPressed: () {},),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              //Containter for the texted details
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),

                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Name: Sultan Salah"),
                            Text("TicketID: 100012"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Route: \nFrom: King Khaled International Airport"),
                            Text("Time: 13:00"),
                          ],
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 10,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          height: 150,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // color: Color.fromARGB(255, 6, 179, 107),
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 6, 179, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Export',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      // color: Color.fromARGB(255, 6, 179, 107),
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
