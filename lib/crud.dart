import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Crud {
  final db = FirebaseFirestore.instance;

  bool insertClient(String? name, double? balance, String? bd, String? email,
      String? phone, String? walletID, String? password, bool? status) {
    if (name == null ||
        balance == null ||
        bd == null ||
        email == null ||
        phone == null ||
        walletID == null ||
        password == null ||
        status == null) {
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
        "STATUS": status
      };
      db.collection("User").add(data);
    }
    return true;
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}
