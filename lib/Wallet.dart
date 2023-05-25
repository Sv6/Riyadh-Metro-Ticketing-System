import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'client.dart';
import 'book.dart';
import 'settings.dart';
import 'crud.dart';

void main() {
  runApp(walletPage(
    clientName: "",
    balance: 0,
    walletID: "",
    pass: 0,
  ));
}

class walletPage extends StatefulWidget {
  final String clientName;
  final String walletID;
  double balance;
  double pass;

  walletPage(
      {required this.balance,
      required this.clientName,
      required this.walletID,
      required this.pass});

  @override
  State<walletPage> createState() => _walletPageState();
}

class _walletPageState extends State<walletPage> {
  late final TextEditingController _amt;
  final Crud CRUD = Crud();

  @override
  void initState() {
    // TODO: implement initState
    _amt = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text("Wallet"),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
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
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
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
                            padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                ),
                Column(children: [
                  Text("Enter the amount you want to add"),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200.0,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                controller: _amt,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ))),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 70,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.balance = widget.balance +
                                          double.parse(_amt.text);
                                    });
                                    CRUD.updateBalance(double.parse(_amt.text));
                                  },
                                  child: Text("Add"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 6, 179, 107),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )))),
                        ],
                      )),
                ]),
                Text("Choose Your Pass Plan"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 6, 179, 107),
                      ),
                      height: 250,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.balance = widget.balance - 100;
                            widget.pass = widget.pass + 10;
                          });
                          CRUD.updateBalance(-100);
                          CRUD.updatePass(10);
                        },
                        child: Text("10",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 6, 179, 107),
                      ),
                      height: 250,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.balance = widget.balance - 200;
                            widget.pass = widget.pass + 20;
                          });
                          CRUD.updateBalance(-200);
                          CRUD.updatePass(20);
                        },
                        child: Text("20",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 6, 179, 107),
                      ),
                      height: 250,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.balance = widget.balance - 500;
                            widget.pass = widget.pass + 50;
                          });
                          CRUD.updateBalance(-500);
                          CRUD.updatePass(50);
                        },
                        child: Text("50",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//test
