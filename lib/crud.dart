import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
    User? user = await FirebaseAuth.instance.currentUser;
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
      print(e);
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
