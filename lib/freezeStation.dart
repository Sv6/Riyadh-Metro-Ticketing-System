import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'Admin.dart';
import 'crud.dart';
import 'firebase_options.dart';

final Crud CRUD = Crud();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    freezeStation(),
  );
}

void changeStationStatus(String station, bool selection) async {
  if (selection) {
    FirebaseFirestore.instance
        .collection("STATIONS")
        .doc(station)
        .update({"status": false});
  } else {
    FirebaseFirestore.instance
        .collection("STATIONS")
        .doc(station)
        .update({"status": true});
  }
}

String printStatus(String s) {
  if (s == "true") return "Open";
  return "Closed";
}

String? first;

// ignore: non_constant_identifier_names
Future<List<String>> initializeStationList(Crud CRUD) async {
  List stations = await CRUD.retrieveStations();
  List<String> a = stations.map((e) => e.toString()).toList();
  first = a[0];

  return a;
}

class freezeStation extends StatefulWidget {
  const freezeStation({super.key});

  @override
  State<freezeStation> createState() => _freezeStationState();
}

class _freezeStationState extends State<freezeStation> {
  final Crud CRUD = Crud();

  List<String> stations = [];
  List timeCongestion = [];
  List countCongestion = [];
  late String? selectedFrom = first;
  late String selectedDropDownValue;
  String status = "true";

  @override
  initState() {
    String selectedFrom;
    String selectedTime;
    List timeCongestion;
    List countCongestion;
    String status;
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Admin()));

            },
          ),
          title: Text("Freeze Station"),
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
                        children: const [],
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
                                            status = data['status'].toString();
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
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Status:${printStatus(status)} ",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                 
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.red,
                                    ),
                                    height: 50,
                                    width: 150,
                                    child: TextButton(
                                        child: Text(
                                          "Freeze",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          changeStationStatus(
                                              selectedFrom as String, true);
                                          setState(() {
                                            status = "false";
                                          });
                                        }),
                                  ),
                                ),
                                Center(
                                 
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color.fromARGB(255, 6, 179, 107),
                                    ),
                                    height: 50,
                                    width: 150,
                                    child: TextButton(
                                        child: Text(
                                          "UnFreeze",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          changeStationStatus(
                                              selectedFrom as String, false);
                                          setState(() {
                                            status = "true";
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
