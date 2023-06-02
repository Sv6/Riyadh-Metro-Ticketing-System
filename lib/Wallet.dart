import 'package:flutter/material.dart';
import 'client.dart';
import 'crud.dart';
import 'validator.dart';

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
      {super.key,
      required this.balance,
      required this.clientName,
      required this.walletID,
      required this.pass});

  @override
  State<walletPage> createState() => _walletPageState();
}

class _walletPageState extends State<walletPage> {
  late final TextEditingController _amt;
  final _formKey = GlobalKey<FormState>();
  final Crud CRUD = Crud();
  final Validator validate = Validator();

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
                            padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                ),
                Column(children: [
                  Text("Enter the amount you want to add"),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.0,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _amt,
                                  validator: (value) {
                                    if (!validate.validateNonNegative(
                                        num: _amt.text)) {
                                      return "please enter positive number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      widget.balance = widget.balance +
                                          double.parse(_amt.text);
                                    });
                                    CRUD.updateBalance(double.parse(_amt.text));
                                    _amt.clear();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 6, 179, 107),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text("Add"),
                              ),
                            ),
                          ],
                        ),
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
                          if (widget.balance >= 10) {
                            setState(() {
                              widget.balance = widget.balance - 10;
                              widget.pass = widget.pass + 10;
                            });
                            CRUD.updateBalance(-10);
                            CRUD.updatePass(10);
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("insufficient balance"),
                                content: Text(
                                    "Charge your balance to buy this pass"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK")),
                                ],
                              ),
                            );
                          }
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
                          if (widget.balance >= 20) {
                            setState(() {
                              widget.balance = widget.balance - 20;
                              widget.pass = widget.pass + 20;
                            });
                            CRUD.updateBalance(-20);
                            CRUD.updatePass(20);
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("insufficient balance"),
                                content: Text(
                                    "Charge your balance to buy this pass"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK")),
                                ],
                              ),
                            );
                          }
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
                          if (widget.balance >= 50) {
                            setState(() {
                              widget.balance = widget.balance - 50;
                              widget.pass = widget.pass + 50;
                            });
                            CRUD.updateBalance(-50);
                            CRUD.updatePass(50);
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("insufficient balance"),
                                content: Text(
                                    "Charge your balance to buy this pass"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK")),
                                ],
                              ),
                            );
                          }
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
