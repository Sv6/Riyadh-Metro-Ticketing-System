import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Copy pasta method, makes first letter of every word Captialized,
//i put in crud as its imported in every class,as an extension, we have to import it every time -f
extension StringCasingExtension on String {
  //use this if you want only the FIRST letter captilized, example:hello=>Hello
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  //use this if you want EVERY first letter on every word captilized, example:feras alaskar=>Feras Alaskar
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class Crud {
  final db = FirebaseFirestore.instance;

  bool insertAdmin(
    String? uid,
    String? name,
    String? bd,
    String? email,
    String? phone,
    String? password,
    bool? status,
  ) {
    if (uid == null ||
        name == null ||
        bd == null ||
        email == null ||
        phone == null ||
        password == null ||
        status == null) {
      return false;
    } else {
      final data = <String, dynamic>{
        "FULLNAME": name,

        "BIRTHDATE": bd, //change to DateTime
        "EMAIL": email,
        "PHONE": phone,

        "PASSWORD": password,
        "STATUS": status,
      };
      db.collection("Admin").doc(uid).set(data);
    }
    return true;
  }

  bool insertClient(
      String? uid,
      String? name,
      double? balance,
      String? bd,
      String? email,
      String? phone,
      String? walletID,
      String? password,
      bool? status,
      List? tickets,
      double? pass) {
    if (uid == null ||
        name == null ||
        balance == null ||
        bd == null ||
        email == null ||
        phone == null ||
        walletID == null ||
        password == null ||
        status == null ||
        tickets == null ||
        pass == null) {
      return false;
    } else {
      final data = <String, dynamic>{
        "FULLNAME": name,
        "BALANCE": balance,
        "BIRTHDATE": bd, //change to DateTime
        "EMAIL": email,
        "PHONE": phone,
        "WALLETID": walletID,
        "PASSWORD": password,
        "STATUS": status,
        "TICKETS": tickets,
        "PASS": pass
      };
      db.collection("User").doc(uid).set(data);
    }
    return true;
  }

  Future<String> getId() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return uid;
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    uid = await getId();

    // Create a reference to the data you want to retrieve.
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    DocumentReference userDocument = users.doc(uid);

    // Use the `get()` method to retrieve the data.
    DocumentSnapshot snapshot = await userDocument.get();
    // QuerySnapshot<Map<String, dynamic>> snapshot = await users.doc(uid).get();

    // Check the `exists` property to make sure the data exists.
    if (snapshot.exists) {
      String mapString = jsonEncode(snapshot.data());
      var mapObject = jsonDecode(mapString);

      // The data exists.
      // You can access it using the `data` property.
      // Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      Map<String, dynamic> data = mapObject;

      return data;
    } else {
      // The data does not exist.
      return {};
    }
  }

//not finished
  CollectionReference cR = FirebaseFirestore.instance.collection("Admin");
  Future<void> retrieveAdminEmail() async {
    QuerySnapshot qS = await cR.get();

    final allData = qS.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  void InsertTicket(String tickID) async {
    String uid = await getId();
    Map<String, dynamic> data = await getUserData(uid);
    List tickets = data["TICKETS"];
    tickets.add(tickID);
    db.collection("User").doc(uid).update({"TICKETS": tickets});
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  void updateBalance(double amt) async {
    String id = await getId();
    Map<String, dynamic> data = await getUserData(id);
    double newBalance = data["BALANCE"] + amt;
    db.collection("User").doc(id).update({"BALANCE": newBalance});
  }

  void updatePass(double amt) async {
    String id = await getId();
    Map<String, dynamic> data = await getUserData(id);
    double newPass = data["PASS"] + amt;
    db.collection("User").doc(id).update({"PASS": newPass});
  }

  void updateName(String name) async {
    String id = await getId();
    Map<String, dynamic> data = await getUserData(id);
    db.collection("User").doc(id).update({"FULLNAME": name});
  }

  void updatePassword(String password) async {
    String id = await getId();
    try {
      FirebaseAuth.instance.currentUser!.updatePassword(password);
    } on FirebaseAuthException {
      return;
    }
    Map<String, dynamic> data = await getUserData(id);
    db.collection("User").doc(id).update({"PASSWORD": password});
  }

  void updateEmail(String email) async {
    String id = await getId();
    try {
      FirebaseAuth.instance.currentUser!.updateEmail(email);
    } on FirebaseAuthException {
      return;
    }
    Map<String, dynamic> data = await getUserData(id);
    db.collection("User").doc(id).update({"EMAIL": email});
  }

  void updatePhone(String phone) async {
    String id = await getId();
    Map<String, dynamic> data = await getUserData(id);
    db.collection("User").doc(id).update({"PHONE": phone});
  }

  Future<List> retrieveStations() async {
    QuerySnapshot qS = await db.collection("STATIONS").get();
    final data = qS.docs.map((e) => e.id).toList();
    return data;
  }

  void setCounter(String name, String time) async {
    Map<String, dynamic> data = await getStationInfo(name);
    double count;
    try {
      count = data["time_count"][time];
      count = count + 1;
    } catch (e) {
      count = 1;
    }
    data['time_count'][time] = count;
    db.collection("STATIONS").doc(name).set(data);
  }

  Future<Map<String, dynamic>> getStationInfo(String key) async {
    DocumentSnapshot stationSnapshot =
        await db.collection("STATIONS").doc(key).get();
    if (stationSnapshot.exists) {
      String mapString = jsonEncode(stationSnapshot.data());
      var mapObject = jsonDecode(mapString);

      Map<String, dynamic> data = mapObject;
      return data;
    } else {
      return {};
    }
  }

  bool insertTicket(String? id, String? startStation, String? Date,
      bool? Status, String? uid) {
    if (id == null ||
        startStation == null ||
        Date == null ||
        Status == null ||
        uid == null) {
      return false;
    }
    final data = <String, dynamic>{
      "Date": Date,
      "Start_station": startStation,
      "Status": Status,
      "UID": uid
    };
    db.collection("Tickets").doc(id).set(data);
    return true;
  }

  bool insertFeedback(String? title, String? body, String? id) {
    if (title == null || body == null || id == null) {
      return false;
    }
    DateTime now = DateTime.now();
    final data = <String, dynamic>{
      "TITLE": title,
      "BODY": body,
      "ID": id,
      "DATE": now
    };
    db.collection("FEEDBACKS").doc().set(data);
    return true;
  }

  String createTicketID(String stationName) {
    if (stationName.substring(0, 2).toLowerCase() == "al") {
      stationName = stationName.substring(2);
    }
    stationName = stationName.substring(0, 4);
    DateTime now = DateTime.now();
    String dateID = now.weekday.toString();
    String subID = idGenerator();
    subID = subID.substring(subID.length - 5, subID.length - 1);

    return "${stationName}_${dateID}_$subID";
  }

  Future<Map<String, dynamic>> getTicketInfo(String tickID) async {
    DocumentSnapshot ticketSnapshot =
        await db.collection("Tickets").doc(tickID).get();

    if (ticketSnapshot.exists) {
      String mapString = jsonEncode(ticketSnapshot.data());
      var mapObject = jsonDecode(mapString);

      Map<String, dynamic> data = mapObject;
      return data;
    } else {
      return {};
    }
  }
}

class userObject {
  String uid;
  String name;
  double balance;
  String email;
  String phone;
  String walletID;
  String password;
  bool status;
  List tickets;
  double pass;

  userObject(
      {required this.uid,
      required this.name,
      required this.balance,
      required this.email,
      required this.phone,
      required this.walletID,
      required this.password,
      required this.status,
      required this.tickets,
      required this.pass});

  factory userObject.fromJson(Map<String, dynamic> json) {
    return userObject(
      uid: json["USER"] as String,
      name: json["FULLNAME"] as String,
      balance: json["BALANCE"] as double,
      email: json["EMAIL"] as String,
      phone: json["PHONE"] as String,
      walletID: json["WALLETID"] as String,
      status: json["STATUS"] as bool,
      password: json["PASSWORD"] as String,
      tickets: json["TICKET"] as List,
      pass: json["PASS"] as double,
    );
  }
}
