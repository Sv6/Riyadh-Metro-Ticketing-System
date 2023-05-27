import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'client.dart';
import 'crud.dart';

void main() {
  runApp(DisplayTicket(
    name: "",
    id: "",
    from: "",
    time: "",
    status: true,
  ));
}

class DisplayTicket extends StatefulWidget {
  final String name;
  final String id;
  final String from;
  final String time;
  bool status;

  DisplayTicket({
    super.key,
    required this.name,
    required this.id,
    required this.from,
    required this.time,
    required this.status,
  });

  @override
  State<DisplayTicket> createState() => _DisplayTicketState();
}

String printStatus(bool s) {
  if (s) return "Open";
  return "Closed";
}

class _DisplayTicketState extends State<DisplayTicket> {
  void initState() {
    bool status;
    super.initState();
  }

  Crud CRUD = Crud();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Display Ticket",
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Ticket"),
          leading: BackButton(
            color: Colors.white,
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
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
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
                          padding: EdgeInsets.all(15),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            spacing: 10.0, // gap between adjacent chips
                            direction: Axis.horizontal,
                            children: [
                              Text("Name: ${widget.name}"),
                              Text("TicketID: ${widget.id}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            spacing: 10.0, // gap between adjacent chips
                            direction: Axis.horizontal,
                            children: [
                              Text("From: ${widget.from}"),
                              Text("Time: ${widget.time}"),
                            ],
                          ),
                        ),
                        Text("Status: ${printStatus(widget.status)}"),
                        SizedBox(
                          height: 10,
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
                            height: 200,
                            width: 200,
                            child: QrImageView(
                              data: widget.id,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
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
                          onPressed: () {
                            CRUD.insertCanceledTicket(widget.id);
                            CRUD.changeTicketStatus(widget.id);
                            CRUD.setCancelCounter(widget.from, widget.time);
                            setState(() {
                              widget.status = false;
                            });
                          },
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
      ),
    );
  }
}
