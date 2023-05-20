import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
